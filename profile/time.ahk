; Очень полезная штука
Hotkey, %keytime%, time
return

time: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/time{Enter}
Return