# Search Hotkeys
# Copyright 2022,Shinji Shioda
# CSV Output Version
#

# C# Win32API Define in PowerShell String
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
# Add-Type C# code in $src
try { Add-Type $src } catch {}
# Add-Type System.Windows.Forms for KeysConverter class
add-type -AssemblyName System.Windows.Forms
# Define Modifirers & it's combination
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
# Define VKey code for searching
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

# Prepare KeysConverter
$kc= New-Object Windows.Forms.KeysConverter;

# Prepare Output string var.
$outstring=""

# Output CSV Header Line
foreach( $M in $Modkeys.GetEnumerator() ) {
    #Write-Host -NoNewline ("{0,11}" -f $M.Key)
   $outstring +='"'+$M.Key+'",'
}
Write-Output ('"Code","KeyName",'+$outstring)

# Main Loop VKey Code - Modifiers
$Vkey.foreach{          # Loop for VKeys
    # build $output strings
    $outstring=""+$_+',"'+ $kc.ConvertToString($_)+'",'
    
        # Inner Loop All Modifier combination
        foreach( $M in $Modkeys.GetEnumerator() ) {             # Loop for Modifiers
            # Try RegisterHotkey Function
            $r=[Hotkey]::RegisterHotKey(0,1,$M.Value,([int32]$_));
            
            # Check Result. Result of RegisterHotkey is Not Zero?
            if($r -ne 0) { 
                # Yes! RegisterHotkey success. Accumrate to $outstring VAR.
                $outstring+='1,'
                
                # Unregister Hotkey
                $r2=[Hotkey]::UnregisterHotKey(0,1);
            } else {
                # No! RegisterHotkey Fail. Accumrate to $outstring VAR.
                $outstring+="0,"
            }   # End if block
        }   # Modifier Foreach statement
        
    # Output Current VKey's result
    Write-Output $outstring;
} # Foreach Method VKey
