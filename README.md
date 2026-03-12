# QaaS.Runner.Template

Minimal Rider-friendly QaaS runner project template.

## Includes

- `QaaS.Runner` `4.1.0-alpha.3`
- `Program.cs` wired to `QaaS.Runner.Bootstrap.New(args).Run()`
- `test.qaas.yaml` with temporary metadata placeholders
- `executable.yaml` with basic `template` and `run` commands

## Quick Start

```bash
dotnet restore
dotnet run --project QaaS.Runner.Template/QaaS.Runner.Template.csproj -- template
dotnet run --project QaaS.Runner.Template/QaaS.Runner.Template.csproj -- run
dotnet run --project QaaS.Runner.Template/QaaS.Runner.Template.csproj -- execute executable.yaml
```

Update the `MetaData` values in `QaaS.Runner.Template/test.qaas.yaml`, then add data sources, sessions, and assertions for your scenario.
