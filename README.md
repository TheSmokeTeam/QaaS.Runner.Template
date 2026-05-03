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
- `NuGet.config` pointing at `nuget.org` by default, with template parameters to override the feed name and URL at creation time
- `QaaS.Runner` with `Version="4.*"` so restore pulls the latest stable `4.x.x` version from the configured feed
- a minimal valid `test.qaas.yaml`
- explicit YAML startup through `dotnet run -- run test.qaas.yaml`

Create a private-feed project directly from the template with:

```bash
dotnet new qaas-runner -n MyCompany.QaaS.Runner --nugetFeedName qaas-private --nugetFeedUrl https://artifactory.example/api/nuget/qaas/index.json
```

If you publish a separate internal template package, keep the source tree shared and change only the `defaultValue` entries for `nugetFeedName` and `nugetFeedUrl` in `template/.template.config/template.json` before packing the internal variant.

## Pack Locally

```bash
dotnet pack .\QaaS.Runner.Template.Package.csproj -p:PackageVersion=1.3.4 -o .\artifacts\package
dotnet new install .\artifacts\package\QaaS.Runner.Template.1.3.4.nupkg
dotnet new qaas-runner -n MyCompany.QaaS.Runner
```

Run the generated project from the project directory with:

```bash
dotnet run -- run test.qaas.yaml
```
