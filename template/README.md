# QaaS Runner Project

This project was created from the `QaaS.Runner.Template` dotnet template pack.

## Included Defaults

- `NuGet.config` restores from `QAAS_NUGET_SOURCE_URL`
- `Program.cs` runs `QaaS.Runner.Bootstrap.New(args).Run()`
- `test.qaas.yaml` contains only placeholder metadata and one minimal session
- Rider launch settings use `run test.qaas.yaml`

## First Run

```bash
export QAAS_NUGET_SOURCE_URL=https://api.nuget.org/v3/index.json
dotnet restore --configfile NuGet.config --source "$QAAS_NUGET_SOURCE_URL"
dotnet run --project QaaS.Runner.Template/QaaS.Runner.Template.csproj -- run test.qaas.yaml
```

Replace the placeholder metadata and expand the session before using the project for real workloads.

If you restore from a private feed or local Artifactory, set `QAAS_NUGET_SOURCE_URL` before restoring.
