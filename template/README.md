# QaaS Runner Project

This project was created from the `QaaS.Runner.Template` dotnet template pack.

## Included Defaults

- `Program.cs` runs `QaaS.Runner.Bootstrap.New(args).Run()`
- `test.qaas.yaml` starts empty except for temporary metadata placeholders
- Rider launch settings use `run test.qaas.yaml`

## First Run

```bash
dotnet restore
dotnet run --project QaaS.Runner.Template/QaaS.Runner.Template.csproj -- run test.qaas.yaml
```

Replace the placeholder metadata values and add your own sessions and assertions before using the project. The bundled YAML is intentionally empty, so execution will fail validation until you fill it in.
