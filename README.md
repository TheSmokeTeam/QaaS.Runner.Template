# QaaS.Runner.Template

Installable `dotnet new` template pack for creating Rider-friendly QaaS runner projects.

## What This Repo Publishes

- Template package ID: `QaaS.Runner.Template`
- Current release: `1.1.0`
- Template short name: `qaas-runner`
- Template display name in IDEs: `QaaS Runner Project`

After the template pack is installed, Rider and the `dotnet new` CLI can create a new QaaS runner project with:

- `Program.cs` wired to `QaaS.Runner.Bootstrap.New(args).Run()`
- `QaaS.Runner` pinned to the latest published package at packaging time: `4.1.0-alpha.15`
- `test.qaas.yaml` with temporary metadata placeholders and otherwise empty sections
- Rider launch arguments preconfigured as `run test.qaas.yaml`

## Download Options

The easiest public install path is the GitHub release asset:

- `QaaS.Runner.Template.1.1.0.nupkg`

Download it from the `1.1.0` release page for this repository, then install it with `dotnet new install`.

This package can also be installed from GitHub Packages if you have a token that can read packages from `TheSmokeTeam`.

## Install From a Downloaded Release

1. Download `QaaS.Runner.Template.1.1.0.nupkg` from the `1.1.0` release.
2. Install it:

```bash
dotnet new install .\QaaS.Runner.Template.1.1.0.nupkg
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

## Install From GitHub Packages

GitHub Packages for NuGet requires authentication. After configuring your GitHub package source, install a specific version with:

```bash
dotnet new install QaaS.Runner.Template::1.1.0 --add-source https://nuget.pkg.github.com/TheSmokeTeam/index.json
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

The generated project includes a `launchSettings.json` profile named `QaaS Runner` with `run test.qaas.yaml`, so the first local run in Rider is already pointed at the bundled YAML. That YAML is intentionally empty apart from metadata placeholders, so it must be filled in before execution will validate successfully.

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
dotnet new install .\QaaS.Runner.Template.1.1.0.nupkg
```

If you are installing from a package feed, the supported CLI syntax for a fixed version is:

```bash
dotnet new install QaaS.Runner.Template::1.1.0
```

## Build the Template Pack Locally

```bash
dotnet pack .\QaaS.Runner.Template.Package.csproj -c Release -o .\artifacts
```

That produces a `.nupkg` you can install locally with `dotnet new install`.

## Generated Project

The files copied into new projects live under the `template/` folder in this repository.
