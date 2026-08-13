[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$missionRoot = Join-Path (Split-Path -Parent $PSScriptRoot) 'IslasFracturadas.Altis'
$expectedFunctions = @(
    'runtimeRebuildAfterLoad',
    'serializeValue', 'deserializeValue', 'checksumCreate',
    'storageSave', 'storageLoad', 'storageList', 'storageDelete',
    'saveCreateSnapshot', 'saveValidate', 'saveMigrateV0ToV1',
    'saveMigrate', 'saveCampaign', 'loadCampaign', 'm2PersistenceTest'
)

$cfgFunctions = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'cfg\CfgFunctions.hpp')
foreach ($functionName in $expectedFunctions) {
    if ($cfgFunctions -notmatch "class\s+$([regex]::Escape($functionName))\b") {
        throw "CfgFunctions no registra: IF_fnc_$functionName"
    }
}

$description = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'description.ext')
if ($description -notmatch 'missionGroup\s*=\s*"IF_MAIN_CAMPAIGN"\s*;') {
    throw 'description.ext no declara missionGroup = IF_MAIN_CAMPAIGN.'
}

$storageFiles = Get-ChildItem -LiteralPath (Join-Path $missionRoot 'core\storage') -Filter '*.sqf' -File
$allSqfFiles = Get-ChildItem -LiteralPath $missionRoot -Recurse -Filter '*.sqf' -File
foreach ($file in $allSqfFiles) {
    $content = Get-Content -Raw -LiteralPath $file.FullName
    $opens = ([regex]::Matches($content, '\{')).Count
    $closes = ([regex]::Matches($content, '\}')).Count
    if ($opens -ne $closes) {
        throw "Llaves SQF desequilibradas: $($file.FullName)"
    }
}

$namespaceUsers = @($allSqfFiles | Where-Object {
    (Get-Content -Raw -LiteralPath $_.FullName) -match '\bmissionProfileNamespace\b|\bsaveMissionProfileNamespace\b'
})
$outsideAdapter = @($namespaceUsers | Where-Object {
    $_.DirectoryName -ne (Join-Path $missionRoot 'core\storage')
})
if ($outsideAdapter.Count -gt 0) {
    throw "Acceso directo a missionProfileNamespace fuera del adaptador: $($outsideAdapter.FullName -join ', ')"
}

$memorySave = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\storage\fn_storageSave.sqf')
$memoryLoad = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\storage\fn_storageLoad.sqf')
if ($memorySave -match '\+_stored' -or $memoryLoad -match '\+\s*\(_memory\s+get') {
    throw 'El adaptador en memoria usa copia unaria no segura para valores escalares.'
}
if ($memorySave -notmatch 'IF_fnc_valueClone' -or $memoryLoad -notmatch 'IF_fnc_valueClone') {
    throw 'El adaptador en memoria no clona valores mediante IF_fnc_valueClone.'
}

$saveCampaign = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\persistence\fn_saveCampaign.sqf')
foreach ($guard in @('OPEN_TRANSACTION', 'MATERIALIZATION_INCOMPLETE', 'OWNERSHIP_UNCONFIRMED', 'READ_BACK_FAILED')) {
    if (-not $saveCampaign.Contains($guard)) {
        throw "Falta guardia de guardado M2: $guard"
    }
}

$loadCampaign = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\persistence\fn_loadCampaign.sqf')
foreach ($slot in @('AUTOSAVE_A', 'AUTOSAVE_B', 'CHECKPOINT', 'MANUAL_1')) {
    if (-not $loadCampaign.Contains($slot)) {
        throw "La recuperación M2 no contempla: $slot"
    }
}

$testSuite = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'tests\fn_m2PersistenceTest.sqf')
foreach ($check in @(
    'save.abRotation', 'load.latest', 'recovery.corruptAFallsBackB',
    'event.noDuplicateAfterLoad', 'save.manual',
    'save.openTransactionRejected', 'save.incompleteStateRejected',
    'migration.v0ToV1Idempotent', 'migration.preservesOriginal'
)) {
    if (-not $testSuite.Contains($check)) {
        throw "La suite M2 no cubre: $check"
    }
}

$bootstrap = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\bootstrap\fn_bootstrapPostInit.sqf')
foreach ($probeStage in @('persistence.restart.auto.stage1', 'persistence.restart.auto.stage2')) {
    if (-not $bootstrap.Contains($probeStage)) {
        throw "El bootstrap no registra la etapa automática: $probeStage"
    }
}

$sqfText = ($allSqfFiles | ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName }) -join [Environment]::NewLine
if ($sqfText -match '(?i)\bcompile(?:Final)?\b') {
    throw 'Se detectó compilación dinámica en M2.'
}
if ($sqfText -match '(?i)\bremoteExec(?:Call)?\b') {
    throw 'Se detectó ejecución remota sin contrato en M2.'
}

Write-Output 'PASS: contratos, adaptador, snapshots A/B, recuperación, migración y pruebas M2.'
