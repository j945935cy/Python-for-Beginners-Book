param(
    [string]$Root = ".",
    [string]$ConfigPath = "book.config.yaml",
    [string]$MetadataPath = "meta/metadata.yaml",
    [string]$OutputPath = "output/epub/python-for-beginners.epub",
    [switch]$Build
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

function Split-ConfigList {
    param([string]$Value)

    if (-not $Value) {
        return @()
    }
    return @($Value -split "," | ForEach-Object { $_.Trim() } | Where-Object { $_ })
}

$rootPath = Resolve-Path $Root
Push-Location $rootPath
try {
    $config = Read-BookConfig -Path $ConfigPath
    if ($config.ContainsKey("metadata_path") -and $MetadataPath -eq "meta/metadata.yaml") {
        $MetadataPath = $config["metadata_path"]
    }
    if ($config.ContainsKey("epub_output") -and $OutputPath -eq "output/epub/python-for-beginners.epub") {
        $OutputPath = $config["epub_output"]
    }

    $failures = New-Object System.Collections.Generic.List[string]

    $pandoc = Get-Command pandoc -ErrorAction SilentlyContinue
    if (-not $pandoc -and (Test-Path "C:\Program Files\Pandoc\pandoc.exe")) {
        $pandoc = @{ Source = "C:\Program Files\Pandoc\pandoc.exe" }
    }
    if (-not $pandoc) {
        $failures.Add("Pandoc was not found in PATH or C:\Program Files\Pandoc\pandoc.exe.")
    }

    if (-not (Test-Path $MetadataPath)) {
        $failures.Add("Metadata file is missing: $MetadataPath")
    } else {
        $metadata = Get-Content $MetadataPath -Raw -Encoding UTF8
        foreach ($field in @("title", "author", "language", "identifier", "cover-image")) {
            if ($metadata -notmatch "(?m)^$field\s*:") {
                $failures.Add("Metadata field is missing: $field")
            }
        }
        $coverMatch = [regex]::Match($metadata, '(?m)^cover-image\s*:\s*"?([^"\r\n]+)"?')
        if ($coverMatch.Success -and -not (Test-Path $coverMatch.Groups[1].Value.Trim())) {
            $failures.Add("Cover image from metadata is missing: $($coverMatch.Groups[1].Value.Trim())")
        }
    }

    $chapters = @()
    $chapterDir = if ($config.ContainsKey("chapter_dir")) { $config["chapter_dir"] } else { "src" }
    $chapterIndex = if ($config.ContainsKey("chapter_index")) { $config["chapter_index"] } else { Join-Path $chapterDir "index.md" }

    if (Test-Path $chapterIndex) {
        $chapters += Get-Item $chapterIndex
    }
    if (Test-Path $chapterDir) {
        $chapters += Get-ChildItem $chapterDir -Filter "*.md" |
            Where-Object { $_.FullName -ne (Resolve-Path $chapterIndex -ErrorAction SilentlyContinue).Path } |
            Sort-Object Name
    }
    if ($chapters.Count -eq 0) {
        $failures.Add("No Markdown chapters found under src/.")
    }

    if ($failures.Count -gt 0) {
        $failures | ForEach-Object { Write-Host "[FAIL] $_" -ForegroundColor Red }
        exit 1
    }

    Write-Host "[OK] EPUB preflight passed." -ForegroundColor Green
    Write-Host "[OK] Chapters: $($chapters.Count)"

    if ($Build) {
        if ($config.ContainsKey("epub_build_command")) {
            Invoke-Expression $config["epub_build_command"]
        } elseif (Test-Path "package.json") {
            npm run build:epub
        } elseif (Test-Path "scripts/build-epub.ps1") {
            powershell -ExecutionPolicy Bypass -File "scripts/build-epub.ps1"
        } else {
            & $pandoc.Source @($chapters.FullName) --metadata-file=$MetadataPath --resource-path="." --toc -o $OutputPath
        }
    }

    if ($Build -or (Test-Path $OutputPath)) {
        if (-not (Test-Path $OutputPath)) {
            Write-Host "[FAIL] EPUB output is missing: $OutputPath" -ForegroundColor Red
            exit 1
        }
        $epub = Get-Item $OutputPath
        if ($epub.Length -le 0) {
            Write-Host "[FAIL] EPUB output is empty: $OutputPath" -ForegroundColor Red
            exit 1
        }
        Write-Host "[OK] EPUB output: $OutputPath ($($epub.Length) bytes)" -ForegroundColor Green
    }
}
finally {
    Pop-Location
}
