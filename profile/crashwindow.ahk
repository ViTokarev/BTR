; Разбить окно и вытащить человека из машины
Hotkey, %keycrashwindow%, crashwindow
return

crashwindow: ; ВАЖНО Эту строку И ВЫШЕ не трогать
SendMessage, 0x50,, 0x4190419,, A 
  Sendinput,{F6}/me Резким движением разбил стекло машины {Enter} 
  Sleep 1500
  Sendinput,{F6}/do Стекло разбито {Enter} 
  Sleep 1500 
  Sendinput,{F6}/me открыл дверь, вытащил человека из машины и заломал руку{Enter} 
  Sleep 1500 
  Sendinput,{F6}/do Водитель обезврежен.{Enter} ; это обязательно, чтобы водитель не /me встал и сел обратно в машину
  Sleep 1500 
  Sendinput,{F6}/b Покиньте транспорт. Если это не выполнить, будет считаться уход от РП. (ORP)
Return
