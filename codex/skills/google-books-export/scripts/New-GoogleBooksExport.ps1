param(
    [string]$Root = ".",
    [string]$ConfigPath = "book.config.yaml",
    [string]$EpubPath = "output/epub/python-for-beginners.epub",
    [string]$MetadataPath = "meta/metadata.yaml",
    [string]$ExportDir = "output/google-books"
)

$ErrorActionPreference = "Stop"

function Read-BookConfig {
    param([string]$Path)

    $config = @{}
    if (-not (Test-Path $Path)) {
        return $config
    }

    foreach ($line in Get-Content $Path -Encoding UTF8) {
        $trimmed = $line.Trim()
        if (-not $trimmed -or $trimmed.StartsWith("#")) {
            continue
        }
        $match = [regex]::Match($trimmed, '^([A-Za-z0-9_-]+)\s*:\s*(.*)$')
        if ($match.Success) {
            $value = $match.Groups[2].Value.Trim().Trim('"').Trim("'")
            $config[$match.Groups[1].Value] = $value
        }
    }
    return $config
}

$rootPath = Resolve-Path $Root
Push-Location $rootPath
try {
    $config = Read-BookConfig -Path $ConfigPath
    if ($config.ContainsKey("epub_output") -and $EpubPath -eq "output/epub/python-for-beginners.epub") {
        $EpubPath = $config["epub_output"]
    }
    if ($config.ContainsKey("metadata_path") -and $MetadataPath -eq "meta/metadata.yaml") {
        $MetadataPath = $config["metadata_path"]
    }
    if ($config.ContainsKey("google_books_export_dir") -and $ExportDir -eq "output/google-books") {
        $ExportDir = $config["google_books_export_dir"]
    }
    $expectedLanguage = if ($config.ContainsKey("google_books_language")) { $config["google_books_language"] } else { "zh-TW" }

    $failures = New-Object System.Collections.Generic.List[string]

    if (-not (Test-Path $EpubPath)) {
        $failures.Add("EPUB is missing: $EpubPath")
    }
    if (-not (Test-Path $MetadataPath)) {
        $failures.Add("Metadata is missing: $MetadataPath")
    }

    $metadata = ""
    if (Test-Path $MetadataPath) {
        $metadata = Get-Content $MetadataPath -Raw -Encoding UTF8
        foreach ($field in @("title", "author", "language", "identifier", "cover-image")) {
            if ($metadata -notmatch "(?m)^$field\s*:") {
                $failures.Add("Metadata field is missing: $field")
            }
        }
        $languagePattern = '(?m)^language\s*:\s*"?' + [regex]::Escape($expectedLanguage) + '"?'
        if ($metadata -notmatch $languagePattern) {
            $failures.Add("Metadata language should be $expectedLanguage.")
        }
    }

    $coverPath = $null
    $coverMatch = [regex]::Match($metadata, '(?m)^cover-image\s*:\s*"?([^"\r\n]+)"?')
    if ($coverMatch.Success) {
        $coverPath = $coverMatch.Groups[1].Value.Trim()
        if (-not (Test-Path $coverPath)) {
            $failures.Add("Cover image is missing: $coverPath")
        }
    }

    if ($failures.Count -gt 0) {
        $failures | ForEach-Object { Write-Host "[FAIL] $_" -ForegroundColor Red }
        exit 1
    }

    New-Item -ItemType Directory -Force -Path $ExportDir | Out-Null
    Copy-Item $EpubPath (Join-Path $ExportDir (Split-Path $EpubPath -Leaf)) -Force
    Copy-Item $MetadataPath (Join-Path $ExportDir (Split-Path $MetadataPath -Leaf)) -Force
    if ($coverPath) {
        Copy-Item $coverPath (Join-Path $ExportDir (Split-Path $coverPath -Leaf)) -Force
    }

    $checklist = @"
# Google Books Export Checklist

- [x] EPUB included: $(Split-Path $EpubPath -Leaf)
- [x] Metadata included: $(Split-Path $MetadataPath -Leaf)
- [x] Cover included: $(Split-Path $coverPath -Leaf)
- [x] Language checked: $expectedLanguage
- [x] Identifier present
- [ ] Upload manually in Google Books/Google Play Books Partner Center

Generated from: $((Resolve-Path ".").Path)
"@
    Set-Content -Path (Join-Path $ExportDir "upload-checklist.md") -Value $checklist -Encoding UTF8

    Write-Host "[OK] Google Books export package created: $ExportDir" -ForegroundColor Green
}
finally {
    Pop-Location
}
