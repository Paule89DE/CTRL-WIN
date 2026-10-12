@echo off
setlocal EnableExtensions DisableDelayedExpansion
title Rebuild Explorer Icon Cache
set "CTRLWIN_SELF=%~f0"
set "CTRLWIN_CHECK_ONLY=%~1"
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -Command "$ErrorActionPreference='Stop'; $taskParts=[IO.File]::ReadAllText($env:CTRLWIN_SELF) -split '(?m)^rem \[POWERSHELL\]\r?$',2; if($taskParts.Length -ne 2){throw 'PowerShell section is missing.'}; & ([scriptblock]::Create($taskParts[1]))"
set "taskResult=%errorlevel%"
if not "%taskResult%"=="0" echo ERROR: Operation did not complete. See the message above.
if not "%~1"=="--check" pause
exit /b %taskResult%
rem [POWERSHELL]
if($env:CTRLWIN_CHECK_ONLY -and $env:CTRLWIN_CHECK_ONLY -ne '--check') { throw 'Supported parameter: --check' }
$taskLocal=[Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
if([string]::IsNullOrWhiteSpace($taskLocal)) { throw 'LocalAppData is unavailable.' }
$taskLocal=[IO.Path]::GetFullPath($taskLocal).TrimEnd('\')
if(-not $taskLocal -or -not [IO.Directory]::Exists($taskLocal)) { throw 'LocalAppData is unavailable.' }
$taskCache=[IO.Path]::GetFullPath((Join-Path $taskLocal 'Microsoft\Windows\Explorer'))
if(-not $taskCache.StartsWith($taskLocal+'\',[StringComparison]::OrdinalIgnoreCase)) { throw 'The cache path is outside LocalAppData.' }
function Assert-CachePath([string]$Path) {
 $taskParent=Get-Item -LiteralPath $Path -Force
 while($taskParent) {
  if($taskParent.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw ('Do not follow junctions or symbolic links: '+$taskParent.FullName) }
  if($taskParent.FullName.TrimEnd('\') -eq $taskLocal) { return }
  $taskParent=if($taskParent -is [IO.DirectoryInfo]) { $taskParent.Parent } else { $taskParent.Directory }
 }
 throw 'The cache path is outside the expected LocalAppData folder.'
}
Assert-CachePath $taskLocal
$taskFiles=@()
if(Test-Path -LiteralPath $taskCache -PathType Container) {
 Assert-CachePath $taskCache
 $taskFiles+=@(Get-ChildItem -LiteralPath $taskCache -File -Force -Filter 'iconcache*.db')
}
$taskLegacy=Join-Path $taskLocal 'IconCache.db'
if(Test-Path -LiteralPath $taskLegacy -PathType Leaf) { $taskFiles+=Get-Item -LiteralPath $taskLegacy -Force }
foreach($taskFile in $taskFiles) { Assert-CachePath $taskFile.FullName }
$taskExplorer=[IO.Path]::GetFullPath((Join-Path $env:SystemRoot 'explorer.exe'))
$taskSession=(Get-Process -Id $PID).SessionId
function Get-OwnExplorer {
 @(Get-Process -Name explorer -ErrorAction SilentlyContinue | Where-Object { $_.SessionId -eq $taskSession -and $_.Path -eq $taskExplorer })
}
if($env:CTRLWIN_CHECK_ONLY -eq '--check') {
 Write-Host 'Preview: Only iconcache*.db and IconCache.db for the current user.'
 Write-Host ('Cache folder: '+$taskCache)
 Write-Host ('Files found: '+$taskFiles.Count+'; Explorer processes in this session: '+@(Get-OwnExplorer).Count)
 return
}
if($taskFiles.Count -eq 0) { Write-Host 'No icon cache files were found. Nothing to delete.'; return }
Write-Host 'Explorer will restart in this session. Open Explorer windows will close.'
$taskRestart=$false
$taskDeleted=0
try {
 foreach($taskProcess in @(Get-OwnExplorer)) {
  $taskRestart=$true
  Stop-Process -Id $taskProcess.Id -Force -ErrorAction Stop
  if(-not $taskProcess.WaitForExit(5000)) { throw 'Explorer did not exit in time.' }
 }
 foreach($taskFile in $taskFiles) {
  if(Test-Path -LiteralPath $taskFile.FullName -PathType Leaf) {
   Assert-CachePath $taskFile.FullName
   $taskDeleted++
  }
 }
} finally {
 if($taskRestart -and @(Get-OwnExplorer).Count -eq 0) { Start-Process -FilePath $taskExplorer -WindowStyle Hidden -ErrorAction Stop | Out-Null }
}
Write-Host ('Icon cache files deleted: '+$taskDeleted)
Write-Host 'Windows rebuilds the icon cache as needed.'
