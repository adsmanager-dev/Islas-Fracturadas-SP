[CmdletBinding()]
param(
    [switch]$Check
)

$ErrorActionPreference = "Stop"
$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$sourceRoot = Join-Path $projectRoot "agent-skills-src"
$destinations = @(
    (Join-Path $projectRoot ".claude\skills"),
    (Join-Path $projectRoot ".agents\skills")
)
$manifestName = ".if-agent-skills-manifest.json"

function Get-RelativeSkillPath {
    param([string]$Root, [string]$Path)
    return [System.IO.Path]::GetRelativePath($Root, $Path).Replace("\", "/")
}

function Get-SkillFiles {
    param([string]$Root)
    if (-not (Test-Path -LiteralPath $Root)) {
        return @()
    }
    return @(Get-ChildItem -LiteralPath $Root -Recurse -File |
        Where-Object { $_.Name -ne $manifestName } |
        Sort-Object FullName)
}

function Get-SourceManifest {
    $entries = foreach ($file in (Get-SkillFiles -Root $sourceRoot)) {
        [ordered]@{
            path = Get-RelativeSkillPath -Root $sourceRoot -Path $file.FullName
            sha256 = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash
        }
    }
    return @($entries)
}

function Assert-ManagedDestination {
    param(
        [string]$Destination,
        [switch]$AllowStaleManifestWhenMatchingSource
    )
    if (-not (Test-Path -LiteralPath $Destination)) {
        return
    }

    $manifestPath = Join-Path $Destination $manifestName
    $files = Get-SkillFiles -Root $Destination
    if (-not (Test-Path -LiteralPath $manifestPath)) {
        if ($files.Count -gt 0) {
            throw "El destino contiene archivos sin manifiesto: $Destination"
        }
        return
    }

    $recorded = @(Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json)
    $recordedByPath = @{}
    foreach ($entry in $recorded) {
        $recordedByPath[$entry.path] = $entry.sha256
    }

    foreach ($file in $files) {
        $relative = Get-RelativeSkillPath -Root $Destination -Path $file.FullName
        if (-not $recordedByPath.ContainsKey($relative)) {
            throw "Archivo no administrado en destino: $relative"
        }
        $hash = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash
        if ($hash -ne $recordedByPath[$relative]) {
            $sourceFile = Join-Path $sourceRoot $relative
            $matchesCurrentSource = (Test-Path -LiteralPath $sourceFile) -and
                ((Get-FileHash -LiteralPath $sourceFile -Algorithm SHA256).Hash -eq $hash)
            if ($AllowStaleManifestWhenMatchingSource -and $matchesCurrentSource) {
                continue
            }
            throw "Modificación manual detectada en destino: $relative"
        }
    }

    foreach ($relative in $recordedByPath.Keys) {
        if (-not (Test-Path -LiteralPath (Join-Path $Destination $relative))) {
            throw "Archivo administrado ausente en destino: $relative"
        }
    }
}

if (-not (Test-Path -LiteralPath $sourceRoot)) {
    throw "No existe la fuente de skills: $sourceRoot"
}

$sourceManifest = Get-SourceManifest
foreach ($destination in $destinations) {
    Assert-ManagedDestination -Destination $destination -AllowStaleManifestWhenMatchingSource:(-not $Check)
    if ($Check) {
        $destinationFiles = Get-SkillFiles -Root $destination
        if ($destinationFiles.Count -ne $sourceManifest.Count) {
            throw "Cantidad de archivos distinta en $destination"
        }
        foreach ($entry in $sourceManifest) {
            $target = Join-Path $destination $entry.path
            if (-not (Test-Path -LiteralPath $target)) {
                throw "Falta en destino: $($entry.path)"
            }
            if ((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne $entry.sha256) {
                throw "Hash distinto en destino: $($entry.path)"
            }
        }
        continue
    }

    if (Test-Path -LiteralPath $destination) {
        $resolved = (Resolve-Path -LiteralPath $destination).Path
        if (-not $resolved.StartsWith($projectRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Destino fuera del proyecto: $resolved"
        }
        Get-ChildItem -LiteralPath $destination -Directory |
            Where-Object { $_.Name -like "if-*" } |
            ForEach-Object { Remove-Item -LiteralPath $_.FullName -Recurse -Force }
    } else {
        New-Item -ItemType Directory -Path $destination -Force | Out-Null
    }

    foreach ($skill in (Get-ChildItem -LiteralPath $sourceRoot -Directory -Filter "if-*")) {
        Copy-Item -LiteralPath $skill.FullName -Destination $destination -Recurse
    }
    $sourceManifest | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $destination $manifestName) -Encoding utf8
}

if ($Check) {
    Write-Output "Skills sincronizadas y hashes verificados."
} else {
    Write-Output "Skills copiadas desde agent-skills-src y manifiestos actualizados."
}
