# Changelog

All notable changes to Pact Agent Marketplace are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versions follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.1.0] — 2026-06-28

First release as a professional installable product.

### Added

- `AGENTS.md` — compact always-on Pact/KDA-CE instruction set, auto-loaded by Gemini CLI,
  Cursor, Windsurf, Antigravity, CodeWhale, and any tool that reads `AGENTS.md` at the repo root
- `.claude-plugin/marketplace.json` and `.claude-plugin/plugin.json` — Claude Code marketplace
  listing and plugin definition; enables `claude plugins add Pact-Community-Organization/github-marketplace`
- `.codex-plugin/plugin.json` — Codex plugin definition; enables
  `codex plugins add Pact-Community-Organization/github-marketplace`
- `gemini-extension.json` — Gemini CLI extension manifest pointing `contextFileName` at `AGENTS.md`;
  enables `gemini extension install https://github.com/Pact-Community-Organization/github-marketplace`
- `package.json` — npm package metadata at `@pact-community/pact-agents v0.1.0` for discoverability
- `scripts/install.sh` — one-command copy-paste install for GitHub Copilot and any tool without
  native plugin support; works via `bash <(curl -fsSL .../scripts/install.sh)`
- `docs/agent-portability.md` — per-host adapter guide documenting what each install method provides

### Changed

- `README.md` — rewritten to lead with value proposition and four install commands
  (Claude Code, Codex, Gemini CLI, copy-paste); content inventory reorganized by theme

### Content (carried from initial migration, 2026-06-09)

- 24 Pact/KDA-CE skills in `skills/<name>/SKILL.md` format
- 8 role-based agents (Admin, Architect, Developer, Tester, Security, Auditor, DevOps, Docs)
- 18 instruction files scoped by `applyTo` glob
- 24 task prompts for architecture, implementation, review, security, validation, and coordination
- 4 Claude Code hook files + portable shell scripts in `.github/scripts/`
- `pact-ci.yml` GitHub Actions workflow

[0.1.0]: https://github.com/Pact-Community-Organization/github-marketplace/releases/tag/v0.1.0
