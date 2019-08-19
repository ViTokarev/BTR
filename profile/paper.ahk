; Справка: пока пуста
Hotkey, %keypaper%, paper
return

paper: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  Gui Add, Text,,
  (
    Что-то ещё
  )
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