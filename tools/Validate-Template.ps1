param(
    [string]$Configuration = "Release",
    [string]$PackageVersion,
    [string]$PackageSource = "https://api.nuget.org/v3/index.json"
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repoRoot = Split-Path -Parent $PSScriptRoot
$packageProject = Join-Path $repoRoot "QaaS.Runner.Template.Package.csproj"
$templateShortName = "qaas-runner"
$templatePackageId = "QaaS.Runner.Template"
$runtimePackageId = "QaaS.Runner"
$generatedName = "Smoke.QaaS.Runner"
$artifactRoot = Join-Path $repoRoot "artifacts"
$packageOutput = Join-Path $artifactRoot "package"
$smokeRoot = Join-Path $artifactRoot "smoke"
$runRoot = Join-Path $smokeRoot ([Guid]::NewGuid().ToString("N"))
$generatedRoot = Join-Path $runRoot "generated"

function Assert-True {
    param(
        [bool]$Condition,
        [string]$Message
    )

    if (-not $Condition) {
        throw $Message
    }
}

function Get-ProjectVersion {
    param([string]$ProjectPath)

    [xml]$projectXml = Get-Content $ProjectPath
    $version = $projectXml.Project.PropertyGroup.Version
    if ([string]::IsNullOrWhiteSpace($version)) {
        throw "Could not determine package version from '$ProjectPath'."
    }

    return $version
}

function Get-LatestPackageVersion {
    param(
        [string]$PackageId,
        [string]$Source
    )

    $output = dotnet package search $PackageId --source $Source --take 1
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to query latest version for '$PackageId' from '$Source'."
    }

    foreach ($line in $output) {
        if ($line -match "^\|\s*$([Regex]::Escape($PackageId))\s*\|\s*([^|]+?)\s*\|") {
            return $Matches[1].Trim()
        }
    }

    throw "Could not parse the latest version for '$PackageId' from 'dotnet package search'."
}

function Get-ResolvedPackageVersion {
    param(
        [string]$AssetsFilePath,
        [string]$PackageId
    )

    $assets = Get-Content $AssetsFilePath -Raw | ConvertFrom-Json
    $libraryName = $assets.libraries.PSObject.Properties.Name |
        Where-Object { $_ -like "$PackageId/*" } |
        Select-Object -First 1

    if ([string]::IsNullOrWhiteSpace($libraryName)) {
        throw "Could not find '$PackageId' in '$AssetsFilePath'."
    }

    return ($libraryName -split "/", 2)[1]
}

function Assert-PackageDoesNotContainBuildOutput {
    param([string]$PackagePath)

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [System.IO.Compression.ZipFile]::OpenRead($PackagePath)

    try {
        $invalidEntries = @($zip.Entries |
            Where-Object {
                $_.FullName -match "(^|/)(bin|obj)/"
            } |
            Select-Object -ExpandProperty FullName)

        Assert-True ($invalidEntries.Count -eq 0) (
            "Template package should not contain build output, but found: {0}" -f ($invalidEntries -join ", ")
        )
    }
    finally {
        $zip.Dispose()
    }
}

$projectVersion = Get-ProjectVersion -ProjectPath $packageProject
if ([string]::IsNullOrWhiteSpace($PackageVersion)) {
    $PackageVersion = "$projectVersion-ci"
}

New-Item -ItemType Directory -Force -Path $packageOutput | Out-Null
New-Item -ItemType Directory -Force -Path $runRoot | Out-Null

$env:DOTNET_CLI_HOME = Join-Path $runRoot "cli-home"
$env:NUGET_PACKAGES = Join-Path $runRoot "nuget-packages"
$env:DOTNET_NOLOGO = "true"
$env:DOTNET_CLI_TELEMETRY_OPTOUT = "true"
$env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "1"

Get-ChildItem $packageOutput -Filter "$templatePackageId*.nupkg" -ErrorAction SilentlyContinue | Remove-Item -Force

dotnet pack $packageProject `
    --configuration $Configuration `
    -p:PackageVersion=$PackageVersion `
    --output $packageOutput
if ($LASTEXITCODE -ne 0) {
    throw "dotnet pack failed."
}

$package = Get-ChildItem $packageOutput -Filter "$templatePackageId*.nupkg" |
    Where-Object { $_.Name -notlike "*.snupkg" } |
    Select-Object -First 1

Assert-True ($null -ne $package) "Template package was not created."
Assert-PackageDoesNotContainBuildOutput -PackagePath $package.FullName

dotnet new install $package.FullName
if ($LASTEXITCODE -ne 0) {
    throw "dotnet new install failed."
}

dotnet new $templateShortName -n $generatedName -o $generatedRoot
if ($LASTEXITCODE -ne 0) {
    throw "dotnet new $templateShortName failed."
}

git -C $generatedRoot init | Out-Null

$solutionPath = Join-Path $generatedRoot "$generatedName.sln"
$generatedProjectRoot = Join-Path $generatedRoot $generatedName
$projectFile = Join-Path $generatedProjectRoot "$generatedName.csproj"
$nuGetConfig = Join-Path $generatedRoot "NuGet.config"
$readmePath = Join-Path $generatedRoot "README.md"
$yamlPath = Join-Path $generatedProjectRoot "test.qaas.yaml"
$assetsFile = Join-Path $generatedProjectRoot "obj\project.assets.json"

Assert-True (Test-Path $solutionPath) "Generated solution file is missing."
Assert-True (Test-Path $projectFile) "Generated project file is missing."
Assert-True (Test-Path $nuGetConfig) "Generated NuGet.config is missing."
Assert-True (Test-Path $readmePath) "Generated README is missing."
Assert-True (Test-Path $yamlPath) "Generated test.qaas.yaml is missing."

$projectText = Get-Content $projectFile -Raw
$nuGetConfigText = Get-Content $nuGetConfig -Raw
$readmeText = Get-Content $readmePath -Raw

Assert-True ($projectText -match '<PackageReference Include="QaaS\.Runner" Version="\*" />') (
    "Generated project should use a floating QaaS.Runner package reference."
)
Assert-True ($nuGetConfigText -match 'https://api\.nuget\.org/v3/index\.json') (
    "Generated NuGet.config should default to nuget.org."
)
Assert-True ($readmeText -match 'NuGet\.config') (
    "Generated README should mention the project-local NuGet.config."
)
Assert-True ($readmeText -notmatch 'will fail validation') (
    "Generated README should no longer claim the default runner YAML fails validation."
)

dotnet restore $solutionPath --configfile $nuGetConfig
if ($LASTEXITCODE -ne 0) {
    throw "dotnet restore failed."
}

dotnet build $solutionPath -c $Configuration --no-restore
if ($LASTEXITCODE -ne 0) {
    throw "dotnet build failed."
}

$runOutput = & dotnet run -c $Configuration --project $projectFile -- run test.qaas.yaml 2>&1 | Out-String
if ($LASTEXITCODE -ne 0) {
    throw "Runner smoke execution failed.`n$runOutput"
}

Assert-True ($runOutput -match 'ExitCode=0') (
    "Runner smoke execution did not finish with ExitCode=0.`n$runOutput"
)

$latestRuntimeVersion = Get-LatestPackageVersion -PackageId $runtimePackageId -Source $PackageSource
$resolvedRuntimeVersion = Get-ResolvedPackageVersion -AssetsFilePath $assetsFile -PackageId $runtimePackageId

Assert-True ($resolvedRuntimeVersion -eq $latestRuntimeVersion) (
    "Generated project restored QaaS.Runner $resolvedRuntimeVersion, but the latest published version on '$PackageSource' is $latestRuntimeVersion."
)

Write-Host "Validated $templatePackageId using $runtimePackageId $resolvedRuntimeVersion."
