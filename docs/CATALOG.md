# Shortcut catalog

[Back to README](../README.md) | [Usage](USAGE.md) | [Optional tweaks](TWEAKS.md)

Every one of the 262 shortcuts is listed below with its purpose and launch target. Clicking a shortcut link on GitHub opens or downloads the file; it does not run the Windows tool in your browser. Extract the collection and launch the shortcut locally.

Targets use Windows environment variables or shell identifiers. The operating system resolves them for the current computer and user. A target can exist only on particular Windows editions or hardware. Opening a tool does not perform its subsequent configuration, cleanup, or recovery actions.

The two Network Connections entries reach the classic adapter interface through different Windows entry points. Repeated tools in different categories are intentional: a category provides a route for the task you are doing. CPL Applets contains direct .cpl entry points; More Control Panel Items uses named Control Panel pages or specific tabs. Windows may redirect older interfaces to Settings.

Settings URIs are documented by [Microsoft](https://learn.microsoft.com/en-us/windows/apps/develop/launch/launch-settings). Their availability varies by Windows version and edition.




### Main folder

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [GodMode](../GodMode.lnk) | Open All Tasks, a searchable collection of classic Control Panel actions in one Explorer window. | `%SystemRoot%\explorer.exe "shell:::{ED7BA470-8E54-465E-825C-99712043E01C}"` |

### 01 Network

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Advanced Sharing Settings](../01%20Network/Advanced%20Sharing%20Settings.lnk) | Configure network discovery, file and printer sharing, and sharing behavior for network profiles. | `%SystemRoot%\System32\control.exe /name Microsoft.NetworkAndSharingCenter /page Advanced` |
| [Credential Manager](../01%20Network/Credential%20Manager.lnk) | Review and manage stored Windows and web credentials; use this when saved network logins need updating. | `%SystemRoot%\System32\control.exe /name Microsoft.CredentialManager` |
| [Map Network Drive](../01%20Network/Map%20Network%20Drive.lnk) | Connect a shared network folder to a drive letter for convenient access in File Explorer. | `%SystemRoot%\System32\rundll32.exe shell32.dll,SHHelpShortcuts_RunDLL Connect` |
| [Network and Sharing Center](../01%20Network/Network%20and%20Sharing%20Center.lnk) | Inspect the active network and open classic adapter and sharing configuration. | `%SystemRoot%\System32\control.exe /name Microsoft.NetworkAndSharingCenter` |
| [Network Connections (Control Panel)](../01%20Network/Network%20Connections%20%28Control%20Panel%29.lnk) | Open the classic network adapter list through ncpa.cpl to manage adapters and their properties. | `%SystemRoot%\System32\ncpa.cpl` |
| [Network Connections](../01%20Network/Network%20Connections.lnk) | Open the network adapter list to inspect or configure Ethernet, Wi-Fi, VPN, and other connections. | `%SystemRoot%\explorer.exe "shell:ConnectionsFolder"` |
| [Network Shortcuts](../01%20Network/Network%20Shortcuts.lnk) | Browse the current user's saved network-location shortcuts. | `%SystemRoot%\explorer.exe "shell:NetHood"` |
| [Network](../01%20Network/Network.lnk) | Browse discoverable computers and devices; visible results depend on network discovery and firewall settings. | `%SystemRoot%\explorer.exe "shell:NetworkPlacesFolder"` |
| [Quick Access](../01%20Network/Quick%20Access.lnk) | Open Explorer's Quick Access location for pinned folders and recent activity; newer Windows versions may present Home instead. | `%SystemRoot%\explorer.exe "shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}"` |
| [Shared Folders](../01%20Network/Shared%20Folders.lnk) | Inspect shared folders, connected sessions, and open shared files in the management console. | `%SystemRoot%\System32\fsmgmt.msc` |
| [Sync Center](../01%20Network/Sync%20Center.lnk) | Manage synchronization partnerships and Offline Files where that feature is available. | `%SystemRoot%\System32\control.exe /name Microsoft.SyncCenter` |
| [This PC](../01%20Network/This%20PC.lnk) | Browse available drives and the computer's standard Explorer locations. | `%SystemRoot%\explorer.exe "shell:MyComputerFolder"` |

### 02 Start Menu and Taskbar

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Administrative Tools](../02%20Start%20Menu%20and%20Taskbar/Administrative%20Tools.lnk) | Browse the shared Windows Administrative Tools folder; newer Windows versions may call this Windows Tools. | `%SystemRoot%\explorer.exe "shell:Common Administrative Tools"` |
| [Applications](../02%20Start%20Menu%20and%20Taskbar/Applications.lnk) | Browse the Windows Applications shell folder, including registered desktop and packaged apps. | `%SystemRoot%\explorer.exe "shell:AppsFolder"` |
| [Common Programs](../02%20Start%20Menu%20and%20Taskbar/Common%20Programs.lnk) | Browse Start Menu program shortcuts shared by all users. | `%SystemRoot%\explorer.exe "shell:Common Programs"` |
| [Common Start Menu](../02%20Start%20Menu%20and%20Taskbar/Common%20Start%20Menu.lnk) | Browse the shared Start Menu folder used by all accounts on the computer. | `%SystemRoot%\explorer.exe "shell:Common Start Menu"` |
| [Common Startup](../02%20Start%20Menu%20and%20Taskbar/Common%20Startup.lnk) | Browse startup shortcuts executed for all users when they sign in; editing usually needs administrator rights. | `%SystemRoot%\explorer.exe "shell:Common Startup"` |
| [Implicit App Shortcuts](../02%20Start%20Menu%20and%20Taskbar/Implicit%20App%20Shortcuts.lnk) | Inspect app shortcuts maintained by Windows for application identity and shell integration. | `%SystemRoot%\explorer.exe "shell:ImplicitAppShortcuts"` |
| [Pinned Start Menu](../02%20Start%20Menu%20and%20Taskbar/Pinned%20Start%20Menu.lnk) | Browse the legacy pinned Start Menu shortcut location; this does not represent the complete Windows 11 pinned layout. | `%USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu` |
| [Pinned Taskbar](../02%20Start%20Menu%20and%20Taskbar/Pinned%20Taskbar.lnk) | Browse shortcut files used by taskbar pinning; copying files here does not necessarily create or remove a pin. | `%USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar` |
| [Programs](../02%20Start%20Menu%20and%20Taskbar/Programs.lnk) | Browse the current user's Start Menu program shortcuts. | `%SystemRoot%\explorer.exe "shell:Programs"` |
| [Quick Launch](../02%20Start%20Menu%20and%20Taskbar/Quick%20Launch.lnk) | Browse the legacy Quick Launch shortcut folder, also used by some pinned-shortcut storage. | `%SystemRoot%\explorer.exe "shell:Quick Launch"` |
| [Start Menu Settings](../02%20Start%20Menu%20and%20Taskbar/Start%20Menu%20Settings.lnk) | Configure the Start Menu's available layout and content options in Settings. | `%SystemRoot%\explorer.exe ms-settings:personalization-start` |
| [Start Menu](../02%20Start%20Menu%20and%20Taskbar/Start%20Menu.lnk) | Browse the current user's Start Menu shortcut folder. | `%SystemRoot%\explorer.exe "shell:Start Menu"` |
| [StartMenuExperienceHost](../02%20Start%20Menu%20and%20Taskbar/StartMenuExperienceHost.lnk) | Inspect the packaged Start Menu host's LocalState folder when diagnosing Start Menu problems; the folder may be absent on some versions. | `%USERPROFILE%\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState` |
| [Startup Apps](../02%20Start%20Menu%20and%20Taskbar/Startup%20Apps.lnk) | Review and enable or disable registered startup applications in Settings. | `%SystemRoot%\explorer.exe ms-settings:startupapps` |
| [Startup](../02%20Start%20Menu%20and%20Taskbar/Startup.lnk) | Browse startup shortcuts executed when the current user signs in. | `%SystemRoot%\explorer.exe "shell:Startup"` |
| [Taskbar Settings](../02%20Start%20Menu%20and%20Taskbar/Taskbar%20Settings.lnk) | Configure taskbar behavior and the options supported by the installed Windows version. | `%SystemRoot%\explorer.exe ms-settings:taskbar` |
| [User Pinned](../02%20Start%20Menu%20and%20Taskbar/User%20Pinned.lnk) | Browse the parent folder for Windows' pinned shortcut files, including legacy Start Menu and taskbar locations. | `%SystemRoot%\explorer.exe "shell:User Pinned"` |
| [WinX](../02%20Start%20Menu%20and%20Taskbar/WinX.lnk) | Inspect shortcut groups for the Windows+X menu; Windows validates these shortcuts, so ordinary copies may not appear in the menu. | `%USERPROFILE%\AppData\Local\Microsoft\Windows\WinX` |

### 03 User Folders

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Desktop](../03%20User%20Folders/Desktop.lnk) | Browse the current user's Desktop shell location, including supported folder redirection. | `%SystemRoot%\explorer.exe "shell:Desktop"` |
| [Documents](../03%20User%20Folders/Documents.lnk) | Browse the current user's Documents shell location. | `%SystemRoot%\explorer.exe "shell:Personal"` |
| [Downloads](../03%20User%20Folders/Downloads.lnk) | Browse the current user's Downloads shell location. | `%SystemRoot%\explorer.exe "shell:Downloads"` |
| [Favorites](../03%20User%20Folders/Favorites.lnk) | Browse the legacy Favorites folder used by older applications and shell integrations. | `%SystemRoot%\explorer.exe "shell:Favorites"` |
| [Libraries](../03%20User%20Folders/Libraries.lnk) | Open Explorer's Libraries view, which combines configured folders without moving their contents. | `%SystemRoot%\explorer.exe "shell:Libraries"` |
| [Music](../03%20User%20Folders/Music.lnk) | Browse the current user's Music shell location. | `%SystemRoot%\explorer.exe "shell:My Music"` |
| [Pictures](../03%20User%20Folders/Pictures.lnk) | Browse the current user's Pictures shell location. | `%SystemRoot%\explorer.exe "shell:My Pictures"` |
| [Public Desktop](../03%20User%20Folders/Public%20Desktop.lnk) | Browse Desktop shortcuts shared by all users of the computer. | `%SystemRoot%\explorer.exe "shell:Common Desktop"` |
| [Public Documents](../03%20User%20Folders/Public%20Documents.lnk) | Browse the shared Public Documents location. | `%SystemRoot%\explorer.exe "shell:Common Documents"` |
| [Public Music](../03%20User%20Folders/Public%20Music.lnk) | Browse the shared Public Music location. | `%SystemRoot%\explorer.exe "shell:CommonMusic"` |
| [Public Pictures](../03%20User%20Folders/Public%20Pictures.lnk) | Browse the shared Public Pictures location. | `%SystemRoot%\explorer.exe "shell:CommonPictures"` |
| [Public User Folder](../03%20User%20Folders/Public%20User%20Folder.lnk) | Browse the Public profile root and its shared folders. | `%SystemRoot%\explorer.exe "shell:Public"` |
| [Public Videos](../03%20User%20Folders/Public%20Videos.lnk) | Browse the shared Public Videos location. | `%SystemRoot%\explorer.exe "shell:CommonVideo"` |
| [Saved Games](../03%20User%20Folders/Saved%20Games.lnk) | Browse the current user's standard Saved Games location; individual games may use other folders. | `%SystemRoot%\explorer.exe "shell:SavedGames"` |
| [Saved Searches](../03%20User%20Folders/Saved%20Searches.lnk) | Browse saved Windows Search definitions in the current user's profile. | `%SystemRoot%\explorer.exe "shell:Searches"` |
| [User Links](../03%20User%20Folders/User%20Links.lnk) | Browse the current user's Links shortcut folder, used by legacy Explorer favorites. | `%SystemRoot%\explorer.exe "shell:Links"` |
| [User Profile](../03%20User%20Folders/User%20Profile.lnk) | Browse the current user's profile root. | `%SystemRoot%\explorer.exe "shell:Profile"` |
| [Videos](../03%20User%20Folders/Videos.lnk) | Browse the current user's Videos shell location. | `%SystemRoot%\explorer.exe "shell:My Video"` |

### 04 AppData

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [AppData - Local](../04%20AppData/AppData%20-%20Local.lnk) | Browse machine-specific per-user application data and caches. | `%SystemRoot%\explorer.exe "shell:Local AppData"` |
| [AppData - LocalLow](../04%20AppData/AppData%20-%20LocalLow.lnk) | Browse per-user application data associated with lower-integrity application contexts. | `%SystemRoot%\explorer.exe "shell:LocalAppDataLow"` |
| [AppData - Roaming](../04%20AppData/AppData%20-%20Roaming.lnk) | Browse per-user application settings intended to support roaming profiles where configured. | `%SystemRoot%\explorer.exe "shell:AppData"` |
| [AppData](../04%20AppData/AppData.lnk) | Browse the AppData parent folder containing Local, LocalLow, and Roaming data. | `%USERPROFILE%\AppData` |
| [Application Shortcuts](../04%20AppData/Application%20Shortcuts.lnk) | Inspect application shortcut metadata stored in the current user's Local AppData. | `%USERPROFILE%\AppData\Local\Microsoft\Windows\Application Shortcuts` |
| [Automatic Jump Lists](../04%20AppData/Automatic%20Jump%20Lists.lnk) | Inspect files Windows maintains for applications' automatic recent-item Jump Lists. | `%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations` |
| [Crash Dumps](../04%20AppData/Crash%20Dumps.lnk) | Browse user-process crash dumps when Windows Error Reporting has created them. | `%USERPROFILE%\AppData\Local\CrashDumps` |
| [Custom Jump Lists](../04%20AppData/Custom%20Jump%20Lists.lnk) | Inspect application-defined Jump List files in the current user's profile. | `%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Recent\CustomDestinations` |
| [Document Templates](../04%20AppData/Document%20Templates.lnk) | Browse document templates registered for the current user. | `%SystemRoot%\explorer.exe "shell:Templates"` |
| [Error Reports](../04%20AppData/Error%20Reports.lnk) | Browse per-user Windows Error Reporting data for application failures. | `%USERPROFILE%\AppData\Local\Microsoft\Windows\WER` |
| [Icon and Thumbnail Cache](../04%20AppData/Icon%20and%20Thumbnail%20Cache.lnk) | Inspect Explorer's per-user icon and thumbnail cache files; opening the folder does not rebuild or delete them. | `%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer` |
| [INetCache](../04%20AppData/INetCache.lnk) | Browse the legacy per-user Internet cache used by Windows components and compatible applications. | `%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache` |
| [Library Files](../04%20AppData/Library%20Files.lnk) | Inspect .library-ms definitions that describe Explorer Libraries. | `%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Libraries` |
| [Packages](../04%20AppData/Packages.lnk) | Browse per-user data folders for packaged Windows apps; this is app data rather than the shared installation directory. | `%USERPROFILE%\AppData\Local\Packages` |
| [Printer Shortcuts](../04%20AppData/Printer%20Shortcuts.lnk) | Browse the user's printer-related shell shortcuts. | `%SystemRoot%\explorer.exe "shell:PrintHood"` |
| [Recent](../04%20AppData/Recent.lnk) | Browse shortcuts to recently used items maintained by Windows. | `%SystemRoot%\explorer.exe "shell:Recent"` |
| [SendTo](../04%20AppData/SendTo.lnk) | Browse the shortcut folder behind the classic Send to context menu. | `%SystemRoot%\explorer.exe "shell:SendTo"` |
| [Temporary Files](../04%20AppData/Temporary%20Files.lnk) | Browse the directory resolved from the current user's TEMP environment variable. | `%TEMP%` |
| [User Account Pictures](../04%20AppData/User%20Account%20Pictures.lnk) | Browse account-picture files associated with the current user. | `%SystemRoot%\explorer.exe "shell:AccountPictures"` |
| [User Fonts](../04%20AppData/User%20Fonts.lnk) | Browse font files installed only for the current user. | `%USERPROFILE%\AppData\Local\Microsoft\Windows\Fonts` |
| [User Programs](../04%20AppData/User%20Programs.lnk) | Browse programs installed in the per-user Local Programs directory. | `%USERPROFILE%\AppData\Local\Programs` |
| [Windows Themes](../04%20AppData/Windows%20Themes.lnk) | Browse theme data stored in the current user's Local AppData. | `%USERPROFILE%\AppData\Local\Microsoft\Windows\Themes` |

### 05 Windows Folders

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [CBS Logs](../05%20Windows%20Folders/CBS%20Logs.lnk) | Inspect Component-Based Servicing logs used when diagnosing Windows servicing or component repair. | `%SystemRoot%\Logs\CBS` |
| [Common Program Files](../05%20Windows%20Folders/Common%20Program%20Files.lnk) | Browse shared application components in the Common Program Files directory. | `%CommonProgramFiles%` |
| [DISM Logs](../05%20Windows%20Folders/DISM%20Logs.lnk) | Inspect Deployment Image Servicing and Management logs after image servicing or repair operations. | `%SystemRoot%\Logs\DISM` |
| [Document Templates - All Users](../05%20Windows%20Folders/Document%20Templates%20-%20All%20Users.lnk) | Browse document templates shared by all users. | `%SystemRoot%\explorer.exe "shell:Common Templates"` |
| [Drivers](../05%20Windows%20Folders/Drivers.lnk) | Browse driver binaries and related files in System32\drivers; driver installation is managed by Windows. | `%SystemRoot%\System32\drivers` |
| [DriverStore](../05%20Windows%20Folders/DriverStore.lnk) | Inspect staged driver packages in DriverStore\FileRepository; use supported driver tools for changes. | `%SystemRoot%\System32\DriverStore\FileRepository` |
| [Event Logs](../05%20Windows%20Folders/Event%20Logs.lnk) | Browse Windows event-log files; Event Viewer provides a structured way to read them. | `%SystemRoot%\System32\winevt\Logs` |
| [Hosts and Network Files](../05%20Windows%20Folders/Hosts%20and%20Network%20Files.lnk) | Browse hosts and other legacy network configuration files in drivers\etc. | `%SystemRoot%\System32\drivers\etc` |
| [INF](../05%20Windows%20Folders/INF.lnk) | Inspect driver installation-information files stored by Windows. | `%SystemRoot%\INF` |
| [Installed Fonts](../05%20Windows%20Folders/Installed%20Fonts.lnk) | Open the Windows Fonts shell view for installed fonts. | `%SystemRoot%\explorer.exe "shell:Fonts"` |
| [Installer](../05%20Windows%20Folders/Installer.lnk) | Inspect the Windows Installer package cache used for maintenance, repair, and uninstall operations. | `%SystemRoot%\Installer` |
| [Logs](../05%20Windows%20Folders/Logs.lnk) | Browse the Windows log directory and its component-specific subfolders. | `%SystemRoot%\Logs` |
| [Minidump](../05%20Windows%20Folders/Minidump.lnk) | Browse small kernel crash dumps generated after system crashes when configured. | `%SystemRoot%\Minidump` |
| [Program Files (x86)](../05%20Windows%20Folders/Program%20Files%20%28x86%29.lnk) | Browse the default 32-bit application installation directory on 64-bit Windows. | `%ProgramFiles(x86)%` |
| [Program Files](../05%20Windows%20Folders/Program%20Files.lnk) | Browse the default native application installation directory. | `%ProgramFiles%` |
| [ProgramData](../05%20Windows%20Folders/ProgramData.lnk) | Browse application data shared across users, often hidden in Explorer's normal view. | `%ProgramData%` |
| [Recycle Bin](../05%20Windows%20Folders/Recycle%20Bin.lnk) | Open the Recycle Bin to inspect, restore, or permanently remove recycled items. | `%SystemRoot%\explorer.exe "shell:RecycleBinFolder"` |
| [Resources](../05%20Windows%20Folders/Resources.lnk) | Browse theme resources supplied with Windows. | `%SystemRoot%\Resources\Themes` |
| [Security](../05%20Windows%20Folders/Security.lnk) | Inspect Windows security configuration files and databases; some contents require elevated access. | `%SystemRoot%\Security` |
| [SoftwareDistribution](../05%20Windows%20Folders/SoftwareDistribution.lnk) | Inspect the Windows Update download and state directory; opening it does not reset Windows Update. | `%SystemRoot%\SoftwareDistribution` |
| [Spool](../05%20Windows%20Folders/Spool.lnk) | Browse print-spooler files, drivers, and spool directories. | `%SystemRoot%\System32\spool` |
| [System32](../05%20Windows%20Folders/System32.lnk) | Browse native Windows system executables and libraries; on 64-bit Windows this is the native 64-bit directory. | `%SystemRoot%\System32` |
| [SystemApps](../05%20Windows%20Folders/SystemApps.lnk) | Browse system app packages supplied as part of Windows. | `%SystemRoot%\SystemApps` |
| [System-Wide Error Reports](../05%20Windows%20Folders/System-Wide%20Error%20Reports.lnk) | Browse computer-wide Windows Error Reporting data in ProgramData. | `%ProgramData%\Microsoft\Windows\WER` |
| [SysWOW64](../05%20Windows%20Folders/SysWOW64.lnk) | Browse 32-bit Windows system executables and libraries on 64-bit Windows. | `%SystemRoot%\SysWOW64` |
| [Tasks](../05%20Windows%20Folders/Tasks.lnk) | Inspect task-definition files maintained by Task Scheduler; use Task Scheduler to manage tasks. | `%SystemRoot%\System32\Tasks` |
| [Temp](../05%20Windows%20Folders/Temp.lnk) | Browse the Windows system temporary directory, distinct from the current user's TEMP location. | `%SystemRoot%\Temp` |
| [Windows](../05%20Windows%20Folders/Windows.lnk) | Browse the Windows installation directory resolved for the current computer. | `%SystemRoot%` |
| [WinSxS](../05%20Windows%20Folders/WinSxS.lnk) | Inspect the Windows component store used for servicing and optional features; cleanup belongs in supported servicing tools. | `%SystemRoot%\WinSxS` |

### 06 Control Panel

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [All Control Panel Items](../06%20Control%20Panel/All%20Control%20Panel%20Items.lnk) | Open the classic Control Panel shell view listing available items. | `%SystemRoot%\explorer.exe "shell:ControlPanelFolder"` |
| [Control Panel](../06%20Control%20Panel/Control%20Panel.lnk) | Open the main classic Control Panel interface. | `%SystemRoot%\System32\control.exe` |
| [Printers](../06%20Control%20Panel/Printers.lnk) | Open the classic printers shell view to inspect installed printers and their queues. | `%SystemRoot%\explorer.exe "shell:PrintersFolder"` |

### 06 Control Panel / CPL Applets

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Bluetooth](../06%20Control%20Panel/CPL%20Applets/Bluetooth.lnk) | Open the classic Bluetooth applet where available; Windows may redirect it to modern device settings. | `%SystemRoot%\System32\bthprops.cpl` |
| [Date and Time](../06%20Control%20Panel/CPL%20Applets/Date%20and%20Time.lnk) | Set the clock, time zone, and related date/time options through the applicable Windows dialog. | `%SystemRoot%\System32\timedate.cpl` |
| [Device Manager](../06%20Control%20Panel/CPL%20Applets/Device%20Manager.lnk) | Inspect hardware devices, driver status, and device properties. | `%SystemRoot%\System32\hdwwiz.cpl` |
| [Display](../06%20Control%20Panel/CPL%20Applets/Display.lnk) | Open display configuration; older Control Panel entry points can redirect to modern Settings. | `%SystemRoot%\System32\desk.cpl` |
| [Game Controllers](../06%20Control%20Panel/CPL%20Applets/Game%20Controllers.lnk) | Inspect and calibrate supported game controllers through the classic controller dialog. | `%SystemRoot%\System32\joy.cpl` |
| [Internet Properties](../06%20Control%20Panel/CPL%20Applets/Internet%20Properties.lnk) | Configure legacy Internet Options used by Windows components and applications that still honor them. | `%SystemRoot%\System32\inetcpl.cpl` |
| [Mouse Properties](../06%20Control%20Panel/CPL%20Applets/Mouse%20Properties.lnk) | Configure mouse buttons, pointers, wheel behavior, and related classic options. | `%SystemRoot%\System32\main.cpl` |
| [Network Connections](../06%20Control%20Panel/CPL%20Applets/Network%20Connections.lnk) | Open the network adapter list to inspect or configure Ethernet, Wi-Fi, VPN, and other connections. | `%SystemRoot%\System32\ncpa.cpl` |
| [Phone and Modem](../06%20Control%20Panel/CPL%20Applets/Phone%20and%20Modem.lnk) | Manage legacy dialing locations and modem configuration where supported. | `%SystemRoot%\System32\telephon.cpl` |
| [Power Options](../06%20Control%20Panel/CPL%20Applets/Power%20Options.lnk) | Configure classic power plans and supported advanced power settings. | `%SystemRoot%\System32\powercfg.cpl` |
| [Programs and Features](../06%20Control%20Panel/CPL%20Applets/Programs%20and%20Features.lnk) | Manage installed desktop programs and their uninstall or repair operations. | `%SystemRoot%\System32\appwiz.cpl` |
| [Region](../06%20Control%20Panel/CPL%20Applets/Region.lnk) | Configure regional formats and administrative locale options in the classic Region dialog. | `%SystemRoot%\System32\intl.cpl` |
| [Security and Maintenance](../06%20Control%20Panel/CPL%20Applets/Security%20and%20Maintenance.lnk) | Review classic Windows security and maintenance messages. | `%SystemRoot%\System32\wscui.cpl` |
| [Sound](../06%20Control%20Panel/CPL%20Applets/Sound.lnk) | Manage audio devices and sound options through the applicable sound interface. | `%SystemRoot%\System32\mmsys.cpl` |
| [System Properties](../06%20Control%20Panel/CPL%20Applets/System%20Properties.lnk) | Open the classic System Properties dialog for computer identity, hardware, advanced settings, protection, and remote options. | `%SystemRoot%\System32\sysdm.cpl` |
| [Tablet PC and Pen Input](../06%20Control%20Panel/CPL%20Applets/Tablet%20PC%20and%20Pen%20Input.lnk) | Open the legacy tablet/pen applet where installed and supported by the device. | `%SystemRoot%\System32\TabletPC.cpl` |
| [Windows Firewall](../06%20Control%20Panel/CPL%20Applets/Windows%20Firewall.lnk) | Review the classic Windows Defender Firewall interface and basic allowed-app settings. | `%SystemRoot%\System32\Firewall.cpl` |

### 06 Control Panel / More Control Panel Items

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [AutoPlay](../06%20Control%20Panel/More%20Control%20Panel%20Items/AutoPlay.lnk) | Choose actions for removable media and devices in the classic AutoPlay interface. | `%SystemRoot%\System32\control.exe /name Microsoft.AutoPlay` |
| [Color Management](../06%20Control%20Panel/More%20Control%20Panel%20Items/Color%20Management.lnk) | Manage device color profiles and color-management options. | `%SystemRoot%\System32\control.exe /name Microsoft.ColorManagement` |
| [Communications](../06%20Control%20Panel/More%20Control%20Panel%20Items/Communications.lnk) | Choose how Windows adjusts other sounds when it detects communication activity. | `%SystemRoot%\System32\control.exe mmsys.cpl,,3` |
| [Credential Manager](../06%20Control%20Panel/More%20Control%20Panel%20Items/Credential%20Manager.lnk) | Review and manage stored Windows and web credentials; use this when saved network logins need updating. | `%SystemRoot%\System32\control.exe /name Microsoft.CredentialManager` |
| [Ease of Access Center](../06%20Control%20Panel/More%20Control%20Panel%20Items/Ease%20of%20Access%20Center.lnk) | Open classic accessibility settings and links to built-in accessibility tools. | `%SystemRoot%\System32\control.exe /name Microsoft.EaseOfAccessCenter` |
| [File Explorer Options](../06%20Control%20Panel/More%20Control%20Panel%20Items/File%20Explorer%20Options.lnk) | Configure Explorer's general behavior, folder view options, and search settings. | `%SystemRoot%\System32\control.exe /name Microsoft.FolderOptions` |
| [File History](../06%20Control%20Panel/More%20Control%20Panel%20Items/File%20History.lnk) | Configure or review the File History backup feature where available. | `%SystemRoot%\System32\control.exe /name Microsoft.FileHistory` |
| [Indexing Options](../06%20Control%20Panel/More%20Control%20Panel%20Items/Indexing%20Options.lnk) | Inspect indexed locations and configure Windows Search indexing. | `%SystemRoot%\System32\control.exe /name Microsoft.IndexingOptions` |
| [Keyboard Properties](../06%20Control%20Panel/More%20Control%20Panel%20Items/Keyboard%20Properties.lnk) | Configure classic keyboard repeat delay, repeat rate, and cursor blink options. | `%SystemRoot%\System32\control.exe /name Microsoft.Keyboard` |
| [Recording](../06%20Control%20Panel/More%20Control%20Panel%20Items/Recording.lnk) | Open the Recording tab of the classic Sound dialog to manage audio input devices. | `%SystemRoot%\System32\control.exe mmsys.cpl,,1` |
| [Recovery](../06%20Control%20Panel/More%20Control%20Panel%20Items/Recovery.lnk) | Open classic recovery options, including access to System Restore and recovery-drive tools. | `%SystemRoot%\System32\control.exe /name Microsoft.Recovery` |
| [RemoteApp and Desktop Connections](../06%20Control%20Panel/More%20Control%20Panel%20Items/RemoteApp%20and%20Desktop%20Connections.lnk) | Configure subscriptions to published RemoteApp and desktop resources. | `%SystemRoot%\System32\control.exe /name Microsoft.RemoteAppAndDesktopConnections` |
| [Sounds](../06%20Control%20Panel/More%20Control%20Panel%20Items/Sounds.lnk) | Open the Sounds tab of the classic Sound dialog to choose system sound schemes. | `%SystemRoot%\System32\control.exe mmsys.cpl,,2` |
| [Storage Spaces](../06%20Control%20Panel/More%20Control%20Panel%20Items/Storage%20Spaces.lnk) | Manage storage pools and virtual disks through the available Storage Spaces interface. | `%SystemRoot%\System32\control.exe /name Microsoft.StorageSpaces` |
| [User Accounts](../06%20Control%20Panel/More%20Control%20Panel%20Items/User%20Accounts.lnk) | Open the classic Control Panel account page for account type, credentials, and related settings. | `%SystemRoot%\System32\control.exe /name Microsoft.UserAccounts` |

### 07 Administrative Tools

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Certificates - Local Computer](../07%20Administrative%20Tools/Certificates%20-%20Local%20Computer.lnk) | Manage certificate stores for the local computer, including trusted roots and computer certificates. | `%SystemRoot%\System32\certlm.msc` |
| [Certificates](../07%20Administrative%20Tools/Certificates.lnk) | Manage certificate stores for the current user, including personal certificates and trusted roots. | `%SystemRoot%\System32\certmgr.msc` |
| [Component Services](../07%20Administrative%20Tools/Component%20Services.lnk) | Inspect COM+, DCOM, and related component-service administration settings. | `%SystemRoot%\System32\comexp.msc` |
| [Computer Management](../07%20Administrative%20Tools/Computer%20Management.lnk) | Open a combined management console for system tools, storage, services, and other available snap-ins. | `%SystemRoot%\System32\compmgmt.msc` |
| [Device Manager](../07%20Administrative%20Tools/Device%20Manager.lnk) | Inspect hardware devices, driver status, and device properties. | `%SystemRoot%\System32\devmgmt.msc` |
| [Disk Management](../07%20Administrative%20Tools/Disk%20Management.lnk) | Inspect disks, partitions, and volumes and perform supported storage-management operations. | `%SystemRoot%\System32\diskmgmt.msc` |
| [Event Viewer](../07%20Administrative%20Tools/Event%20Viewer.lnk) | Read and filter application, system, security, and component event logs. | `%SystemRoot%\System32\eventvwr.msc` |
| [Firewall with Advanced Security](../07%20Administrative%20Tools/Firewall%20with%20Advanced%20Security.lnk) | Inspect or configure inbound, outbound, and connection-security rules and firewall profiles. | `%SystemRoot%\System32\WF.msc` |
| [Microsoft Management Console](../07%20Administrative%20Tools/Microsoft%20Management%20Console.lnk) | Open an empty MMC console to add installed management snap-ins. | `%SystemRoot%\System32\mmc.exe` |
| [Performance Monitor](../07%20Administrative%20Tools/Performance%20Monitor.lnk) | Monitor Windows performance counters and work with data collector sets. | `%SystemRoot%\System32\perfmon.msc` |
| [Services](../07%20Administrative%20Tools/Services.lnk) | Inspect Windows services, their startup types, dependencies, and current running state. | `%SystemRoot%\System32\services.msc` |
| [Shared Folders](../07%20Administrative%20Tools/Shared%20Folders.lnk) | Inspect shared folders, connected sessions, and open shared files in the management console. | `%SystemRoot%\System32\fsmgmt.msc` |
| [Task Scheduler](../07%20Administrative%20Tools/Task%20Scheduler.lnk) | Review triggers, actions, schedules, and execution history for scheduled tasks. | `%SystemRoot%\System32\taskschd.msc` |
| [TPM Management](../07%20Administrative%20Tools/TPM%20Management.lnk) | Inspect Trusted Platform Module status and available management actions on supported hardware. | `%SystemRoot%\System32\tpm.msc` |
| [WMI Control](../07%20Administrative%20Tools/WMI%20Control.lnk) | Inspect Windows Management Instrumentation configuration and namespace-security settings. | `%SystemRoot%\System32\WmiMgmt.msc` |

### 07 Administrative Tools / Pro and Enterprise

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Authorization Manager](../07%20Administrative%20Tools/Pro%20and%20Enterprise/Authorization%20Manager.lnk) | Manage legacy application authorization policy stores where the snap-in is installed. | `%SystemRoot%\System32\azman.msc` |
| [Local Group Policy](../07%20Administrative%20Tools/Pro%20and%20Enterprise/Local%20Group%20Policy.lnk) | Edit local computer and user policy settings on editions that include the Group Policy Editor. | `%SystemRoot%\System32\gpedit.msc` |
| [Local Security Policy](../07%20Administrative%20Tools/Pro%20and%20Enterprise/Local%20Security%20Policy.lnk) | Inspect and configure local security policies on supported Windows editions. | `%SystemRoot%\System32\secpol.msc` |
| [Local Users and Groups](../07%20Administrative%20Tools/Pro%20and%20Enterprise/Local%20Users%20and%20Groups.lnk) | Manage local accounts and group membership through the MMC snap-in on supported editions. | `%SystemRoot%\System32\lusrmgr.msc` |
| [Print Management](../07%20Administrative%20Tools/Pro%20and%20Enterprise/Print%20Management.lnk) | Manage printers, queues, drivers, and print servers where the snap-in is installed. | `%SystemRoot%\System32\printmanagement.msc` |
| [Resultant Set of Policy](../07%20Administrative%20Tools/Pro%20and%20Enterprise/Resultant%20Set%20of%20Policy.lnk) | Inspect the resulting applied Group Policy settings and diagnose policy conflicts. | `%SystemRoot%\System32\rsop.msc` |

### 08 System Properties

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Advanced System Properties](../08%20System%20Properties/Advanced%20System%20Properties.lnk) | Open the Advanced System Properties tab for performance, user profiles, and startup/recovery options. | `%SystemRoot%\System32\SystemPropertiesAdvanced.exe` |
| [Computer Name](../08%20System%20Properties/Computer%20Name.lnk) | Review or change the computer name and domain/workgroup membership through System Properties. | `%SystemRoot%\System32\SystemPropertiesComputerName.exe` |
| [Environment Variables](../08%20System%20Properties/Environment%20Variables.lnk) | Inspect and edit user or system environment variables, including PATH. | `%SystemRoot%\System32\rundll32.exe sysdm.cpl,EditEnvironmentVariables` |
| [Hardware](../08%20System%20Properties/Hardware.lnk) | Open the Hardware tab of System Properties for Device Manager and device-installation settings. | `%SystemRoot%\System32\SystemPropertiesHardware.exe` |
| [iSCSI Initiator](../08%20System%20Properties/iSCSI%20Initiator.lnk) | Configure connections to iSCSI storage targets through the Windows initiator. | `%SystemRoot%\System32\iscsicpl.exe` |
| [ODBC Data Sources (32-bit)](../08%20System%20Properties/ODBC%20Data%20Sources%20%2832-bit%29.lnk) | Manage ODBC drivers and data-source definitions for 32-bit applications on 64-bit Windows. | `%SystemRoot%\SysWOW64\odbcad32.exe` |
| [ODBC Data Sources](../08%20System%20Properties/ODBC%20Data%20Sources.lnk) | Manage ODBC drivers and data-source definitions for native-architecture applications. | `%SystemRoot%\System32\odbcad32.exe` |
| [Performance Options](../08%20System%20Properties/Performance%20Options.lnk) | Configure visual effects, processor scheduling, and virtual-memory options. | `%SystemRoot%\System32\SystemPropertiesPerformance.exe` |
| [Remote](../08%20System%20Properties/Remote.lnk) | Configure Remote Assistance and supported Remote Desktop hosting options in System Properties. | `%SystemRoot%\System32\SystemPropertiesRemote.exe` |
| [Stored User Names and Passwords](../08%20System%20Properties/Stored%20User%20Names%20and%20Passwords.lnk) | Open the legacy stored-credentials dialog for saved network logins. | `%SystemRoot%\System32\rundll32.exe keymgr.dll,KRShowKeyMgr` |
| [System Protection](../08%20System%20Properties/System%20Protection.lnk) | Configure protection for supported drives and access restore-point creation and System Restore. | `%SystemRoot%\System32\SystemPropertiesProtection.exe` |
| [User Account Control](../08%20System%20Properties/User%20Account%20Control.lnk) | Adjust the current Windows UAC notification setting through its standard dialog. | `%SystemRoot%\System32\UserAccountControlSettings.exe` |
| [User Accounts](../08%20System%20Properties/User%20Accounts.lnk) | Open netplwiz to manage local account properties and available advanced sign-in options. | `%SystemRoot%\System32\netplwiz.exe` |
| [Windows Features](../08%20System%20Properties/Windows%20Features.lnk) | Enable or disable optional Windows components through the classic Windows Features dialog. | `%SystemRoot%\System32\OptionalFeatures.exe` |

### 09 Diagnostics

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [DirectX Diagnostic Tool](../09%20Diagnostics/DirectX%20Diagnostic%20Tool.lnk) | Inspect graphics, audio, driver, and DirectX details and export a diagnostic report. | `%SystemRoot%\System32\dxdiag.exe` |
| [Disk Cleanup](../09%20Diagnostics/Disk%20Cleanup.lnk) | Review Windows' supported temporary-file cleanup categories before deleting selected items. | `%SystemRoot%\System32\cleanmgr.exe` |
| [Optimize Drives](../09%20Diagnostics/Optimize%20Drives.lnk) | Inspect drive optimization status and configure the supported optimization schedule. | `%SystemRoot%\System32\dfrgui.exe` |
| [Performance Monitor](../09%20Diagnostics/Performance%20Monitor.lnk) | Monitor Windows performance counters and work with data collector sets. | `%SystemRoot%\System32\perfmon.exe` |
| [Recovery Drive](../09%20Diagnostics/Recovery%20Drive.lnk) | Start the wizard for creating a USB recovery drive; writing the drive is a separate explicit action. | `%SystemRoot%\System32\recoverydrive.exe` |
| [Registry Editor](../09%20Diagnostics/Registry%20Editor.lnk) | Inspect or edit the Windows Registry through regedit; opening the shortcut itself changes no values. | `%SystemRoot%\regedit.exe` |
| [Reliability Monitor](../09%20Diagnostics/Reliability%20Monitor.lnk) | Review a timeline of failures, updates, and reliability events for troubleshooting recurring problems. | `%SystemRoot%\System32\perfmon.exe /rel` |
| [Resource Monitor](../09%20Diagnostics/Resource%20Monitor.lnk) | Inspect current CPU, memory, disk, and network activity by process. | `%SystemRoot%\System32\resmon.exe` |
| [System Configuration](../09%20Diagnostics/System%20Configuration.lnk) | Review startup, service, and boot configuration through msconfig. | `%SystemRoot%\System32\msconfig.exe` |
| [System Information](../09%20Diagnostics/System%20Information.lnk) | Inspect hardware, firmware, system components, and software-environment information. | `%SystemRoot%\System32\msinfo32.exe` |
| [Task Manager](../09%20Diagnostics/Task%20Manager.lnk) | Inspect processes, performance, startup apps, users, and other supported management views. | `%SystemRoot%\System32\taskmgr.exe` |
| [Windows Memory Diagnostic](../09%20Diagnostics/Windows%20Memory%20Diagnostic.lnk) | Open the memory-test scheduling dialog; the actual test requires a restart. | `%SystemRoot%\System32\MdSched.exe` |

### 10 Settings / Apps and Accounts

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Access Work or School](../10%20Settings/Apps%20and%20Accounts/Access%20Work%20or%20School.lnk) | Review organizational account connections, device enrollment, and management information in Settings. | `%SystemRoot%\explorer.exe ms-settings:workplace` |
| [Default Apps](../10%20Settings/Apps%20and%20Accounts/Default%20Apps.lnk) | Choose application defaults and supported file-type or protocol associations. | `%SystemRoot%\explorer.exe ms-settings:defaultapps` |
| [Installed Apps](../10%20Settings/Apps%20and%20Accounts/Installed%20Apps.lnk) | Browse installed apps and their available uninstall, repair, or advanced options. | `%SystemRoot%\explorer.exe ms-settings:appsfeatures` |
| [Optional Features](../10%20Settings/Apps%20and%20Accounts/Optional%20Features.lnk) | Manage optional capabilities such as language components and supported add-on Windows features. | `%SystemRoot%\explorer.exe ms-settings:optionalfeatures` |
| [Sign-In Options](../10%20Settings/Apps%20and%20Accounts/Sign-In%20Options.lnk) | Configure supported Windows Hello, password, PIN, and related sign-in options. | `%SystemRoot%\explorer.exe ms-settings:signinoptions` |
| [Startup Apps](../10%20Settings/Apps%20and%20Accounts/Startup%20Apps.lnk) | Review and enable or disable registered startup applications in Settings. | `%SystemRoot%\explorer.exe ms-settings:startupapps` |
| [Your Info](../10%20Settings/Apps%20and%20Accounts/Your%20Info.lnk) | Review the current account profile and available Microsoft/local account options. | `%SystemRoot%\explorer.exe ms-settings:yourinfo` |

### 10 Settings / Network and Internet

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Ethernet](../10%20Settings/Network%20and%20Internet/Ethernet.lnk) | Inspect wired network properties and supported Ethernet configuration. | `%SystemRoot%\explorer.exe ms-settings:network-ethernet` |
| [Manage Known Networks](../10%20Settings/Network%20and%20Internet/Manage%20Known%20Networks.lnk) | Review saved Wi-Fi profiles and forget networks or change their available properties. | `%SystemRoot%\explorer.exe ms-settings:network-wifisettings` |
| [Mobile Hotspot](../10%20Settings/Network%20and%20Internet/Mobile%20Hotspot.lnk) | Configure Internet connection sharing through the supported Windows mobile hotspot feature. | `%SystemRoot%\explorer.exe ms-settings:network-mobilehotspot` |
| [Network Status](../10%20Settings/Network%20and%20Internet/Network%20Status.lnk) | Review network connectivity status; newer Windows versions may route this URI to the current Network and Internet overview. | `%SystemRoot%\explorer.exe ms-settings:network-status` |
| [Proxy Settings](../10%20Settings/Network%20and%20Internet/Proxy%20Settings.lnk) | Configure automatic proxy detection, setup scripts, or a manual proxy. | `%SystemRoot%\explorer.exe ms-settings:network-proxy` |
| [VPN Connections](../10%20Settings/Network%20and%20Internet/VPN%20Connections.lnk) | Add, inspect, or manage VPN connections registered in Settings. | `%SystemRoot%\explorer.exe ms-settings:network-vpn` |
| [Wi-Fi](../10%20Settings/Network%20and%20Internet/Wi-Fi.lnk) | Inspect wireless connection status and available Wi-Fi settings on devices with supported hardware. | `%SystemRoot%\explorer.exe ms-settings:network-wifi` |

### 10 Settings / Personalization

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Advanced Keyboard Settings](../10%20Settings/Personalization/Advanced%20Keyboard%20Settings.lnk) | Choose input-method defaults and related advanced keyboard/input options. | `%SystemRoot%\explorer.exe ms-settings:keyboard-advanced` |
| [Background](../10%20Settings/Personalization/Background.lnk) | Choose the desktop background and supported background display options. | `%SystemRoot%\explorer.exe ms-settings:personalization-background` |
| [Colors](../10%20Settings/Personalization/Colors.lnk) | Configure Windows accent colors, transparency, and supported light/dark appearance options. | `%SystemRoot%\explorer.exe ms-settings:personalization-colors` |
| [Date and Time](../10%20Settings/Personalization/Date%20and%20Time.lnk) | Configure time zone, automatic time synchronization, and available clock options in Settings. | `%SystemRoot%\explorer.exe ms-settings:dateandtime` |
| [Fonts](../10%20Settings/Personalization/Fonts.lnk) | Browse installed fonts and their Settings management interface. | `%SystemRoot%\explorer.exe ms-settings:fonts` |
| [Language and Region](../10%20Settings/Personalization/Language%20and%20Region.lnk) | Configure display/input languages, regional formats, and other supported regional options. | `%SystemRoot%\explorer.exe ms-settings:regionlanguage` |
| [Lock Screen](../10%20Settings/Personalization/Lock%20Screen.lnk) | Choose lock-screen appearance and related supported options. | `%SystemRoot%\explorer.exe ms-settings:lockscreen` |
| [Personalization](../10%20Settings/Personalization/Personalization.lnk) | Open the main Personalization page for appearance settings. | `%SystemRoot%\explorer.exe ms-settings:personalization` |
| [Start Menu](../10%20Settings/Personalization/Start%20Menu.lnk) | Configure supported Start Menu options in Windows Settings. | `%SystemRoot%\explorer.exe ms-settings:personalization-start` |
| [Taskbar](../10%20Settings/Personalization/Taskbar.lnk) | Configure supported taskbar appearance and behavior in Windows Settings. | `%SystemRoot%\explorer.exe ms-settings:taskbar` |
| [Themes](../10%20Settings/Personalization/Themes.lnk) | Choose or manage Windows themes and related appearance settings. | `%SystemRoot%\explorer.exe ms-settings:themes` |

### 10 Settings / Privacy and Accessibility

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Camera Permissions](../10%20Settings/Privacy%20and%20Accessibility/Camera%20Permissions.lnk) | Review camera access controls and per-app permissions where Windows exposes them. | `%SystemRoot%\explorer.exe ms-settings:privacy-webcam` |
| [Color Filters](../10%20Settings/Privacy%20and%20Accessibility/Color%20Filters.lnk) | Configure accessibility color filters for the display. | `%SystemRoot%\explorer.exe ms-settings:easeofaccess-colorfilter` |
| [Contrast Themes](../10%20Settings/Privacy%20and%20Accessibility/Contrast%20Themes.lnk) | Configure high-contrast accessibility options; the page name varies between Windows versions. | `%SystemRoot%\explorer.exe ms-settings:easeofaccess-highcontrast` |
| [Diagnostics and Feedback](../10%20Settings/Privacy%20and%20Accessibility/Diagnostics%20and%20Feedback.lnk) | Review diagnostic-data, feedback, and related privacy options exposed by Windows. | `%SystemRoot%\explorer.exe ms-settings:privacy-feedback` |
| [File System Permissions](../10%20Settings/Privacy%20and%20Accessibility/File%20System%20Permissions.lnk) | Review file-system access permissions for apps covered by Windows privacy controls. | `%SystemRoot%\explorer.exe ms-settings:privacy-broadfilesystemaccess` |
| [Keyboard](../10%20Settings/Privacy%20and%20Accessibility/Keyboard.lnk) | Configure accessibility keyboard options such as Sticky Keys, Filter Keys, and the on-screen keyboard. | `%SystemRoot%\explorer.exe ms-settings:easeofaccess-keyboard` |
| [Location Permissions](../10%20Settings/Privacy%20and%20Accessibility/Location%20Permissions.lnk) | Review device and application location-access permissions. | `%SystemRoot%\explorer.exe ms-settings:privacy-location` |
| [Magnifier](../10%20Settings/Privacy%20and%20Accessibility/Magnifier.lnk) | Configure Magnifier accessibility options when opened from Settings; the accessory shortcut launches the tool itself. | `%SystemRoot%\explorer.exe ms-settings:easeofaccess-magnifier` |
| [Microphone Permissions](../10%20Settings/Privacy%20and%20Accessibility/Microphone%20Permissions.lnk) | Review microphone access controls and per-app permissions where supported. | `%SystemRoot%\explorer.exe ms-settings:privacy-microphone` |
| [Narrator](../10%20Settings/Privacy%20and%20Accessibility/Narrator.lnk) | Configure Narrator accessibility options when opened from Settings; the accessory shortcut launches the screen reader. | `%SystemRoot%\explorer.exe ms-settings:easeofaccess-narrator` |
| [Privacy](../10%20Settings/Privacy%20and%20Accessibility/Privacy.lnk) | Open the privacy overview supported by the installed Windows version. | `%SystemRoot%\explorer.exe ms-settings:privacy` |

### 10 Settings / System

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [About](../10%20Settings/System/About.lnk) | Inspect device specifications, Windows edition, version, and related system links in Settings. | `%SystemRoot%\explorer.exe ms-settings:about` |
| [Bluetooth](../10%20Settings/System/Bluetooth.lnk) | Manage Bluetooth connections and available device settings through Windows Settings. | `%SystemRoot%\explorer.exe ms-settings:bluetooth` |
| [Clipboard](../10%20Settings/System/Clipboard.lnk) | Configure supported clipboard history and synchronization options. | `%SystemRoot%\explorer.exe ms-settings:clipboard` |
| [Default Save Locations](../10%20Settings/System/Default%20Save%20Locations.lnk) | Choose supported default drives for newly saved content. | `%SystemRoot%\explorer.exe ms-settings:savelocations` |
| [Display](../10%20Settings/System/Display.lnk) | Open display configuration; older Control Panel entry points can redirect to modern Settings. | `%SystemRoot%\explorer.exe ms-settings:display` |
| [Graphics Settings](../10%20Settings/System/Graphics%20Settings.lnk) | Configure per-app graphics preferences and supported GPU-related settings. | `%SystemRoot%\explorer.exe ms-settings:display-advancedgraphics` |
| [Mouse](../10%20Settings/System/Mouse.lnk) | Configure mouse pointer behavior and available mouse settings. | `%SystemRoot%\explorer.exe ms-settings:mousetouchpad` |
| [Multitasking](../10%20Settings/System/Multitasking.lnk) | Configure supported window snapping, virtual desktops, and related multitasking behavior. | `%SystemRoot%\explorer.exe ms-settings:multitasking` |
| [Night Light](../10%20Settings/System/Night%20Light.lnk) | Configure reduced-blue-light display settings and the available schedule. | `%SystemRoot%\explorer.exe ms-settings:nightlight` |
| [Notifications](../10%20Settings/System/Notifications.lnk) | Configure system and per-app notification behavior where supported. | `%SystemRoot%\explorer.exe ms-settings:notifications` |
| [Power and Sleep](../10%20Settings/System/Power%20and%20Sleep.lnk) | Configure supported screen, sleep, and power behavior; options depend on hardware and Windows version. | `%SystemRoot%\explorer.exe ms-settings:powersleep` |
| [Printers and Scanners](../10%20Settings/System/Printers%20and%20Scanners.lnk) | Add or manage printers, scanners, and their available Settings options. | `%SystemRoot%\explorer.exe ms-settings:printers` |
| [Remote Desktop](../10%20Settings/System/Remote%20Desktop.lnk) | Configure Remote Desktop hosting where the installed Windows edition supports it; use Remote Desktop Connection to connect as a client. | `%SystemRoot%\explorer.exe ms-settings:remotedesktop` |
| [Settings](../10%20Settings/System/Settings.lnk) | Open the Windows Settings home page. | `%SystemRoot%\explorer.exe ms-settings:` |
| [Sound](../10%20Settings/System/Sound.lnk) | Manage audio output, input, volume, and supported audio-device options in Settings. | `%SystemRoot%\explorer.exe ms-settings:sound` |
| [Storage Sense](../10%20Settings/System/Storage%20Sense.lnk) | Configure automatic cleanup schedules and retention choices for supported Storage Sense categories. | `%SystemRoot%\explorer.exe ms-settings:storagepolicies` |
| [Storage](../10%20Settings/System/Storage.lnk) | Inspect drive usage and Windows' storage-management categories. | `%SystemRoot%\explorer.exe ms-settings:storagesense` |
| [Touchpad](../10%20Settings/System/Touchpad.lnk) | Configure supported touchpad gestures and behavior; this page depends on touchpad hardware and drivers. | `%SystemRoot%\explorer.exe ms-settings:devices-touchpad` |
| [USB](../10%20Settings/System/USB.lnk) | Configure the USB options exposed by Windows and the connected hardware. | `%SystemRoot%\explorer.exe ms-settings:usb` |
| [Volume Mixer](../10%20Settings/System/Volume%20Mixer.lnk) | Configure per-app volume and supported input/output device preferences. | `%SystemRoot%\explorer.exe ms-settings:apps-volume` |

### 10 Settings / Update and Security

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Activation](../10%20Settings/Update%20and%20Security/Activation.lnk) | Review Windows activation state and available licensing/activation options. | `%SystemRoot%\explorer.exe ms-settings:activation` |
| [Advanced Options](../10%20Settings/Update%20and%20Security/Advanced%20Options.lnk) | Configure advanced Windows Update behavior, including options available on the installed edition. | `%SystemRoot%\explorer.exe ms-settings:windowsupdate-options` |
| [Delivery Optimization](../10%20Settings/Update%20and%20Security/Delivery%20Optimization.lnk) | Configure how Windows obtains and shares supported update and app downloads. | `%SystemRoot%\explorer.exe ms-settings:delivery-optimization` |
| [Optional Updates](../10%20Settings/Update%20and%20Security/Optional%20Updates.lnk) | Review optional driver or other updates when Windows offers them. | `%SystemRoot%\explorer.exe ms-settings:windowsupdate-optionalupdates` |
| [Recovery](../10%20Settings/Update%20and%20Security/Recovery.lnk) | Review reset, advanced startup, and available recovery options in Settings; launching the page does not start a reset. | `%SystemRoot%\explorer.exe ms-settings:recovery` |
| [Troubleshoot](../10%20Settings/Update%20and%20Security/Troubleshoot.lnk) | Open the troubleshooting interface supported by the installed Windows version; available troubleshooters may change. | `%SystemRoot%\explorer.exe ms-settings:troubleshoot` |
| [Update History](../10%20Settings/Update%20and%20Security/Update%20History.lnk) | Review installed Windows updates and related update-history information. | `%SystemRoot%\explorer.exe ms-settings:windowsupdate-history` |
| [Windows Security](../10%20Settings/Update%20and%20Security/Windows%20Security.lnk) | Open the Windows Security overview and its supported protection areas. | `%SystemRoot%\explorer.exe ms-settings:windowsdefender` |
| [Windows Update](../10%20Settings/Update%20and%20Security/Windows%20Update.lnk) | Check Windows Update status and open its available update controls. | `%SystemRoot%\explorer.exe ms-settings:windowsupdate` |

### 10 Settings / Windows 11 Only

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [Advanced Network Settings](../10%20Settings/Windows%2011%20Only/Advanced%20Network%20Settings.lnk) | Open the newer network-adapter and advanced network configuration page on supported Windows 11 builds. | `%SystemRoot%\explorer.exe ms-settings:network-advancedsettings` |
| [Cameras](../10%20Settings/Windows%2011%20Only/Cameras.lnk) | Open the Windows 11 camera-management page for available camera devices and their settings. | `%SystemRoot%\explorer.exe ms-settings:camera` |
| [Storage Recommendations](../10%20Settings/Windows%2011%20Only/Storage%20Recommendations.lnk) | Review Windows 11 storage cleanup recommendations before selecting any cleanup operation. | `%SystemRoot%\explorer.exe ms-settings:storagerecommendations` |

### 12 Windows Accessories

| Shortcut | Purpose | Launch target |
| --- | --- | --- |

| [About Windows](../12%20Windows%20Accessories/About%20Windows.lnk) | Show the standard winver dialog with Windows version and build information. | `%SystemRoot%\System32\winver.exe` |
| [Calculator](../12%20Windows%20Accessories/Calculator.lnk) | Launch Windows Calculator for arithmetic and the modes supplied by the installed app. | `%SystemRoot%\System32\calc.exe` |
| [Character Map](../12%20Windows%20Accessories/Character%20Map.lnk) | Browse characters in installed fonts and copy selected characters. | `%SystemRoot%\System32\charmap.exe` |
| [Command Prompt](../12%20Windows%20Accessories/Command%20Prompt.lnk) | Open the standard command-line interpreter using the current user's normal permissions. | `%SystemRoot%\System32\cmd.exe` |
| [Magnifier](../12%20Windows%20Accessories/Magnifier.lnk) | Launch the built-in screen magnification tool. | `%SystemRoot%\System32\magnify.exe` |
| [Narrator](../12%20Windows%20Accessories/Narrator.lnk) | Launch the built-in Narrator screen reader. | `%SystemRoot%\System32\Narrator.exe` |
| [Notepad](../12%20Windows%20Accessories/Notepad.lnk) | Launch the installed Windows Notepad text editor. | `%SystemRoot%\System32\notepad.exe` |
| [On-Screen Keyboard](../12%20Windows%20Accessories/On-Screen%20Keyboard.lnk) | Launch the classic on-screen keyboard for pointer-based keyboard input. | `%SystemRoot%\System32\osk.exe` |
| [Paint](../12%20Windows%20Accessories/Paint.lnk) | Launch the installed Windows Paint app for simple image drawing and editing. | `%SystemRoot%\System32\cmd.exe /d /c start "" mspaint.exe` |
| [Remote Desktop Connection](../12%20Windows%20Accessories/Remote%20Desktop%20Connection.lnk) | Launch the RDP client to connect to a remote Windows desktop or other compatible RDP host. | `%SystemRoot%\System32\mstsc.exe` |
| [Snipping Tool](../12%20Windows%20Accessories/Snipping%20Tool.lnk) | Launch the installed Snipping Tool to capture screenshots and use the features supplied by that app version. | `%SystemRoot%\System32\cmd.exe /d /c start "" SnippingTool.exe` |
| [Windows PowerShell](../12%20Windows%20Accessories/Windows%20PowerShell.lnk) | Open Windows PowerShell 5.1; this shortcut does not select PowerShell 7 or permanently change execution policy. | `%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe` |
