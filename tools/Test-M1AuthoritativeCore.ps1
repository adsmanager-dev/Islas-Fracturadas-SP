[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$missionRoot = Join-Path (Split-Path -Parent $PSScriptRoot) 'IslasFracturadas.Altis'
$expectedFunctions = @(
    'runtimeCreate', 'valueClone', 'valueIsPersistable', 'errorCreate',
    'configLoad', 'configValidate', 'idGenerateRuntime',
    'stateCreate', 'stateValidate', 'stateCommandSet', 'stateQueryGet',
    'eventSubscribe', 'eventPublish', 'eventProcess', 'eventProcessQueue',
    'schedulerRegister', 'schedulerTick',
    'transactionBegin', 'transactionRecord', 'transactionCommit', 'transactionRollback',
    'clockGetStrategicTime', 'clockAdvance', 'm1CoreTest'
)
$expectedFiles = @(
    'core\runtime\fn_runtimeCreate.sqf',
    'core\util\fn_valueClone.sqf',
    'core\util\fn_valueIsPersistable.sqf',
    'core\errors\fn_errorCreate.sqf',
    'core\config\fn_configLoad.sqf',
    'core\config\fn_configValidate.sqf',
    'core\ids\fn_idGenerateRuntime.sqf',
    'core\state\fn_stateCreate.sqf',
    'core\state\fn_stateValidate.sqf',
    'core\state\fn_stateCommandSet.sqf',
    'core\state\fn_stateQueryGet.sqf',
    'core\events\fn_eventSubscribe.sqf',
    'core\events\fn_eventPublish.sqf',
    'core\events\fn_eventProcess.sqf',
    'core\events\fn_eventProcessQueue.sqf',
    'core\scheduler\fn_schedulerRegister.sqf',
    'core\scheduler\fn_schedulerTick.sqf',
    'core\transactions\fn_transactionBegin.sqf',
    'core\transactions\fn_transactionRecord.sqf',
    'core\transactions\fn_transactionCommit.sqf',
    'core\transactions\fn_transactionRollback.sqf',
    'core\clock\fn_clockGetStrategicTime.sqf',
    'core\clock\fn_clockAdvance.sqf',
    'tests\fn_m1CoreTest.sqf'
)

foreach ($relativePath in $expectedFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $missionRoot $relativePath) -PathType Leaf)) {
        throw "Falta el archivo M1: $relativePath"
    }
}

$cfgFunctions = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'cfg\CfgFunctions.hpp')
foreach ($functionName in $expectedFunctions) {
    if ($cfgFunctions -notmatch "class\s+$([regex]::Escape($functionName))\b") {
        throw "CfgFunctions no registra: IF_fnc_$functionName"
    }
}

$stateCreate = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\state\fn_stateCreate.sqf')
foreach ($rootKey in @(
    'meta', 'campaign', 'clock', 'world', 'regions', 'sectors', 'connections',
    'factions', 'forces', 'vehicles', 'logistics', 'characters', 'roles',
    'relations', 'civilians', 'government', 'helios', 'intelligence',
    'evidence', 'knowledge', 'missions', 'events', 'progression', 'endings'
)) {
    if ($stateCreate -notmatch ('\["' + [regex]::Escape($rootKey) + '"\s*,')) {
        throw "El estado M1 no declara la raíz: $rootKey"
    }
}

$authorityFiles = @(
    'core\runtime\fn_runtimeCreate.sqf',
    'core\state\fn_stateCreate.sqf',
    'core\state\fn_stateCommandSet.sqf',
    'core\events\fn_eventPublish.sqf',
    'core\scheduler\fn_schedulerRegister.sqf',
    'core\transactions\fn_transactionBegin.sqf',
    'core\clock\fn_clockAdvance.sqf'
)
foreach ($relativePath in $authorityFiles) {
    $content = Get-Content -Raw -LiteralPath (Join-Path $missionRoot $relativePath)
    if ($content -notmatch 'if\s*\(\s*!isServer\s*\)\s*exitWith') {
        throw "Falta guardia autoritativa en: $relativePath"
    }
}

$bootstrap = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\bootstrap\fn_bootstrapPostInit.sqf')
foreach ($phase in @('PHASE_20_CONFIG', 'PHASE_30_SERVICES', 'PHASE_40_STATE', 'PHASE_50_WORLD', 'PHASE_60_TESTS', 'PHASE_90_RUNNING')) {
    if (-not $bootstrap.Contains($phase)) {
        throw "El bootstrap M1 no declara la fase: $phase"
    }
}
if ($bootstrap.IndexOf('PHASE_30_SERVICES') -gt $bootstrap.IndexOf('PHASE_40_STATE')) {
    throw 'El bootstrap inicializa estado antes que servicios.'
}

$eventPublish = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'core\events\fn_eventPublish.sqf')
foreach ($field in @('id', 'type', 'version', 'createdAt', 'sourceModule', 'sourceId', 'payload', 'persistent', 'processedBy')) {
    if ($eventPublish -notmatch ('\["' + [regex]::Escape($field) + '"\s*,')) {
        throw "El envelope de evento no declara: $field"
    }
}

$testSuite = Get-Content -Raw -LiteralPath (Join-Path $missionRoot 'tests\fn_m1CoreTest.sqf')
foreach ($check in @(
    'config.valid', 'state.new', 'ids.duplicateRejected', 'state.commandAndQuery',
    'event.persistent', 'event.repeatedOnce', 'scheduler.once',
    'transaction.rollback', 'clock.advance', 'error.critical'
)) {
    if (-not $testSuite.Contains($check)) {
        throw "La suite M1 no cubre: $check"
    }
}

$sqfText = (Get-ChildItem -LiteralPath $missionRoot -Recurse -Filter '*.sqf' -File |
    ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName }) -join [Environment]::NewLine
if ($sqfText -match '(?i)\bcompile(?:Final)?\b') {
    throw 'Se detectó compilación dinámica en M1.'
}
if ($sqfText -match '(?i)\bremoteExec(?:Call)?\b') {
    throw 'Se detectó ejecución remota sin contrato en M1.'
}

$missionSqm = Join-Path $missionRoot 'mission.sqm'
if (-not (Test-Path -LiteralPath $missionSqm -PathType Leaf)) {
    throw 'Falta mission.sqm.'
}

Write-Output 'PASS: estructura, autoridad, estado, eventos, pruebas y fronteras SQF de M1.'
