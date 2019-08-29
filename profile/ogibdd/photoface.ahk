; Фоторобот, проверка человека
Hotkey, %keyphotoface%, photoface
return

photoface: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInput,{F6}/me достал фоторобот из небольшой папки в кармане{Enter}
  Sleep 1000
  SendInput,{F6}/me сравнил лицо на изображении с лицом человека рядом{Enter}
  Sleep 1000
  SendInput,{F6}/do Лицо на изображении совпадает с лицом человеком рядом{Enter}
Return