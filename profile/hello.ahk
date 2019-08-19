; Воинское приветсвие
Hotkey, %keyhello%, hello
return

hello: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInPut, {F6}Здравия желаю{!}{Enter}
  Sleep 1500
  SendInPut, {F6}/me выполнил воинское приветствие.{Enter}
Return