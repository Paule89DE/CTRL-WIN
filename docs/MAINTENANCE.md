# Setup, maintenance, and troubleshooting

[Back to README](../README.md) | [Usage](USAGE.md) | [Shortcut catalog](CATALOG.md) | [Optional tweaks](TWEAKS.md)

## What each setup file does

| File | Responsibility | Changes |
| --- | --- | --- |
| `unlock_links_and_update_icons.cmd` | Run the three helpers in order and report combined success/failure | Starts Windows PowerShell 5.1; `--no-pause` suppresses the final pause |
| `scripts/Unlock-shortcuts.ps1` | Remove download markers from collection shortcuts and folder metadata | Unblocks only `.lnk` and `desktop.ini` files |
| `scripts/Update-icons.ps1` | Select and validate native Windows icons, save folder metadata, and refresh Explorer | Changes shortcut icon fields, collection `desktop.ini` files, folder attributes, and folder modification times |
| `scripts/Set-Explorer-view.ps1` | Save the desired Explorer presentation for this user and folder tree | Saves the Videos template and 256-pixel icon view; updates matching open collection windows |

The launcher uses the built-in Windows PowerShell executable under `%SystemRoot%` rather than a separately installed PowerShell version. The icon and view helpers run in a single-threaded apartment for Windows Shell COM interfaces. The three helper names and the `scripts` directory name are part of launcher discovery; preserve them when reorganizing a copy.

Helpers skip junctions and symbolic links to keep operations inside the collection tree. They also skip `.git` so cloning the repository does not cause Explorer customization or download-marker processing inside Git's database. The icon helper customizes a defined list of collection and documentation folders. The view helper saves a view for ordinary folders under this collection root; it is not a global Explorer preference change.

## Icons and folder views

The **30 collection folders** use native Windows icons, English tooltips, and the **Videos** folder template. The template is saved as `FolderType=Videos` under `[ViewState]` in `desktop.ini` and in each folder's view storage. It does not turn the shortcuts into videos or change their targets.

`desktop.ini` uses UTF-16 with a BOM and the Hidden and System attributes. A folder's Read-only attribute enables its customization; it does not prevent editing the files inside it. Setup restores these attributes after copying or extraction.

The icon helper checks folder resources at 16, 32, 48, 96, and 256 pixels. It updates the folder modification time so Windows discards stale yellow folder thumbnails, then sends Explorer change notifications. It does not disable thumbnails globally, delete cache databases, or restart Explorer.

The view helper saves `FolderType`, `Mode`, `LogicalViewMode`, and `IconSize` for the current user and each collection folder. The **Extra large icons** setting is saved separately from the folder template. Other folders and global Explorer defaults are not changed. Junctions and symbolic links are skipped. Explorer can eventually discard older view-cache entries; run setup again if that happens.

Manual helper commands, run from the main collection folder:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\scripts\Unlock-shortcuts.ps1"
powershell.exe -NoProfile -STA -ExecutionPolicy Bypass -File ".\scripts\Update-icons.ps1"
powershell.exe -NoProfile -STA -ExecutionPolicy Bypass -File ".\scripts\Set-Explorer-view.ps1"
```

Each helper supports `-WhatIf` for a preview. `Update-icons.ps1 -FoldersOnly` repairs folder icons and templates without rewriting shortcut icons. Setup overwrites the supplied folder customizations with the collection definitions.

The release contains 30 customized collection folders, plus `docs` and `docs/screenshots`. The latter two also receive Videos templates and native folder icons. Windows icons are referenced from installed system resources rather than copied out as redistributed DLLs or icon packs. The supplied screenshot shows the collection on one Windows installation; resource artwork and availability can vary across Windows builds.

Git and archive extraction do not reliably preserve Windows Hidden, System, or folder Read-only attributes. Setup reapplies them. The `scripts` folder is hidden by setup, and `desktop.ini` is marked Hidden and System. A machine with hidden/protected files enabled will still display these items, as in the overview screenshot.

## Why both Videos and Extra large icons are set

The folder template tells Explorer which kind of presentation to associate with a folder. Icon size is a separate saved view setting. `FolderType=Videos` alone does not force 256-pixel icons. The view helper therefore saves both the folder type and the view properties. The collection remains a set of Windows shortcuts, scripts, and documentation; no video-processing behavior is added.

## Portable shortcut targets

Shortcut targets use Windows shell identifiers and/or environment variables so they can resolve on another user account or installation. For example, `%TEMP%` is the current user's temporary folder, and `shell:Personal` asks Windows for Documents rather than assuming a profile directory. The catalog presents environment-based target paths; a shortcut's Properties dialog may show the path expanded for the current machine.

Icon updates preserve the shortcut's target, arguments, working directory, show mode, hotkey, and non-icon payload. This is deliberate: saving an existing shortcut through a generic shortcut editor can expand environment-based targets into a machine-specific path. Paint and Snipping Tool use a minimized `cmd.exe` launcher to resolve installed executables or app execution aliases. A disabled alias or missing app can prevent launch.

## Troubleshooting

| Symptom | What to check / do |
| --- | --- |
| Main folders show yellow thumbnails or wrong artwork | Run setup from the local extracted collection; it invalidates each customized folder's stale presentation and sends targeted Shell notifications |
| Icons look small after extraction or moving the folder | Run setup at the new path so the current user's folder view storage receives Videos and IconSize=256 |
| Folder icon is ignored | Check that setup can write `desktop.ini` and folder attributes; on an untrusted network path, try a local copy |
| Scripts or launcher are blocked after download | Inspect the files, then use Properties > Unblock where available; the shortcut unblock helper does not unblock itself or optional tweaks |
| Shortcut opens a differently named Settings page | Windows can rename or redirect older pages; compare the launch URI in CATALOG.md with the installed version |
| A console is missing | Check Windows edition and installed components; Pro and Enterprise snap-ins can be absent in Home |
| Touchpad, Wi-Fi, TPM, or other hardware page is absent | Check hardware and driver availability; the collection does not add the hardware feature |
| Paint or Snipping Tool fails to launch | Verify the app is installed and its executable/app execution alias is enabled |
| Setup reports access denied | Use a local folder writable by your current account; inspect the reported file or policy rather than assuming every setup step needs elevation |
| User-configured icons are replaced | Setup reapplies the supplied folder/style definitions and shortcut icon selection; keep a copy of custom metadata before running it |
| A tweak seems ineffective | Check its scope, restart/sign-out requirement, Windows version, and overriding Group Policy; use its CMD --check mode where available |

The optional Rebuild Explorer Icon Cache command is a separate recovery tool. Unlike routine setup, it stops Explorer and removes this user's icon-cache databases. Its documented effects and preview mode are in [TWEAKS.md](TWEAKS.md).

## Release and validation

`VERSION` contains `0.1.0-alpha.1`; the corresponding Git tag is `v0.1.0-alpha.1`. Alpha means this is an early published collection with version-, edition-, and hardware-dependent targets. It does not imply every Windows tool or tweak has been exercised on every supported Windows installation.

Publication checks cover 262 readable shortcuts, complete purpose/target catalog entries, unchanged original launch parameters, optional REG operations, PowerShell parsing, CMD preview behavior, matching large folder icons, and Videos/256-pixel view storage. Administrative tools are inspected as shortcut targets rather than blindly executed. Optional registry/network/time changes are not applied as part of validation.

Before publishing a future update, inspect the actual staged diff, run setup on a Windows test copy, verify folder artwork through the normal Shell image path, preview the optional CMD files, and check all documentation links. Build a ZIP from the tagged tree so the package corresponds to the version being announced. Exclude `.git`, temporary validation output, personal backups, and authentication material from release packages.

## References

[Microsoft's desktop.ini documentation](https://learn.microsoft.com/en-us/windows/win32/shell/how-to-customize-folders-with-desktop-ini) explains the Unicode file, custom icon fields, infotips, and folder attributes. [Microsoft's Settings URI reference](https://learn.microsoft.com/en-us/windows/apps/develop/launch/launch-settings) describes page launch identifiers and version/edition restrictions. [Unblock-File](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/unblock-file) describes removal of file download markers.
