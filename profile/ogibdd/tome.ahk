; Заломал руку и повел за собой
Hotkey, %keytome%, tome
return

tome: ; ВАЖНО Эту строку И ВЫШЕ не трогать
SendMessage, 0x50,, 0x4190419,, A 
Sendinput, {F6}/me заломал руку и повёл задержанного за собой {Enter} 
sleep 500 
Sendinput, {F6}Если будет совершена попытка побега я буду вынужден применить табельное оружие! {Enter} 
sleep 1000 
Sendinput, {F6}/tome {space} 
Return