---
name: security-audit
description: "Comprehensive security audit methodology for Pact 5 smart contracts. 5-phase audit protocol, finding classification, and audit report generation."
---
# Security Audit

## 5-Phase Audit Protocol

### Phase 1: Architecture Review
- Review module dependency DAG
- Identify trust boundaries
- Map capability hierarchy
- Check governance model

## Vulnerability Classification

### Critical
- **Unguarded fund transfer** — transfer without capability check
- **Governance bypass** — admin function callable without governance
- **Infinite mint** — token creation without supply constraint
- **Reentrancy** — state modified after cross-module call

### High
- **Logic error with financial impact** — incorrect formula, rounding error
- **Capability composition gap** — bypass via unexpected composition path
- **Time manipulation** — front-running time-dependent operations

### Medium
- **Gas griefing** — operations with attacker-controlled gas cost
- **Information disclosure** — sensitive data in error messages or reads
- **Phantom reads** — with-default-read returning exploitable defaults

### Low
- **Missing events** — critical operations without @event
- **Unused capabilities** — dead code in capability definitions
- **Documentation gaps** — undocumented security assumptions

### Assessment Process Step
For each entry point: what can go wrong? (STRIDE)

### Phase 2: Code Review
- Line-by-line review of all .pact files
- Check for Pact 5 critical traps
- Verify all write paths are guarded
- Check all enforce conditions

### Phase 3: Capability Audit
- Map all capabilities and their guards
- Verify composition chains
- Check @managed cap scoping
- Test grant/revoke paths

### Phase 4: Attack Simulation
- Design exploit attempts for each STRIDE category
- Test on dedicated devnet (port 8083)
- Attempt every identified attack vector
- Document results (success = CRITICAL finding)

### Phase 5: Report Generation
```markdown
## Security Audit Report — {module/project}
Date: YYYY-MM-DD
Auditor: [Security]

### Summary
Findings: {N critical, N high, N medium, N low}
Verdict: [Security] [APPROVE|REJECT]

### Findings
#### {SEVERITY}-{NNN}: {Title}
Category: {STRIDE category}
Location: {file:line}
Description: {what's wrong}
Impact: {what could happen}
Proof: {evidence or PoC}
Recommendation: {how to fix}
Status: {Open|Fixed|Accepted}
```
