$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$docsPath = Join-Path $root "docs"

Set-Location $docsPath

if (Get-Command py -ErrorAction SilentlyContinue) {
    py -m http.server 8000
}
elseif (Get-Command python -ErrorAction SilentlyContinue) {
    python -m http.server 8000
}
else {
    Write-Error "Python is not installed or not available in PATH."
    exit 1
}
