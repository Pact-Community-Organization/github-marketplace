---
name: ponytail-audit
description: "Audit skill for verifying that Pact Community changes follow minimal-first execution and preserve mandatory safety safeguards."
---

# Ponytail Audit Skill

## Purpose

Audit completed work for compliance with Ponytail minimalism plus Pact Community safety requirements.

## Audit Criteria

1. Correct ladder usage (lowest viable step chosen).
2. No unrequested abstraction.
3. No avoidable dependency additions.
4. Diff is minimal and behavior-preserving.
5. Safeguards preserved: trust boundaries, data-loss safety, security, accessibility.
6. Temporary ceilings are documented with `ponytail:` + upgrade trigger.

## Output Format

- `Audit Result:` `pass`, `pass-with-notes`, or `fail`.
- `Violations:` itemized criterion failures with severity.
- `Required Fixes:` smallest corrections to regain compliance.
- `Residual Risk:` what remains if no further work is done.
