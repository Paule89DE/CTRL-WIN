# Optional Windows tweaks

[Back to README](../README.md) | [Usage](USAGE.md) | [Maintenance](MAINTENANCE.md)

Category 11 contains **12 REG files and 5 CMD files**. They are not applied by the setup launcher. Read the effects below before running them. CMD files support `--check`, which displays the planned operation and current state without applying changes.

Reset files remove the named collection values or keys; disable files set the stated opposing value. They do not restore a previous custom configuration. Export existing values with Registry Editor before replacing your own settings. Group Policy may override a change.

| Folder | Option | Scope and follow-up |
| --- | --- | --- |
| Explorer | Windows 11 classic context menu | Current user; version-dependent workaround; restart Explorer or sign out |
| Explorer | Network Thumbs.db policy | Current user; restart Explorer or sign out |
| Explorer | Rebuild icon cache | Current session; closes Explorer windows and restarts Explorer |
| Network | Private-network SMB trust | Current user; file/SMB sources only; reopen Explorer or sign out |
| Network | IPv6 temporary addresses | Administrator; persistent computer-wide setting |
| Keyboard | Hex Unicode input | Current user; sign out and back in |
| PowerShell | Script execution policy | Current user in Windows PowerShell 5.1; immediate, subject to Group Policy |
| File System | Long Win32 paths | Administrator; compatible applications only; restart Windows |
| Date and Time | Hardware clock UTC/local time | Administrator; coordinate dual-boot systems and restart Windows |

**Classic context menu:** Sets an empty default value under `HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32`. Reset removes only that default value. This workaround is not guaranteed on every Windows 11 version. **Show more options** and Shift+F10 remain available.

**Network Thumbs.db:** Sets `DisableThumbsDBOnNetworkFolders=1` under `HKCU\Software\Policies\Microsoft\Windows\Explorer`. Reset removes that policy value. Existing `thumbs.db` files are not deleted, and local thumbnails remain enabled.

**Icon cache rebuild:** Stops Explorer only in the current session, deletes `iconcache*.db` under the current user's `%LOCALAPPDATA%\Microsoft\Windows\Explorer` and the older `%LOCALAPPDATA%\IconCache.db`, then restarts Explorer if needed. It checks the paths and rejects junctions and symbolic links. It does not delete `thumbcache*.db` or personal documents. Finish Explorer file operations first. This optional rebuild is separate from the setup helper's targeted folder refresh.

**SMB trust:** Assigns only the `file` protocol to Local Intranet (zone 1) for `10.*.*.*`, `172.16-31.*.*`, and `192.168.*.*`. HTTP/HTTPS mappings remain unchanged. This covers every matching private network, including VPN, guest, and unfamiliar networks; narrow the ranges if you only want your own LAN. DNS names, IPv6, and server-name UNC paths need separate mappings. Mark of the Web, SmartScreen, UAC, and other policies can still cause warnings. This does not enable SMB1, guest access, or change SMB signing, shares, or firewall rules.

The SMB reset removes only `WinShortcuts10`, `WinShortcuts172`, and `WinShortcuts192` under `HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges`. These existing key names are retained for compatibility with previously applied files. Other range entries and zones are preserved.

**IPv6 Privacy Extensions:** Uses `netsh interface ipv6 set privacy state=enabled|disabled store=persistent`. This controls temporary IPv6 addresses without disabling IPv6 or assigning a fixed address. The scripts require administrator rights and check the command result.

**Hex Unicode input:** Sets the string `EnableHexNumpad="1"` under `HKCU\Control Panel\Input Method`. After signing out and in, supported programs accept Alt + numeric-keypad Plus + a hexadecimal code, for example `20AC` for the euro sign. Reset removes this value. Application handling can vary.

**PowerShell policy:** Allow sets `RemoteSigned` for `CurrentUser` in Windows PowerShell 5.1. Downloaded scripts still require a valid signature or individual unblocking after review. Reset sets `Undefined`, so the next applicable policy takes effect. Neither file changes PowerShell 7. Group Policy takes precedence, and execution policy is not a complete security boundary. The collection's setup does not require this permanent change.

**Long paths:** Sets DWORD `LongPathsEnabled` to `1` or `0` under `HKLM\SYSTEM\CurrentControlSet\Control\FileSystem`. Applications must also opt into long paths (`longPathAware`); this does not remove every application or path-component limit.

**Hardware clock:** UTC sets DWORD `RealTimeIsUniversal=1` under `HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation`. Local Time removes it. Match the convention used by other installed operating systems. Windows timezone and time-service settings are not changed; check the clock after restarting.

## File-by-file guide

| File | Purpose | Reversal / next step |
| --- | --- | --- |
| [Hardware Clock - Local Time.reg](../11%20Windows%20Tweaks/Date%20and%20Time/Hardware%20Clock%20-%20Local%20Time.reg) | Remove RealTimeIsUniversal so Windows uses its default local-time hardware-clock convention. | Pair with Hardware Clock - UTC; administrator rights and a restart are required. |
| [Hardware Clock - UTC.reg](../11%20Windows%20Tweaks/Date%20and%20Time/Hardware%20Clock%20-%20UTC.reg) | Set RealTimeIsUniversal=1 for a UTC hardware clock, commonly needed when matching another operating system. | Use Hardware Clock - Local Time to remove the value; coordinate all installed operating systems. |
| [Disable Network Thumbs.db.reg](../11%20Windows%20Tweaks/Explorer/Disable%20Network%20Thumbs.db.reg) | Set the current-user policy that prevents Explorer from writing network-folder thumbs.db files. | Use Reset Network Thumbs.db Policy; existing cache files remain. |
| [Rebuild Explorer Icon Cache.cmd](../11%20Windows%20Tweaks/Explorer/Rebuild%20Explorer%20Icon%20Cache.cmd) | Rebuild the current session/user icon cache by stopping Explorer, removing the specified iconcache databases, and restarting Explorer. | No reversal file; Windows rebuilds the cache. Finish Explorer copy/move operations first. Use --check to inspect the operation. |
| [Reset Network Thumbs.db Policy.reg](../11%20Windows%20Tweaks/Explorer/Reset%20Network%20Thumbs.db%20Policy.reg) | Remove the current-user DisableThumbsDBOnNetworkFolders policy value. | Windows or Group Policy determines the resulting behavior; this does not restore an earlier custom value. |
| [Windows 11 - Enable Classic Context Menu.reg](../11%20Windows%20Tweaks/Explorer/Windows%2011%20-%20Enable%20Classic%20Context%20Menu.reg) | Apply the current-user CLSID default-value workaround for the classic context menu. | Use Windows 11 - Reset Classic Context Menu; restart Explorer or sign out. The workaround is version-dependent. |
| [Windows 11 - Reset Classic Context Menu.reg](../11%20Windows%20Tweaks/Explorer/Windows%2011%20-%20Reset%20Classic%20Context%20Menu.reg) | Remove the workaround default value from InprocServer32, preserving other values and keys. | Restart Explorer or sign out; does not restore a previously customized default value. |
| [Disable Long File Paths.reg](../11%20Windows%20Tweaks/File%20System/Disable%20Long%20File%20Paths.reg) | Set the computer-wide LongPathsEnabled DWORD to 0. | Enable Long File Paths sets it to 1; administrator rights and a restart are required. |
| [Enable Long File Paths.reg](../11%20Windows%20Tweaks/File%20System/Enable%20Long%20File%20Paths.reg) | Set the computer-wide LongPathsEnabled DWORD to 1 for applications that support long paths. | Disable Long File Paths sets it to 0; applications must separately opt in. |
| [Enable Hex Unicode Input.reg](../11%20Windows%20Tweaks/Keyboard/Enable%20Hex%20Unicode%20Input.reg) | Set the current-user EnableHexNumpad string to 1 for supported Alt+Numpad Plus hexadecimal input. | Use Reset Hex Unicode Input; sign out and back in. |
| [Reset Hex Unicode Input.reg](../11%20Windows%20Tweaks/Keyboard/Reset%20Hex%20Unicode%20Input.reg) | Remove the current-user EnableHexNumpad value. | Sign out and back in; the previous custom value is not restored. |
| [IPv6 - Disable Temporary Addresses.cmd](../11%20Windows%20Tweaks/Network/IPv6%20-%20Disable%20Temporary%20Addresses.cmd) | Set persistent IPv6 privacy state to disabled with netsh, without disabling IPv6 itself. | IPv6 - Enable Temporary Addresses sets the opposing state. Requires administrator rights; --check is read-only. |
| [IPv6 - Enable Temporary Addresses.cmd](../11%20Windows%20Tweaks/Network/IPv6%20-%20Enable%20Temporary%20Addresses.cmd) | Set persistent IPv6 privacy state to enabled with netsh for temporary IPv6 addresses. | IPv6 - Disable Temporary Addresses sets the opposing state. Requires administrator rights; --check is read-only. |
| [SMB - Remove Intranet Mappings.reg](../11%20Windows%20Tweaks/Network/SMB%20-%20Remove%20Intranet%20Mappings.reg) | Delete only the WinShortcuts10, WinShortcuts172, and WinShortcuts192 range keys created by the matching trust file. | Reopen Explorer or sign out. Other range keys remain; earlier contents of these three keys are not restored. |
| [SMB - Trust Private Networks.reg](../11%20Windows%20Tweaks/Network/SMB%20-%20Trust%20Private%20Networks.reg) | Map file-protocol IPv4 private-address ranges to Local Intranet zone 1 for the current user. | SMB - Remove Intranet Mappings removes the three collection keys. Scope includes matching VPN and guest networks; narrow ranges when appropriate. |
| [PowerShell - Allow Local Scripts.cmd](../11%20Windows%20Tweaks/PowerShell/PowerShell%20-%20Allow%20Local%20Scripts.cmd) | Set CurrentUser execution policy to RemoteSigned in Windows PowerShell 5.1. | PowerShell - Reset Execution Policy sets Undefined. Use --check for current policy; setup does not require this permanent change. |
| [PowerShell - Reset Execution Policy.cmd](../11%20Windows%20Tweaks/PowerShell/PowerShell%20-%20Reset%20Execution%20Policy.cmd) | Set CurrentUser execution policy to Undefined in Windows PowerShell 5.1 so the next policy in precedence applies. | Does not restore the previous policy. Group Policy can control the result; PowerShell 7 is separate. |

## Running a preview

Open Command Prompt in the collection folder and invoke the specific CMD file with `--check`. The preview prints its planned operation and current state where supported, then exits without applying the tweak. For example:

```cmd
"11 Windows Tweaks\Network\IPv6 - Enable Temporary Addresses.cmd" --check
"11 Windows Tweaks\PowerShell\PowerShell - Allow Local Scripts.cmd" --check
"11 Windows Tweaks\Explorer\Rebuild Explorer Icon Cache.cmd" --check
```

REG files have no `--check` switch. Open them in Notepad to inspect their exact keys, value types, and operations before importing. Double-clicking a REG file asks Registry Editor to import its contents; accept that prompt only when you want the described change. HKCU means the current user. HKLM means the computer-wide configuration and normally needs elevation. DWORD values, strings, and value/key deletion are different operations; the matching reset file explains which one it uses.

Apply only the option you need rather than importing an entire folder. Export relevant existing registry values before replacing a custom configuration. A supplied opposite or reset file restores the documented opposing/default behavior; it is not a snapshot of your previous state. The collection does not silently elevate a setup run or execute these tweaks during icon repair.

## References

The files in this repository are the definitive list of registry and command operations performed by each tweak. See also Microsoft's documentation for [PowerShell execution policies](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies), [Unblock-File](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/unblock-file), and [long path support](https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation).
