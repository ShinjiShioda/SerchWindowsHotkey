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
    SHIFT=0x004;
    ALT_CTRL=0x0001+0x0002;
    ALT_SHIFT=0x0001+0x0004; 
    CTRL_SHIFT=0x0002+0x0004;
    ALT_CTRL_SHIFT=0x0001+0x0002+0x0004;
    WIN=0x0008; 
    WIN_ALT=0x0008+0x0001; 
    WIN_CTRL=0x0008+0x0002;
    WIN_SHIFT=0x0008+0x0004;
    WIN_ALT_CTRL=0x0008+0x0001+0x0002;
    WIN_ALT_SHIFT=0x0008+0x0004+0x0001; 
    WIN_CTRL_SHIFT=0x0008+0x0004+0x0002;
    WIN_ALT_CTRL_SHIFT=0x0008+0x0001+0x0002+0x0004;
}
$Vkey=8,9,0x0d
$VKey+=0x13..0x15
$VKey+=0x1b..0x1d
$VKey+=0x20..0x2f
# $Vkey+=0x5D         # Apps
# $Vkey+=0x5F         # Sleep
# $Vkey+=0xE5         # Processキー
$Vkey+=0x70..0x87   # Fキー
$Vkey+=0x90..0x91   # Numlock、Scroll
# 英数字（文字キー）
$Vkey+=0x30..0x39   # 0～9
$Vkey+=0x41..0x5A   # A～Z
$Vkey+=0xBA..0xC0   # OEM_1～OEM_3
$Vkey+=0xDB..0xDF   # OEM_4～OEM_8
$Vkey+=0xE2         # OEM_102
$Vkey+=0x60..0x6F   # テンキー
$kc= New-Object Windows.Forms.KeysConverter;
$CsvHeader='"Code","KeyName",'
foreach( $M in $Modkeys.GetEnumerator() ) {
   $CsvHeader+='"'+($M.Key -replace '_','+') +'",'
}
$OutArray=@()
$Vkey.foreach{
    $tempObj=[PSCustomObject]@{code="0x"+[Convert]::toString($_,16); KeyName=$kc.ConvertToString($_)} 
    foreach( $M in $Modkeys.GetEnumerator() ) {
        $r=[Hotkey]::RegisterHotKey(0,1,$M.Value,([int32]$_));
        $v="X"
        if($r -ne 0) { # Success register
            $v=""
            [void][Hotkey]::UnregisterHotKey(0,1); # Unregister 
        } 
        $tempObj | Add-Member -MemberType NoteProperty -Name $M.Name -Value $v
    } 
    $OutArray +=$tempobj; 
}
$CsvHeader
$OutArray | ConvertTo-Csv | select -skip 1
