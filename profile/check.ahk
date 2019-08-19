; Проверить ремень безопасности
Hotkey, %keycheck%, check
return

check: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/check{space}
Return