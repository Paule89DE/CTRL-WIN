@echo off
setlocal EnableExtensions DisableDelayedExpansion
title PowerShell Execution Policy
set "CTRLWIN_SELF=%~f0"
set "CTRLWIN_CHECK_ONLY=%~1"
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -Command "$ErrorActionPreference='Stop'; $taskParts=[IO.File]::ReadAllText($env:CTRLWIN_SELF) -split '(?m)^rem \[POWERSHELL\]\r?$',2; if($taskParts.Length -ne 2){throw 'PowerShell section is missing.'}; & ([scriptblock]::Create($taskParts[1]))"
set "taskResult=%errorlevel%"
if not "%taskResult%"=="0" echo ERROR: Operation did not complete. See the message above.
if not "%~1"=="--check" pause
exit /b %taskResult%
rem [POWERSHELL]
Import-Module (Join-Path $PSHOME 'Modules\Microsoft.PowerShell.Security\Microsoft.PowerShell.Security.psd1') -ErrorAction Stop
if($env:CTRLWIN_CHECK_ONLY -and $env:CTRLWIN_CHECK_ONLY -ne '--check') { throw 'Supported parameter: --check' }
if($env:CTRLWIN_CHECK_ONLY -eq '--check') {
 Write-Host 'Preview: Windows PowerShell 5.1, CurrentUser -> RemoteSigned'
 Get-ExecutionPolicy -List | Format-Table -AutoSize
 return
}
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force -ErrorAction Stop
if((Get-ExecutionPolicy -Scope CurrentUser) -ne 'RemoteSigned') { throw 'The user execution policy was not saved as expected.' }
Write-Host 'Saved: CurrentUser -> RemoteSigned'
Write-Host ('Effective policy: '+(Get-ExecutionPolicy))
Write-Host 'Group Policy takes precedence. See README.md for details.'
