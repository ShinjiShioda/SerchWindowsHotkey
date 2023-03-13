# SerchWindowsHotkey
WindowsのHotkeyを探すWindows PowerShellのプログラムです。Win32APIである[RegisterHotkey](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-registerhotkey "RegisterHotKey function (winuser.h)")を使って、登録できないホットキーの組み合わせを探します。
# Execution / 実行
"searchhotkeys.ps1"を実行してください。
出力はCSV形式でテキストとして標準出力に出ます。最初の欄は、Windowsの仮想キーコード、２つめの欄は、[Windows.Forms.KeysConverter](https://learn.microsoft.com/ja-jp/dotnet/api/system.windows.forms.keysconverter?view=windowsdesktop-7.0)を使ったKeyNameです。

３つめ以降は、修飾キーとキーの組合せがホットキーとして登録されているかどうかを示します。“X”になっている組合せはホットキーとして登録されています。

Windows PowerShellで実行するとKeyNameは英語になりますが、PowerShellで実行した場合、日本語版Windowsでは一部日本語が混ざります。
これは.NETのWindows.Fromsの問題で、PowerShellからは解決できません。.NETのアップデートを待つしかありません。

**参考**

[Runtime crash due to localization and the way designer serializes keyboard shortcuts · Issue #2886 · dotnet/winforms](https://github.com/dotnet/winforms/issues/2886)

[Don't translate Home, Backspace, End and Enter keys in KeysConverter for Japanese. · Issue #8440 · dotnet/winforms](https://github.com/dotnet/winforms/issues/8440)

# Output / 出力

ファイルに保存するならリダイレトや`Out-File`を使ってください。

例

    .\searchHotKey.ps1 | Out-File -Encoding utf8 c:\temp\W11ver22H2Hotkey.csv
