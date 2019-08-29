; Дать денег
Hotkey, %keypay%, pay
return

pay: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/pay{space}
Return