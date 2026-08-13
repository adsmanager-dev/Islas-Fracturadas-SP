<#
.SYNOPSIS
    Convierte los emblemas SVG de Islas Fracturadas en texturas .paa para Arma 3.

.DESCRIPTION
    Cadena: art/identity/*.svg  ->  art/export/*.png  ->  IslasFracturadas.Altis/ui/insignia/*_ca.paa

    El script NO asume que las herramientas estén instaladas: las detecta y, si faltan,
    informa exactamente qué falta y dónde obtenerlo, sin dejar salidas a medias.

    Rasterizador (cualquiera de estos, en orden de preferencia):
      - Inkscape        https://inkscape.org
      - ImageMagick     https://imagemagick.org      (comando 'magick')
      - rsvg-convert    (librsvg)
      - Sharp local     tools/if-media-mcp (fallback reproducible del proyecto)

    Conversor PAA (cualquiera de estos, en orden de preferencia):
      - ImageToPAA.exe  incluido en "Arma 3 Tools" (Steam, appid 233800)
      - HEMTT           https://github.com/BrettMayson/HEMTT (binario único, sin Steam;
                         'hemtt utils paa convert') — alternativa cuando no hay cuenta de Steam
                         usable en esta máquina.

    Rutas locales: defínelas por entorno para no versionar rutas de máquina.
      $env:IF_INKSCAPE = 'C:\...\Inkscape\bin\inkscape.com'
      $env:IF_ARMA3_TOOLS = 'C:\...\steamapps\common\Arma 3 Tools'
      $env:IF_HEMTT = 'C:\...\hemtt.exe'

.PARAMETER Size
    Lado en píxeles de la textura. DEBE ser potencia de dos. Insignias: 128.

.PARAMETER WhatIf
    Muestra lo que haría sin escribir nada.

.EXAMPLE
    .\tools\Build-Assets.ps1 -Size 128
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [ValidateScript({
        if ($_ -band ($_ - 1)) { throw "Size debe ser potencia de dos (64, 128, 256, 512, 1024, 2048). Recibido: $_" }
        $true
    })]
    [int]$Size = 128
)

$ErrorActionPreference = 'Stop'
$root     = Split-Path -Parent $PSScriptRoot
$svgDir   = Join-Path $root 'art\identity'
$pngDir   = Join-Path $root 'art\export'
$paaDir   = Join-Path $root 'IslasFracturadas.Altis\ui\insignia'

function Assert-ProjectOutputDirectory {
    param([string]$Directory)

    $fullRoot = [System.IO.Path]::GetFullPath($root).TrimEnd('\') + '\'
    $fullDirectory = [System.IO.Path]::GetFullPath($Directory)
    if (-not $fullDirectory.StartsWith($fullRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Directorio de salida fuera del proyecto: $fullDirectory"
    }
    if (Test-Path -LiteralPath $Directory) {
        $item = Get-Item -LiteralPath $Directory -Force
        if (($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -ne 0) {
            throw "No se permite un enlace como directorio de salida: $Directory"
        }
    }
}

function Find-Rasterizer {
    if ($env:IF_INKSCAPE -and (Test-Path -LiteralPath $env:IF_INKSCAPE)) {
        return @{ Name = 'inkscape'; Path = (Resolve-Path -LiteralPath $env:IF_INKSCAPE).Path }
    }

    $inkscape = Get-Command 'inkscape' -ErrorAction SilentlyContinue
    if ($inkscape) { return @{ Name = 'inkscape'; Path = $inkscape.Source } }

    $magick = Get-Command 'magick' -ErrorAction SilentlyContinue
    if ($magick) { return @{ Name = 'magick'; Path = $magick.Source } }

    $rsvg = Get-Command 'rsvg-convert' -ErrorAction SilentlyContinue
    if ($rsvg) { return @{ Name = 'rsvg'; Path = $rsvg.Source } }

    $node = Get-Command 'node' -ErrorAction SilentlyContinue
    $sharpCli = Join-Path $root 'tools\if-media-mcp\dist\rasterize-cli.js'
    if ($node -and (Test-Path -LiteralPath $sharpCli)) {
        return @{ Name = 'sharp'; Path = $node.Source; Script = $sharpCli }
    }

    return $null
}

function Find-ImageToPAA {
    if ($env:IF_ARMA3_TOOLS) {
        $c = Join-Path $env:IF_ARMA3_TOOLS 'ImageToPAA\ImageToPAA.exe'
        if (Test-Path -LiteralPath $c) { return $c }
        $c = Join-Path $env:IF_ARMA3_TOOLS 'ImageToPAA.exe'
        if (Test-Path -LiteralPath $c) { return $c }
    }
    $cmd = Get-Command 'ImageToPAA.exe' -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }

    foreach ($base in @(
        "${env:ProgramFiles(x86)}\Steam\steamapps\common\Arma 3 Tools",
        "$env:ProgramFiles\Steam\steamapps\common\Arma 3 Tools")) {
        $c = Join-Path $base 'ImageToPAA\ImageToPAA.exe'
        if (Test-Path -LiteralPath $c) { return $c }
    }
    return $null
}

function Find-Hemtt {
    if ($env:IF_HEMTT -and (Test-Path -LiteralPath $env:IF_HEMTT)) {
        return (Resolve-Path -LiteralPath $env:IF_HEMTT).Path
    }
    $hemtt = Get-Command 'hemtt.exe' -ErrorAction SilentlyContinue
    if ($hemtt) { return $hemtt.Source }
    $hemtt = Get-Command 'hemtt' -ErrorAction SilentlyContinue
    if ($hemtt) { return $hemtt.Source }
    return $null
}

# --- Comprobaciones previas: fallar pronto y con un mensaje accionable -------

Assert-ProjectOutputDirectory -Directory $pngDir
Assert-ProjectOutputDirectory -Directory $paaDir

$svgFiles = @(Get-ChildItem -LiteralPath $svgDir -Filter '*.svg' -ErrorAction SilentlyContinue)
if ($svgFiles.Count -eq 0) { throw "No hay SVG en $svgDir" }

$raster = Find-Rasterizer
$paaTool = Find-ImageToPAA
$hemttTool = Find-Hemtt

Write-Host "Islas Fracturadas — construccion de assets" -ForegroundColor Cyan
Write-Host ("  SVG de entrada : {0}" -f $svgFiles.Count)
Write-Host ("  Tamano destino : {0}x{0} px" -f $Size)
Write-Host ("  Rasterizador   : {0}" -f $(if ($raster) { "$($raster.Name) -> $($raster.Path)" } else { 'NO ENCONTRADO' }))
Write-Host ("  ImageToPAA     : {0}" -f $(if ($paaTool) { $paaTool } else { 'NO ENCONTRADO' }))
Write-Host ("  HEMTT          : {0}" -f $(if ($hemttTool) { $hemttTool } else { 'NO ENCONTRADO' }))

if (-not $raster) {
    throw @"
No se encontro ningun rasterizador SVG.
Instala UNO de estos y vuelve a ejecutar:
  winget install Inkscape.Inkscape
  winget install ImageMagick.ImageMagick
  o ejecuta: cd tools\if-media-mcp; npm install; npm run build
"@
}

# --- Etapa 1: SVG -> PNG -----------------------------------------------------

if (-not (Test-Path -LiteralPath $pngDir)) {
    if ($PSCmdlet.ShouldProcess($pngDir, 'Crear directorio')) {
        New-Item -ItemType Directory -Path $pngDir -Force | Out-Null
    }
}

$pngFiles = [System.Collections.Generic.List[string]]::new()

foreach ($svg in $svgFiles) {
    $png = Join-Path $pngDir ($svg.BaseName + '.png')
    if ($PSCmdlet.ShouldProcess($png, "Rasterizar $($svg.Name) a ${Size}x${Size}")) {
        switch ($raster.Name) {
            'inkscape' {
                & $raster.Path $svg.FullName --export-type=png --export-filename=$png `
                    --export-width=$Size --export-height=$Size | Out-Null
            }
            'magick' {
                & $raster.Path -background none -density 384 $svg.FullName `
                    -resize "${Size}x${Size}" $png | Out-Null
            }
            'rsvg' {
                & $raster.Path -w $Size -h $Size -o $png $svg.FullName | Out-Null
            }
            'sharp' {
                & $raster.Path $raster.Script --project-root $root --input $svg.FullName `
                    --output $png --size $Size | Out-Null
            }
        }
        if (-not (Test-Path -LiteralPath $png)) { throw "Fallo al rasterizar $($svg.Name)" }
        Write-Host "  [PNG] $($svg.BaseName).png" -ForegroundColor Green
    }
    $pngFiles.Add($png)
}

# --- Etapa 2: PNG -> PAA -----------------------------------------------------

if (-not $paaTool -and -not $hemttTool) {
    $pngStatus = if ($WhatIfPreference) {
        'Simulacion completada; no se escribieron PNG ni PAA.'
    } else {
        'PNG generados correctamente; no se han creado los .paa.'
    }
    Write-Warning @"
$pngStatus

Ningun conversor PAA disponible. Opciones:

  1) ImageToPAA, parte de "Arma 3 Tools" (Steam, appid 233800; requiere cuenta con
     licencia de Arma 3). No viene con copias ajenas a Steam.
       `$env:IF_ARMA3_TOOLS = 'C:\ruta\a\Arma 3 Tools'

  2) HEMTT (github.com/BrettMayson/HEMTT), binario unico sin Steam ni cuenta.
       `$env:IF_HEMTT = 'C:\ruta\a\hemtt.exe'

Luego repite: .\tools\Build-Assets.ps1 -Size $Size

Los PNG quedan en: $pngDir
"@
    return
}

if (-not (Test-Path -LiteralPath $paaDir)) {
    if ($PSCmdlet.ShouldProcess($paaDir, 'Crear directorio')) {
        New-Item -ItemType Directory -Path $paaDir -Force | Out-Null
    }
}

$paaEngine = if ($paaTool) { 'ImageToPAA' } else { 'HEMTT' }
Write-Host ("  Motor PAA      : {0}" -f $paaEngine)

foreach ($png in $pngFiles) {
    # Sufijo _ca: convencion de Bohemia para textura con canal alfa
    $paa = Join-Path $paaDir ([IO.Path]::GetFileNameWithoutExtension($png) + '_ca.paa')
    if ($PSCmdlet.ShouldProcess($paa, "Convertir a PAA ($paaEngine)")) {
        if ($paaTool) {
            & $paaTool $png $paa | Out-Null
        } else {
            & $hemttTool utils paa convert $png $paa | Out-Null
        }
        if (-not (Test-Path -LiteralPath $paa)) { throw "Fallo al convertir $png" }
        Write-Host "  [PAA] $(Split-Path $paa -Leaf)" -ForegroundColor Green
    }
}

Write-Host "`nListo. Texturas en: $paaDir" -ForegroundColor Cyan
Write-Host "No incluyas CfgUnitInsignia.hpp hasta validar las texturas en Arma 3/3DEN y revisar el RPT." -ForegroundColor Yellow
