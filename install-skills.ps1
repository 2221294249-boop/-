$ErrorActionPreference = "Stop"

$sourceRoot = Join-Path $PSScriptRoot "plugins\research-skills\skills"
$destinationRoot = Join-Path $HOME ".codex\skills"

if (-not (Test-Path -LiteralPath $sourceRoot -PathType Container)) {
    throw "Skill source directory not found: $sourceRoot"
}

New-Item -ItemType Directory -Force -Path $destinationRoot | Out-Null

$installed = 0
$skipped = 0

Get-ChildItem -LiteralPath $sourceRoot -Directory | Sort-Object Name | ForEach-Object {
    $destination = Join-Path $destinationRoot $_.Name
    if (Test-Path -LiteralPath $destination) {
        Write-Warning "Skipped existing skill: $($_.Name)"
        $skipped += 1
        return
    }

    Copy-Item -LiteralPath $_.FullName -Destination $destination -Recurse
    Write-Host "Installed: $($_.Name)"
    $installed += 1
}

Write-Host "Completed. Installed: $installed; skipped: $skipped"
Write-Host "Restart Codex or start a new conversation before using the skills."
