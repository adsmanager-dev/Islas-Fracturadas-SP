[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$syncScript = Join-Path $PSScriptRoot 'Sync-MissionWorkspace.ps1'
$temporaryBase = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
$temporaryRoot = Join-Path $temporaryBase ('IF-SyncMission-' + [guid]::NewGuid().ToString('N'))
$projectRoot = Join-Path $temporaryRoot 'project\IslasFracturadas.Altis'
$editorRoot = Join-Path $temporaryRoot 'editor\Islas%20Fracturadas.Altis'

function Assert-Equal {
    param(
        [Parameter(Mandatory = $true)]$Expected,
        [Parameter(Mandatory = $true)]$Actual,
        [Parameter(Mandatory = $true)][string]$Message
    )

    if ($Expected -ne $Actual) {
        throw "$Message Esperado: '$Expected'. Real: '$Actual'."
    }
}

New-Item -ItemType Directory -Path (Join-Path $projectRoot 'core') -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $editorRoot 'core') -Force | Out-Null

try {
    Set-Content -LiteralPath (Join-Path $projectRoot 'core\fn_test.sqf') -Value 'project-v1'
    Set-Content -LiteralPath (Join-Path $projectRoot 'mission.sqm') -Value 'project-mission'
    Set-Content -LiteralPath (Join-Path $editorRoot 'mission.sqm') -Value 'editor-mission'

    & $syncScript -Action Push -ProjectMissionPath $projectRoot -EditorMissionPath $editorRoot -WhatIf | Out-Null
    Assert-Equal `
        -Expected $false `
        -Actual (Test-Path -LiteralPath (Join-Path $editorRoot 'core\fn_test.sqf')) `
        -Message 'Push con -WhatIf modificó el destino.'

    & $syncScript -Action Push -ProjectMissionPath $projectRoot -EditorMissionPath $editorRoot | Out-Null

    Assert-Equal `
        -Expected 'project-v1' `
        -Actual ((Get-Content -Raw -LiteralPath (Join-Path $editorRoot 'core\fn_test.sqf')).Trim()) `
        -Message 'Push no copió el archivo del proyecto.'
    Assert-Equal `
        -Expected 'editor-mission' `
        -Actual ((Get-Content -Raw -LiteralPath (Join-Path $editorRoot 'mission.sqm')).Trim()) `
        -Message 'Push modificó mission.sqm, que debe permanecer protegido.'

    Set-Content -LiteralPath (Join-Path $editorRoot 'core\fn_test.sqf') -Value 'editor-v2'
    Set-Content -LiteralPath (Join-Path $editorRoot 'mission.sqm') -Value 'editor-mission-v2'
    (Get-Item -LiteralPath (Join-Path $editorRoot 'core\fn_test.sqf')).LastWriteTimeUtc = [datetime]::UtcNow.AddMinutes(2)
    (Get-Item -LiteralPath (Join-Path $editorRoot 'mission.sqm')).LastWriteTimeUtc = [datetime]::UtcNow.AddMinutes(2)

    & $syncScript -Action Pull -ProjectMissionPath $projectRoot -EditorMissionPath $editorRoot | Out-Null

    Assert-Equal `
        -Expected 'editor-v2' `
        -Actual ((Get-Content -Raw -LiteralPath (Join-Path $projectRoot 'core\fn_test.sqf')).Trim()) `
        -Message 'Pull no trajo el archivo del editor.'
    Assert-Equal `
        -Expected 'editor-mission-v2' `
        -Actual ((Get-Content -Raw -LiteralPath (Join-Path $projectRoot 'mission.sqm')).Trim()) `
        -Message 'Pull no trajo mission.sqm desde 3DEN.'

    Set-Content -LiteralPath (Join-Path $editorRoot 'core\fn_test.sqf') -Value 'editor-conflict'
    Set-Content -LiteralPath (Join-Path $projectRoot 'core\fn_test.sqf') -Value 'project-conflict'
    (Get-Item -LiteralPath (Join-Path $editorRoot 'core\fn_test.sqf')).LastWriteTimeUtc = [datetime]::UtcNow.AddMinutes(3)
    (Get-Item -LiteralPath (Join-Path $projectRoot 'core\fn_test.sqf')).LastWriteTimeUtc = [datetime]::UtcNow.AddMinutes(4)

    $conflictDetected = $false
    try {
        & $syncScript -Action Pull -ProjectMissionPath $projectRoot -EditorMissionPath $editorRoot | Out-Null
    }
    catch {
        $conflictDetected = $true
    }
    Assert-Equal -Expected $true -Actual $conflictDetected -Message 'Pull no detuvo un conflicto con destino más reciente.'

    $status = @(& $syncScript -Action Status -ProjectMissionPath $projectRoot -EditorMissionPath $editorRoot)
    $conflictStatus = @($status | Where-Object {
        $_.Ruta -eq 'core\fn_test.sqf' -and $_.Estado -eq 'ProyectoMasNuevo'
    })
    Assert-Equal -Expected 1 -Actual $conflictStatus.Count -Message 'Status no informó la diferencia esperada.'

    & $syncScript -Action Pull -ProjectMissionPath $projectRoot -EditorMissionPath $editorRoot -Force | Out-Null
    Assert-Equal `
        -Expected 'editor-conflict' `
        -Actual ((Get-Content -Raw -LiteralPath (Join-Path $projectRoot 'core\fn_test.sqf')).Trim()) `
        -Message 'Pull con -Force no hizo prevalecer el origen.'

    Write-Output 'PASS: WhatIf, Push, protección de mission.sqm, Pull, conflictos, Status y Force.'
}
finally {
    $resolvedTemporaryRoot = [IO.Path]::GetFullPath($temporaryRoot)
    if (-not $resolvedTemporaryRoot.StartsWith($temporaryBase, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Se rechazó limpiar una ruta fuera del directorio temporal: $resolvedTemporaryRoot"
    }
    if (Test-Path -LiteralPath $resolvedTemporaryRoot) {
        Remove-Item -LiteralPath $resolvedTemporaryRoot -Recurse -Force
    }
}
