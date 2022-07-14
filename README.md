# SerchWindowsHotkey
PowerShell Search Windows Hotkey program.Search Hotkeys use Win32APi [RegisterHotkey](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-registerhotkey "RegisterHotKey function (winuser.h)").

WindowsのHotkeyを探すWindows PowerShellのプログラムです。Win32APIである[RegisterHotkey](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-registerhotkey "RegisterHotKey function (winuser.h)")を使って、登録できないホットキーの組み合わせを探します。

# Execution / 実行
Execute "searchhotkeys.ps1"

"searchhotkeys.ps1"を実行してください
# Output / 出力
CSV format text output to console.If you want to save to file, please use redirection.

出力はCSV形式でテキストとして標準出力に出ます。ファイルに保存するならリダイレトを使ってください。
