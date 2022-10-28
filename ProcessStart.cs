using System;
using System.Diagnostics;

using System.Threading;



namespace ProcessStart
{
    static class Program
    {
        [STAThread]
        static void Main()
        {
            string m = "powershell";
            Process ProcessShell = new Process
            {

                StartInfo = new ProcessStartInfo(m)
                {
                    UseShellExecute = false,
                    CreateNoWindow = true,
                    RedirectStandardInput = true,
                    //RedirectStandardOutput = true,

                }
            };
            ProcessShell.Start();
            Thread.Sleep(3000);
            ProcessShell.StandardInput.WriteLine("calc.exe");
            Environment.Exit(0);

        }
    }
}
