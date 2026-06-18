---
name: agent-coordination
description: "Manage inter-agent communication, message routing, conflict resolution, and workflow orchestration across the 9-agent team using hybrid protocol."
---
# Agent Coordination

## Communication Channels

### File-Based (Internal)
- **Task queue**: `docs/tasks/` — JSON task files
- **Mailboxes**: `docs/mailboxes/{agent}.json` — agent-specific messages
- **Status**: `docs/status/dashboard.json` — team-wide status

### GitHub (External)
- PR/issue comments with `[AgentName]` prefix
- Branch-per-feature workflow

## Message Routing Rules
1. User → Admin (always)
2. Admin → Any agent (task delegation)
3. Agent → Admin (results, blockers, questions)
4. Developer ↔ Tester (code handoff, finding discussion)
5. Developer ↔ Security (code handoff, vulnerability discussion)
6. Tester/Security → Admin (GO/NO-GO verdicts)

## Conflict Resolution
1. Tester NO-GO vs Developer disagrees → Admin arbitrates
2. Security CRITICAL vs timeline pressure → Security veto wins
3. Agent overloaded → Admin redistributes or sequences
4. Ambiguous requirement → Escalate to Product via Admin
