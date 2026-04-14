$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $root

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Error "Pandoc is not installed or not available in PATH."
    exit 1
}

$chapters = @(
    "src/index.md",
    "src/01-python-intro.md",
    "src/02-variables-and-types.md",
    "src/03-input-output.md",
    "src/04-operators.md",
    "src/05-if.md",
    "src/06-loop.md",
    "src/07-list.md",
    "src/08-dict.md",
    "src/09-string.md",
    "src/10-function.md"
)

New-Item -ItemType Directory -Force -Path "output/epub" | Out-Null

pandoc @chapters `
  --metadata-file="meta/metadata.yaml" `
  --toc `
  --css="style/ebook.css" `
  --epub-cover-image="meta/cover.png" `
  -o "output/epub/python-for-beginners.epub"

Write-Host "EPUB build completed: output/epub/python-for-beginners.epub"
