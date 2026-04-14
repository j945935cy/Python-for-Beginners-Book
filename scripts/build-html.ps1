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

New-Item -ItemType Directory -Force -Path "docs" | Out-Null
New-Item -ItemType Directory -Force -Path "output/html" | Out-Null

pandoc @chapters `
  --metadata-file="meta/metadata.yaml" `
  --standalone `
  --toc `
  --css="assets/css/site.css" `
  -o "docs/index.html"

Copy-Item "docs/index.html" "output/html/index.html" -Force
if (Test-Path "output/html/assets") {
    Remove-Item "output/html/assets" -Recurse -Force
}
Copy-Item "docs/assets" "output/html/assets" -Recurse -Force

Write-Host "HTML build completed: docs/index.html and output/html/index.html"
