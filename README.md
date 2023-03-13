# SerchWindowsHotkey
WindowsのHotkeyを探すWindows PowerShellのプログラムです。Win32APIである[RegisterHotkey](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-registerhotkey "RegisterHotKey function (winuser.h)")を使って、登録できないホットキーの組み合わせを探します。残念ながら、このプログラムでは、キーの組合せがホットキーとして使えるかどうかしか判定できません。ホットキーを登録しているプログラムを調べることはできません。しかし、ホットキーを登録するとき、空いているキーの組合せを知ることは可能です。
なお、このプログラムで判定可能なのは、Windowsのグローバルホットキーのみで、アプリケーションが定義するキーボードショートカットは含まれません。たとえば、ウィンドウの一覧を表示する`Alt+Tab`はホットキーですが、クリップボードの貼り付けを行なう`Ctrl+C`は、アプリケーションやコントロールのキーボードショートカットです。
Windowsが定義するホットキーとキーボードショートカットについては、[Windows のキーボード ショートカット](https://support.microsoft.com/ja-jp/windows/windows-%E3%81%AE%E3%82%AD%E3%83%BC%E3%83%9C%E3%83%BC%E3%83%89-%E3%82%B7%E3%83%A7%E3%83%BC%E3%83%88%E3%82%AB%E3%83%83%E3%83%88-dcc61a57-8ff0-cffe-9796-cb9706c75eec)で見ることができます。
# Execution / 実行
"searchhotkeys.ps1"を実行してください。
出力はCSV形式でテキストとして標準出力に出ます。最初の欄は、Windowsの仮想キーコードを示します。仮想キーコードに関しては、[仮想キーコード](https://learn.microsoft.com/ja-jp/windows/win32/inputdev/virtual-key-codes?source=recommendations)を参照してください。

２つめの欄は、[Windows.Forms.KeysConverter](https://learn.microsoft.com/ja-jp/dotnet/api/system.windows.forms.keysconverter?view=windowsdesktop-7.0)を使ったKeyNameです。

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

# 参考ファイル
参考のため、searchhotkeys.ps1が出力したCSVファイル（W11ver22H2Hotkey.csv）と、それを読み込んで加工したExcelのブックファイル（Hotkey.xlsx）もアップロードしてあります。

