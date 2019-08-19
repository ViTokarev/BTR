; КПЗ передал в тюрму (арестовал)

arrest: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/do Служебный КПК в кармане.{enter}
  sleep 500
  SendInput, {F6}/me взял КПК в руку и включил{enter}
  sleep 1000
  SendInput, {F6}/me ввел данные о преступнике{Enter}
  Sleep 1000
  SendInput, {F6}/me выключил КПК и убрал в карман{Enter}
  Sleep 1000
  SendInput, {F6}/me передал преступника в участок{Enter}
  SendInput, {F6}/arrest{Space}
Return
