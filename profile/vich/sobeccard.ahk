sobeccard: ; ВАЖНО Эту строку И ВЫШЕ не трогать

SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me взял мед.карту у человека напротив{enter}
Sleep 1500
SendInput, {F6}/me начал проверять мед.карту{enter}
Sleep 1500
SendInput, {F6}/do Документ проверен.{enter}
Sleep 1500
SendInput, {F6}/me вернул мед.карту человеку напротив{enter}
Sleep, 500 
Sendinput,{F6}/yes {ENTER}
Return