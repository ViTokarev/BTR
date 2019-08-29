; Надеть наручники
Hotkey, %keycuff%, cuff
return

cuff: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/me отцепил наручники от крепления на поясе и взял их в правую руку.{enter}
  sleep 500
  SendInput, {F6}/cuff {space}
Return