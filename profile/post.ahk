; Шлагбаум
Hotkey, %keypost%, post
return

post: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInput {F6}/do Пульт управления шлагбаумом в кармане.{Enter}
  Sleep 250
  SendInput {F6}/me протянул руку в карман, достал пульт управления шлагбаумом. {enter}
  Sleep 250
  SendInput {F6}/do Пульту управления в руке.{Enter}
  Sleep 250
  SendInput {F6}/me нажал на кнопку на пульте управления шлагбаумом.{Enter}
  Sleep 250
  SendInput {F6}/do Шлагбаум активирован.{Enter}
  Sleep 100
  Sendinput,{F6}/post{Enter}
Return