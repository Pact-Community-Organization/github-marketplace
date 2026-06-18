---
name: markitdown-integration
description: "MarkItDown document ingestion workflows for Pact Community: installation, OCR/plugins, MCP startup, and file-to-Markdown routing."
---

# MarkItDown Integration

## Purpose

Use this skill to convert heterogeneous files into Markdown for LLM-ready workflows, documentation migration, artifact ingestion, and content triage.

## What This Skill Covers

- Installing `markitdown` with full optional dependencies
- Enabling and validating third-party plugins
- Running OCR enhancement via `markitdown-ocr`
- Running the `markitdown-mcp` server (stdio or localhost HTTP)
- Selecting which Pact Community agents should apply MarkItDown

## Quick Install (Workspace-Local)

```bash
cd 
python3 -m venv .venv-markitdown
source .venv-markitdown/bin/activate
pip install --upgrade pip
pip install "markitdown[all]" markitdown-mcp markitdown-ocr openai
```

Validation:

```bash
markitdown --version
markitdown --list-plugins
markitdown-mcp --help
printf 'hello\n' | markitdown -x .txt
```

## Dependency Selection Strategy

- Broad ingestion: `pip install "markitdown[all]"`
- Minimal scope example: `pip install "markitdown[pdf,docx,pptx]"`
- Azure Content Understanding: `pip install "markitdown[az-content-understanding]"`
- Azure Document Intelligence: `pip install "markitdown[az-doc-intel]"`
- OCR plugin: `pip install markitdown-ocr openai`

## CLI Workflows

Basic conversion:

```bash
markitdown input.pdf > output.md
markitdown input.pdf -o output.md
cat input.pdf | markitdown > output.md
```

Plugin workflows:

```bash
markitdown --list-plugins
markitdown --use-plugins input.pdf -o output.md
```

Cloud conversion examples:

```bash
markitdown report.pdf -d -e "<document_intelligence_endpoint>" -o report.md
markitdown report.pdf --use-cu --cu-endpoint "<content_understanding_endpoint>" -o report.md
```

## Python API Pattern

```python
from markitdown import MarkItDown
from openai import OpenAI

md = MarkItDown(enable_plugins=True, llm_client=OpenAI(), llm_model="gpt-4o")
result = md.convert("input.pdf")
print(result.text_content)
```

Security-first narrow APIs:

```python
md = MarkItDown()
result = md.convert_local("./local-file.pdf")
```

## MCP Server Pattern

Default stdio:

```bash
markitdown-mcp
```

Localhost HTTP/SSE:

```bash
markitdown-mcp --http --host 127.0.0.1 --port 3001
```

Only expose non-localhost interfaces with explicit approval because the server has no built-in authentication.

## Agent Routing Matrix

| Agent | Use MarkItDown? | Typical Use Cases |
|---|---|---|
| `Docs` | Yes (Primary) | Convert external specs, PDFs, runbooks, and office docs into canonical markdown inputs |
| `Support` | Yes (Primary) | Triage attached customer docs/log exports into searchable markdown |
| `Product` | Yes (Primary) | Convert PRDs, requirement decks, and stakeholder docs for backlog extraction |
| `Developer` | Yes (Secondary) | Convert technical references and migration docs used during implementation |
| `Architect` | Yes (Secondary) | Ingest architecture references and standards docs for ADR drafting |
| `Security` | Yes (Secondary) | Normalize audit artifacts and reports before analysis |
| `Tester` | Yes (Secondary) | Ingest test evidence, exported reports, and QA attachments |
| `Auditor` | Yes (Secondary) | Normalize third-party evidence packs for independent review |
| `WebDev` | Yes (Secondary) | Convert UX specs and design exports to markdown checklists |
| `DevOps` | Limited | Only when parsing external ops docs; not for core infra automation |
| `Admin` | Limited | Route tasks to other agents rather than operating conversions directly |
| `Intake` | Limited | Use only for prompt prep when source docs are non-markdown |

## Non-Goals

- Not a replacement for Pact Community MCP servers (`pact`, `chainweb`, `coordination`)
- Not intended for high-fidelity publishing output; optimized for LLM/text analysis workflows
