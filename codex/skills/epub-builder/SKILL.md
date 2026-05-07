---
name: epub-builder
description: Build and validate EPUB files for Markdown textbook projects that use Pandoc. Use when Codex needs to preflight chapter order, metadata, cover assets, Pandoc availability, run an EPUB build, or confirm an EPUB output such as output/epub/python-for-beginners.epub is ready.
---

# EPUB Builder

## Workflow

1. Inspect the repo for the build command before assuming paths. Prefer `npm run build:epub`, then `scripts/build-epub.ps1`, then a direct Pandoc command only if no project script exists.
2. Run `scripts/Test-EpubBuild.ps1` from this skill before building. Use `-Build` when the user wants Codex to produce the EPUB in the same step.
3. Treat failed checks as blockers: missing Pandoc, missing metadata, missing cover, empty chapter list, or missing output after build.
4. Keep project defaults unless the repo proves otherwise:
   - metadata: `meta/metadata.yaml`
   - cover: `meta/cover.png`
   - chapters: `src/index.md`, then numbered `src/*.md`
   - output: `output/epub/python-for-beginners.epub`
5. If `book.config.yaml` exists, use it for repo-specific paths and build commands before falling back to defaults.

## Commands

Use from the repo root:

```powershell
powershell -ExecutionPolicy Bypass -File .\codex\skills\epub-builder\scripts\Test-EpubBuild.ps1
powershell -ExecutionPolicy Bypass -File .\codex\skills\epub-builder\scripts\Test-EpubBuild.ps1 -Build
```

If the project has `package.json`, prefer:

```powershell
npm run build:epub
```

## Validation

After building, confirm the EPUB exists and has nonzero size. If Pandoc is missing, report the install command only after verifying the current system cannot find `pandoc`.
