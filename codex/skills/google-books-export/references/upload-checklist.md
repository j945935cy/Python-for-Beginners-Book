# Google Books Upload Checklist

Use this checklist before telling the user an export is ready for Google Books or Google Play Books.

## Required Files

- EPUB file
- Cover image
- Metadata source file
- Upload checklist or notes

## Metadata Checks

- Title is present.
- Author is present.
- Language is `zh-TW` for this Traditional Chinese edition.
- Identifier is present and stable.
- Publisher is present when available.
- Rights statement is present.
- Description is present.
- Cover image path exists.

## Content Checks

- Chapter order is correct.
- Table of contents is generated.
- Code blocks render legibly.
- Images referenced by Markdown are included in the EPUB.
- The book does not go beyond the intended beginner scope.

## Publishing Boundary

This skill prepares files for upload. It does not upload to Google Books unless a future connector or explicit API credential workflow is added.
