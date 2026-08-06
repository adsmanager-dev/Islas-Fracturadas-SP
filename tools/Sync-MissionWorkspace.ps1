<#
.SYNOPSIS
Sincroniza de forma controlada la misión del repositorio con la carpeta local de 3DEN.

.DESCRIPTION
Status compara ambas carpetas. Pull trae archivos desde 3DEN al proyecto, incluido
mission.sqm. Push envía archivos del proyecto a 3DEN, pero protege mission.sqm. No
se eliminan archivos y los destinos más recientes requieren revisión o -Force.

.EXAMPLE
.\tools\Sync-MissionWorkspace.ps1 -Action Status

.EXAMPLE
.\tools\Sync-MissionWorkspace.ps1 -Action Pull

.EXAMPLE
.\tools\Sync-MissionWorkspace.ps1 -Action Push -WhatIf
#>
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    [ValidateSet('Status', 'Pull', 'Push')]
    [string]$Action = 'Status',

    [string]$ProjectMissionPath = (
        Join-Path (Split-Path -Parent $PSScriptRoot) 'IslasFracturadas.Altis'
    ),

    [string]$EditorMissionPath = (
        Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'Arma 3\missions\IslasFracturadas.Altis'
    ),

    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ignoredDirectories = @(
    '.git',
    '.serena',
    '.codebase-memory',
    '.hemttout',
    '__cur_mp',
    'coverage',
    'test-results',
    'missionscache',
    'mpmissionscache'
)

$ignoredFilePatterns = @(
    '.gitkeep',
    '.DS_Store',
    'Thumbs.db',
    'ehthumbs.db',
    'Desktop.ini',
    '*.pbo',
    '*.ebo',
    '*.bisign',
    '*.biprivatekey',
    '*.rpt',
    '*.bidmp',
    '*.mdmp',
    '*.Arma3Profile',
    '*.vars.Arma3Profile',
    '*.log',
    '*.tmp',
    '*.temp',
    '*.bak',
    '*.old',
    '*.swp',
    '*~'
)

function Get-NormalizedPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    $expanded = [Environment]::ExpandEnvironmentVariables($Path)
    if (-not [IO.Path]::IsPathRooted($expanded)) {
        $expanded = Join-Path (Get-Location).Path $expanded
    }

    $fullPath = [IO.Path]::GetFullPath($expanded)
    $root = [IO.Path]::GetPathRoot($fullPath)
    if ($fullPath.Length -gt $root.Length) {
        return $fullPath.TrimEnd([char[]]'\/')
    }
    return $fullPath
}

function Assert-MissionDirectory {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Label
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        throw "No existe la carpeta de misión de $Label`: $Path"
    }
}

function Assert-SeparateRoots {
    param(
        [Parameter(Mandatory = $true)][string]$ProjectRoot,
        [Parameter(Mandatory = $true)][string]$EditorRoot
    )

    if ($ProjectRoot.Equals($EditorRoot, [StringComparison]::OrdinalIgnoreCase)) {
        throw 'Las carpetas de proyecto y 3DEN no pueden ser la misma.'
    }

    $separator = [IO.Path]::DirectorySeparatorChar
    $projectPrefix = $ProjectRoot + $separator
    $editorPrefix = $EditorRoot + $separator
    if ($ProjectRoot.StartsWith($editorPrefix, [StringComparison]::OrdinalIgnoreCase) -or
        $EditorRoot.StartsWith($projectPrefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw 'Una carpeta de sincronización no puede estar contenida dentro de la otra.'
    }
}

function Get-RelativeMissionPath {
    param(
        [Parameter(Mandatory = $true)][string]$Root,
        [Parameter(Mandatory = $true)][string]$Path
    )

    $prefix = $Root + [IO.Path]::DirectorySeparatorChar
    if (-not $Path.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw "La ruta no pertenece a la raíz esperada: $Path"
    }
    return $Path.Substring($prefix.Length)
}

function Test-IgnoredDirectory {
    param([Parameter(Mandatory = $true)][string]$RelativePath)

    foreach ($segment in ($RelativePath -split '[\\/]')) {
        if ($ignoredDirectories -contains $segment) {
            return $true
        }
    }
    return $false
}

function Test-IgnoredFile {
    param([Parameter(Mandatory = $true)][string]$RelativePath)

    $leafName = Split-Path -Leaf $RelativePath
    foreach ($pattern in $ignoredFilePatterns) {
        if ($leafName -like $pattern) {
            return $true
        }
    }
    return $false
}

function Get-MissionFiles {
    param([Parameter(Mandatory = $true)][string]$Root)

    $queue = New-Object 'System.Collections.Generic.Queue[System.IO.DirectoryInfo]'
    $queue.Enqueue((Get-Item -LiteralPath $Root))

    while ($queue.Count -gt 0) {
        $directory = $queue.Dequeue()
        foreach ($item in (Get-ChildItem -LiteralPath $directory.FullName -Force)) {
            $relativePath = Get-RelativeMissionPath -Root $Root -Path $item.FullName
            $isReparsePoint = ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0
            if ($isReparsePoint) {
                continue
            }

            if ($item.PSIsContainer) {
                if (-not (Test-IgnoredDirectory -RelativePath $relativePath)) {
                    $queue.Enqueue($item)
                }
                continue
            }

            if (-not (Test-IgnoredFile -RelativePath $relativePath)) {
                $item
            }
        }
    }
}

function Get-FileMap {
    param([Parameter(Mandatory = $true)][string]$Root)

    $map = @{}
    foreach ($file in (Get-MissionFiles -Root $Root)) {
        $relativePath = Get-RelativeMissionPath -Root $Root -Path $file.FullName
        $map[$relativePath] = $file
    }
    return $map
}

function Test-SameContent {
    param(
        [Parameter(Mandatory = $true)][IO.FileInfo]$Left,
        [Parameter(Mandatory = $true)][IO.FileInfo]$Right
    )

    if ($Left.Length -ne $Right.Length) {
        return $false
    }

    $leftHash = (Get-FileHash -LiteralPath $Left.FullName -Algorithm SHA256).Hash
    $rightHash = (Get-FileHash -LiteralPath $Right.FullName -Algorithm SHA256).Hash
    return $leftHash -eq $rightHash
}

function Get-StatusEntries {
    param(
        [Parameter(Mandatory = $true)][hashtable]$ProjectFiles,
        [Parameter(Mandatory = $true)][hashtable]$EditorFiles
    )

    $relativePaths = @($ProjectFiles.Keys) + @($EditorFiles.Keys) | Sort-Object -Unique
    foreach ($relativePath in $relativePaths) {
        $inProject = $ProjectFiles.ContainsKey($relativePath)
        $inEditor = $EditorFiles.ContainsKey($relativePath)
        $state = $null

        if (-not $inEditor) {
            $state = 'SoloProyecto'
        }
        elseif (-not $inProject) {
            $state = 'SoloEditor'
        }
        elseif (Test-SameContent -Left $ProjectFiles[$relativePath] -Right $EditorFiles[$relativePath]) {
            $state = 'Igual'
        }
        elseif ($ProjectFiles[$relativePath].LastWriteTimeUtc -gt $EditorFiles[$relativePath].LastWriteTimeUtc) {
            $state = 'ProyectoMasNuevo'
        }
        elseif ($EditorFiles[$relativePath].LastWriteTimeUtc -gt $ProjectFiles[$relativePath].LastWriteTimeUtc) {
            $state = 'EditorMasNuevo'
        }
        else {
            $state = 'ConflictoMismaFecha'
        }

        [PSCustomObject]@{
            Estado = $state
            Ruta = $relativePath
        }
    }
}

function Get-SyncPlan {
    param(
        [Parameter(Mandatory = $true)][hashtable]$SourceFiles,
        [Parameter(Mandatory = $true)][hashtable]$TargetFiles,
        [Parameter(Mandatory = $true)][ValidateSet('Pull', 'Push')][string]$Direction,
        [Parameter(Mandatory = $true)][bool]$OverwriteNewerTarget
    )

    foreach ($relativePath in ($SourceFiles.Keys | Sort-Object)) {
        $sourceFile = $SourceFiles[$relativePath]

        if ($Direction -eq 'Push' -and $relativePath.Equals('mission.sqm', [StringComparison]::OrdinalIgnoreCase)) {
            [PSCustomObject]@{
                Operacion = 'Protegido'
                Ruta = $relativePath
                Motivo = 'mission.sqm solo puede entrar al proyecto mediante Pull'
            }
            continue
        }

        if (-not $TargetFiles.ContainsKey($relativePath)) {
            [PSCustomObject]@{
                Operacion = 'Copiar'
                Ruta = $relativePath
                Motivo = 'ausente en destino'
            }
            continue
        }

        $targetFile = $TargetFiles[$relativePath]
        if (Test-SameContent -Left $sourceFile -Right $targetFile) {
            [PSCustomObject]@{
                Operacion = 'SinCambios'
                Ruta = $relativePath
                Motivo = 'contenido idéntico'
            }
            continue
        }

        if ($sourceFile.LastWriteTimeUtc -gt $targetFile.LastWriteTimeUtc -or $OverwriteNewerTarget) {
            [PSCustomObject]@{
                Operacion = 'Copiar'
                Ruta = $relativePath
                Motivo = if ($OverwriteNewerTarget) { 'sobrescritura autorizada con -Force' } else { 'origen más reciente' }
            }
        }
        else {
            [PSCustomObject]@{
                Operacion = 'Conflicto'
                Ruta = $relativePath
                Motivo = 'el destino es más reciente o tiene la misma fecha con contenido distinto'
            }
        }
    }
}

$projectRoot = Get-NormalizedPath -Path $ProjectMissionPath
$editorRoot = Get-NormalizedPath -Path $EditorMissionPath

Assert-MissionDirectory -Path $projectRoot -Label 'proyecto'
Assert-MissionDirectory -Path $editorRoot -Label '3DEN'
Assert-SeparateRoots -ProjectRoot $projectRoot -EditorRoot $editorRoot

$projectFiles = Get-FileMap -Root $projectRoot
$editorFiles = Get-FileMap -Root $editorRoot

Write-Host "Proyecto: $projectRoot"
Write-Host "3DEN:     $editorRoot"

if ($Action -eq 'Status') {
    Get-StatusEntries -ProjectFiles $projectFiles -EditorFiles $editorFiles
    return
}

if ($Action -eq 'Pull') {
    $sourceRoot = $editorRoot
    $targetRoot = $projectRoot
    $sourceFiles = $editorFiles
    $targetFiles = $projectFiles
}
else {
    $sourceRoot = $projectRoot
    $targetRoot = $editorRoot
    $sourceFiles = $projectFiles
    $targetFiles = $editorFiles
}

$plan = @(Get-SyncPlan `
    -SourceFiles $sourceFiles `
    -TargetFiles $targetFiles `
    -Direction $Action `
    -OverwriteNewerTarget $Force.IsPresent)

$conflicts = @($plan | Where-Object { $_.Operacion -eq 'Conflicto' })
if ($conflicts.Count -gt 0) {
    $conflictList = ($conflicts.Ruta | ForEach-Object { " - $_" }) -join [Environment]::NewLine
    throw "Sincronización cancelada antes de copiar. Conflictos detectados:`n$conflictList`nRevise con -Action Status y use -Force solo si el origen debe prevalecer."
}

$copied = 0
$planned = @($plan | Where-Object { $_.Operacion -eq 'Copiar' })
foreach ($entry in $planned) {
    $sourcePath = Join-Path $sourceRoot $entry.Ruta
    $targetPath = Join-Path $targetRoot $entry.Ruta
    $description = "$Action '$sourcePath'"

    if ($PSCmdlet.ShouldProcess($targetPath, $description)) {
        $targetDirectory = Split-Path -Parent $targetPath
        if (-not (Test-Path -LiteralPath $targetDirectory -PathType Container)) {
            New-Item -ItemType Directory -Path $targetDirectory -Force | Out-Null
        }
        Copy-Item -LiteralPath $sourcePath -Destination $targetPath -Force
        $copied++
    }
}

$targetOnly = @($targetFiles.Keys | Where-Object { -not $sourceFiles.ContainsKey($_) })
[PSCustomObject]@{
    Accion = $Action
    Planificados = $planned.Count
    Copiados = $copied
    SinCambios = @($plan | Where-Object { $_.Operacion -eq 'SinCambios' }).Count
    Protegidos = @($plan | Where-Object { $_.Operacion -eq 'Protegido' }).Count
    SoloDestinoConservados = $targetOnly.Count
}
