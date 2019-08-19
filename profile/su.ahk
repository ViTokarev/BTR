; дать розыск
Hotkey, %keysu%, su
return

su: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/do Служебный КПК в кармане.{enter}
  sleep 100
  SendInput, {F6}/me взял КПК в руку и включил{enter}
  sleep 1000
  SendInput, {F6}/me ввел данные о нарушителе в базу данных «МВД»{enter}
  SendInput, {F6}/su{space}
Return