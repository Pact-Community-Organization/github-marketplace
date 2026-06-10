# github-marketplace

Community-safe, production-ready agent system templates for Pact 5 and Kadena Community Edition (KDA-CE) repositories.

## What This Repository Provides

- A complete multi-agent set for development, security, QA, docs, support, product, and governance workflows.
- Reusable instruction, prompt, and skill libraries for Pact/Kadena delivery.
- Copilot hook definitions and script entrypoints for pre/post tool-use automation.
- A clean base that avoids private workspace assumptions while preserving practical KDA-CE guidance.

## Directory Layout

- `agents/`: Canonical agent definitions (`*.agent.md`, lowercase only)
- `skills/`: Domain skills (`skills/<name>/SKILL.md`)
- `instructions/`: Behavioral rules (`*.instructions.md`)
- `prompts/`: Reusable prompt templates (`*.prompt.md`)
- `hooks/`: Copilot hook configuration JSON files
- `.github/scripts/`: Hook runtime scripts called by hook JSON
- `docs/`: Supporting registry and migration docs

## Naming Conventions

- Agent files MUST use lowercase format: `name.agent.md`
- Do not keep case-variant duplicates (example: `Developer.agent.md`)
- One canonical coordination agent name: `Admin` in `agents/admin.agent.md`
- Skills always use `SKILL.md` in a dedicated folder
- Instructions and prompts use suffix-based naming:
	- `*.instructions.md`
	- `*.prompt.md`

## How To Use

### Agents

1. Pick the right agent file in `agents/`.
2. Use `Admin` as the coordination and delegation role.
3. Keep all agent frontmatter model defaults at `Auto`.

### Skills

1. Load `skills/<topic>/SKILL.md` when a task needs domain depth.
2. Keep skills practical and implementation-ready.

### Instructions

1. Apply matching instruction files before implementation.
2. Favor explicit checklists and deterministic rules.

### Prompts

1. Start from `prompts/*.prompt.md` for repeatable operations.
2. Keep prompts specific to scope, inputs, constraints, and deliverables.

### Hooks

1. Hook definitions live in `hooks/*.json`.
2. Runtime scripts live in `.github/scripts/`.
3. Pre-tool and post-tool hooks should be fast, deterministic, and non-destructive.

## Admin Role

The system uses `Admin` (not `Orchestrator`) as the central coordinator agent. `Admin` delegates to specialist agents, enforces quality gates, and synthesizes user-facing outcomes.

## Production Readiness Notes

- Lowercase canonical agent file format enforced
- Duplicate case-variant stubs removed
- Hook commands point to real, versioned scripts
- Agent registry documented in `docs/AGENT-REGISTRY.md`
- Content aligned for Pact/Kadena community usage without private workspace dependencies

## License

Apache-2.0
