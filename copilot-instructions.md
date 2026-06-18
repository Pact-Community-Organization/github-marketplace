# Pact agent system — Tier 1 (always-on router)

An agent system for **Pact 5** smart contract development. Pact runs on multiple platforms; these defaults target **Kadena Community Edition (KDA-CE)** — adapt them to whichever Pact platform your project targets.

## Session start (read once)

If your project uses the `docs/memory/` coordination convention, read `INDEX.md` → `PROJECT-STATE.md` ONCE per session (not auto-loaded), then rely on that context — do NOT re-read them each task. Check a file registry (if present) before creating a file. Scope/identity/irreversible-action and file-placement gates are enforced by the always-on `clarification-protocol` and `workspace-conventions` — follow them, do not restate.

## Universal non-negotiables (no narrower home)

- Pact deploys require `.github/scripts/pact-static-check.sh` exit 0 — never bypass.
- Transparency-first: business-critical state and final outcomes on-chain by default; justify any off-chain logic.
- Stability over churn: no architecture-changing refactor without a problem statement, alternatives, and ADR approval.
- Code-touching work is minimal-first (`ponytail` skill) unless the user explicitly overrides.

## Read only what the task needs

Your context already lists every instruction (with its `applyTo`), skill, and agent description — trust those to self-route; do not duplicate them here. Beyond that auto-routing:

- Domain rules load by path: Pact → `pact-rules` (`*.pact`/`*.repl`); TS SDK → `typescript-sdk`; deploy/gas/security/testing → their `*-rules` instructions.
- Pact language traps: pull the matching section of `pact-traps.instructions.md` on demand — large, not auto-loaded.
- Cross-project status & roles: `docs/memory/PROJECT-STATE.md`, `AGENT-REGISTRY.md`.
- Guardrail mechanism (hooks/scripts, secret scan): `github-guardrails.instructions.md` — loads for `.github/hooks|scripts`.
