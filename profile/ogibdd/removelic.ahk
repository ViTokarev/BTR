; Изъял водительское (с 5го ранга!)
Hotkey, %keyremovelic%, removelic
return

removelic: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/me забрал у человека водительские права{Enter}
  Sleep 1500
  Sendinput,{F6}/do Водительские права в руке.{Enter}
  Sleep 1500
  Sendinput,{F6}/me переписал данные в протокол{Enter}
  Sleep 1500
  Sendinput,{F6}/do Данные записаны в протокол.{Enter}
  Sendinput,{F6}/remove{Space}
Return