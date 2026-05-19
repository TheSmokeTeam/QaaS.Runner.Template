# QaaS.Runner.Template

Installable `dotnet new` template for new QaaS runner repos.

## Install

```bash
dotnet new install QaaS.Runner.Template
# or
dotnet new install .\QaaS.Runner.Template.<version>.nupkg
# or, from this repo root
dotnet new install .
```

## Create

```bash
dotnet new qaas-runner -n MyCompany.QaaS.Runner
```

The generated repo includes:
- `NuGet.config` using `QAAS_NUGET_SOURCE_URL`
- `QaaS.Runner` with `Version="*"` so restore pulls the latest stable version from the configured feed
- a minimal valid `test.qaas.yaml`
- explicit YAML startup through `dotnet run -- run test.qaas.yaml`

If you restore from a private feed or local Artifactory, set `QAAS_NUGET_SOURCE_URL` before restoring the generated project.

## Pack Locally

```bash
dotnet pack .\QaaS.Runner.Template.Package.csproj -p:PackageVersion=1.3.3 -o .\artifacts\package
dotnet new install .\artifacts\package\QaaS.Runner.Template.1.3.3.nupkg
dotnet new qaas-runner -n MyCompany.QaaS.Runner
```

Run the generated project from the project directory with:

```bash
dotnet run -- run test.qaas.yaml
```
