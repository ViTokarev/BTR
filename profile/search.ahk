; Обыскать человека
Hotkey, %keysearch%, search
return

search: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/me достал из набедренного кармана резиновые перчатки.{Enter}
  Sleep 1500
  Sendinput,{F6}/me надевает перчатки.{Enter}
  Sleep 1500
  Sendinput,{F6}/do Процесс...{Enter}
  Sleep 1500
  Sendinput,{F6}/me начал обыскивать человека напротив.{Enter}
  Sleep 1500
  Sendinput,{F6}/me ощупывает торс человека напротив. [1/3].{Enter}
  Sleep 1500
  Sendinput,{F6}/me обыскивает карманы человека напротив. [2/3].{Enter}
  Sleep 1500
  Sendinput,{F6}/me ощупывает ноги и руки человека напротив. [3/3].{Enter}
  Sendinput,{F6}/search{Space}
Return