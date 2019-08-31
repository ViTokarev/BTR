order3: ; ВАЖНО Эту строку И ВЫШЕ не трогать

SendMessage, 0x50,, 0x4190419,, A 
Sleep, 250
Sendinput, {F6}/yes{Enter} 
Sleep 1000
Sendinput, {F6}/me резким движением руки взял паспорт{Enter} 
Sleep 1000
Sendinput, {F6}/do Паспорт в руке.{Enter} 
Sleep 1000 
Sendinput, {F6}/me открыл паспорт на второй странице{Enter} 
sleep, 1000 
Sendinput, {F6}/do Паспорт открыт. {Enter} 
sleep, 1000 
Sendinput, {F6}/me начал изучать информацию в паспорте{Enter} 
sleep, 1000 
Sendinput, {F6}/do Процесс... {Enter} 
sleep, 1000 
Sendinput, {F6}/me изучил информацию в паспорте {Enter} 
sleep, 1000 
Sendinput, {F6}/todo Заберите Ваш паспорт, пожалуйста.*передавая паспорт гражданину{Enter} 
Return