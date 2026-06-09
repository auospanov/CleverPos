# Полная очистка перед установкой CleverApp на iPhone (Hot Restart с Windows).
# Закройте Visual Studio перед запуском.

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Stopping VS iOS tooling (if running)..."
Get-Process -Name "iOSBuildHost","Xamarin.PreBuilt.iOS.app" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

Write-Host "Removing CleverApp bin/obj..."
Remove-Item -Recurse -Force "$root\bin", "$root\obj" -ErrorAction SilentlyContinue

Write-Host "Removing Hot Restart cache..."
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\Temp\Xamarin\HotRestart" -ErrorAction SilentlyContinue

Write-Host "Done. Next steps:"
Write-Host "  1. Delete CleverApp from iPhone"
Write-Host "  2. Open CleverApp.sln in Visual Studio"
Write-Host "  3. Select iPhone device, Rebuild, F5"
