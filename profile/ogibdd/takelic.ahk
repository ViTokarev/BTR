; Взял водительское удостоверение и проверил
Hotkey, %keytakelic%, takelic
return

takelic: ; ВАЖНО Эту строку И ВЫШЕ не трогать
SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/me взял у человека водительское удостоверение.{Enter}
  Sleep 1500
  Sendinput,{F6}/do водительское удостоверение в руке.{Enter}
  Sleep 1500
  Sendinput,{F6}/me изучаяет информацию в документе.{Enter}
  Sleep 1500
  Sendinput,Sendinput,{F6}/yes{Enter}
  Sleep 1500
  Sendinput,{F6}/me анализирует полученную информацию.{Enter}
  Sleep 1500
  SendInput, {F6}/do водительское удостоверение в руке.{enter}
  Sleep 1500
  Sendinput,{F6}/me вернул водительское удостоверение владельцу.{Enter}
Return