[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$missionRoot = Join-Path (Split-Path -Parent $PSScriptRoot) 'IslasFracturadas.Altis'
$expectedFiles = @(
    'description.ext',
    'cfg\CfgFunctions.hpp',
    'config\sectors.hpp',
    'core\bootstrap\fn_bootstrapPreInit.sqf',
    'core\bootstrap\fn_bootstrapPostInit.sqf',
    'core\logging\fn_log.sqf',
    'core\ids\fn_validateIds.sqf',
    'diagnostics\fn_diagnosticsSetMode.sqf',
    'diagnostics\fn_diagnosticsReport.sqf',
    'tests\fn_smokeTest.sqf'
)

foreach ($relativePath in $expectedFiles) {
    $fullPath = Join-Path $missionRoot $relativePath
    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        throw "Falta el archivo requerido: $relativePath"
    }
}

$description = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'description.ext')
foreach ($include in @('cfg\CfgFunctions.hpp', 'config\sectors.hpp')) {
    if (-not $description.Contains($include)) {
        throw "description.ext no carga: $include"
    }
}

$cfgFunctions = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'cfg\CfgFunctions.hpp')
$registeredFunctions = @(
    'bootstrapPreInit',
    'bootstrapPostInit',
    'log',
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

Write-Output 'PASS: archivos, includes, CfgFunctions, IDs, llaves y fronteras SQF de M0.'
