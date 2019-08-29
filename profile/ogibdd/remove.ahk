; Изъял запрещенные предметы
Hotkey, %keyremove%, remove
return

remove: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/me закончил обыск и изъял у человека найденные запрещенные предметы{Enter}
  Sleep 1500
  Sendinput,{F6}/do Запрещенные предметы в руке.{Enter}
  Sleep 1500
  Sendinput,{F6}/me поместил предметы в прозрачный пластиковый пакет{Enter}
  Sleep 1500
  Sendinput,{F6}/do Предметы в пакете.{Enter}
  Sleep 1500
  Sendinput,{F6}/me убрал пакет в карман.{Enter}
  Sendinput,{F6}/remove{Space}
Return