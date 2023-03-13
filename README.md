# SerchWindowsHotkey
WindowsのHotkeyを探すWindows PowerShellのプログラムです。Win32APIである[RegisterHotkey](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-registerhotkey "RegisterHotKey function (winuser.h)")を使って、登録できないホットキーの組み合わせを探します。
# Execution / 実行
"searchhotkeys.ps1"を実行してください。
Windows PowerShellで実行するとKeyNameは英語になりますが、PowerShellで実行した場合、日本語版Windowsでは一部日本語が混ざります。
これは.NETのWindows.Fromsの問題で、PowerShellからは解決できません。.NETのアップデートを待つしかありません。

参考

[Runtime crash due to localization and the way designer serializes keyboard shortcuts · Issue #2886 · dotnet/winforms](https://github.com/dotnet/winforms/issues/2886)

[Don't translate Home, Backspace, End and Enter keys in KeysConverter for Japanese. · Issue #8440 · dotnet/winforms](https://github.com/dotnet/winforms/issues/8440)

# Output / 出力
出力はCSV形式でテキストとして標準出力に出ます。ファイルに保存するならリダイレトを使ってください。

例

    .\searchHotKey.ps1 | Out-File -Encoding utf8 c:\temp\W11ver22H2Hotkey.csv
