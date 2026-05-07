param(
    [string]$Root = ".",
    [string]$ConfigPath = "book.config.yaml",
    [string]$CommitMessage = "Publish textbook site",
    [string]$Remote = "origin",
    [switch]$DryRun
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
    git rev-parse --is-inside-work-tree | Out-Null

    $config = Read-BookConfig -Path $ConfigPath
    $currentBranch = git branch --show-current
    if (-not $currentBranch) {
        Write-Host "[FAIL] Could not determine the current git branch." -ForegroundColor Red
        exit 1
    }
    git remote get-url $Remote | Out-Null

    $upstream = git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>$null
    if (-not $upstream) {
        Write-Host "[WARN] Current branch '$currentBranch' has no upstream. Push will use '$Remote HEAD'." -ForegroundColor Yellow
    }

    if ($config.ContainsKey("html_build_command")) {
        Invoke-Expression $config["html_build_command"]
    } elseif (Test-Path "package.json") {
        npm run build:html
    } elseif (Test-Path "scripts/build-html.ps1") {
        powershell -ExecutionPolicy Bypass -File "scripts/build-html.ps1"
    } else {
        Write-Host "[FAIL] No HTML build command found." -ForegroundColor Red
        exit 1
    }

    $required = if ($config.ContainsKey("pages_required_files")) {
        Split-ConfigList $config["pages_required_files"]
    } else {
        @("index.html", "assets/css/site.css", "assets/js/site.js")
    }
    foreach ($path in $required) {
        if (-not (Test-Path $path)) {
            Write-Host "[FAIL] Missing required Pages file: $path" -ForegroundColor Red
            exit 1
        }
    }

    $workflow = if ($config.ContainsKey("pages_workflow")) { $config["pages_workflow"] } else { ".github/workflows/deploy-pages.yml" }
    if (-not (Test-Path $workflow)) {
        Write-Host "[WARN] No Pages workflow found at $workflow. Push may not deploy Pages automatically." -ForegroundColor Yellow
    }

    $status = git status --short
    if (-not $status) {
        Write-Host "[OK] Build passed, but there are no changes to publish." -ForegroundColor Green
        exit 0
    }

    Write-Host "[INFO] Changes to publish:"
    $status | ForEach-Object { Write-Host "  $_" }

    if ($DryRun) {
        Write-Host "[OK] Dry run passed. No commit or push was performed." -ForegroundColor Green
        exit 0
    }

    $addPaths = if ($config.ContainsKey("pages_git_add_paths")) {
        Split-ConfigList $config["pages_git_add_paths"]
    } else {
        @("index.html", "output/html", "assets", "docs", "404.html")
    }
    Write-Host "[INFO] Staging paths:"
    $addPaths | ForEach-Object { Write-Host "  $_" }
    git add @addPaths
    git commit -m $CommitMessage
    git push $Remote HEAD

    Write-Host "[OK] Pushed Pages update. Check GitHub Actions for deployment status." -ForegroundColor Green
}
finally {
    Pop-Location
}
