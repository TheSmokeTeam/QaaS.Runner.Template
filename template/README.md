# QaaS Runner Project

This project was created from the `QaaS.Runner.Template` dotnet template pack.

## Included Files

- `QaaS.Runner.Template/Program.cs`
- `QaaS.Runner.Template/test.qaas.yaml`
- `QaaS.Runner.Template/executable.yaml`

## Quick Start

```bash
dotnet restore
dotnet run --project QaaS.Runner.Template/QaaS.Runner.Template.csproj -- template
dotnet run --project QaaS.Runner.Template/QaaS.Runner.Template.csproj -- run
dotnet run --project QaaS.Runner.Template/QaaS.Runner.Template.csproj -- execute executable.yaml
```

Update the metadata placeholders in `test.qaas.yaml`, then add the data sources, sessions, and assertions your test flow needs.
