#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
param([switch]$FoldersOnly)

$ErrorActionPreference = 'Stop'
if ((Split-Path -Leaf $PSScriptRoot) -ine 'scripts') {
    throw 'Keep this script in the scripts subfolder of the collection.'
}
$taskCollectionRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))

if (-not ('WinShortcutIcons' -as [type])) {
    Add-Type -ReferencedAssemblies 'System.Drawing.dll' @'
using System;
using System.IO;
using System.Text;
using System.Runtime.InteropServices;
public static class WinShortcutIcons {
    public sealed class IconRef { public string File; public int Index; public IconRef(string file, int index) { File = file; Index = index; } }
    [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Unicode)]
    public struct StockInfo { public uint cbSize; public IntPtr hIcon; public int iSysImageIndex; public int iIcon; [MarshalAs(UnmanagedType.ByValTStr, SizeConst=260)] public string szPath; }
    [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Unicode)]
    public struct FileInfo { public IntPtr hIcon; public int iIcon; public uint dwAttributes; [MarshalAs(UnmanagedType.ByValTStr, SizeConst=260)] public string szDisplayName; [MarshalAs(UnmanagedType.ByValTStr, SizeConst=80)] public string szTypeName; }
    [DllImport("shell32.dll")] static extern int SHGetStockIconInfo(int id, uint flags, ref StockInfo info);
    [DllImport("shell32.dll", CharSet=CharSet.Unicode)] static extern int SHParseDisplayName(string name, IntPtr bind, out IntPtr pidl, uint attrs, out uint outAttrs);
    [DllImport("shell32.dll", CharSet=CharSet.Unicode, EntryPoint="SHGetFileInfoW")] static extern IntPtr SHGetFileInfo(IntPtr pidl, uint attrs, out FileInfo info, uint size, uint flags);
    [DllImport("shell32.dll", CharSet=CharSet.Unicode)] static extern int SHDefExtractIcon(string file, int index, uint flags, out IntPtr large, out IntPtr small, uint size);
    [DllImport("user32.dll")] static extern bool DestroyIcon(IntPtr icon);
    [DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)]
    static extern IntPtr CreateFile(string path, uint access, uint sharing, IntPtr security, uint disposition, uint flags, IntPtr template);
    [DllImport("kernel32.dll", SetLastError=true)]
    static extern bool SetFileTime(IntPtr handle, IntPtr creation, IntPtr access, ref long write);
    [DllImport("kernel32.dll")] static extern bool CloseHandle(IntPtr handle);
    [DllImport("shell32.dll", CharSet=CharSet.Unicode)] public static extern void SHChangeNotify(uint eventId, uint flags, string item1, IntPtr item2);
    public static void InvalidateFolderThumbnail(string path) {
        IntPtr handle = CreateFile(path, 0x100, 7, IntPtr.Zero, 3, 0x02000000, IntPtr.Zero);
        if (handle == new IntPtr(-1)) throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error());
        try {
            long write = DateTime.UtcNow.ToFileTimeUtc();
            if (!SetFileTime(handle, IntPtr.Zero, IntPtr.Zero, ref write)) throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error());
        } finally { CloseHandle(handle); }
    }
    public static IconRef Stock(int id) {
        var info = new StockInfo(); info.cbSize = (uint)Marshal.SizeOf(info);
        return SHGetStockIconInfo(id, 0, ref info) == 0 ? new IconRef(info.szPath, info.iIcon) : null;
    }
    public static IconRef Shell(string path) {
        IntPtr pidl; uint attrs;
        if (SHParseDisplayName(path, IntPtr.Zero, out pidl, 0, out attrs) != 0) return null;
        try {
            FileInfo info;
            var result = SHGetFileInfo(pidl, 0, out info, (uint)Marshal.SizeOf(typeof(FileInfo)), 0x1008);
            return result != IntPtr.Zero && !String.IsNullOrEmpty(info.szDisplayName) ? new IconRef(info.szDisplayName, info.iIcon) : null;
        } finally { Marshal.FreeCoTaskMem(pidl); }
    }
    public static bool Valid(string path, int index) {
        return ValidSize(path, index, 32);
    }
    public static bool ValidSize(string path, int index, int size) {
        if (size < 16 || size > 256) return false;
        IntPtr icon, small;
        int result = SHDefExtractIcon(path, index, 0, out icon, out small, (uint)size);
        if (icon == IntPtr.Zero) {
            if (small != IntPtr.Zero) DestroyIcon(small);
            return false;
        }
        try {
            if (result != 0) return false;
            using (var view = System.Drawing.Icon.FromHandle(icon))
            using (var bitmap = view.ToBitmap()) {
                int visible = 0;
                for (int x = 0; x < bitmap.Width; x++)
                    for (int y = 0; y < bitmap.Height; y++)
                        if (bitmap.GetPixel(x, y).A > 32 && ++visible > 16) return true;
            }
            return false;
        } finally {
            DestroyIcon(icon);
            if (small != IntPtr.Zero && small != icon) DestroyIcon(small);
        }
    }
    public static void RefreshIconCache() {
        SHChangeNotify(0x08000000, 0x1000, null, IntPtr.Zero);
    }
    static void Wide(BinaryWriter writer, string value) {
        byte[] bytes = Encoding.Unicode.GetBytes(value);
        if (bytes.Length / 2 > UInt16.MaxValue) throw new InvalidDataException("Icon path is too long.");
        writer.Write((ushort)(bytes.Length / 2)); writer.Write(bytes);
    }
    public static byte[] WithIcon(byte[] source, string iconPath, int iconIndex) {
        if (source.Length < 80 || BitConverter.ToUInt32(source, 0) != 76) throw new InvalidDataException("Invalid LNK file.");
        uint flags = BitConverter.ToUInt32(source, 20);
        if ((flags & 0x80) == 0) throw new InvalidDataException("Expected a Unicode LNK file.");
        int cursor = 76;
        if ((flags & 1) != 0) cursor = checked(cursor + 2 + BitConverter.ToUInt16(source, cursor));
        if ((flags & 2) != 0) cursor = checked(cursor + (int)BitConverter.ToUInt32(source, cursor));
        using (var output = new MemoryStream()) using (var writer = new BinaryWriter(output)) {
            writer.Write(source, 0, cursor);
            foreach (uint flag in new uint[] {4, 8, 16, 32, 64}) {
                if ((flags & flag) == 0) continue;
                int length = checked(2 + 2 * BitConverter.ToUInt16(source, cursor));
                if (flag != 64) writer.Write(source, cursor, length);
                cursor = checked(cursor + length);
            }
            Wide(writer, iconPath);
            while (true) {
                uint size = BitConverter.ToUInt32(source, cursor);
                if (size == 0) break;
                if (size < 8 || size > source.Length - cursor) throw new InvalidDataException("Invalid LNK data block.");
                uint signature = BitConverter.ToUInt32(source, cursor + 4);
                if (signature != 0xA0000007) writer.Write(source, cursor, (int)size);
                cursor += (int)size;
            }
            byte[] ansi = Encoding.ASCII.GetBytes(iconPath + "\0");
            byte[] unicode = Encoding.Unicode.GetBytes(iconPath + "\0");
            if (ansi.Length > 260 || unicode.Length > 520) throw new InvalidDataException("Icon path is too long.");
            writer.Write(0x314u); writer.Write(0xA0000007u);
            writer.Write(ansi); writer.Write(new byte[260 - ansi.Length]);
            writer.Write(unicode); writer.Write(new byte[520 - unicode.Length]);
            writer.Write(source, cursor, source.Length - cursor);
            writer.Flush(); output.Position = 20; writer.Write(flags | 0x4040u);
            output.Position = 56; writer.Write(iconIndex); writer.Flush();
            return output.ToArray();
        }
    }
}
'@
}

$taskIconCache = @{}
$taskFolderIconCache = @{}
$taskCanonicalCache = @{}
$taskCanonicalClasses = @{}
$taskSystemRoot = [IO.Path]::GetFullPath($env:SystemRoot).TrimEnd('\') + '\'
$taskSystem32 = Join-Path $env:SystemRoot 'System32'
foreach ($taskClass in Get-ChildItem -LiteralPath 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID' -ErrorAction SilentlyContinue) {
    $taskProperties = Get-ItemProperty -LiteralPath $taskClass.PSPath -ErrorAction SilentlyContinue
    if ($taskProperties.'System.ApplicationName') {
        $taskCanonicalClasses[$taskProperties.'System.ApplicationName'] = $taskClass.PSChildName
    }
}

function Get-CheckedIcon($Candidate) {
    if ($null -eq $Candidate) { return $null }
    $taskIconFile = [Environment]::ExpandEnvironmentVariables($Candidate.File.TrimStart('@'))
    if (-not [IO.Path]::IsPathRooted($taskIconFile)) { $taskIconFile = Join-Path $taskSystem32 $taskIconFile }
    $taskIconFile = [IO.Path]::GetFullPath($taskIconFile)
    if (-not $taskIconFile.StartsWith($taskSystemRoot, [StringComparison]::OrdinalIgnoreCase)) { return $null }
    $taskKey = $taskIconFile + ',' + $Candidate.Index
    if (-not $taskIconCache.ContainsKey($taskKey)) {
        $taskIconCache[$taskKey] = if ([WinShortcutIcons]::Valid($taskIconFile, $Candidate.Index)) {
            [WinShortcutIcons+IconRef]::new(('%SystemRoot%\' + $taskIconFile.Substring($taskSystemRoot.Length)), $Candidate.Index)
        } else { $null }
    }
    return $taskIconCache[$taskKey]
}

function Get-StockIcon([int]$Id) { Get-CheckedIcon ([WinShortcutIcons]::Stock($Id)) }
function Get-ResourceIcon([string]$File, [int]$Index = 0) { Get-CheckedIcon ([WinShortcutIcons+IconRef]::new($File, $Index)) }
function Get-ShellIcon([string]$Path) { Get-CheckedIcon ([WinShortcutIcons]::Shell($Path)) }
function Get-SettingsIcon {
    $taskSettingsIcon = Get-ResourceIcon (Join-Path $env:SystemRoot 'ImmersiveControlPanel\SystemSettings.exe')
    if (-not $taskSettingsIcon) { $taskSettingsIcon = Get-ResourceIcon (Join-Path $taskSystem32 'control.exe') }
    return $taskSettingsIcon
}

function Get-ControlIcon([string]$Canonical) {
    if ($taskCanonicalCache.ContainsKey($Canonical)) { return $taskCanonicalCache[$Canonical] }
    $taskFound = $null
    if ($taskCanonicalClasses.ContainsKey($Canonical)) { $taskFound = Get-ShellIcon ('shell:::' + $taskCanonicalClasses[$Canonical]) }
    $taskCanonicalCache[$Canonical] = $taskFound
    return $taskFound
}

function Get-CheckedFolderIcon($Candidate) {
    if (-not $Candidate) { return $null }
    $taskPath = [Environment]::ExpandEnvironmentVariables($Candidate.File)
    $taskKey = $taskPath + ',' + $Candidate.Index
    if (-not $taskFolderIconCache.ContainsKey($taskKey)) {
        $taskValid = $true
        foreach ($taskSize in @(16, 32, 48, 96, 256)) {
            if (-not [WinShortcutIcons]::ValidSize($taskPath, $Candidate.Index, $taskSize)) {
                $taskValid = $false
                break
            }
        }
        $taskFolderIconCache[$taskKey] = $taskValid
    }
    if ($taskFolderIconCache[$taskKey]) { return $Candidate }
    return $null
}

$taskCplNames = @{
    'appwiz.cpl'='ProgramsAndFeatures'; 'ncpa.cpl'='NetworkAndSharingCenter'; 'inetcpl.cpl'='InternetOptions';
    'Firewall.cpl'='WindowsFirewall'; 'sysdm.cpl'='System'; 'powercfg.cpl'='PowerOptions'; 'mmsys.cpl'='Sound';
    'main.cpl'='Mouse'; 'timedate.cpl'='DateAndTime'; 'intl.cpl'='RegionAndLanguage'; 'desk.cpl'='Display';
    'hdwwiz.cpl'='DeviceManager'; 'wscui.cpl'='ActionCenter'; 'telephon.cpl'='PhoneAndModem'; 'TabletPC.cpl'='TabletPCSettings'
}

function Get-ThematicIcon([string]$Name) {
    switch -Regex ($Name) {
        'Network Drive' { return Get-StockIcon 9 }
        'Shared|Share|Network Shortcuts' { return Get-StockIcon 51 }
        'Network Connections|Adapter|Ethernet|VPN|Proxy|Hotspot|Wi-Fi|iSCSI' { return Get-StockIcon 103 }
        'Network' { return Get-StockIcon 17 }
        'Credential|Password|Certificate' { return Get-StockIcon 81 }
        'System Protection|Security|Firewall|TPM|UAC|Account Control|Privacy|Permissions' { return Get-StockIcon 77 }
        'Power' { return Get-ResourceIcon (Join-Path $taskSystem32 'powercpl.dll') }
        'Desktop|Display|Screen|Graphics|Computer Name|System Information' { return Get-StockIcon 94 }
        'Font' { return Get-ResourceIcon (Join-Path $taskSystem32 'fontext.dll') }
        'Startup|Start Menu|Taskbar|Quick Launch|WinX' { return Get-StockIcon 82 }
        'User|Account|Work or School|Sign-In' { return Get-StockIcon 96 }
        'Print|Spool' { return Get-StockIcon 16 }
        'Camera' { return Get-StockIcon 100 }
        'Sound|Audio|Volume|Microphone' { return Get-StockIcon 102 }
        'Picture|Screenshot|Thumbnail|Color|Theme|Background|Night Light|Paint|Snipping' { return Get-StockIcon 72 }
        'Music' { return Get-StockIcon 71 }
        'Video' { return Get-StockIcon 73 }
        'Internet|INetCache' { return Get-StockIcon 104 }
        'Search|Index' { return Get-StockIcon 22 }
        'Log|Error|Crash|Minidump|Reliability|Diagnostic' { return Get-StockIcon 79 }
        'Disk|Drive|Storage|Component|Installer|WinSxS' { return Get-StockIcon 8 }
        'Recycle|Temp' { return Get-StockIcon 31 }
        'Program|App' { return Get-StockIcon 82 }
        'Librar|Jump List|Recent|Template' { return Get-StockIcon 49 }
        'Quick Access|Favorite|User Links|SendTo' { return Get-StockIcon 51 }
        default { return Get-SettingsIcon }
    }
}

function Get-LinkIcon($File, $Shortcut) {
    $taskName = $File.BaseName
    $taskTarget = $Shortcut.TargetPath
    $taskArgument = $Shortcut.Arguments.Trim('"')
    $taskExtension = [IO.Path]::GetExtension($taskTarget)
    $taskSelected = $null
    if ($taskArgument -eq 'shell:::{ED7BA470-8E54-465E-825C-99712043E01C}') {
        return Get-FolderIcon 'ControlPanel'
    }
    if ($taskArgument.StartsWith('shell:')) {
        $taskSelected = Get-ShellIcon $taskArgument
        $taskPlainFolder = Get-StockIcon 3
        if ($taskSelected -and $taskSelected.File -eq $taskPlainFolder.File -and $taskSelected.Index -eq $taskPlainFolder.Index) {
            $taskSelected = Get-ThematicIcon $taskName
        }
    }
    elseif ($taskArgument -match '/name\s+(Microsoft\.\S+)') {
        $taskSelected = Get-ControlIcon $Matches[1]
    }
    elseif ($taskExtension -eq '.cpl' -or $taskArgument -match '^(mmsys\.cpl)') {
        $taskCpl = if ($taskExtension -eq '.cpl') { [IO.Path]::GetFileName($taskTarget) } else { 'mmsys.cpl' }
        if ($taskCplNames.ContainsKey($taskCpl)) { $taskSelected = Get-ControlIcon ('Microsoft.' + $taskCplNames[$taskCpl]) }
        if (-not $taskSelected) { $taskSelected = Get-ResourceIcon (Join-Path $taskSystem32 $taskCpl) }
    }
    elseif ($taskExtension -eq '.msc' -and (Test-Path -LiteralPath $taskTarget)) {
        try {
            $taskXml = New-Object Xml.XmlDocument
            $taskXml.XmlResolver = $null
            $taskXml.Load($taskTarget)
            $taskMscIcon = $taskXml.SelectSingleNode('/MMC_ConsoleFile/VisualAttributes/Icon')
            if ($taskMscIcon) { $taskSelected = Get-ResourceIcon $taskMscIcon.File ([int]$taskMscIcon.Index) }
        } catch { $taskSelected = $null }
        if ([IO.Path]::GetFileName($taskTarget) -eq 'eventvwr.msc') { $taskSelected = Get-ResourceIcon (Join-Path $taskSystem32 'eventvwr.exe') }
        if ([IO.Path]::GetFileName($taskTarget) -eq 'taskschd.msc') { $taskSelected = Get-ResourceIcon (Join-Path $taskSystem32 'mstask.dll') 1 }
        if ([IO.Path]::GetFileName($taskTarget) -eq 'devmgmt.msc') { $taskSelected = Get-ControlIcon 'Microsoft.DeviceManager' }
        if ($taskName -match 'Certificates') { $taskSelected = Get-ResourceIcon (Join-Path $taskSystem32 'cryptui.dll') 1 }
    }
    elseif ($taskArgument.StartsWith('ms-settings:')) {
        if ($taskName -match 'Date|Time') { $taskSelected = Get-ControlIcon 'Microsoft.DateAndTime' }
        elseif ($taskName -match 'Mouse|Touchpad') { $taskSelected = Get-ControlIcon 'Microsoft.Mouse' }
        elseif ($taskName -match 'Keyboard') { $taskSelected = Get-ControlIcon 'Microsoft.Keyboard' }
        elseif ($taskName -match 'Power') { $taskSelected = Get-ControlIcon 'Microsoft.PowerOptions' }
        elseif ($taskName -match 'Fonts') { $taskSelected = Get-ShellIcon 'shell:Fonts' }
        elseif ($taskName -match 'Accessibility|Ease of Access|Narrator|Magnifier|Color Filter|Contrast') { $taskSelected = Get-ControlIcon 'Microsoft.EaseOfAccessCenter' }
        else { $taskSelected = Get-ThematicIcon $taskName }
    }
    elseif ($taskExtension -eq '.exe' -and $taskTarget -notmatch '\\(explorer|control|rundll32)\.exe$') {
        $taskSelected = Get-ResourceIcon $taskTarget
    }
    if ($taskArgument -match '^/d /c start "" (mspaint|SnippingTool)\.exe$') { $taskSelected = Get-StockIcon 72 }
    if ($taskName -match 'Fonts') { $taskSelected = Get-ThematicIcon $taskName }
    if ($taskName -match '^Bluetooth') {
        $taskSelected = Get-ResourceIcon (Join-Path $taskSystem32 'bthprops.cpl') -103
        if (-not $taskSelected) { $taskSelected = Get-ResourceIcon (Join-Path $taskSystem32 'fsquirt.exe') }
    }
    if ($taskName -match '^Magnifier') { $taskSelected = Get-ResourceIcon (Join-Path $taskSystem32 'magnify.exe') }
    if ($taskName -match '^Narrator') { $taskSelected = Get-ResourceIcon (Join-Path $taskSystem32 'Narrator.exe') }
    if ($taskName -match '^Environment Variables') { $taskSelected = Get-SettingsIcon }
    if (-not $taskSelected) { $taskSelected = Get-ThematicIcon $taskName }
    if (-not $taskSelected) { $taskSelected = Get-SettingsIcon }
    if (-not $taskSelected) { throw 'No valid Windows icon was found.' }
    return $taskSelected
}

$taskFolderStyles = @(
    @{ Path=''; Icon='ControlPanel'; Tip='CTRL-WIN - Windows tools, system folders and settings for Windows 10 and 11.' }
    @{ Path='docs'; Icon='Help'; Tip='English usage, shortcut catalog, optional tweaks and maintenance guides.' }
    @{ Path='docs\screenshots'; Icon='Appearance'; Tip='Actual Explorer screenshots of CTRL-WIN.' }
    @{ Path='scripts'; Icon='Scripts'; Tip='Set up shortcut icons, Videos folder templates and extra large Explorer icons.' }
    @{ Path='01 Network'; Icon='Network'; Tip='Browse Network.' }
    @{ Path='02 Start Menu and Taskbar'; Icon='Programs'; Tip='Browse Start Menu and Taskbar.' }
    @{ Path='03 User Folders'; Icon='Users'; Tip='Browse User Folders.' }
    @{ Path='04 AppData'; Icon='Profile'; Tip='Browse AppData.' }
    @{ Path='05 Windows Folders'; Icon='Disk'; Tip='Browse Windows Folders.' }
    @{ Path='06 Control Panel'; Icon='ControlPanel'; Tip='Browse Control Panel.' }
    @{ Path='06 Control Panel\CPL Applets'; Icon='ControlPanel'; Tip='Browse CPL Applets.' }
    @{ Path='06 Control Panel\More Control Panel Items'; Icon='Tools'; Tip='Browse More Control Panel Items.' }
    @{ Path='07 Administrative Tools'; Icon='Tools'; Tip='Browse Administrative Tools.' }
    @{ Path='07 Administrative Tools\Pro and Enterprise'; Icon='Security'; Tip='Browse Pro and Enterprise.' }
    @{ Path='08 System Properties'; Icon='System'; Tip='Browse System Properties.' }
    @{ Path='09 Diagnostics'; Icon='Diagnostics'; Tip='Browse Diagnostics.' }
    @{ Path='10 Settings'; Icon='Settings'; Tip='Browse Settings.' }
    @{ Path='10 Settings\System'; Icon='System'; Tip='Browse System.' }
    @{ Path='10 Settings\Network and Internet'; Icon='Network'; Tip='Browse Network and Internet.' }
    @{ Path='10 Settings\Apps and Accounts'; Icon='Users'; Tip='Browse Apps and Accounts.' }
    @{ Path='10 Settings\Personalization'; Icon='Appearance'; Tip='Browse Personalization.' }
    @{ Path='10 Settings\Privacy and Accessibility'; Icon='Accessibility'; Tip='Browse Privacy and Accessibility.' }
    @{ Path='10 Settings\Update and Security'; Icon='Security'; Tip='Browse Update and Security.' }
    @{ Path='10 Settings\Windows 11 Only'; Icon='Settings'; Tip='Browse Windows 11 Only.' }
    @{ Path='11 Windows Tweaks'; Icon='Tools'; Tip='Browse Windows Tweaks.' }
    @{ Path='11 Windows Tweaks\Explorer'; Icon='Appearance'; Tip='Browse Explorer.' }
    @{ Path='11 Windows Tweaks\Network'; Icon='Network'; Tip='Browse Network.' }
    @{ Path='11 Windows Tweaks\Keyboard'; Icon='Keyboard'; Tip='Browse Keyboard.' }
    @{ Path='11 Windows Tweaks\PowerShell'; Icon='Scripts'; Tip='Browse PowerShell.' }
    @{ Path='11 Windows Tweaks\File System'; Icon='Disk'; Tip='Browse File System.' }
    @{ Path='11 Windows Tweaks\Date and Time'; Icon='Clock'; Tip='Browse Date and Time.' }
    @{ Path='12 Windows Accessories'; Icon='Programs'; Tip='Remote Desktop Connection, Calculator, Notepad, Paint and other built-in Windows apps.' }
)

function Get-FolderIcon([string]$Kind) {
    $taskSelected = switch ($Kind) {
        'ControlPanel' { Get-ShellIcon 'shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}' }
        'Help' { Get-StockIcon 79 }
        'Scripts' { Get-ResourceIcon (Join-Path $taskSystem32 'WindowsPowerShell\v1.0\powershell.exe') }
        'Keyboard' { Get-ResourceIcon (Join-Path $taskSystem32 'main.cpl') -200 }
        'Clock' { Get-ResourceIcon (Join-Path $taskSystem32 'timedate.cpl') -50 }
        'Network' { Get-StockIcon 17 }
        'Programs' { Get-StockIcon 82 }
        'Users' { Get-StockIcon 96 }
        'Profile' { Get-ShellIcon 'shell:Profile' }
        'Disk' { Get-StockIcon 8 }
        'Tools' { Get-ControlIcon 'Microsoft.AdministrativeTools' }
        'Security' { Get-StockIcon 77 }
        'System' { Get-StockIcon 94 }
        'Diagnostics' { Get-ResourceIcon (Join-Path $taskSystem32 'perfmon.exe') }
        'Settings' { Get-SettingsIcon }
        'Appearance' { Get-ControlIcon 'Microsoft.Personalization' }
        'Accessibility' { Get-ControlIcon 'Microsoft.EaseOfAccessCenter' }
    }
    if (-not $taskSelected -and $Kind -eq 'ControlPanel') { $taskSelected = Get-ResourceIcon (Join-Path $taskSystem32 'control.exe') }
    if (-not $taskSelected -and $Kind -eq 'Tools') { $taskSelected = Get-ResourceIcon (Join-Path $taskSystem32 'mycomput.dll') 2 }
    if (-not $taskSelected -and $Kind -eq 'Appearance') { $taskSelected = Get-StockIcon 72 }
    if (-not $taskSelected) { $taskSelected = Get-SettingsIcon }
    $taskSelected = Get-CheckedFolderIcon $taskSelected
    if (-not $taskSelected) { $taskSelected = Get-CheckedFolderIcon (Get-SettingsIcon) }
    if (-not $taskSelected) { throw 'No folder icon supporting small, large and extra large sizes was found.' }
    return $taskSelected
}

function Set-CollectionFolderStyle($Style) {
    $taskFolderPath = if ($Style.Path) { Join-Path $taskCollectionRoot $Style.Path } else { $taskCollectionRoot }
    if (-not (Test-Path -LiteralPath $taskFolderPath -PathType Container)) { return }
    $taskAncestor = Get-Item -LiteralPath $taskFolderPath -Force
    while ($taskAncestor) {
        if (($taskAncestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { return }
        if ($taskAncestor.FullName -eq $taskCollectionRoot) { break }
        $taskAncestor = $taskAncestor.Parent
    }
    $taskIni = Join-Path $taskFolderPath 'desktop.ini'
    if ((Test-Path -LiteralPath $taskIni) -and ((Get-Item -LiteralPath $taskIni -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)) { return }
    $taskIcon = Get-FolderIcon $Style.Icon
    $taskFolderIconPath = [IO.Path]::GetFullPath([Environment]::ExpandEnvironmentVariables($taskIcon.File))
    $taskIniText = "[.ShellClassInfo]`r`nConfirmFileOp=0`r`nIconResource=$taskFolderIconPath,$($taskIcon.Index)`r`nIconFile=$taskFolderIconPath`r`nIconIndex=$($taskIcon.Index)`r`nInfoTip=$($Style.Tip)`r`n`r`n[ViewState]`r`nFolderType=Videos`r`n"
    if ($PSCmdlet.ShouldProcess($taskFolderPath, ('Set folder icon and English tooltip: ' + $taskIcon.File + ',' + $taskIcon.Index))) {
        $taskEncoding = [Text.Encoding]::Unicode
        $taskIniBytes = [byte[]]($taskEncoding.GetPreamble() + $taskEncoding.GetBytes($taskIniText))
        $taskMode = if (Test-Path -LiteralPath $taskIni) { [IO.FileMode]::Open } else { [IO.FileMode]::CreateNew }
        $taskIniStream = [IO.File]::Open($taskIni, $taskMode, [IO.FileAccess]::Write, [IO.FileShare]::Read)
        try {
            $taskIniStream.Write($taskIniBytes, 0, $taskIniBytes.Length)
            $taskIniStream.SetLength($taskIniBytes.Length)
        } finally { $taskIniStream.Dispose() }
        [IO.File]::SetAttributes($taskIni, ([IO.File]::GetAttributes($taskIni) -bor [IO.FileAttributes]::Hidden -bor [IO.FileAttributes]::System))
        [IO.File]::SetAttributes($taskFolderPath, ([IO.File]::GetAttributes($taskFolderPath) -bor [IO.FileAttributes]::ReadOnly))
        if ($Style.Path -eq 'scripts') { [IO.File]::SetAttributes($taskFolderPath, ([IO.File]::GetAttributes($taskFolderPath) -bor [IO.FileAttributes]::Hidden)) }
        # Refresh cached folder attributes when desktop.ini is enabled for the first time.
        [WinShortcutIcons]::SHChangeNotify(0x800, 0x1005, $taskFolderPath, [IntPtr]::Zero)
        [WinShortcutIcons]::InvalidateFolderThumbnail($taskFolderPath)
        [WinShortcutIcons]::SHChangeNotify(0x2000, 0x1005, $taskFolderPath, [IntPtr]::Zero)
        [WinShortcutIcons]::SHChangeNotify(0x1000, 0x1005, $taskFolderPath, [IntPtr]::Zero)
        $script:taskFoldersUpdated++
    }
}

$taskFolders = New-Object 'System.Collections.Generic.Stack[string]'
$taskFolders.Push($taskCollectionRoot)
$taskShell = New-Object -ComObject WScript.Shell
$taskUpdated = 0
$taskFailed = 0
$taskChecked = 0
Write-Host ('Windows icons for CTRL-WIN: ' + $taskCollectionRoot)
while ($taskFolders.Count -gt 0) {
    foreach ($taskFile in Get-ChildItem -LiteralPath $taskFolders.Pop() -Force) {
        if (($taskFile.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { continue }
        if ($taskFile.PSIsContainer) { if ($taskFile.Name -ine '.git') { $taskFolders.Push($taskFile.FullName) }; continue }
        if ($FoldersOnly -or $taskFile.Extension -ine '.lnk') { continue }
        $taskChecked++
        try {
            $taskShortcut = $taskShell.CreateShortcut($taskFile.FullName)
            $taskIcon = Get-LinkIcon $taskFile $taskShortcut
            $taskOriginal = [IO.File]::ReadAllBytes($taskFile.FullName)
            $taskBytes = [WinShortcutIcons]::WithIcon($taskOriginal, $taskIcon.File, $taskIcon.Index)
            if ($PSCmdlet.ShouldProcess($taskFile.FullName, ('Set Windows icon: ' + $taskIcon.File + ',' + $taskIcon.Index))) {
                $taskStream = [IO.File]::Open($taskFile.FullName, [IO.FileMode]::Open, [IO.FileAccess]::Write, [IO.FileShare]::Read)
                try {
                    $taskStream.Write($taskBytes, 0, $taskBytes.Length)
                    $taskStream.SetLength($taskBytes.Length)
                } finally { $taskStream.Dispose() }
                [WinShortcutIcons]::SHChangeNotify(0x2000, 0x5, $taskFile.FullName, [IntPtr]::Zero)
                $taskUpdated++
            }
        } catch {
            $taskFailed++
            Write-Warning ($taskFile.Name + ': ' + $_.Exception.Message)
        }
    }
}
$taskFoldersUpdated = 0
foreach ($taskStyle in $taskFolderStyles) {
    try { Set-CollectionFolderStyle $taskStyle }
    catch {
        $taskFailed++
        Write-Warning ('Folder ' + $taskStyle.Path + ': ' + $_.Exception.Message)
    }
}
Write-Host ('Shortcuts checked: ' + $taskChecked + '; updated: ' + $taskUpdated + '; folders updated: ' + $taskFoldersUpdated + '; Errors: ' + $taskFailed)
if (($taskUpdated -gt 0 -or $taskFoldersUpdated -gt 0) -and $PSCmdlet.ShouldProcess('Windows Explorer', 'Refresh icon and thumbnail caches')) {
    [WinShortcutIcons]::RefreshIconCache()
    Write-Host 'Icon and thumbnail caches refreshed; folder resources checked at 16, 32, 48, 96 and 256 pixels.'
}
if ($taskFailed -gt 0) { exit 1 }
if ($WhatIfPreference) { Write-Host 'Preview complete. No files were changed.' }
else { Write-Host 'Done. Refresh or reopen collection windows if needed.' }
