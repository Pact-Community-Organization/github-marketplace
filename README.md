# Pact Agent Marketplace

**24 Pact/KDA-CE skills · 8 role-based agents · 18 instruction files · 24 prompts**

Domain-specific AI agent configuration for Kadena / Pact 5 smart contract development.
Installable in one command for Claude Code, Codex, Gemini CLI, and GitHub Copilot.

[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue?style=flat-square)](LICENSE)
[![Release](https://img.shields.io/github/v/release/Pact-Community-Organization/github-marketplace?style=flat-square&label=release)](https://github.com/Pact-Community-Organization/github-marketplace/releases)

---

## Install

### Claude Code
```bash
claude plugins add Pact-Community-Organization/github-marketplace
```

### Codex
```bash
codex plugins add Pact-Community-Organization/github-marketplace
```

### Gemini CLI
```bash
gemini extension install https://github.com/Pact-Community-Organization/github-marketplace
```

### GitHub Copilot / any tool (copy-paste fallback)
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Pact-Community-Organization/github-marketplace/main/scripts/install.sh) /path/to/your-repo
```

Or clone and run manually:
```bash
git clone https://github.com/Pact-Community-Organization/github-marketplace.git
bash github-marketplace/scripts/install.sh /path/to/your-repo
```

See [docs/agent-portability.md](docs/agent-portability.md) for per-tool setup details and what each install method provides.

---

## What's Inside

This repository ships **only Pact/Kadena domain content** — no generic software-engineering
skills. The quality bar is the Pact 5 / KDA-CE production stack.

### Skills (24) — Pact 5 / KDA-CE domain only

| Theme | Skills |
|---|---|
| Core language | `pact-capabilities`, `pact-guards`, `pact-schema-design`, `pact-module-design`, `pact-interface-design`, `pact-defpact`, `pact-events`, `pact-architecture`, `pact-invariants` |
| Testing & tooling | `pact-repl-testing`, `pact-devnet-testing`, `pact-module-validation`, `pact-cli-tooling`, `debug-pact`, `static-analysis` |
| Security & audit | `pact-security-review`, `capability-analysis`, `compliance-verification`, `formal-verification` |
| Gas & cross-chain | `pact-gas-analysis`, `gas-station-design`, `cross-chain-design` |
| Platform | `kda-ce-compliance`, `devnet-management` |

### Agents (8) — role-based multi-agent system

| Agent | Role |
|---|---|
| Admin | Coordinator — task delegation, quality-gate tracking, final synthesis |
| Architect | System design — ADRs, API design, cross-chain flows, gas budgets |
| Developer | Implementation — smart contracts, integration code, REPL tests |
| Tester | QA — adversarial validation, GO/NO-GO decisions |
| Security | Threat modeling, capability audit, deployment blocking |
| Auditor | External-style audit — formal verdict, PoC exploits, 7-phase methodology |
| DevOps | CI/CD, deployments, release operations |
| Docs | API docs, guides, changelogs, Mermaid diagrams |

### Instructions (18)

Always-on and scoped guidance: `pact-rules`, `pact-traps`, `coding-rules`, `testing-rules`,
`security-rules`, `architecture-rules`, `deployment-rules`, `gas-optimization`,
`clarification-protocol`, `workspace-conventions`, `cross-module-rules`,
`diagnostic-integrity-rules`, `refactoring-rules`, `self-audit-checklist`,
`commit-conventions`, `github-guardrails`, `inter-agent-protocol`, `quality-gate-rules`.

### Prompts (24)

Reusable task prompts for Pact architecture, implementation, review, security, validation,
and multi-agent coordination workflows.

### Hooks + CI scripts

Four Claude Code hook files (`pre-tool-use`, `post-tool-use`, `session-start`, `session-end`)
backed by portable shell scripts in `.github/scripts/`. Includes `pact-static-check.sh`,
the static analysis gate that enforces 0 violations before any `.pact`/`.repl` change ships.

---

## Naming Conventions

- Agent files: lowercase `*.agent.md`
- Skills: `skills/<name>/SKILL.md`
- Instructions: `*.instructions.md`
- Prompts: `*.prompt.md`

---

## Community Health

- [CONTRIBUTING.md](CONTRIBUTING.md)
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
- [SECURITY.md](SECURITY.md)
- [SUPPORT.md](SUPPORT.md)
- [CHANGELOG.md](CHANGELOG.md)
- [LICENSE](LICENSE)
