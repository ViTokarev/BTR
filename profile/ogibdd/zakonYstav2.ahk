; Справка: Устав страница 2 (держать альт)
Hotkey, %keyzakonYstav2%, zakonYstav2
return

zakonYstav2: ; ВАЖНО Эту строку И ВЫШЕ не трогать
FileRead, tempfile, %A_AppData%\Malinovka\help_menu\help_zakon_ustav2.txt
  Gui Add, Text,, % tempfile
  BlockInput on
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