<#
.SYNOPSIS
    Envia a la Papelera de reciclaje el material de asset/ sin procedencia clara ni uso
    concreto en el proyecto, dejando intacto asset/reference/ y asset/PROCEDENCIA.md.

.DESCRIPTION
    Bloqueado para ejecucion automatica por el clasificador de permisos de Claude Code
    (borrado masivo). Se deja aqui, revisado y listo, para que lo ejecute una persona.

    Envia a la Papelera (recuperable), nunca borra en firme.
    Ver asset/PROCEDENCIA.md para el detalle y el motivo de cada archivo.

.EXAMPLE
    .\tools\Remove-UnusedReferenceAssets.ps1          # revisa antes de borrar
    .\tools\Remove-UnusedReferenceAssets.ps1 -Confirm:$false
#>
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param()

Add-Type -AssemblyName Microsoft.VisualBasic

$root = Split-Path -Parent $PSScriptRoot
$assetDir = Join-Path $root 'asset'

# Solo archivos sueltos en la raiz de asset/: nunca toca asset/reference/ ni PROCEDENCIA.md
$targets = Get-ChildItem -LiteralPath $assetDir -File -ErrorAction Stop |
    Where-Object { $_.Name -ne 'PROCEDENCIA.md' }

if ($targets.Count -eq 0) {
    Write-Host "Nada que retirar: asset/ ya no tiene archivos sueltos en su raiz." -ForegroundColor Green
    return
}

Write-Host "Se enviaran a la Papelera de reciclaje $($targets.Count) archivos:" -ForegroundColor Yellow
$targets | ForEach-Object { Write-Host "  - $($_.Name)" }

$borrados = 0
foreach ($f in $targets) {
    if ($PSCmdlet.ShouldProcess($f.Name, 'Enviar a la Papelera de reciclaje')) {
        [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile(
            $f.FullName, 'OnlyErrorDialogs', 'SendToRecycleBin')
        $borrados++
    }
}

Write-Host "`nEnviados a la Papelera: $borrados" -ForegroundColor Cyan
Write-Host "Recuperables desde la Papelera de reciclaje de Windows si hacen falta." -ForegroundColor Cyan
