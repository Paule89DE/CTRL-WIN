@echo off
setlocal EnableExtensions DisableDelayedExpansion
title IPv6 Privacy Extensions
if "%~1"=="--check" goto check
if not "%~1"=="" goto usage
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -Command "if(-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){exit 1}"
if errorlevel 1 goto admin
"%SystemRoot%\System32\netsh.exe" interface ipv6 set privacy state=enabled store=persistent
if errorlevel 1 goto failed
echo IPv6 Privacy Extensions set to enabled.
echo This option does not disable IPv6. See README.md for details.
pause
exit /b 0
:check
echo Preview: netsh interface ipv6 set privacy state=enabled store=persistent
"%SystemRoot%\System32\netsh.exe" interface ipv6 show privacy
exit /b %errorlevel%
:admin
echo This option requires administrator rights.
echo Right-click this file and choose Run as administrator.
pause
exit /b 1
:usage
echo Supported parameter: --check
pause
exit /b 1
:failed
echo ERROR: Could not change the IPv6 setting.
pause
exit /b 1
