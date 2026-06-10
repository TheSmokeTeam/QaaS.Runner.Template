# AGENTS.md — QaaS.Runner.Template

Guidance for AI agents working in this repository.

## What this repo is

The `dotnet new` template package for QaaS test-runner projects.

- Install: `dotnet new install QaaS.Runner.Template` → instantiate: `dotnet new qaas-runner -n Org.Project`
- Package: `QaaS.Runner.Template` (PackageType=Template); template identity `SmokeTeam.QaaS.Runner.Project`.
- Generated project: net10.0 Exe, one-line `Program.cs` (`QaaS.Runner.Bootstrap.New(args).Run();`), `test.qaas.yaml` starter config, NuGet.config, reference to `QaaS.Runner` with `Version="*"` (floats to latest).
- Run a generated project: `dotnet run -- run test.qaas.yaml`.

## Layout

- `QaaS.Runner.Template.Package.csproj` — packs `template/**` into `content/` (IncludeBuildOutput=false, NoBuild=true, EnableDefaultCompileItems=false).
  Pack: `dotnet pack .\QaaS.Runner.Template.Package.csproj -c Release -p:PackageVersion=<v> -o .\artifacts\package`
- `template/.template.config/template.json` — sourceName replacement, `skipRestore` symbol + restore post-action.
- `template/QaaS.Runner.Template/` — the templated project; `template/QaaS.Runner.Template.sln`.
- `.github/workflows/ci.yml` — windows-latest: pack + smoke-test instantiation.

## Template validation loop (the test for any change here)

```powershell
dotnet pack .\QaaS.Runner.Template.Package.csproj -c Release -p:PackageVersion=9.9.9 -o .\artifacts\package
dotnet new install .\artifacts\package\QaaS.Runner.Template.9.9.9.nupkg
dotnet new qaas-runner -o sandbox -n Test.Project
dotnet build sandbox
dotnet new uninstall QaaS.Runner.Template   # ALWAYS — the template cache poisons the next install
Remove-Item sandbox -Recurse -Force
```

## Gotchas

- **Template caching**: `dotnet new uninstall` before any reinstall; use an isolated `DOTNET_CLI_HOME` for clean CI-like checks.
- **sourceName replacement covers project/solution names only** — content namespaces and YAML references are not rewritten unless template.json says so.
- `Version="*"` in the generated csproj means air-gapped consumers must pin or mirror QaaS.Runner.
- Package version (e.g. 1.3.3) and template identity version (1.2.2) drift independently — that is expected.
- CI smoke test runs from the project root — keep paths relative to it.

## Process

Changes follow the QaaS harness pipeline (plan → contract → implement → adversarial evaluation, rubric ≥7/10 per dimension). The acceptance evidence for template changes is ALWAYS a successful pack → install → instantiate → build → uninstall loop. Conventional commits.
