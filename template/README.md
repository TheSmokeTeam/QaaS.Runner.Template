# QaaS Runner Project

This project was created from the `QaaS.Runner.Template` dotnet template pack.

## Included Defaults

- `NuGet.config` defaults restores to `nuget.org`
- `Program.cs` runs `QaaS.Runner.Bootstrap.New(args).Run()`
- `test.qaas.yaml` starts with placeholder metadata and otherwise empty sections
- Rider launch settings use `run test.qaas.yaml`

## First Run

```bash
dotnet restore --configfile NuGet.config
dotnet run --project QaaS.Runner.Template/QaaS.Runner.Template.csproj -- run test.qaas.yaml
```

The bundled YAML is intentionally minimal but valid, so the first smoke run succeeds without talking to external systems. Replace the placeholder metadata values and add your own sessions and assertions before using the project for real workloads.
