---
name: ponytail-review
description: "Review skill to detect over-engineering and reduce changes to the smallest safe solution in Pact workflows and code patches."
---

# Ponytail Review Skill

## Purpose

Review existing or proposed changes and identify simplifications that keep required behavior intact.

## Review Checks

1. Can code/config be deleted instead of added?
2. Is any abstraction unrequested by requirements?
3. Is any dependency avoidable with native/platform features?
4. Can the diff be reduced without losing correctness?
5. Are safeguards still intact (trust boundary, data loss, security, accessibility)?

## Output Format

- `Verdict:` `minimal` or `over-engineered`.
- `Findings:` concise list of simplification opportunities.
- `Minimal Alternative:` exact lower-complexity approach.
- `Safety Impact:` what must remain unchanged.
- `Shortcut Note:` required `ponytail:` annotation, if applicable.
