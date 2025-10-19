<#
build-capacitor.ps1

Helper to build (optional), sync/copy web assets into Capacitor native projects,
and open Android Studio / Xcode. Designed for local development workflows.

Usage examples:
  # Sync and open Android
  .\scripts\build-capacitor.ps1 -openAndroid

  # Build web assets with a custom command, sync and open Android
  .\scripts\build-capacitor.ps1 -buildWeb -webBuildCmd 'npm run build' -openAndroid

  # Sync only (no open)
  .\scripts\build-capacitor.ps1 -noOpen
#>

param(
  [switch]$buildWeb = $false,
  [string]$webBuildCmd = 'npm run build',
  [switch]$openAndroid = $false,
  [switch]$openIos = $false,
  [switch]$noOpen = $false,
  [switch]$skipInstall = $false
)

Set-StrictMode -Version Latest

function Invoke-Run($cmd) {
  Write-Host "Running: $cmd"
  $proc = Start-Process -FilePath pwsh -ArgumentList "-NoProfile","-Command","$cmd" -NoNewWindow -Wait -PassThru
  if ($proc.ExitCode -ne 0) { throw "Command failed: $cmd (exit $($proc.ExitCode))" }
}

try {
  Push-Location -Path (Resolve-Path "..\")
  # Optionally build web assets
  if ($buildWeb) {
    Write-Host "Building web assets using: $webBuildCmd"
  Invoke-Run $webBuildCmd
  }

  # Ensure Capacitor CLI is available
  if (-not $skipInstall) {
    Write-Host "Ensuring Capacitor CLI is installed (local dev dep)..."
  Invoke-Run "npm install --no-audit --no-fund @capacitor/cli @capacitor/core"
  }

  # Sync native projects (updates plugins + copies web assets)
  Write-Host "Syncing Capacitor projects (copying web assets and plugins)..."
  Invoke-Run "npx cap sync"

  if (-not $noOpen) {
    if ($openAndroid -or (-not $openIos -and -not $openAndroid)) {
  Write-Host "Opening Android project in Android Studio..."
  Invoke-Run "npx cap open android"
    }
    if ($openIos) {
  Write-Host "Opening iOS project in Xcode (macOS only)..."
  Invoke-Run "npx cap open ios"
    }
  } else {
    Write-Host "No open requested; synced and copied assets only."
  }

  Pop-Location
  Write-Host "Done."
} catch {
  Write-Error "Build helper failed: $_"
  if (Get-Location) { Pop-Location -ErrorAction SilentlyContinue }
  exit 1
}
