---
name: system-architecture
description: "System-level architecture design for KDA-CE Pact 5 smart contracts: ADRs, module decomposition, cross-chain patterns, tradeoffs."
---
# System Architecture

> Canonical traps: [../../instructions/pact-traps.instructions.md](../../instructions/pact-traps.instructions.md)

## Architecture Decision Records (ADRs)
Capture every significant design decision:
```
# ADR-{NNN}: {Title}
Status: Proposed | Accepted | Deprecated | Superseded
Date: YYYY-MM-DD
Context: Why this decision is needed
Decision: What was decided
Consequences: Trade-offs accepted
```

## Module Decomposition Criteria
- Single responsibility per module
- Deploy-transaction gas ≤ 150k KDA-CE ceiling (this is the per-**transaction** ceiling, not a per-module quota; a single module that exceeds it must be split or deployed across steps)
- Clear capability boundary (what each module guards)
- Minimal cross-module writes (prefer read + local compute)

## Architecture Review Checklist
- [ ] Gas budget estimated for all public functions
- [ ] Cross-chain flow designed where needed
- [ ] Module dependency DAG is acyclic
- [ ] Schema evolution strategy (with-default-read for migrations)
- [ ] Failure modes documented
- [ ] Interface contracts defined
