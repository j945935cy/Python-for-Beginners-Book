$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $root

$pandocCommand = Get-Command pandoc -ErrorAction SilentlyContinue
if (-not $pandocCommand -and (Test-Path "C:\Program Files\Pandoc\pandoc.exe")) {
    $pandocCommand = @{ Source = "C:\Program Files\Pandoc\pandoc.exe" }
}

if (-not $pandocCommand) {
    Write-Host ""
    Write-Host "Pandoc was not found, so the EPUB build cannot continue." -ForegroundColor Yellow
    Write-Host "Please install Pandoc and make sure it is available in PATH." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "On Windows, you can try:" -ForegroundColor Cyan
    Write-Host "  winget install --id JohnMacFarlane.Pandoc"
    Write-Host ""
    Write-Host "After installation, verify it with:" -ForegroundColor Cyan
    Write-Host "  pandoc --version"
    Write-Host ""
    Write-Host "Pandoc installation guide:" -ForegroundColor Cyan
    Write-Host "  https://pandoc.org/installing.html"
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

& $pandocCommand.Source @chapters `
  --metadata-file="meta/metadata.yaml" `
  --resource-path="." `
  --toc `
  --css="style/ebook.css" `
  -o "output/epub/python-for-beginners.epub"

Write-Host "EPUB build completed: output/epub/python-for-beginners.epub"
