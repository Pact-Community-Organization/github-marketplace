---
description: "Runtime guardrails for .github/hooks and .github/scripts (pre/post-tool, session start/end). Use for hooks/scripts work or blocked guardrail commands."
applyTo: ".github/hooks/**,.github/scripts/**"
---

# GitHub Runtime Guardrails

> Baseline summary is always-on in `copilot-instructions.md`. This is the full mechanism reference.

## Purpose

Enforced runtime guardrails implemented in `.github/hooks/*.json` and `.github/scripts/*.sh` — reduce destructive operations, enforce Pact static-check discipline, detect secret leakage in modified files.

## Mandatory hook behavior

- `PreToolUse` MUST run `bash .github/scripts/pre-tool-use.sh`.
- `PostToolUse` MUST run `bash .github/scripts/post-tool-use.sh`.
- `SessionStart` MUST emit the memory protocol reminder for non-trivial tasks.
- `SessionEnd` MUST run `bash .github/scripts/session-end-secrets-scan.sh`.

`pre-tool-use.sh`: applies only to `run_in_terminal` calls; blocks configured destructive patterns (exit `2`); blocks Pact deploy-like commands unless static check confirmed by operator workflow.
`post-tool-use.sh`: applies only to file-edit events (`create_file`, `replace_string_in_file`, `insert_edit_into_file`); runs `.github/scripts/pact-static-check.sh` automatically for `.pact`/`.repl` edits.
`session-end-secrets-scan.sh`: scans modified text files for high-signal secret patterns; warn (default) or block mode; writes structured JSON log entries.

## Environment variables

Pre-tool: `SKIP_TOOL_GUARD=true` bypasses pre-tool command blocking.
Secrets scan: `SKIP_SECRETS_SCAN=true` (skip entirely); `SCAN_MODE` = `warn` (default) | `block`; `SCAN_SCOPE` = `diff` (default) | `staged`; `SECRETS_LOG_DIR` (default `.github/logs/copilot/secrets`); `SECRETS_ALLOWLIST` (comma-separated regex to suppress known-safe matches).

## Logging requirements

- Secrets scan MUST append JSON line events to `${SECRETS_LOG_DIR}/scan.log`.
- Minimum events: `scan_complete` (mode, scope, status `no_files`|`clean`); `secrets_found` (mode, scope, scanned file count, finding count).
- On findings, console output MUST include `FILE|LINE|PATTERN|SEVERITY|SNIPPET` rows for operator review.

## Break-glass policy

- Temporary and explicit; only for emergency debugging/recovery. Approved toggles: `SKIP_TOOL_GUARD=true`, `SKIP_SECRETS_SCAN=true`. MUST be time-bounded and followed by restoration of default guardrails.

## Prohibited patterns

Pre-tool guard blocks terminal commands matching high-risk patterns:
- Recursive deletion / destructive VCS (`rm -rf`, `git reset --hard`, `git push --force`, `git commit --amend`).
- Forced container deletion / destructive SQL (`docker rm -f`, `drop table`, `drop database`, `truncate ...`).
- Dangerous permission / remote execution (`chmod 777`, `curl | bash`, `wget | sh|bash`).
- High-risk publish/elevation (`npm publish`, `sudo`).
- Pact deploy-like commands without guardrail workflow confirmation.

Do not weaken these patterns in-place without coordinated review.

## Adoption rules (.github provenance)

- Adopted from awesome-copilot (adapted): tool execution guardian, secret leak scanning, governance threat categorization.
- Adapt-only: broad generic workflows/instructions — filter to Pact/KDA-CE and the Pact Community role model.
- Ignored by default: auto-commit session automation, domain-irrelevant agent/instruction packs.

Do not weaken these patterns in-place without coordinated review.