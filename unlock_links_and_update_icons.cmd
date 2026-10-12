@echo off
setlocal
set "collectionSetupExitCode=0"
set "collectionPowerShell=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
echo [1/3] Unblock shortcuts and folder settings
"%collectionPowerShell%" -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\Unlock-shortcuts.ps1"
if errorlevel 1 set "collectionSetupExitCode=1"
echo.
echo [2/3] Update Windows icons and folder image caches
"%collectionPowerShell%" -NoLogo -NoProfile -STA -ExecutionPolicy Bypass -File "%~dp0scripts\Update-icons.ps1"
if errorlevel 1 set "collectionSetupExitCode=1"
echo.
echo [3/3] Set Videos templates and extra large Explorer icons
"%collectionPowerShell%" -NoLogo -NoProfile -STA -ExecutionPolicy Bypass -File "%~dp0scripts\Set-Explorer-view.ps1"
if errorlevel 1 set "collectionSetupExitCode=1"
echo.
if "%collectionSetupExitCode%"=="0" (echo CTRL-WIN setup completed.) else (echo Setup finished with errors. Please check the messages above.)
if /i not "%~1"=="--no-pause" pause
exit /b %collectionSetupExitCode%
