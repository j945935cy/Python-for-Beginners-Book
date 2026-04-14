$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

function New-HtmlColor {
    param(
        [string]$Hex,
        [int]$Alpha = 255
    )

    $color = [System.Drawing.ColorTranslator]::FromHtml($Hex)
    return [System.Drawing.Color]::FromArgb($Alpha, $color.R, $color.G, $color.B)
}

function Get-RoundRectPath {
    param(
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [int]$Radius
    )

    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $diameter = $Radius * 2

    $path.AddArc($X, $Y, $diameter, $diameter, 180, 90)
    $path.AddArc($X + $Width - $diameter, $Y, $diameter, $diameter, 270, 90)
    $path.AddArc($X + $Width - $diameter, $Y + $Height - $diameter, $diameter, $diameter, 0, 90)
    $path.AddArc($X, $Y + $Height - $diameter, $diameter, $diameter, 90, 90)
    $path.CloseFigure()

    return $path
}

$width = 1600
$height = 2560
$bitmap = New-Object System.Drawing.Bitmap $width, $height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$fullRect = New-Object System.Drawing.Rectangle 0, 0, $width, $height
$bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush $fullRect, (New-HtmlColor "#0f172a"), (New-HtmlColor "#1d4ed8"), 45
$graphics.FillRectangle($bgBrush, $fullRect)

$graphics.FillEllipse((New-Object System.Drawing.SolidBrush (New-HtmlColor "#22d3ee" 70)), -120, -80, 860, 860)
$graphics.FillEllipse((New-Object System.Drawing.SolidBrush (New-HtmlColor "#a78bfa" 85)), 1020, 1450, 680, 680)
$graphics.FillEllipse((New-Object System.Drawing.SolidBrush (New-HtmlColor "#38bdf8" 45)), 1140, -120, 520, 520)

$gridPen = New-Object System.Drawing.Pen -ArgumentList (New-HtmlColor "#ffffff" 22), 2
for ($i = 0; $i -lt $width; $i += 120) {
    $graphics.DrawLine($gridPen, $i, 0, $i, $height)
}
for ($j = 0; $j -lt $height; $j += 120) {
    $graphics.DrawLine($gridPen, 0, $j, $width, $j)
}

$panelPath = Get-RoundRectPath -X 96 -Y 1540 -Width 1408 -Height 620 -Radius 36
$panelBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(72, 15, 23, 42))
$panelPen = New-Object System.Drawing.Pen -ArgumentList ([System.Drawing.Color]::FromArgb(95, 255, 255, 255)), 2
$graphics.FillPath($panelBrush, $panelPath)
$graphics.DrawPath($panelPen, $panelPath)

$tagBrush = New-Object System.Drawing.SolidBrush (New-HtmlColor "#67e8f9")
$titleBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
$subBrush = New-Object System.Drawing.SolidBrush (New-HtmlColor "#dbeafe")
$mutedBrush = New-Object System.Drawing.SolidBrush (New-HtmlColor "#cbd5e1")

$fontTag = New-Object System.Drawing.Font("Segoe UI", 26, [System.Drawing.FontStyle]::Bold)
$fontTitleCn = New-Object System.Drawing.Font("Microsoft JhengHei UI", 52, [System.Drawing.FontStyle]::Bold)
$fontTitleEn = New-Object System.Drawing.Font("Segoe UI", 34, [System.Drawing.FontStyle]::Regular)
$fontBody = New-Object System.Drawing.Font("Consolas", 25, [System.Drawing.FontStyle]::Regular)
$fontAuthor = New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)

$bookTitle = [string]([char[]](80,121,116,104,111,110,32,31243,24335,35373,35336,20837,38272))
$bookSubtitle = [string]([char[]](24478,32,48,32,21040,32,70,117,110,99,116,105,111,110))
$bookTagline = [string]([char[]](28165,26970,12289,30333,35441,12289,36969,21512,31532,19968,27425,23416,32,80,121,116,104,111,110,32,30340,20320))

$graphics.DrawString("BEGINNER FRIENDLY", $fontTag, $tagBrush, 112, 150)
$graphics.DrawString($bookTitle, $fontTitleCn, $titleBrush, 108, 230)
$graphics.DrawString($bookSubtitle, $fontTitleEn, $subBrush, 112, 345)
$graphics.DrawString($bookTagline, $fontTitleEn, $mutedBrush, 112, 420)

$snippet = @"
def greet(name):
    print("Hello, " + name)

for i in range(3):
    greet("Python")
"@
$graphics.DrawString($snippet, $fontBody, $titleBrush, 148, 1655)

$authorPath = Get-RoundRectPath -X 110 -Y 2360 -Width 220 -Height 84 -Radius 22
$authorFill = New-Object System.Drawing.SolidBrush (New-HtmlColor "#111827" 155)
$authorPen = New-Object System.Drawing.Pen -ArgumentList (New-HtmlColor "#67e8f9" 200), 2
$graphics.FillPath($authorFill, $authorPath)
$graphics.DrawPath($authorPen, $authorPath)
$graphics.DrawString("J5", $fontAuthor, $titleBrush, 190, 2384)

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$metaCover = Join-Path $root "meta/cover.png"
$docsCover = Join-Path $root "docs/assets/images/cover.png"

$bitmap.Save($metaCover, [System.Drawing.Imaging.ImageFormat]::Png)
$bitmap.Save($docsCover, [System.Drawing.Imaging.ImageFormat]::Png)

$graphics.Dispose()
$bitmap.Dispose()

Write-Host "Modern cover generated: $metaCover"
Write-Host "Modern cover generated: $docsCover"
