[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$missionRoot = Join-Path (Split-Path -Parent $PSScriptRoot) 'IslasFracturadas.Altis'
$expectedFunctions = @(
    'worldInitialize', 'worldReconcilePhysicalMetadata', 'worldValidate', 'worldQueryGetSector',
    'worldQueryGetNeighbors', 'worldQueryFindPath', 'worldQueryCalculateDepth',
    'worldCommandSetSectorOwner', 'worldDiagnosticsReport', 'm3WorldTest'
)
$expectedFiles = @(
    'modules\world\README.md',
    'modules\world\fn_worldInitialize.sqf',
    'modules\world\fn_worldReconcilePhysicalMetadata.sqf',
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
    $connectionId = $match.Groups[1].Value
    $body = $match.Groups['body'].Value
    $from = [regex]::Match($body, '\bfrom\s*=\s*"([^"]+)"').Groups[1].Value
    $to = [regex]::Match($body, '\bto\s*=\s*"([^"]+)"').Groups[1].Value
    if ($from -notin $expectedSectors -or $to -notin $expectedSectors) {
        throw "Conexión $($match.Groups[1].Value) referencia un sector fuera de M3."
    }
    if ($from -eq $to) {
        throw "Conexión autorreferente: $($match.Groups[1].Value)."
    }
    $expectedValidationStatus = if ($connectionId -eq 'CONN_M3_NERI_AGIOS') {
        'VALIDACION_3DEN_EN_CURSO'
    }
    else {
        'POR_CALIBRAR'
    }
    if ($body -notmatch "validationStatus\s*=\s*`"$expectedValidationStatus`"") {
        throw "Estado de validación inesperado en conexión $connectionId; esperaba $expectedValidationStatus."
    }
    if ($connectionId -eq 'CONN_M3_NERI_AGIOS' -and
        $body -notmatch 'designStatus\s*=\s*"DISEÑO_CONFIRMADO"') {
        throw 'CONN_M3_NERI_AGIOS debe quedar confirmada por DEC-009.'
    }
}

function Get-M3SectorBody {
    param([Parameter(Mandatory)][string]$SectorId)

    $nextSector = '(?=\r?\n\s*class\s+ALT_|\r?\n};\s*\r?\n\s*class\s+IF_Connections)'
    $sectorMatch = [regex]::Match(
        $configText,
        "(?s)class\s+$([regex]::Escape($SectorId))\s*\{(?<body>.*?)$nextSector"
    )
    if (-not $sectorMatch.Success) {
        throw "No se pudo aislar la configuración de $SectorId."
    }
    return $sectorMatch.Groups['body'].Value
}

$validatedAnchors = [ordered]@{
    'ALT_W_NERI_PANOCHORI' = @(5059.8296, 11299.381, 0)
    'ALT_W_AGIOS_DIONYSIOS' = @(9366.166, 15886.582, 0)
    'ALT_CW_STAVROS_WHISKEY' = @(12948.381, 15032.742, 0)
    'ALT_CW_LAKKA' = @(12359.11, 15630.292, 0)
    'ALT_CW_AAC' = @(11479.819, 11632.228, 0)
    'ALT_CW_POLIAKKO_THERISA' = @(11246.036, 13627.0205, 0)
    'ALT_CW_XIROLIMNI_ZAROS' = @(9138.721, 13938.911, 0)
    'ALT_C_AIRPORT_WEST' = @(14383.358, 15922.19, 0)
    'ALT_C_AIRPORT_TERMINAL' = @(15185.31, 16774.15, 0)
}
foreach ($entry in $validatedAnchors.GetEnumerator()) {
    $body = Get-M3SectorBody -SectorId $entry.Key
    $coordinateText = ($entry.Value | ForEach-Object { $_.ToString([Globalization.CultureInfo]::InvariantCulture) }) -join ', '
    foreach ($field in @('positionATL', 'anchorPositionATL')) {
        if ($body -notmatch "$field\[\]\s*=\s*\{$([regex]::Escape($coordinateText))\}\s*;") {
            throw "$($entry.Key) no conserva $field = {$coordinateText}."
        }
    }
    foreach ($statusField in @('anchorStatus', 'validationStatus')) {
        $expectedStatus = if ($statusField -eq 'anchorStatus') {'VALIDADO_3DEN'} else {'VALIDACION_3DEN_EN_CURSO'}
        if ($body -notmatch "$statusField\s*=\s*`"$expectedStatus`"") {
            throw "$($entry.Key) no conserva $statusField = $expectedStatus."
        }
    }
    if ($body -notmatch 'designStatus\s*=\s*"DISEÑO_CONFIRMADO"') {
        throw "$($entry.Key) no conserva designStatus = DISEÑO_CONFIRMADO."
    }
    if ($body -notmatch '\bradius\s*=\s*-1\s*;') {
        throw "$($entry.Key) no conserva radius = -1."
    }
}

$placedAnchorCount = 0
$validatedAnchorCount = 0
foreach ($sectorId in $expectedSectors) {
    $body = Get-M3SectorBody -SectorId $sectorId
    $anchorPosition = [regex]::Match($body, 'anchorPositionATL\[\]\s*=\s*\{(?<value>[^}]*)\}\s*;')
    if ($anchorPosition.Success -and -not [string]::IsNullOrWhiteSpace($anchorPosition.Groups['value'].Value)) {
        $placedAnchorCount++
    }
    if ($body -match 'anchorStatus\s*=\s*"VALIDADO_3DEN"') {
        $validatedAnchorCount++
    }
}
$pendingPlacementCount = $expectedSectors.Count - $placedAnchorCount
$pendingValidationCount = $expectedSectors.Count - $validatedAnchorCount
if ($placedAnchorCount -ne 9 -or $pendingPlacementCount -ne 0 -or
    $validatedAnchorCount -ne 9 -or $pendingValidationCount -ne 0) {
    throw "Diagnóstico de anclajes inesperado: $placedAnchorCount/$pendingPlacementCount/$validatedAnchorCount/$pendingValidationCount."
}

$diagnostics = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'modules\world\fn_worldDiagnosticsReport.sqf')
foreach ($diagnosticField in @(
    'placedAnchorCount', 'pendingPlacementCount',
    'validatedAnchorCount', 'pendingValidationCount'
)) {
    if (-not $diagnostics.Contains($diagnosticField)) {
        throw "El diagnóstico M3 no expone: $diagnosticField"
    }
}

$reconciliation = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'modules\world\fn_worldReconcilePhysicalMetadata.sqf')
foreach ($contractValue in @(
    'IF_fnc_worldValidate', 'IF_fnc_transactionBegin', 'IF_fnc_stateCommandSet',
    'IF_fnc_transactionRollback', 'IF_fnc_transactionCommit',
    'PHYSICAL_METADATA_RECONCILIATION', 'sectorIds', 'fieldsAdded', 'changeCount',
    'PARTIAL_WORLD_STATE', 'NO_CHANGES'
)) {
    if (-not $reconciliation.Contains($contractValue)) {
        throw "La reconciliación física M3 no declara el contrato: $contractValue"
    }
}
$worldInitialize = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'modules\world\fn_worldInitialize.sqf')
foreach ($contractValue in @(
    'IF_fnc_worldReconcilePhysicalMetadata', 'ALREADY_INITIALIZED_RECONCILED',
    'ALREADY_INITIALIZED', 'PARTIAL_WORLD_STATE'
)) {
    if (-not $worldInitialize.Contains($contractValue)) {
        throw "worldInitialize no integra el contrato de reconciliación: $contractValue"
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
    'world.m2DefaultsUpgraded', 'world.newNinePhysicalPositions',
    'graph.pathTraversable', 'graph.depthCalculated',
    'world.invalidReferenceRejected', 'owner.commandPublishesEvent',
    'owner.commandIdempotent', 'persistence.ownerRoundTrip',
    'runtime.depthRebuiltAfterLoad', 'anchors.allPlacedNineValidated',
    'anchors.allValidatedCoordinates',
    'diagnostics.anchorPlacementValidationSplit',
    'reconcile.oldSavePhysicalMetadata', 'reconcile.dynamicStatePreserved',
    'reconcile.idempotent', 'reconcile.pass2AnchorStatusesPromoted',
    'reconcile.persistedPositionWins',
    'reconcile.worldInitializeExistingUpdated', 'reconcile.partialWorldRejected'
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
