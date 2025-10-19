# init-capacitor.ps1 — helper to initialize Capacitor and add platforms
param(
  [string]$android = 'true',
  [string]$ios = 'false'
)

Write-Host "Initializing Capacitor in project root..."

# Ensure @capacitor/cli and core are installed
npm install --save @capacitor/core @capacitor/cli

# Initialize Capacitor (uses capacitor.config.json if present)
npx cap init || Write-Host "cap init skipped (already initialized)"

if ($android -eq 'true') {
  Write-Host "Adding Android platform..."
  npx cap add android
}

if ($ios -eq 'true') {
  Write-Host "Adding iOS platform..."
  npx cap add ios
}

Write-Host "Copy web assets to native projects (run this after building your web app): npx cap copy"
Write-Host "To open Android Studio: npx cap open android"
Write-Host "To open Xcode: npx cap open ios (macOS only)"
