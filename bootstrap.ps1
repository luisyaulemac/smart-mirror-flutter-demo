$ErrorActionPreference = "Stop"

Write-Host "Bootstrapping Smart Mirror Flutter Demo..." -ForegroundColor Cyan

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    throw "Flutter was not found in PATH."
}

if (-not (Test-Path ".\android") -or -not (Test-Path ".\windows")) {
    flutter create . --platforms=android,windows,web
}

flutter pub get
flutter analyze

Write-Host ""
Write-Host "Ready." -ForegroundColor Green
Write-Host "Run with: flutter run"
