---
description: "Prefer MCP tools over bespoke code. Three MCP servers: pact, chainweb, coordination. Tool-selection decision tree and mandatory preference rules."

# MCP Tool Usage Guidelines

## Available MCP Servers

This setup provides three live local MCP servers plus the GitHub-hosted MCP server:

| Server | Bin | Tools |
|---|---|---|
| `@smartpacts/mcp-pact` | `smartpacts-pact` | `pact.repl_run`, `pact.module_scan` |
| `@smartpacts/mcp-chainweb` | `smartpacts-chainweb` | `chainweb.info`, `chainweb.chain_time`, `chainweb.local`, `chainweb.send`, `chainweb.poll` |
| `@smartpacts/mcp-coordination` | `smartpacts-coordination` | `coord.task_create`, `coord.task_list`, `coord.task_get`, `coord.task_update`, `coord.task_complete`, `coord.mailbox_send`, `coord.mailbox_read`, `coord.mailbox_ack`, `coord.status_set`, `coord.memory_append` |
| `github` (remote) | `https://api.githubcopilot.com/mcp/` | `context`, `repos`, `issues`, `pull_requests`, `users`, `actions`, `code_security`, `dependabot`, `discussions`, `gists`, `git`, `labels`, `notifications`, `orgs`, `projects`, `secret_protection`, `security_advisories`, `stargazers`, `copilot`, `copilot_spaces`, `github_support_docs_search` |

**Total: 17 tools across 3 local servers + GitHub MCP (GitHub-hosted, evolving toolsets)**

## Mandatory Preference Rule

**When an MCP tool exists for a task, agents MUST use it rather than raw `run_in_terminal` or bespoke scripts.**

Rationale: MCP tools provide audit logging, schema validation, input sanitization, automatic type-unwrapping at the boundary, and devnet-only guarantees that prevent security issues and false positives.

## Decision Table

**"I need to..." → tool**

### Pact Development
- **Run a .repl test** → `pact.repl_run`
- **Scan a .pact file for critical traps** → `pact.module_scan`

### Chainweb Operations
- **Query devnet status or chain info** → `chainweb.info`
- **Get current chain time** → `chainweb.chain_time`
- **Do preflight validation / local call** → `chainweb.local`
- **Submit signed transaction** → `chainweb.send` (always preceded by local preflight — the tool enforces this)
- **Poll for transaction result** → `chainweb.poll` (NOT listen — nginx 504)

### Agent Coordination
- **Create task for delegation** → `coord.task_create`
- **List tasks with filters** → `coord.task_list`
- **Get specific task details** → `coord.task_get`
- **Update task progress/status** → `coord.task_update`
- **Mark task as complete** → `coord.task_complete`
- **Send message to another agent** → `coord.mailbox_send`
- **Read agent inbox** → `coord.mailbox_read`
- **Mark messages as read** → `coord.mailbox_ack`
- **Update agent working status** → `coord.status_set`
- **Record learning or finding** → `coord.memory_append`

### GitHub Operations
- **Read a file from any GitHub repo** → GitHub MCP `repos` toolset (e.g., `get_file_contents`)
- **Search code across repos** → GitHub MCP `repos` / `context` toolsets
- **Read / create / update / comment on issues** → GitHub MCP `issues` toolset
- **Read / create / review / comment / merge PRs** → GitHub MCP `pull_requests` toolset
- **Check CI / workflow runs** → GitHub MCP `actions` toolset
- **Review Dependabot alerts** → GitHub MCP `dependabot` toolset
- **Review code scanning / secret scanning** → GitHub MCP `code_security`, `secret_protection`, `security_advisories`
- **Manage notifications** → GitHub MCP `notifications` toolset
- **Org / project / label / discussion ops** → corresponding toolsets

## GitHub MCP vs gh CLI — preference rules

**PREFER GitHub MCP** for: reading files/code, PR comments, issue triage, workflow inspection, security alerts, repo search, any structured read/write that has an MCP tool

**USE gh CLI** for: interactive auth flows (`gh auth login`), commands GitHub MCP doesn't cover, emergency debugging, scripts that need shell piping

**Rationale**: schema validation, audit trail, structured return values (no stdout parsing), consistent error handling, no shell injection surface

## GitHub MCP security considerations

OAuth scope is user's GitHub permissions — agents inherit full user access

Agents MUST NOT call destructive tools (`delete_*`, force push, branch deletion, release deletion) without explicit human confirmation in the conversation

PR merge, branch protection bypass, repo transfer, webhook creation → ALWAYS require human confirmation

Writing to production branches (`main`, `master`, release branches) → always requires human confirmation

Read operations (get file, list issues, get PR) — no confirmation needed

## When NOT to Use MCP

Use standard terminal tools for:
- Local file edits (use workspace editing tools)
- Git operations (`git add`, `git commit`, `git push`)
- Compilation/build operations (`pnpm build`, `npm run`)
- Activities outside the 17 tool surfaces listed above

## Type-Unwrap Reminder

The chainweb server automatically unwraps Pact JSON types (`{int: N}`, `{decimal: "N.M"}`, `{time: "..."}`) at the boundary. Callers receive plain JavaScript values/strings. This eliminates the #1 devnet false-positive class.

## Security Boundaries

- `networkId=development` enforced — prevents mainnet/testnet accidents
- Path-traversal sanitization rejected — prevents filesystem escape
- Prompt-injection sanitized on read operations
- Root UID refused — prevents privilege escalation
- Environment variable allowlist strict — prevents configuration drift
- `tools.lock.json` drift detection — startup fails if tool schemas change

## Kill Switch

Set `SMARTPACTS_MCP_DISABLED=true` to disable all MCP servers and fall back to bespoke scripts temporarily during emergencies.

## Future Tools

The following tools are planned but not yet implemented — do not invoke:

`pact.repl_run_many`, `pact.gas_estimate`, `pact.interface_diff`, `pact.fmt_check`, `chainweb.read_table`, `chainweb.keys`, `chainweb.continue_pact`, `chainweb.spv_proof`, `chainweb.principal_namespace`, `chainweb.deploy_module`

## Cross-References

- [MCP Tool Use Skill](../skills/mcp-tool-use/SKILL.md) — implementation guidance
- [GitHub MCP Server](https://github.com/github/github-mcp-server) — upstream docs
- [mcp-pact README](../../mcp/packages/mcp-pact/README.md) — pact tool details
- [mcp-chainweb README](../../mcp/packages/mcp-chainweb/README.md) — chainweb tool details
- [mcp-coordination README](../../mcp/packages/mcp-docs/README.md) — coordination tool details