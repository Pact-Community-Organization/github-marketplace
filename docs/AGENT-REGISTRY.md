# Agent Registry

Canonical agent definitions for this repository.

## Canonical Agent Files

- `agents/admin.agent.md`: Central coordinator for intake triage, delegation, quality-gate tracking, and final synthesis.
- `agents/architect.agent.md`: System design and architecture decisions for Pact/KDA-CE implementations.
- `agents/developer.agent.md`: Implementation agent for Pact modules, integration code, and engineering fixes.
- `agents/tester.agent.md`: QA and validation agent for deterministic test execution and gate verdicts.
- `agents/security.agent.md`: Security review agent for vulnerability analysis, threat modeling, and mitigation guidance.
- `agents/devops.agent.md`: CI/CD and deployment operations agent for reproducible release workflows.
- `agents/product.agent.md`: Product planning agent for requirements, priorities, and acceptance criteria.
- `agents/docs.agent.md`: Documentation agent for technical docs, changelogs, and onboarding guidance.
- `agents/support.agent.md`: Support and triage agent for issue routing, troubleshooting, and feedback handling.
- `agents/auditor.agent.md`: Independent-style external audit agent for formal security and risk assessments.
- `agents/intake.agent.md`: User-facing clarification agent that turns rough requests into precise task prompts.
- `agents/github-architect.agent.md`: Automation governance agent for `.github/` workflow and policy design.

## Naming Rules

- Use lowercase canonical naming only: `*.agent.md`.
- Do not add case-variant duplicates (for example, `Developer.agent.md`).
- Use `Admin` as the coordination role name (not `Orchestrator`).

## Model Default

All canonical agents use:

- `model: ["Auto"]`
