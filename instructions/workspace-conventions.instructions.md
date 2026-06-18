---
description: "Use for general workspace conventions, file organization, naming patterns, and project structure for the Pact Community enterprise workspace."
applyTo: "**"
---
# Workspace Conventions

> **MANDATORY before creating any file/dir.** Also check `docs/memory/FILE-REGISTRY.md`.

## Canonical Structure (single git repo at the repository root)

- `.github/` — ALL agent configs; never place configs outside. Subdirs: `copilot-instructions.md` (always-on prompt), `agents/`, `instructions/` (`*.instructions.md`), `skills/` (`*/SKILL.md`), `prompts/`, `hooks/` (event JSON).
- `_archive/` — READ-ONLY history: `README.md`; `pact-examples/` (pre-ADR-012); `equity/` (shelved, full git history); `website-root-stale/` (superseded by `web-examples/`); `workspace-history/` (old planning/init docs).
- `docs/` — inter-agent comms:
  - `memory/` (session-start memory — read once per session): `INDEX.md` (entry point — read first), `PROJECT-STATE.md` (cross-project status), `FILE-REGISTRY.md` (anti-duplication registry), `SESSION-LOG.md` (append-only handoff log), `*.md` (domain memory).
  - `mailboxes/` (per-agent JSON), `tasks/` (queue), `status/` (`dashboard.json`), `artifacts/` (agent scans/bundles/reports).
- `pact-examples/` — DAO smart contracts:
  - `pact/modules/` (ACTIVE `.pact`: `dao.pact`, `dao-types.pact`, `dao-gas-station.pact`), `pact/interfaces/`, `pact/tests/` (ACTIVE `.repl`), `pact/deploy/`, `pact/kda-env/` (keyset/env).
  - `ts/src/` (client/utils), `ts/scripts/` (deploy/seed/diagnostic), `ts/tests/devnet/` (integration).
  - `docs/adr/` (ADR-001..012; 012 current), `docs/processes/` (PROC-001..018 runbooks), `docs/AUDIT-REPORT-ADR012-2026-06.md` (CURRENT audit — CONDITIONAL PASS), `docs/*.md` (architecture/API/capability).
  - `devnet/` (certs/config), `scripts/` (monitoring), `docker-compose.*.yml` (per-agent devnet), `CHANGELOG.md`, `README.md`, `TESTNET-DEPLOYMENT-SUMMARY.md`.
- `ledger-examples/` — Ledger hardware wallet signer (separate git repo): `packages/` (core, cli, web).
- `mcp/` — MCP servers (pact, chainweb, coordination): `packages/` (per-server).
- `web-examples/` — Web codebase (separate git repo, AUTHORITATIVE): `apps/` (marketing/, stakeholder-app/, admin-app/), `packages/` (pact-bindings/, ui/, web-config/), `e2e/` (Playwright), `scripts/` (web build/audit), `docs/` (ADRs/ops/backlog), `infra/` (Terraform/Cloudflare), `docs/artifacts/` (Playwright artifacts — NOT agent memory), `AGENTS.md` (website-scoped notes).
- `scripts/` (root) — full-stack ops: `mvp-up.sh`, `mvp-down.sh`, `mvp-status.sh`, `web-restart.sh` (web dev server only).
- Root files: `.git/`, `.gitignore`, `enterprise.code-workspace`, `package.json` (minimal: format scripts only), `README.md`, `AGENTS.md` (root runtime notes), `COOKBOOK.md` (dev quick-ref, live), `MVP-USER-MANUAL.md` (end-user MVP guide, live).

## File Placement Rules

| File type | Correct location | NEVER in |
|-----------|-----------------|----------|
| Pact contract (`.pact`) | `pact-examples/pact/modules/` | root, pact-examples/, elsewhere |
| Pact REPL test (`.repl`) | `pact-examples/pact/tests/` | pact-examples/ root, elsewhere |
| DAO TS deploy/seed script | `pact-examples/ts/scripts/` | pact-examples/ts/ root |
| DAO TS devnet test | `pact-examples/ts/tests/devnet/` | pact-examples/ts/ root |
| DAO ADR | `pact-examples/docs/adr/ADR-0NN-name.md` | elsewhere |
| DAO runbook (PROC-*) | `pact-examples/docs/processes/` | elsewhere |
| DAO architecture/API doc | `pact-examples/docs/` | pact-examples/ root |
| Agent behavioral rule | `.github/instructions/topic.instructions.md` | root, docs/ |
| Agent skill | `.github/skills/skill-name/SKILL.md` | root, docs/ |
| Agent prompt | `.github/prompts/action.prompt.md` | root |
| Agent definition | `.github/agents/Name.agent.md` | root |
| Cross-project status | `docs/memory/PROJECT-STATE.md` | elsewhere |
| Security finding | `docs/memory/security-findings.md` | elsewhere |
| Session handoff | `docs/memory/SESSION-LOG.md` (append) | elsewhere |
| New canonical artifact | register in `docs/memory/FILE-REGISTRY.md` | — |
| Agent coordination artifact | `docs/artifacts/` | root, .github/ |
| Web app code | `web-examples/apps/<app>/src/` | root apps/ (stale) |
| Web shared package | `web-examples/packages/<pkg>/src/` | root packages/ (stale) |
| Web E2E test | `web-examples/e2e/tests/` | root e2e/ (stale) |
| Web operational script | `web-examples/scripts/` | root scripts/ |
| Enterprise operational script | `scripts/` (root) | web-examples/scripts/ |
| Archived/obsolete content | `_archive/` with a README | active tree |

### Anti-duplication rules
1. Check `docs/memory/FILE-REGISTRY.md` before creating any doc; UPDATE the canonical file if it exists.
2. Never create `STATUS.md`/`TODO.md`/`NOTES.md` in project dirs — use `docs/memory/` files.
3. Never create a second ADR index — use `pact-examples/docs/adr/INDEX.md`.
4. Debug/temp files belong in `pact-examples/ts/` root only during active debugging, then move to `_archive/pact-examples/legacy-typescript/`.
5. Runtime artifacts (`.log`, `.pid`) are gitignored — never commit them.

> Current per-project status: see docs/memory/PROJECT-STATE.md.

## Naming Conventions

| Artifact | Pattern | Example |
|----------|---------|---------|
| Instructions file | `{topic}.instructions.md` | `pact-rules.instructions.md` |
| Skill | `{skill-name}/SKILL.md` | `pact-repl-testing/SKILL.md` |
| Prompt | `{action}.prompt.md` | `deploy-dao.prompt.md` |
| Agent | `{AgentName}.agent.md` | `Developer.agent.md` |
| ADR | `ADR-{NNN}-{kebab-name}.md` | `ADR-012-single-module-consolidation.md` |
| Process | `PROC-{NNN}-{kebab-name}.md` | `PROC-018-testnet06-dao-deploy.md` |
| Devnet compose | `docker-compose.{agent}.yml` | `docker-compose.tester.yml` |
| Test file | `{scope}-{description}.test.ts` | `tester-sec005-consolidated.test.ts` |
