param(
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [int]$MaxParagraphChars = 260
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $Path)) {
    Write-Host "[FAIL] Chapter file is missing: $Path" -ForegroundColor Red
    exit 1
}

$text = Get-Content $Path -Raw -Encoding UTF8
$failures = New-Object System.Collections.Generic.List[string]

$utf8 = [System.Text.Encoding]::UTF8
$required = @(
    "5pys56ug6YeN6bue",
    "5qaC5b+16Kqq5piO",
    "56+E5L6L56iL5byP",
    "56iL5byP6Kej6Kqq",
    "5bi46KaL6Yyv6Kqk",
    "57e057+S6aGM",
    "5bCP57WQ"
) | ForEach-Object { $utf8.GetString([Convert]::FromBase64String($_)) }
$lastIndex = -1
foreach ($heading in $required) {
    $pattern = '(?m)^#{2,3}\s+' + [regex]::Escape($heading) + '\s*$'
    $match = [regex]::Match($text, $pattern)
    if (-not $match.Success) {
        $failures.Add("Missing section: $heading")
    } elseif ($match.Index -lt $lastIndex) {
        $failures.Add("Section is out of order: $heading")
    } else {
        $lastIndex = $match.Index
    }
}

$forbiddenPatterns = @{
    "class definitions" = "(?m)^\s*class\s+\w+"
    "decorators" = "(?m)^\s*@\w+"
    "generators" = "(?m)\byield\b"
    "module import lessons" = "(?m)^\s*(import|from)\s+\w+"
}

foreach ($item in $forbiddenPatterns.GetEnumerator()) {
    if ($text -match $item.Value) {
        $failures.Add("Potential advanced topic found: $($item.Key)")
    }
}

if ($text -notmatch '```python') {
    $failures.Add("No fenced Python code block found.")
}

$paragraphs = $text -split "(\r?\n){2,}" | Where-Object {
    $trimmed = $_.Trim()
    $trimmed -and
    $trimmed -notmatch "^#" -and
    $trimmed -notmatch '^```' -and
    $trimmed.Length -gt $MaxParagraphChars
}

if ($paragraphs.Count -gt 0) {
    $failures.Add("Found $($paragraphs.Count) paragraph(s) longer than $MaxParagraphChars characters.")
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Host "[FAIL] $_" -ForegroundColor Red }
    exit 1
}

Write-Host "[OK] Textbook chapter passed: $Path" -ForegroundColor Green
