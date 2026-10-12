#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
param()

$ErrorActionPreference = 'Stop'
if ((Split-Path -Leaf $PSScriptRoot) -ine 'scripts') {
    throw 'Keep this script in the scripts subfolder of the collection.'
}
$taskCollectionRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))

if (-not ('WinShortcutFolderViews' -as [type])) {
    Add-Type @'
using System;
using System.Runtime.InteropServices;

public static class WinShortcutFolderViews {
    [ComImport, Guid("55272A00-42CB-11CE-8135-00AA004BB851"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    interface IPropertyBag {
        [PreserveSig] int Read([MarshalAs(UnmanagedType.LPWStr)] string name, [In, Out, MarshalAs(UnmanagedType.Struct)] ref object value, IntPtr errorLog);
        [PreserveSig] int Write([MarshalAs(UnmanagedType.LPWStr)] string name, [In, MarshalAs(UnmanagedType.Struct)] ref object value);
    }
    [DllImport("shell32.dll", CharSet=CharSet.Unicode)]
    static extern int SHParseDisplayName(string name, IntPtr bind, out IntPtr pidl, uint attrs, out uint outAttrs);
    [DllImport("shlwapi.dll", CharSet=CharSet.Unicode, ExactSpelling=true)]
    static extern int SHGetViewStatePropertyBag(IntPtr pidl, string bagName, uint flags, ref Guid iid, [MarshalAs(UnmanagedType.Interface)] out IPropertyBag bag);
    [DllImport("shell32.dll", CharSet=CharSet.Unicode)]
    static extern void SHChangeNotify(uint eventId, uint flags, string item1, IntPtr item2);

    static readonly string[] Bags = new string[] {
        "Shell",
        "Shell\\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}",
        "Shell\\{7D49D726-3C21-4F05-99AA-FDC2C9474656}",
        "Shell\\{B3690E58-E961-423B-B687-386EBFD83239}",
        "Shell\\{94D6DDCC-4A68-4175-A374-BD584A510B78}",
        "Shell\\{5FA96407-7E77-483C-AC93-691D05850DE8}",
        "Shell\\{885A186E-A440-4ADA-812B-DB871B942259}"
    };
    static readonly string[] Names = new string[] { "Mode", "LogicalViewMode", "IconSize" };
    static readonly int[] Values = new int[] { 1, 3, 256 };

    static void CheckHr(int hr, string operation) {
        if (hr < 0) throw new COMException(operation + " (HRESULT 0x" + hr.ToString("X8") + ").", hr);
    }

    static IPropertyBag Open(IntPtr pidl, string name) {
        Guid iid = typeof(IPropertyBag).GUID;
        IPropertyBag bag;
        CheckHr(SHGetViewStatePropertyBag(pidl, name, 0x80000005u, ref iid, out bag), "Open folder view storage: " + name);
        return bag;
    }
    public static bool Check(string path) { return Process(path, false); }
    public static void Set(string path) {
        Process(path, true);
        if (!Check(path)) throw new InvalidOperationException("The folder view was not fully saved.");
        SHChangeNotify(0x1000, 0x5, path, IntPtr.Zero);
    }
    static bool Process(string path, bool write) {
        IntPtr pidl; uint attrs;
        CheckHr(SHParseDisplayName(path, IntPtr.Zero, out pidl, 0, out attrs), "Resolve folder");
        try {
            foreach (string name in Bags) {
                IPropertyBag bag = Open(pidl, name);
                try {
                    if (name == "Shell") {
                        object type = "Videos";
                        if (write) CheckHr(bag.Write("FolderType", ref type), "Save folder template");
                        else {
                            type = null;
                            if (bag.Read("FolderType", ref type, IntPtr.Zero) < 0 || !String.Equals(Convert.ToString(type).Split('\0')[0], "Videos", StringComparison.Ordinal)) return false;
                        }
                    }
                    for (int i = 0; i < Names.Length; i++) {
                        object value;
                        if (write) {
                            value = Values[i];
                            CheckHr(bag.Write(Names[i], ref value), "Save view: " + name + " / " + Names[i]);
                        } else {
                            value = null;
                            if (bag.Read(Names[i], ref value, IntPtr.Zero) < 0 || value == null || Convert.ToUInt32(value) != Values[i]) return false;
                        }
                    }
                } finally { Marshal.ReleaseComObject(bag); }
            }
            return true;
        } finally { Marshal.FreeCoTaskMem(pidl); }
    }

    [ComImport, Guid("6D5140C1-7436-11CE-8034-00AA006009FA"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    interface IServiceProvider {
        [PreserveSig] int QueryService(ref Guid service, ref Guid iid, out IntPtr result);
    }
    [UnmanagedFunctionPointer(CallingConvention.StdCall)]
    delegate int QueryView(IntPtr self, out IntPtr view);
    [UnmanagedFunctionPointer(CallingConvention.StdCall)]
    delegate int SetViewSize(IntPtr self, uint mode, int size);
    [UnmanagedFunctionPointer(CallingConvention.StdCall)]
    delegate int GetViewSize(IntPtr self, out uint mode, out int size);

    static T Method<T>(IntPtr instance, int slot) where T : class {
        IntPtr vtable = Marshal.ReadIntPtr(instance);
        return Marshal.GetDelegateForFunctionPointer(Marshal.ReadIntPtr(vtable, slot * IntPtr.Size), typeof(T)) as T;
    }
    public static string OpenView(object window, bool write) {
        IntPtr browser = IntPtr.Zero, view = IntPtr.Zero, folderView = IntPtr.Zero;
        try {
            Guid service = new Guid("4C96BE40-915C-11CF-99D3-00AA004AE837");
            Guid browserId = new Guid("000214E2-0000-0000-C000-000000000046");
            CheckHr(((IServiceProvider)window).QueryService(ref service, ref browserId, out browser), "Resolve Explorer window");
            CheckHr(Method<QueryView>(browser, 15)(browser, out view), "Read active folder view");
            Guid folderViewId = new Guid("1AF3A467-214F-4298-908E-06B03E0B39F9");
            CheckHr(Marshal.QueryInterface(view, ref folderViewId, out folderView), "Open IFolderView2");
            if (write) CheckHr(Method<SetViewSize>(folderView, 35)(folderView, 1, 256), "Set open view to extra large icons");
            uint mode; int size;
            CheckHr(Method<GetViewSize>(folderView, 36)(folderView, out mode, out size), "Verify open folder view");
            if (write && (mode != 1 || size != 256)) throw new InvalidOperationException("The open view did not accept the icon size.");
            return "Mode=" + mode + "; IconSize=" + size;
        } finally {
            if (folderView != IntPtr.Zero) Marshal.Release(folderView);
            if (view != IntPtr.Zero) Marshal.Release(view);
            if (browser != IntPtr.Zero) Marshal.Release(browser);
        }
    }
}
'@
}

$taskFolders = New-Object 'System.Collections.Generic.Stack[string]'
$taskFolders.Push($taskCollectionRoot)
$taskUpdated = 0
$taskFailed = 0
Write-Host ('Extra large Explorer icons for: ' + $taskCollectionRoot)
while ($taskFolders.Count -gt 0) {
    $taskPath = $taskFolders.Pop()
    try {
        $taskFolder = Get-Item -LiteralPath $taskPath -Force
        if (($taskFolder.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { continue }
        foreach ($taskChild in Get-ChildItem -LiteralPath $taskPath -Directory -Force) {
            if ($taskChild.Name -ine '.git' -and ($taskChild.Attributes -band [IO.FileAttributes]::ReparsePoint) -eq 0) { $taskFolders.Push($taskChild.FullName) }
        }
        if ($PSCmdlet.ShouldProcess($taskPath, 'Set this folder to the Videos template and 256-pixel icons')) {
            [WinShortcutFolderViews]::Set($taskPath)
            $taskUpdated++
        }
    } catch {
        $taskFailed++
        Write-Warning ($taskPath + ': ' + $_.Exception.Message)
    }
}
Write-Host ('Folder views saved and verified: ' + $taskUpdated + '; Errors: ' + $taskFailed)
if (-not $WhatIfPreference) {
    try {
        $taskExplorer = New-Object -ComObject Shell.Application
        $taskRootPrefix = $taskCollectionRoot.TrimEnd('\') + '\'
        foreach ($taskWindow in $taskExplorer.Windows()) {
            try { $taskOpenPath = [IO.Path]::GetFullPath($taskWindow.Document.Folder.Self.Path).TrimEnd('\') }
            catch { continue }
            if ($taskOpenPath -ine $taskCollectionRoot -and -not $taskOpenPath.StartsWith($taskRootPrefix, [StringComparison]::OrdinalIgnoreCase)) { continue }
            if (($taskOpenPath -split '\\') -contains '.git') { continue }
            if ($PSCmdlet.ShouldProcess($taskOpenPath, 'Set open Explorer window to 256-pixel icons')) {
                try {
                    $taskResult = [WinShortcutFolderViews]::OpenView($taskWindow, $true)
                    $taskWindow.Refresh()
                    Write-Host ('Open view updated: ' + $taskOpenPath + '; ' + $taskResult)
                } catch {
                    $taskFailed++
                    Write-Warning ('Open view: ' + $_.Exception.Message + ' Close collection windows and run setup again.')
                }
            }
        }
    } catch {
        Write-Warning ('Could not update open Explorer windows. Close collection windows and run setup again. ' + $_.Exception.Message)
    }
}
if ($taskFailed -gt 0) { exit 1 }
if ($WhatIfPreference) { Write-Host 'Preview complete. No views were changed.' }
else { Write-Host 'Done. Collection views have been saved; refresh or reopen windows if needed.' }
