#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
param()


$ErrorActionPreference = 'Stop'
if ((Split-Path -Leaf $PSScriptRoot) -ine 'scripts') {
    throw 'Keep this script in the scripts subfolder of the collection.'
}
$taskCollectionRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$taskFolders = New-Object 'System.Collections.Generic.Stack[string]'
$taskFolders.Push($taskCollectionRoot)
$taskChecked = 0
$taskMarked = 0
$taskUnblocked = 0
$taskFailed = 0

Write-Host 'Unblock CTRL-WIN shortcuts and folder settings'
Write-Host ('Folder: ' + $taskCollectionRoot)
Write-Host ''

while ($taskFolders.Count -gt 0) {
    $taskDirectory = $taskFolders.Pop()
    try {
        $taskItems = @(Get-ChildItem -LiteralPath $taskDirectory -Force)
    }
    catch {
        $taskFailed++
        Write-Warning ('Cannot read folder: ' + $taskDirectory + '. ' + $_.Exception.Message)
        continue
    }

    foreach ($taskItem in $taskItems) {
        if (($taskItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
            continue
        }
        if ($taskItem.PSIsContainer) {
            if ($taskItem.Name -ieq '.git') { continue }
            $taskFolders.Push($taskItem.FullName)
            continue
        }
        if ($taskItem.Extension -ine '.lnk' -and $taskItem.Name -ine 'desktop.ini') {
            continue
        }

        $taskChecked++
        $taskZone = Get-Item -LiteralPath $taskItem.FullName -Force -Stream Zone.Identifier -ErrorAction SilentlyContinue
        if ($null -eq $taskZone) {
            continue
        }
        $taskMarked++
        if ($PSCmdlet.ShouldProcess($taskItem.FullName, 'Remove Mark of the Web')) {
            try {
                Unblock-File -LiteralPath $taskItem.FullName -ErrorAction Stop
                $taskRemainingZone = Get-Item -LiteralPath $taskItem.FullName -Force -Stream Zone.Identifier -ErrorAction SilentlyContinue
                if ($null -ne $taskRemainingZone) {
                    throw 'The Mark of the Web is still present.'
                }
                $taskUnblocked++
            }
            catch {
                $taskFailed++
                Write-Warning ('Could not unblock: ' + $taskItem.FullName + '. ' + $_.Exception.Message)
            }
        }
    }
}

Write-Host ('LNK/desktop.ini files checked: ' + $taskChecked)
Write-Host ('Files with Mark of the Web: ' + $taskMarked)
Write-Host ('Successfully unblocked:   ' + $taskUnblocked)

if ($taskFailed -gt 0) {
    Write-Host ('Errors: ' + $taskFailed)
    exit 1
}
if ($WhatIfPreference) {
    Write-Host 'Preview complete. No files were changed.'
}
elseif ($taskMarked -eq 0) {
    Write-Host 'No Mark of the Web was found. Nothing to unblock.'
    Write-Host 'If the warning persists, these file markers are not its cause.'
}
else {
    Write-Host 'Done. Shortcuts and folder settings have been unblocked.'
}
