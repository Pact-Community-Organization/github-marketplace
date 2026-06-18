---
description: "Use when converting files to Markdown with MarkItDown, enabling OCR/plugins, running MarkItDown MCP, or preparing document-ingestion workflows."
---

# MarkItDown Integration Rules

## Scope

Use this guidance when tasks require converting PDFs, Office files, HTML, or other sources into Markdown using `markitdown`, `markitdown-ocr`, or `markitdown-mcp`.

## Installation Baseline

Prefer an isolated virtual environment at workspace root:

```bash
python3 -m venv .venv-markitdown
source .venv-markitdown/bin/activate
pip install --upgrade pip
pip install "markitdown[all]" markitdown-mcp markitdown-ocr openai
```

Verify installation:

```bash
markitdown --version
markitdown --list-plugins
markitdown-mcp --help
```

## Runtime Rules

1. Prefer `markitdown` CLI or Python API for local one-shot conversions.
2. Use `--use-plugins` only when plugin behavior is needed.
3. If OCR plugin is enabled, provide both `llm_client` and `llm_model`; otherwise OCR is skipped.
4. Use optional dependency sets when appropriate (`[pdf]`, `[docx]`, etc.); use `[all]` for broad ingestion coverage.
5. Use `markitdown-mcp` only when an MCP tool interface is explicitly required by a host/client workflow.

## Security Rules

1. Treat untrusted paths and URIs as high risk. MarkItDown can access local/network resources with current process privileges.
2. Prefer narrower APIs over permissive entry points in server-side code paths:
   - `convert_local()` for local files only
   - `convert_stream()` for caller-controlled streams
   - `convert_response()` for pre-fetched responses
3. If running `markitdown-mcp --http`, bind to localhost only unless explicit user approval is provided for wider exposure.
4. Do not pass secrets into converted content unless the user explicitly requests it.

## Agent Usage Guidance

- Primary users: `Docs`, `Support`, `Product`
- Secondary users: `Developer`, `Architect`, `WebDev`, `Auditor`, `Security`, `Tester`
- Not a replacement for Pact Community blockchain MCP tools (`pact`, `chainweb`, `coordination`); use those for blockchain and coordination operations.
