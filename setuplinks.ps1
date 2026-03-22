# setuplinks.ps1

$Source = $PSScriptRoot
$Target = "$env:USERPROFILE\.claude"

$Folders = @("agents", "commands", "rules", "skills")
$Files   = @("CLAUDE.md")

Write-Host "Source: $Source"
Write-Host "Target: $Target"
Write-Host ""

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "[ERROR] Please run PowerShell as Administrator." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $Target)) {
    New-Item -ItemType Directory -Path $Target | Out-Null
    Write-Host "[CREATED] $Target" -ForegroundColor Cyan
}

foreach ($folder in $Folders) {
    $src  = Join-Path $Source $folder
    $dest = Join-Path $Target $folder

    if (-not (Test-Path $src)) {
        Write-Host "[SKIP] $folder not found in source" -ForegroundColor Yellow
        continue
    }

    if (Test-Path $dest) {
        Write-Host "[SKIP] $dest already exists" -ForegroundColor Yellow
    } else {
        cmd /c mklink /D "`"$dest`"" "`"$src`"" | Out-Null
        Write-Host "[LINKED] $dest -> $src" -ForegroundColor Green
    }
}

foreach ($file in $Files) {
    $src  = Join-Path $Source $file
    $dest = Join-Path $Target $file

    if (-not (Test-Path $src)) {
        Write-Host "[SKIP] $file not found in source" -ForegroundColor Yellow
        continue
    }

    if (Test-Path $dest) {
        Write-Host "[SKIP] $dest already exists" -ForegroundColor Yellow
    } else {
        cmd /c mklink "`"$dest`"" "`"$src`"" | Out-Null
        Write-Host "[LINKED] $dest -> $src" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Cyan