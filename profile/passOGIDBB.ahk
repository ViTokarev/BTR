; Речь/удостоверение
Hotkey, %keypassOGIDBB%, passOGIDBB
return

passOGIDBB: ; ВАЖНО Эту строку И ВЫШЕ не трогать
SendMessage, 0x50,, 0x4190419,, A
Sendinput,{F6}Здравия желаю. Виталик Токарев, инспектор ДПС ОГИБДД по Н.О.{ENTER}  
Sleep 1000
SendInput, {F6}/do Значок сотрудника «ДПС» на груди.{Enter}
Sleep 1000
SendInput, {F6}/me показал гражданину служебное удостоверение «МВД РОССИИ» в открытом виде.{Enter}
Sleep 1000
SendInput, {F6}/do ОГИБДД по НО | инспектор ДПС ОГИБДД | Полковник {Enter} 
Return
