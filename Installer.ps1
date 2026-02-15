# =======================================
# Keycap_desktop PowerShell Web Installer
# =======================================

$AppName = "KEYCAP_DESKTOP"
$InstallDir = "$env:LOCALAPPDATA\KEYCAP"
$ExeName = "Keycap_desktop.exe"

# CHANGE THIS TO YOUR REAL URL
$DownloadUrl = "https://github.com/keycapeditor/Keycap-desktop/releases/download/Keycap/Keycap_desktop.exe"

$ExePath = Join-Path $InstallDir $ExeName

Write-Host "Installing $AppName..." -ForegroundColor Cyan

# Create install directory
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir | Out-Null
}

# Download EXE
Write-Host "Downloading from $DownloadUrl"
Invoke-WebRequest `
    -Uri $DownloadUrl `
    -OutFile $ExePath `
    -UseBasicParsing

# Ensure download worked
if (!(Test-Path $ExePath)) {
    Write-Error "Download failed!"
    exit 1
}

# Get current PATH
$CurrentPath = [Environment]::GetEnvironmentVariable("Path", "User")

# Add install dir to PATH if needed
if ($CurrentPath -notlike "*$InstallDir*") {
    [Environment]::SetEnvironmentVariable(
        "Path",
        "$CurrentPath;$InstallDir",
        "User"
    )
    Write-Host "Added to PATH" -ForegroundColor Green
} else {
    Write-Host "Already in PATH" -ForegroundColor Yellow
}

Write-Host "`nInstallation complete!" -ForegroundColor Green
Write-Host "Open a NEW terminal in a empty folder and run:" -ForegroundColor Cyan
Write-Host "  Keycap_desktop ./" -ForegroundColor White

Read-Host "`nPress Enter to exit"
