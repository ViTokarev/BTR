order1: ; ВАЖНО Эту строку И ВЫШЕ не трогать

SendMessage, 0x50,, 0x4190419,, A  
Sleep, 250
Sendinput,{F6}/me достал бланк "Заявление" из шкафчика {Enter} 
Sleep 3000 
Sendinput,{F6}/do Заявление в руке. {Enter} 
Sleep 3000
Sendinput,{F6}/me взял ручку с гравировкой "МВД" {Enter} 
Sleep 3000 
Sendinput,{F6}/do Ручка в руке. {Enter} 
Sleep 3000 
Sendinput,{F6}/me передал человеку напротив {Enter}
Return