$ErrorActionPreference = "Stop"

& "$PSScriptRoot/build-html.ps1"
& "$PSScriptRoot/build-epub.ps1"

Write-Host "All builds completed."
