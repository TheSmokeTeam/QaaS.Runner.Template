# Copilot instructions — QaaS.Runner.Template

Read `AGENTS.md` at the repo root first.

Essentials:
- `dotnet new` template package: content lives under `template/`, packed by `QaaS.Runner.Template.Package.csproj` (PackageType=Template, NoBuild).
- Short name `qaas-runner`; generated project references `QaaS.Runner` `Version="*"` and runs via `dotnet run --project <name>.csproj -- run test.qaas.yaml`.
- Acceptance evidence for any change: pack → `dotnet new install` → `dotnet new qaas-runner` → build sandbox → `dotnet new uninstall` (uninstall is mandatory; cache poisons reinstalls).
- sourceName replacement does NOT rewrite namespaces/YAML content — only project/solution names.
