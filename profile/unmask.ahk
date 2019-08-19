; Снять маску /unmask
Hotkey, %keyunmask%, unmask
return

unmask: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A 
  Sendinput,{F6}/me быстрым движением правой руки снял маску с человека {Enter} 
  Sleep 1500 
  Sendinput,{F6}/unmask{Enter} 
  Sleep 500 
  Sendinput,{F6}/do маска в руке{Enter} 
Return