; Посадить задержанного в машину
Hotkey, %keyincar%, incar
return

incar: ; ВАЖНО Эту строку И ВЫШЕ не трогать
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/me взял преступника за руку{enter}
  sleep 500
  SendInput, {F6}/me повел преступника за собой{enter}
  sleep 500
  SendInput, {F6}/me открыл дверь машины и затолкал туда задержанного{enter}
  SendInput, {F6}/incar{space}
Return