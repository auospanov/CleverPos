@echo off
REM Windows helper: run deploy.sh via Git Bash (asks SSH password interactively).
REM Requires Git for Windows. Does NOT use local Docker.

setlocal
cd /d "%~dp0"

where bash >nul 2>&1
if errorlevel 1 (
  echo Git Bash not found. Install Git for Windows, then run:
  echo   bash deploy.sh
  exit /b 1
)

bash "%~dp0deploy.sh" %*
exit /b %ERRORLEVEL%
