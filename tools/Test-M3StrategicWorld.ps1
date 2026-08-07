[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$missionRoot = Join-Path (Split-Path -Parent $PSScriptRoot) 'IslasFracturadas.Altis'
$expectedFunctions = @(
    'worldInitialize', 'worldValidate', 'worldQueryGetSector',
    'worldQueryGetNeighbors', 'worldQueryFindPath', 'worldQueryCalculateDepth',
    'worldCommandSetSectorOwner', 'worldDiagnosticsReport', 'm3WorldTest'
)
$expectedFiles = @(
    'modules\world\README.md',
    'modules\world\fn_worldInitialize.sqf',
    'modules\world\fn_worldValidate.sqf',
    'modules\world\fn_worldQueryGetSector.sqf',
    'modules\world\fn_worldQueryGetNeighbors.sqf',
    'modules\world\fn_worldQueryFindPath.sqf',
    'modules\world\fn_worldQueryCalculateDepth.sqf',
    'modules\world\fn_worldCommandSetSectorOwner.sqf',
    'modules\world\fn_worldDiagnosticsReport.sqf',
    'tests\fn_m3WorldTest.sqf'
)
foreach ($relativePath in $expectedFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $missionRoot $relativePath) -PathType Leaf)) {
        throw "Falta el artefacto M3: $relativePath"
    }
}

$cfgFunctions = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'cfg\CfgFunctions.hpp')
foreach ($functionName in $expectedFunctions) {
    if ($cfgFunctions -notmatch "class\s+$([regex]::Escape($functionName))\b") {
        throw "CfgFunctions no registra: IF_fnc_$functionName"
    }
}

$configText = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'config\sectors.hpp')
$expectedSectors = @(
    'ALT_W_NERI_PANOCHORI', 'ALT_W_AGIOS_DIONYSIOS',
    'ALT_CW_STAVROS_WHISKEY', 'ALT_CW_LAKKA', 'ALT_CW_AAC',
    'ALT_CW_POLIAKKO_THERISA', 'ALT_CW_XIROLIMNI_ZAROS',
    'ALT_C_AIRPORT_WEST', 'ALT_C_AIRPORT_TERMINAL'
)
foreach ($sectorId in $expectedSectors) {
    if ($configText -notmatch "class\s+$([regex]::Escape($sectorId))\b") {
        throw "Falta el sector M3: $sectorId"
    }
}

$idMatches = [regex]::Matches($configText, '\bid\s*=\s*"([^"]*)"\s*;')
$ids = @($idMatches | ForEach-Object { $_.Groups[1].Value })
if ($ids.Count -ne 23) {
    throw "La configuración M3 debe declarar 5 regiones, 9 sectores y 9 conexiones; encontró $($ids.Count) IDs."
}
if (@($ids | Group-Object | Where-Object Count -gt 1).Count -gt 0) {
    throw 'La configuración M3 contiene IDs duplicados.'
}

$connectionClasses = [regex]::Matches(
    $configText,
    '(?s)class\s+(CONN_M3_[A-Z0-9_]+)\s*\{(?<body>.*?)\};'
)
if ($connectionClasses.Count -ne 9) {
    throw "M3 debe declarar 9 conexiones; encontró $($connectionClasses.Count)."
}
foreach ($match in $connectionClasses) {
    $body = $match.Groups['body'].Value
    $from = [regex]::Match($body, '\bfrom\s*=\s*"([^"]+)"').Groups[1].Value
    $to = [regex]::Match($body, '\bto\s*=\s*"([^"]+)"').Groups[1].Value
    if ($from -notin $expectedSectors -or $to -notin $expectedSectors) {
        throw "Conexión $($match.Groups[1].Value) referencia un sector fuera de M3."
    }
    if ($from -eq $to) {
        throw "Conexión autorreferente: $($match.Groups[1].Value)."
    }
    if ($body -notmatch 'validationStatus\s*=\s*"POR_CALIBRAR"') {
        throw "Conexión sin estado POR_CALIBRAR: $($match.Groups[1].Value)."
    }
}

$command = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'modules\world\fn_worldCommandSetSectorOwner.sqf')
if ($command -notmatch 'if\s*\(\s*!isServer\s*\)\s*exitWith') {
    throw 'El command de propietario M3 no tiene guardia autoritativa.'
}
foreach ($contractValue in @(
    'IF_EVENT_SECTOR_MILITARY_OWNER_CHANGED', 'sectorId', 'oldOwner',
    'newOwner', 'commandId', 'true', 'WORLD'
)) {
    if (-not $command.Contains($contractValue)) {
        throw "El command M3 no declara el contrato: $contractValue"
    }
}

$bootstrap = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\bootstrap\fn_bootstrapPostInit.sqf')
foreach ($callName in @('IF_fnc_worldInitialize', 'IF_fnc_worldValidate', 'IF_fnc_m3WorldTest')) {
    if (-not $bootstrap.Contains($callName)) {
        throw "El bootstrap no integra: $callName"
    }
}
if (-not $bootstrap.Contains('IF_RunIntegrationTests') -and -not $bootstrap.Contains('IF_integrationTestsRun')) {
    throw 'El bootstrap no expone el control de suites de integración.'
}
if ($bootstrap -notmatch 'if\s*\(\s*_servicesReady\s*&&') {
    throw 'El bootstrap podría alcanzar PHASE_90_RUNNING con servicios incompletos.'
}
$description = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'description.ext')
if ($description -notmatch 'class\s+IF_RunIntegrationTests\b' -or $description -notmatch '(?s)class\s+IF_RunIntegrationTests.*?default\s*=\s*0\s*;') {
    throw 'Las suites M1-M3 deben ser opt-in para no penalizar cada arranque.'
}

$stateCreate = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\state\fn_stateCreate.sqf')
$snapshot = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\persistence\fn_saveCreateSnapshot.sqf')
if ($stateCreate -notmatch 'schemaVersion"\s*,\s*1' -or $snapshot -notmatch 'schemaVersion"\s*,\s*1') {
    throw 'M3 alteró el schemaVersion reservado por M2 sin migración.'
}
if (-not $snapshot.Contains('0.3.0-m3-dev')) {
    throw 'El snapshot no identifica el build M3 de desarrollo.'
}

$testSuite = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'tests\fn_m3WorldTest.sqf')
foreach ($check in @(
    'config.nineSectors', 'world.valid', 'world.initializeIdempotent',
    'world.m2DefaultsUpgraded',
    'graph.pathTraversable', 'graph.depthCalculated',
    'world.invalidReferenceRejected', 'owner.commandPublishesEvent',
    'owner.commandIdempotent', 'persistence.ownerRoundTrip',
    'runtime.depthRebuiltAfterLoad', 'anchors.pendingExplicit'
)) {
    if (-not $testSuite.Contains($check)) {
        throw "La suite SQF M3 no cubre: $check"
    }
}

$allSqfFiles = Get-ChildItem -LiteralPath $missionRoot -Recurse -Filter '*.sqf' -File
foreach ($file in $allSqfFiles) {
    $content = Get-Content -Raw -LiteralPath $file.FullName
    if (([regex]::Matches($content, '\{')).Count -ne ([regex]::Matches($content, '\}')).Count) {
        throw "Llaves SQF desequilibradas: $($file.FullName)"
    }
}
$sqfText = ($allSqfFiles | ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName }) -join [Environment]::NewLine
if ($sqfText -match '(?i)\bcompile(?:Final)?\b') {
    throw 'Se detectó compilación dinámica en M3.'
}
if ($sqfText -match '(?i)\bremoteExec(?:Call)?\b') {
    throw 'Se detectó ejecución remota sin contrato en M3.'
}

Write-Output 'PASS: configuración, grafo, autoridad, evento, persistencia y pruebas M3.'
