---
name: textbook-generator
description: Create, revise, and check beginner-friendly Markdown textbook chapters. Use for Traditional Chinese Python beginner book writing, required chapter structure enforcement, Taiwan terminology, short teaching paragraphs, executable examples, and avoiding advanced topics beyond functions.
---

# Textbook Generator

## Workflow

1. Read the project instructions first. For this repo, use `AGENTS.md`; for reusable projects, look for an equivalent authoring guide.
2. Load `references/style-guide.md` when drafting or reviewing chapter content.
3. Match the existing chapter rhythm: short sections, clear examples, executable Python 3 code, and one core idea per example.
4. Do not introduce classes, modules, decorators, generators, or other advanced syntax unless the project instructions explicitly change.
5. Run `scripts/Test-TextbookChapter.ps1` on new or changed chapter files before finishing.

## Required Chapter Shape

Each chapter must contain the seven required sections in the order documented in `references/style-guide.md`. Keep the exact Chinese heading text from that reference when writing chapters.

## Commands

Check one chapter:

```powershell
powershell -ExecutionPolicy Bypass -File .\codex\skills\textbook-generator\scripts\Test-TextbookChapter.ps1 -Path .\src\10-function.md
```

Check all chapters:

```powershell
Get-ChildItem .\src -Filter "*.md" | ForEach-Object {
  powershell -ExecutionPolicy Bypass -File .\codex\skills\textbook-generator\scripts\Test-TextbookChapter.ps1 -Path $_.FullName
}
```
