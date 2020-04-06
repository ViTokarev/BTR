sobecdoc: ; ВАЖНО Эту строку И ВЫШЕ не трогать

SendMessage, 0x50,, 0x4190419,, A 
Sendinput, {F6}Хорошо, передайте мне ваши документы, а именно: паспорт, диплом, мед.карта.{Enter} 
Sleep 1000
Sendinput, {F6}/n /pass /lic /card . Фулл РП {Enter} 
Return