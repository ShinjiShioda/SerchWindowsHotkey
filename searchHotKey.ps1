$src = '
using System;
using System.Runtime.InteropServices;
public static class Hotkey {
    [DllImport("user32.dll")]
    public extern static int RegisterHotKey(IntPtr hWnd, int id, int modKey, int key);
    [DllImport("user32.dll")]
    public extern static int UnregisterHotKey(IntPtr hWnd, int id);
}
'
try { Add-Type $src } catch {}
add-type -AssemblyName System.Windows.Forms
$ModKeys = [ordered]@{
    ALT=0x0001; 
    CTRL=0x0002; 
    SHIFT=0x0004; 
    ALT_CTRL=0x0001+0x0002;
    ALT_SHIFT=0x0001+0x0004; 
    CTRL_SHIFT=0x0002+0x0004;
    WIN=0x0008; 
    WIN_SHIFT=0x0008+0x0004;
    WIN_CTRL=0x0008+0x0002;
    WIN_ALT=0x0008+0x0001; 
    WIN_S_CTRL=0x0008+0x0004+0x0002;
    WIN_ALT_S=0x0008+0x0004+0x0001; 
    WIN_ALT_CL=0x0008+0x0001+0x0002;
    W_ALT_S_CL=0x0008+0x0001+0x0002+0x0004;
}
# $NoRepeat=0x4000;
$Vkey=8,9,0x0c,0x0d
$VKey+=0x13..0x39
$Vkey+=0x41..0x5A
$Vkey+=0x5D
$Vkey+=0x5F..0x87
$Vkey+=0x90..0x91
$Vkey+=0xBA..0xC0
$Vkey+=0xDB..0xDF
$Vkey+=0xE2,0xE5,0xE7
#$Vkey+=(0xE2..0xE7)
#$Vkey+=(0xE9..0xF5)
$kc= New-Object Windows.Forms.KeysConverter;
#Write-Host -NoNewline ("-"*19)
$outstring=""
foreach( $M in $Modkeys.GetEnumerator() ) {
    #Write-Host -NoNewline ("{0,11}" -f $M.Key)
   $outstring +='"'+$M.Key+'",'
}
Write-Output ('"Code","KeyName",'+$outstring)
$Vkey.foreach{
    #Write-Host -NoNewline  ("{0,3:X2} {1,-15}" -f $_, $kc.ConvertToString($_))
    $outstring=""+$_+',"'+ $kc.ConvertToString($_)+'",'
        foreach( $M in $Modkeys.GetEnumerator() ) {
            $r=[Hotkey]::RegisterHotKey(0,1,$M.Value,([int32]$_));
            if($r -ne 0) {
                #Write-Host -NoNewline  ("{0,11}" -f "◯");
                $outstring+='1,'
                $r2=[Hotkey]::UnregisterHotKey(0,1);
            } else {
                #Write-Host  -NoNewline ("{0,11}" -f "✖");
                $outstring+="0,"
            }
        }
    Write-Output $outstring;
}


