---
name: ponytail
description: "Minimal-first implementation skill for the project agents: six-step ladder to deliver the smallest correct change with safeguards."
---

# Ponytail Skill

## Purpose

Deliver the smallest correct change first, escalate complexity only when required.

## 6-Step Ladder

1. YAGNI: no change if behavior is already correct.
2. Reuse existing existing project patterns and local code.
3. Use native/runtime/platform features.
4. Reuse already-installed dependencies.
5. Prefer one-liner or tiny patch.
6. Add minimal new implementation only with an explicit trigger to grow.

## Hard Rules

- No unrequested abstractions.
- No avoidable dependencies.
- Prefer deletion/simplification over addition.
- Choose the shortest diff that preserves correctness.

## Safety Carve-Outs (Always)

- Validate trust boundaries.
- Keep data-loss-safe behavior.
- Preserve security controls.
- Preserve accessibility in user-facing flows.

## Shortcut Annotation

When shipping a temporary ceiling, add a `ponytail:` comment naming:
- ceiling
- upgrade trigger

## Output Format

- `Decision:` chosen ladder step and why lower steps were insufficient.
- `Patch Shape:` files touched and why the diff is minimal.
- `Safety Checks:` trust boundary, data-loss, security, accessibility status.
- `Ceiling:` `ponytail:` note text (or `none`).
