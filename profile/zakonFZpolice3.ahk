; Справка: ФЗ о полиции страница 3 (держать альт)
Hotkey, %keyzakonFZpolice3%, zakonFZpolice3
return

zakonFZpolice3: ; ВАЖНО Эту строку И ВЫШЕ не трогать
FileRead, tempfile, %A_AppData%\Malinovka\help_menu\help_zakon_fzp3.txt
  Gui Add, Text,, % tempfile
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  KeyWait LAlt
  Send,{F6}
  Send,{F6}
  Gui, Show, Hide
  BlockInput off
  Gui, Destroy
Return