; Использовать аптечку
Hotkey, %keyhealme%, healme
return

healme: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/do Аптечка висит на ремне.{Enter} 
  Sleep 500
  SendInput, {F6}/me достает из аптечки шприц и вкалывает себе адреналин{Enter} 
  Sleep 500
  Sendinput,{F6}/healme{enter}
Return