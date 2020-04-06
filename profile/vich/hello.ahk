hello: ; ВАЖНО Эту строку И ВЫШЕ не трогать

SendMessage, 0x50,, 0x4190419,, A
SendInput {F6}Здравствуйте, я %rang% Мэрии - %names%.{Enter}
Sleep 1600
SendInput {F6}/do Бейджик сотрудника Мэрии висит на груди.{Enter}
Sleep 3000
SendInput {F6}Могу ли я Вам чем-нибудь помочь?{Enter}
Return
