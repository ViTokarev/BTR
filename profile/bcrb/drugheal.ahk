drugheal: ; ВАЖНО Эту строку И ВЫШЕ не трогать

SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}Здравствуйте, я "Нарколог" %names%.{Enter}
Sleep 1000
SendInput,{F6}/do На груди бейджик "Нарколог - %names%" Батыревской Центральной Районной Больницы.{Enter}
Sleep 1000
SendInput,{F6}Чем могу Вам помочь?{Enter}
Return