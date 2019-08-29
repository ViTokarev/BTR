; Снять наручники
Hotkey, %keyuncuff%, uncuff
return

uncuff: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/me вытащил из нагрудного кармана ключ от наручников{enter}
  sleep 500
  SendInput, {F6}/do Ключ в руке.{enter}
  sleep 500
  SendInput, {F6}/me вставил ключ в наручники задержанногго{enter}
  SendInput, {F6}/uncuff {space}
Return