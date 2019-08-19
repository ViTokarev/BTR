; Выкинуть из машины
Hotkey, %keyeject%, eject
return

eject: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/eject{space}
Return