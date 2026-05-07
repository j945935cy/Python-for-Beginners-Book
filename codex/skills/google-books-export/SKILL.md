---
name: google-books-export
description: Prepare and validate EPUB export packages for Google Books or Google Play Books upload. Use when Codex needs to check EPUB output, metadata, cover image, zh-TW language settings, required identifiers, and produce an upload-ready package without live Google Books API publishing.
---

# Google Books Export

## Workflow

1. Build or verify the EPUB first. Prefer using `$epub-builder` or the project EPUB command.
2. Read `book.config.yaml` when present for EPUB path, metadata path, export directory, and expected language.
3. Run `scripts/New-GoogleBooksExport.ps1` from the repo root.
4. Confirm the export folder contains the EPUB, cover image, metadata copy, and checklist.
5. Report upload readiness and any missing fields. Do not claim the book was uploaded unless a real Google Books API or connector workflow performed the upload.

## Commands

Create the export package:

```powershell
powershell -ExecutionPolicy Bypass -File .\codex\skills\google-books-export\scripts\New-GoogleBooksExport.ps1
```

Use a different EPUB:

```powershell
powershell -ExecutionPolicy Bypass -File .\codex\skills\google-books-export\scripts\New-GoogleBooksExport.ps1 -EpubPath .\output\epub\python-for-beginners.epub
```

## Reference

Read `references/upload-checklist.md` when preparing final user-facing upload notes or diagnosing metadata gaps.
