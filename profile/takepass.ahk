; Взял паспорт у человека на проверку по базе МВД
Hotkey, %keytakepass%, takepass
return

takepass: ; ВАЖНО Эту строку И ВЫШЕ не трогать
SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/me взял у человека паспорт.{Enter}
  Sleep 750
  Sendinput,{F6}/do Паспорт в руке.{Enter}
  Sleep 500
  Sendinput,{F6}/me листает страницы паспорта, изучая документ.{Enter}
  Sleep 750
  Sendinput,{F6}/yes{Enter}
  Sleep 500
  SendInput, {F6}/do Служебный КПК в кармане.{enter}
  sleep 750
  SendInput, {F6}/me взял КПК в руку и включил.{enter}
  sleep 500
  SendInput, {F6}/me ввел данные гражданина в поиск по базе "МО МВД".{Enter}
  Sleep 750
  SendInput, {F6}/do Процесс...{Enter}
  Sleep 500
  SendInput, {F6}/do Получил информацию.{Enter}
  Sleep 750
  SendInput, {F6}/me выключил КПК и убрал в карман.{Enter}
  Sleep 500
  Sendinput,{F6}/me закрыл паспорт.{Enter}
  Sleep 750
  SendInput, {F6}/do Паспорт в руке.{enter}
  Sleep 500
  Sendinput,{F6}/me вернул паспорт владельцу.{Enter}
Return