; Список сотрудников
Hotkey, %keymembers%, members
return

members: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/members{enter}
Return