; Выдать номера (c 5го ранга!)

givenumber: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/do Гос.номера и бланк учёта на стойке сзади.{Enter}
  Sleep 500
  SendInput, {F6}/me развернулся, взял гос. номера и бланк учета.{Enter}
  Sleep 2000
  SendInput, {F6}/do Бланк и гос. номера в руке.{Enter}
  Sleep 500
  SendInput, {F6}/me положил номера на стол, начал заполнять бланк учета.{Enter}
  Sleep 500
  SendInput, {F6}/do Заполняет...{Enter}
  Sleep 3000
  SendInput, {F6}/me заполнил бланк и передал гос. номера новому владельцу.{Enter}
  SendInput, {F6}/givenumber{Space}
Return
