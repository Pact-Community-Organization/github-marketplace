# Migration Note (2026-06-18)

Re-synced from the upstream source after an extensive `.github/` refactor.

Imported (sanitized) from local source:
- `.github/agents` (excluding the web-implementation agent)
- `.github/instructions`
- `.github/skills`
- `.github/prompts`
- `.github/hooks`
- `.github/copilot-instructions.md`

Sanitization performed (consistent with the 2026-06-09 migration):
- Replaced project branding with neutral Pact Community language
- Removed enterprise-local filesystem references
- Rewrote internal project-memory references to generic repository documentation references
- Replaced internal project ownership and path assumptions tied to enterprise-only repositories
- Preserved the `Admin` coordination role name (not `Orchestrator`) and lowercase canonical agent filenames

Added:
- `instructions/github-guardrails.instructions.md`
- `instructions/markitdown-integration.instructions.md`
- `skills/markitdown-integration`
- `skills/ponytail`, `skills/ponytail-audit`, `skills/ponytail-debt`, `skills/ponytail-review`
- `hooks/session-end.json`

Removed (project-specific or superseded):
- `instructions/devnet-conventions.instructions.md`
- `instructions/ledger-signer-domain.instructions.md`
- `skills/attack-design`, `skills/vulnerability-assessment` (consolidated upstream)
- `skills/web-architecture`, `skills/web-e2e-testing`, `skills/web-hosting`, `skills/web-security`, `skills/webdev-implementation`
- `skills/ux-requirements`, `skills/ux-writing`
- `agents/webdev.agent.md` (web-implementation agent — out of scope for the generic marketplace)

Excluded as enterprise-private or out of scope:
- `.github/workflows`
- `.github/scripts`
- `.github/ARCHITECTURE-AUDIT.md`
- `.github/AGENTS.md`
- project-domain instructions (`dao-domain`)

Post-migration checks run:
- Forbidden string scan on community-facing docs/config content
- Repository structure validation
