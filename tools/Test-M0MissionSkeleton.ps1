[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$missionRoot = Join-Path (Split-Path -Parent $PSScriptRoot) 'IslasFracturadas.Altis'
$expectedFiles = @(
    'description.ext',
    'cfg\CfgFunctions.hpp',
    'cfg\CfgMusic.hpp',
    'config\sectors.hpp',
    'core\bootstrap\fn_bootstrapPreInit.sqf',
    'core\bootstrap\fn_bootstrapPostInit.sqf',
    'core\logging\fn_log.sqf',
    'core\presentation\fn_musicPlayIntro.sqf',
    'core\ids\fn_validateIds.sqf',
    'diagnostics\fn_diagnosticsSetMode.sqf',
    'diagnostics\fn_diagnosticsReport.sqf',
    'tests\fn_smokeTest.sqf',
    'assets\music\voces_partidas\runtime\IF_Voces_Partidas_La_Isla_Hablara.ogg'
)

foreach ($relativePath in $expectedFiles) {
    $fullPath = Join-Path $missionRoot $relativePath
    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        throw "Falta el archivo requerido: $relativePath"
    }
}

$description = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'description.ext')
foreach ($include in @('cfg\CfgFunctions.hpp', 'cfg\CfgMusic.hpp', 'config\sectors.hpp')) {
    if (-not $description.Contains($include)) {
        throw "description.ext no carga: $include"
    }
}

$cfgFunctions = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'cfg\CfgFunctions.hpp')
$registeredFunctions = @(
    'bootstrapPreInit',
    'bootstrapPostInit',
    'log',
    'musicPlayIntro',
    'validateIds',
    'diagnosticsSetMode',
    'diagnosticsReport',
    'smokeTest'
)
foreach ($functionName in $registeredFunctions) {
    if ($cfgFunctions -notmatch "class\s+$([regex]::Escape($functionName))\b") {
        throw "CfgFunctions no registra: IF_fnc_$functionName"
    }
}

$cfgMusic = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'cfg\CfgMusic.hpp')
if ($cfgMusic -notmatch 'class\s+IF_Voces_Partidas_La_Isla_Hablara\b') {
    throw 'CfgMusic no registra la pista de apertura.'
}
$runtimeMusicPath = 'assets\music\voces_partidas\runtime\IF_Voces_Partidas_La_Isla_Hablara.ogg'
if (-not $cfgMusic.Contains($runtimeMusicPath)) {
    throw "CfgMusic no referencia el runtime esperado: $runtimeMusicPath"
}

$musicFunction = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\presentation\fn_musicPlayIntro.sqf')
foreach ($contract in @('hasInterface', 'IF_introMusicRequested', 'findDisplay 46', 'playMusic')) {
    if (-not $musicFunction.Contains($contract)) {
        throw "La función de presentación no cumple el contrato: $contract"
    }
}

$postInit = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\bootstrap\fn_bootstrapPostInit.sqf')
if ($postInit -match '\bIF_fnc_musicPlayIntro\b|\bplayMusic\b') {
    throw 'postInit no debe reproducir música automáticamente durante el desarrollo.'
}

$runtimeMusic = Join-Path $missionRoot $runtimeMusicPath
$runtimeMusicHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $runtimeMusic).Hash.ToLowerInvariant()
$expectedRuntimeMusicHash = 'd5ec78553aa915bde7c632a9dc03d2630190a9a0db67630046e5207a29752a08'
if ($runtimeMusicHash -ne $expectedRuntimeMusicHash) {
    throw "El OGG runtime no coincide con el candidato validado: $runtimeMusicHash"
}

$configText = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'config\sectors.hpp')
$idMatches = [regex]::Matches($configText, '\bid\s*=\s*"([^"]*)"\s*;')
if ($idMatches.Count -eq 0) {
    throw 'No se encontró ningún ID de configuración.'
}

$ids = @($idMatches | ForEach-Object { $_.Groups[1].Value })
if (@($ids | Where-Object { [string]::IsNullOrWhiteSpace($_) }).Count -gt 0) {
    throw 'La configuración contiene un ID vacío.'
}
if (@($ids | Group-Object | Where-Object Count -gt 1).Count -gt 0) {
    throw 'La configuración contiene IDs duplicados.'
}

$configFiles = Get-ChildItem -LiteralPath $missionRoot -Recurse -File |
    Where-Object { $_.Extension -in '.ext', '.hpp' }
foreach ($file in $configFiles) {
    $content = Get-Content -Raw -LiteralPath $file.FullName
    $openBraces = ([regex]::Matches($content, '\{')).Count
    $closeBraces = ([regex]::Matches($content, '\}')).Count
    if ($openBraces -ne $closeBraces) {
        throw "Llaves desequilibradas: $($file.FullName)"
    }
}

$sqfText = (Get-ChildItem -LiteralPath $missionRoot -Recurse -Filter '*.sqf' -File |
    ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName }) -join [Environment]::NewLine
if ($sqfText -match '(?i)\bcompile(?:Final)?\b') {
    throw 'Se detectó compilación dinámica en el esqueleto M0.'
}
if ($sqfText -match '(?i)\bremoteExec(?:Call)?\b') {
    throw 'Se detectó ejecución remota no prevista en el esqueleto M0.'
}

Write-Output 'PASS: archivos, música runtime, includes, CfgFunctions, IDs, llaves y fronteras SQF de M0.'
