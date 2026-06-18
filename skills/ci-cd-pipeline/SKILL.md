---
name: ci-cd-pipeline
description: "GitHub Actions CI/CD pipeline design for Pact 5 and TypeScript: workflow templates, test automation, deploy gates, artifact management for KDA-CE."
---
# CI/CD Pipeline

## Pipeline Stages
```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]
jobs:
  repl-tests:
    # Run Pact REPL tests
  typescript-tests:
    # Run vitest
  devnet-deploy:
    # Deploy to devnet and run integration tests
    needs: [repl-tests, typescript-tests]
  security-scan:
    # Static analysis for Pact traps
```

## Gate Integration
- REPL + TypeScript tests → auto-run on every PR
- Devnet deploy → requires PR review approval
- Testnet deploy → requires Tester GO + Security APPROVE
- Mainnet deploy → requires Admin + all gates

## Artifact Management
- Pact module source: versioned in git
- Deploy scripts: versioned alongside modules
- Gas measurements: stored as CI artifacts

## Notifications
- Test failures → notify Developer
- Security scan findings → notify Security
- Deploy success/failure → notify DevOps + Admin
