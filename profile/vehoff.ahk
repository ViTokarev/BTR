; Блокировка двигателя (нужно сидеть на пасажирском в полиц машине)

vehoff: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/do Ноутбук на торпеде автомобиля.{Enter}
  Sleep 1000
  Sendinput,{F6}/me Запустил в компьютере программу блокировки двигателя.{Enter}
  Sleep 1000
  Sendinput,{F6}/do Соединение с системой ГЛОНАСС.{Enter}
  Sleep 1000
  Sendinput,{F6}/me ввел данные преследуемого Т/С и выбрал "блокировка двигателя".{Enter}
  Sleep 1000
  Sendinput,{F6}/do Процесс...{Enter}
  Sleep 250
  SendInPut, {F6}/vehoff{space}
  KeyWait, Enter, D
  Sendinput,{F6}/do Попытка блокировки двигателя.{Enter}
Return
