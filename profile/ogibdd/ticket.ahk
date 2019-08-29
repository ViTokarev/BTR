; Выписать штраф и дать водителю (водитель не обязан подписывать)
Hotkey, %keyticket%, ticket
return

ticket: ; ВАЖНО Эту строку И ВЫШЕ не трогать
SendMessage, 0x50,, 0x4190419,, A
Sendinput, {F6}/me достал бланк постановления о нарушении и ручку из нагрудного кармана{ENTER}
Sleep, 1500
Sendinput, {F6}/do Заполняет бланк...{ENTER}
Sleep, 2500
Sendinput, {F6}/me заполнил бланк постановления и передал его человеку{ENTER}
Sleep, 500
Sendinput, {F6}/ticket{space}
Return