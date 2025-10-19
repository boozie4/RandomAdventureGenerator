<#
init-cordova.ps1

Create a Cordova mobile project under `mobile/`, copy the web app into `mobile/www`, and add Android/iOS platforms.

Usage:
  # Create mobile project and add Android
  .\scripts\init-cordova.ps1 -addAndroid

  # Create mobile project and add Android + iOS (macOS only for iOS)
  .\scripts\init-cordova.ps1 -addAndroid -addIos

This script uses `npx cordova` (no global install required). It will not commit or add platform folders to git.
#>

param(
  [switch]$addAndroid = $false,
  [switch]$addIos = $false,
  [string]$appId = 'com.example.randomadventure',
  [string]$appName = 'RandomAdventure'
)

Set-StrictMode -Version Latest

function Invoke-Run($cmd) {
  Write-Host "Running: $cmd"
  $proc = Start-Process -FilePath pwsh -ArgumentList "-NoProfile","-Command","$cmd" -NoNewWindow -Wait -PassThru
  if ($proc.ExitCode -ne 0) { throw "Command failed: $cmd (exit $($proc.ExitCode))" }
}

try {
  $root = Resolve-Path "."
  Push-Location $root

  if (-not (Test-Path "mobile")) {
    Write-Host "Creating Cordova project in ./mobile"
    Invoke-Run "npx cordova create mobile $appId $appName"
  } else {
    Write-Host "mobile/ already exists — skipping project creation"
  }

  # Copy web assets into mobile/www
  $www = Join-Path $root "mobile\www"
  if (-not (Test-Path $www)) { New-Item -ItemType Directory -Path $www | Out-Null }

  Write-Host "Clearing default Cordova www files..."
  Get-ChildItem -Path $www -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

  Write-Host "Copying web app files into mobile/www..."
  $filesToCopy = @('index.html','styles.css','scripts.js','mobile-config.js')
  foreach ($f in $filesToCopy) {
    if (Test-Path $f) { Copy-Item -Path $f -Destination $www -Force }
  }
  # Copy assets directory if it exists
  if (Test-Path "assets") { Copy-Item -Path "assets" -Destination $www -Recurse -Force }

  # Add platforms as requested
  if ($addAndroid) {
    Write-Host "Adding Android platform..."
    Invoke-Run "npx cordova platform add android"
  }
  if ($addIos) {
    Write-Host "Adding iOS platform... (requires macOS/Xcode)"
    Invoke-Run "npx cordova platform add ios"
  }

  # Add recommended plugins
  Write-Host "Adding common Cordova plugins (whitelist, splashscreen, statusbar, network)..."
  Invoke-Run "npx cordova plugin add cordova-plugin-whitelist"
  Invoke-Run "npx cordova plugin add cordova-plugin-splashscreen"
  Invoke-Run "npx cordova plugin add cordova-plugin-statusbar"
  Invoke-Run "npx cordova plugin add cordova-plugin-network-information"

  Write-Host "Cordova project setup complete. Next steps:"
  Write-Host "  cd mobile"
  Write-Host "  npx cordova build android"
  Write-Host "  npx cordova run android --device"
  Write-Host "  (on macOS) npx cordova build ios && npx cordova run ios"

  Pop-Location
} catch {
  Write-Error "Cordova init failed: $_"
  if (Get-Location) { Pop-Location -ErrorAction SilentlyContinue }
  exit 1
}
