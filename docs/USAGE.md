# Usage and categories

[Back to README](../README.md) | [Shortcut catalog](CATALOG.md) | [Optional tweaks](TWEAKS.md) | [Maintenance](MAINTENANCE.md)

## Download and installation

Download `CTRL-WIN-0.1.0-alpha.1.zip` from the [alpha release](https://github.com/Paule89DE/CTRL-WIN/releases/tag/v0.1.0-alpha.1) and extract the entire `CTRL-WIN` directory. GitHub's source ZIP and a Git clone also contain the collection. This is a folder-based collection, with no installer or background service.

Keep the numbered folders, `GodMode.lnk`, the setup launcher, and `scripts` together. The `docs` folder contains documentation and screenshots. `VERSION` identifies the package version and `CHANGELOG.md` describes the release. `.gitattributes` and `.gitignore` are repository metadata rather than Windows tools. A Git clone additionally contains `.git`; the helpers skip this Git database.

Run setup from the extracted local folder after you have reviewed the files. Do not launch shortcuts directly from the compressed ZIP: relative organization, helper discovery, and Explorer customization depend on the extracted folder tree.

## Quick start

1. Copy or extract the entire `CTRL-WIN` folder to a local drive.
2. Double-click **`unlock_links_and_update_icons.cmd`** with your normal user account.
3. Open a category and double-click a shortcut.

Setup unblocks marked `.lnk` and `desktop.ini` files, updates Windows icons, and sets **all collection folders to the Videos template and Extra large icons (256 pixels)**. It also updates open Explorer windows belonging to this collection. Run setup again after moving the collection or copying it to another PC.

Setup does not require administrator rights if you can edit the collection and save your own Explorer settings. Individual administrative tools may request elevation. The optional tweaks in category 11 run only when you explicitly open them.

Keep the three PowerShell helpers together in the hidden `scripts` folder. They locate the collection one level above their own directory, so there is no hard-coded installation path. To show `scripts`, enable **View > Show > Hidden items** in File Explorer.

## How to choose a category

### 01 Network

Use this folder to find adapters, network computers, shares, saved credentials, synchronization, and drive mapping. Network Connections opens adapter properties; Network and Sharing Center organizes classic network tasks. Shared Folders is the management console for local shares and connections. Remote access clients are in Windows Accessories, while modern Wi-Fi/VPN/proxy pages are in Settings.

### 02 Start Menu and Taskbar

Use this folder to inspect shortcut locations rather than search through AppData manually. Names beginning with Common refer to all users; names without that prefix usually refer to the current user. Startup and Common Startup contain shortcut files, while Startup Apps opens the Settings list. Windows 11 pins and WinX entries use additional shell rules; these folders are not a complete pin-management API.

### 03 User Folders

Use this folder for standard personal locations and their Public counterparts. Shell-based links ask Windows for the location instead of assuming it is under a particular profile path. This matters when Desktop or Documents has been redirected. Libraries are views over configured folders; Library Files in AppData contains their definitions.

### 04 AppData

Use this folder to locate application state, per-user installations, caches, crash reports, jump lists, fonts, themes, and shell integration files. Local is machine-specific app data, Roaming supports configured roaming profiles, and LocalLow serves lower-integrity contexts. Opening these locations does not clear a cache or repair an app. Packages contains per-user packaged-app data, while SystemApps in category 05 contains Windows system app packages.

### 05 Windows Folders

Use this folder for system directories and diagnostic files: driver packages, servicing logs, event-log files, crash dumps, update state, and installation caches. System32 contains native system binaries; SysWOW64 contains 32-bit binaries on 64-bit Windows. ProgramData is shared application data, whereas Program Files contains installed programs. These are navigation shortcuts; servicing tools manage Windows-owned caches and component stores.

### 06 Control Panel

Use this folder for classic configuration dialogs. The top level opens the Control Panel and printers view. CPL Applets directly launches familiar .cpl files such as Sound, Mouse Properties, Region, and Programs and Features. More Control Panel Items contains canonical named pages and specific tabs such as Recording and Communications. Direct applets and named pages can reach the same interface, and newer Windows builds can redirect older pages to Settings.

### 07 Administrative Tools

Use this folder for management consoles: services, scheduled tasks, devices, disks, certificates, event logs, firewall rules, and performance counters. Certificates targets the current user's store; Certificates - Local Computer targets the computer store. Microsoft Management Console starts an empty console for adding snap-ins. Pro and Enterprise groups consoles commonly absent from Home; availability can also vary in Education and with installed components.

### 08 System Properties

Use this folder for classic advanced dialogs: performance, environment variables, remote access, system protection, computer identity, accounts, ODBC, iSCSI, and Windows Features. ODBC Data Sources is the native-architecture administrator; ODBC Data Sources (32-bit) is the separate 32-bit administrator on 64-bit Windows. Remote configures hosting/assistance, whereas Remote Desktop Connection in category 12 connects to another host.

### 09 Diagnostics

Use this folder when investigating failures or resource usage. Task Manager and Resource Monitor show current activity; Reliability Monitor shows a failure/update timeline; Event Viewer is in Administrative Tools. System Information and DirectX Diagnostic Tool provide inventory and diagnostic details. Disk Cleanup, Optimize Drives, Recovery Drive, and Windows Memory Diagnostic open tools that require additional choices before performing cleanup, optimization, media creation, or a restart.

### 10 Settings

Use this folder for direct Windows Settings pages. System contains hardware, audio, display, storage, and power pages. Network and Internet contains adapters and network connection settings. Apps and Accounts contains app defaults, installed apps, startup apps, and account options. Personalization contains appearance, language, and input pages. Privacy and Accessibility contains app permissions and accessibility controls. Update and Security contains updates, activation, security, and recovery. Windows 11 Only groups newer pages. URI availability and displayed names depend on the installed version, edition, and hardware.

### 11 Windows Tweaks

Use this folder only when you want the specific changes explained in [TWEAKS.md](TWEAKS.md). It contains 12 Registry Editor files and 5 command scripts. Setup does not apply them. Each document entry identifies the effect, user/computer scope, rights, restart requirements, and reversal behavior. The CMD scripts support a read-only `--check` mode.

### 12 Windows Accessories

Use this folder for everyday Windows programs: Remote Desktop Connection, Calculator, Notepad, Paint, Snipping Tool, Character Map, On-Screen Keyboard, Magnifier, Narrator, Command Prompt, Windows PowerShell, and About Windows. Windows PowerShell is version 5.1, not PowerShell 7. Remote Desktop Connection is a client; Windows edition restrictions on hosting apply to the destination host.

### GodMode

The root shortcut opens All Tasks, the combined classic Control Panel task list. Its name is a familiar nickname rather than a special privilege level. It does not bypass Windows permissions.

## Names and compatibility

Names follow familiar English Windows labels wherever practical. Longer explanations and scope information appear in shortcut tooltips and in the [shortcut catalog](CATALOG.md). Windows itself continues to use the language installed on your PC.

Personal folders use Windows shell identifiers or environment variables rather than a fixed user name. Redirected folders, such as a Desktop stored in OneDrive, can therefore resolve to their current location. Public and common folders refer to shared locations.

Some targets depend on Windows version, edition, installed components, or hardware. The collection opens existing targets; it does not install missing components or create missing system folders. Policy consoles under **Pro and Enterprise** can also be available in Education, but may be absent in Home. The **Windows 11 Only** Settings folder contains pages that may not exist on Windows 10. SysWOW64 and Program Files (x86) are relevant to 64-bit Windows.

Paint and Snipping Tool use `cmd.exe /d /c start "" <app>.exe` with a minimized launcher. This resolves classic executables and Windows app execution aliases without embedding a Store package version or user-specific executable path. The corresponding app and its executable or alias must be installed and enabled. Other accessories open their Windows executables directly.

Start Menu and taskbar folders do not contain every aspect of the Windows 11 pinned layout. Copying an arbitrary shortcut into WinX does not necessarily add it to that menu. Administrative tools and Windows may redirect older Control Panel pages to Settings.

## Download markers and Windows prompts

Windows may attach a `Zone.Identifier` stream, also called Mark of the Web, to downloaded files or files extracted from an archive. The unblock helper removes this marker only from `.lnk` and `desktop.ini` files in the collection. It does not change their targets or global security policies, and does not unblock optional REG/CMD files.

The launcher and scripts may themselves need to be unblocked through **Properties > Unblock** after you inspect them. Setup uses `ExecutionPolicy Bypass` only for its own PowerShell processes; it does not save a permanent execution policy. Organizational policies and application control can still apply.

A warning about an unknown publisher, SmartScreen, or UAC has a separate cause. Network trust can also affect folder customization. If folder icons are ignored on an untrusted network path, use a local copy. See [Microsoft: folder icon changes](https://support.microsoft.com/en-au/servicing/os/windows/docs/2026/06/custom-folder-icons-or-localized-folder-names-might-not-appear-after-installing-the-june-2026-window) and [Unblock-File](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/unblock-file).

## Common tasks

| Task | Start here | Why |
| --- | --- | --- |
| Find an adapter's properties | 01 Network / Network Connections | Opens the classic adapter list directly |
| Find a startup shortcut | 02 Start Menu and Taskbar / Startup or Common Startup | Separates current-user and shared startup locations |
| Find per-user app settings | 04 AppData / AppData - Roaming or AppData - Local | Opens the app-data scope you need |
| Diagnose a recurring application crash | 09 Diagnostics / Reliability Monitor, then 07 Administrative Tools / Event Viewer | Combines an event timeline with detailed logs |
| Change PATH | 08 System Properties / Environment Variables | Opens the standard user/system variable editor |
| Connect to another PC | 12 Windows Accessories / Remote Desktop Connection | Starts the RDP client |
| Repair this collection's folder icons | Root / unlock_links_and_update_icons.cmd | Refreshes only the collection's customization and views |
| Review a tweak before applying it | docs / TWEAKS.md and CMD --check | Explains the change and displays supported read-only checks |
