givechest: ; ВАЖНО Эту строку И ВЫШЕ не трогать

SendMessage, 0x50,, 0x4190419,, A 
SendInput, {F6}/me достал комплект для оказания первой помощи {enter} 
sleep 500 
SendInput, {F6}/me взял мини-аптечку индивидуального пользования {enter} 
sleep 500 
SendInput, {F6}/do Аптечка находится в правой руке.{enter} 
sleep 500 
SendInput, {F6}/me передал аптечку человеку напротив.{enter} 
sleep 500 
SendInput, {F6}/b бери аптечку, затем пропиши /healme иначе это NoneRP. {enter} 
sleep 500 
SendInput, {F6}/givechest{space} 
Return