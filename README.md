# QaaS.Runner.Template

Installable `dotnet new` template pack for creating Rider-friendly QaaS runner projects.

## What This Repo Publishes

- Template package ID: `QaaS.Runner.Template`
- First release: `1.0.0`
- Template short name: `qaas-runner`
- Template display name in IDEs: `QaaS Runner Project`

After the template pack is installed, Rider and the `dotnet new` CLI can create a new QaaS runner project with:

- `Program.cs` wired to `QaaS.Runner.Bootstrap.New(args).Run()`
- the latest runner package pinned in this release: `QaaS.Runner` `4.1.0-alpha.3`
- `test.qaas.yaml` with temporary metadata placeholders
- `executable.yaml`

## Release 1.0.0

Release `1.0.0` ships the file:

- `QaaS.Runner.Template.1.0.0.nupkg`

Download it from the GitHub Releases page for this repository, then install it with `dotnet new install`.

## Install From a Downloaded Release

1. Download `QaaS.Runner.Template.1.0.0.nupkg` from the `1.0.0` release.
2. Install it:

```bash
dotnet new install .\QaaS.Runner.Template.1.0.0.nupkg
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
dotnet new install .\QaaS.Runner.Template.1.0.0.nupkg
```

If the pack is published to a NuGet feed later, the supported CLI syntax for a fixed version is:

```bash
dotnet new install QaaS.Runner.Template::1.0.0
```

## Build the Template Pack Locally

```bash
dotnet pack .\QaaS.Runner.Template.Package.csproj -c Release -o .\artifacts
```

That produces a `.nupkg` you can install locally with `dotnet new install`.

## Generated Project

The files copied into new projects live under [template](D:\QaaS\QaaS.Runner.Template\template).

The generated project entrypoint is [Program.cs](D:\QaaS\QaaS.Runner.Template\template\QaaS.Runner.Template\Program.cs).
