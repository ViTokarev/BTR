; Взял документы на машину и проверил по базе
Hotkey, %keytakecarpass%, takecarpass
return

takecarpass: ; ВАЖНО Эту строку И ВЫШЕ не трогать
SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/me взял у человека ПТС.{Enter}
  Sleep 1500
  Sendinput,{F6}/do ПТС в руке.{Enter}
  Sleep 1500
  Sendinput,{F6}/me изучаяет информацию в документе.{Enter}
  Sleep 1500
  Sendinput,{F6}/yes{Enter}
  Sleep 1500
  SendInput, {F6}/do Служебный КПК в кармане.{enter}
  sleep 1500
  SendInput, {F6}/me взял КПК в руку и включил.{enter}
  sleep 1500
  SendInput, {F6}/me ввел данные ПТС в поиск по базе "МО МВД".{Enter}
  Sleep 2500
  SendInput, {F6}/do Процесс...{Enter}
  Sleep 3000
  SendInput, {F6}/do Получил информацию.{Enter}
  Sleep 1500
  SendInput, {F6}/me выключил КПК и убрал в карман.{Enter}
  Sleep 2000
  SendInput, {F6}/do ПТС в руке.{enter}
  Sleep 1500
  Sendinput,{F6}/me вернул ПТС владельцу.{Enter}
Return