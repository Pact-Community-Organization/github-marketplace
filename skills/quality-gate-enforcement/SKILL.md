---
name: quality-gate-enforcement
description: "Verify quality gate pass/fail criteria at each stage of the Three-Gate Model. Ensure all prerequisites met before proceeding to next phase."
---
# Quality Gate Enforcement

Gate pass/fail criteria: see `quality-gate-rules.instructions.md` (canonical).

## Gate 1 — Pre-Code
**Verifier**: Admin
**Inputs**: Product requirements, Architect design

### On Pass → Notify Developer to begin implementation

## Gate 2 — Pre-Merge
**Verifier**: Admin
**Inputs**: Tester report, Security report

### On Pass → Approve merge, notify DevOps for deploy

## Gate 3 — Pre-Deploy
**Verifier**: Admin
**Inputs**: DevOps readiness, Gate 2 results

### On Pass → Authorize deployment
