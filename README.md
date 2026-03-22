# QaaS.Runner.Template

Installable `dotnet new` template pack for creating Rider-friendly QaaS runner projects.

## What This Repo Publishes

- Template package ID: `QaaS.Runner.Template`
- Template short name: `qaas-runner`
- Template display name in IDEs: `QaaS Runner Project`

After the template pack is installed, Rider and the `dotnet new` CLI can create a new QaaS runner project with:

- `Program.cs` wired to `QaaS.Runner.Bootstrap.New(args).Run()`
- `NuGet.config` defaulting to `nuget.org`
- `QaaS.Runner` referenced with `Version="*"` so restore resolves the latest stable package on the configured feed
- `test.qaas.yaml` with temporary metadata placeholders and otherwise empty sections that already lint and run successfully
- Rider launch arguments preconfigured as `run test.qaas.yaml`

## Download Options

The easiest public install path is the latest GitHub release asset:

- `QaaS.Runner.Template.<version>.nupkg`

Download it from this repository's Releases page, then install it with `dotnet new install`.

## Install From a Downloaded Release

1. Download `QaaS.Runner.Template.<version>.nupkg` from Releases.
2. Install it:

```bash
dotnet new install .\QaaS.Runner.Template.<version>.nupkg
```

3. Verify it is available:

```bash
dotnet new list qaas-runner
```

## Install Directly From a Local Clone

From the repository root:

```bash
dotnet new install .
```

This is the fastest way to test local changes before packaging a release.

To run the full local validation flow that packs, installs, generates a repo, restores, builds, and runs the default config:

```powershell
.\tools\Validate-Template.ps1
```

## Create a New Runner Project

CLI:

```bash
dotnet new qaas-runner -n MyCompany.QaaS.Runner
```

Rider:

1. Install the template pack with `dotnet new install`.
2. Open Rider.
3. Go to `New Solution` or `New Project`.
4. Open the `.NET` templates list.
5. Search for `QaaS Runner Project` or `qaas`.
6. Create the project.

If Rider was already open before installation, refresh the new project dialog or restart Rider.

The generated project includes a `launchSettings.json` profile named `QaaS Runner` with `run test.qaas.yaml`, so the first local run in Rider is already pointed at the bundled YAML. The YAML is intentionally minimal but valid, which makes it safe to smoke-test immediately and then replace the placeholder metadata and add your real sessions and assertions.

If you restore from a private feed or local Artifactory, update the generated `NuGet.config` before the first restore.

## Uninstall

```bash
dotnet new uninstall QaaS.Runner.Template
```

To see everything currently installed:

```bash
dotnet new uninstall
```

## Update

If you installed from release assets, the safe update path is:

1. Uninstall the old pack:

```bash
dotnet new uninstall QaaS.Runner.Template
```

2. Download the newer release asset.
3. Install the newer `.nupkg`:

```bash
dotnet new install .\QaaS.Runner.Template.<new-version>.nupkg
```

## Install a Specific Version

Pick the exact release you want from GitHub Releases, download its `.nupkg`, then install that file:

```bash
dotnet new install .\QaaS.Runner.Template.<version>.nupkg
```

If you are installing from a package feed, the supported CLI syntax for a fixed version is:

```bash
dotnet new install QaaS.Runner.Template::<version>
```

## Build the Template Pack Locally

```bash
dotnet pack .\QaaS.Runner.Template.Package.csproj -c Release -o .\artifacts
```

That produces a `.nupkg` you can install locally with `dotnet new install`.

## Generated Project

The files copied into new projects live under the `template/` folder in this repository.
