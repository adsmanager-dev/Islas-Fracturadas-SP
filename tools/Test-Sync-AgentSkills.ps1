[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$fixtureRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("if-agent-skills-" + [guid]::NewGuid().ToString('N'))

try {
    New-Item -ItemType Directory -Path (Join-Path $fixtureRoot 'tools') -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $fixtureRoot 'agent-skills-src\if-test\agents') -Force | Out-Null
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'Sync-AgentSkills.ps1') -Destination (Join-Path $fixtureRoot 'tools\Sync-AgentSkills.ps1')
    Set-Content -LiteralPath (Join-Path $fixtureRoot 'agent-skills-src\if-test\SKILL.md') -Value "---`nname: if-test`ndescription: fixture`n---`n" -Encoding utf8
    Set-Content -LiteralPath (Join-Path $fixtureRoot 'agent-skills-src\if-test\agents\openai.yaml') -Value "interface:`n  display_name: `"Fixture`"`n" -Encoding utf8

    $sync = Join-Path $fixtureRoot 'tools\Sync-AgentSkills.ps1'
    & $sync
    & $sync -Check

    $source = Join-Path $fixtureRoot 'agent-skills-src\if-test\agents\openai.yaml'
    Add-Content -LiteralPath $source -Value '  short_description: "Updated fixture"' -Encoding utf8
    foreach ($destination in '.agents\skills', '.claude\skills') {
        Copy-Item -LiteralPath $source -Destination (Join-Path $fixtureRoot "$destination\if-test\agents\openai.yaml") -Force
    }
    & $sync
    & $sync -Check

    Add-Content -LiteralPath (Join-Path $fixtureRoot '.agents\skills\if-test\SKILL.md') -Value 'manual divergence' -Encoding utf8
    $rejected = $false
    try {
        & $sync
    } catch {
        $rejected = $_.Exception.Message -like '*Modificación manual detectada*'
    }
    if (-not $rejected) {
        throw 'La sincronización no rechazó una divergencia manual real.'
    }

    Write-Output 'PASS: sincronización inicial, recuperación de manifiesto obsoleto y rechazo de divergencia real.'
} finally {
    if (Test-Path -LiteralPath $fixtureRoot) {
        $resolvedFixture = (Resolve-Path -LiteralPath $fixtureRoot).Path
        $resolvedTemp = (Resolve-Path -LiteralPath ([System.IO.Path]::GetTempPath())).Path
        if (-not $resolvedFixture.StartsWith($resolvedTemp, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Fixture fuera del temporal: $resolvedFixture"
        }
        Remove-Item -LiteralPath $resolvedFixture -Recurse -Force
    }
}
