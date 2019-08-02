; ###VERSION:0.9###
; тестовая сборка

Phelp_help = %APPDATA%\Malinovka\help_menu\help_help.txt
Phelp_hotkey = %APPDATA%\Malinovka\help_menu\help_hotkey.txt
Phelp_zakon_kirminal = %APPDATA%\Malinovka\help_menu\help_zakon_kirminal.txt
Phelp_zakon_koap = %APPDATA%\Malinovka\help_menu\help_zakon_koap.txt
Phelp_zakon_ustav = %APPDATA%\Malinovka\help_menu\help_zakon_ustav.txt
Phelp_zakon_ustav2 = %APPDATA%\Malinovka\help_menu\help_zakon_ustav2.txt
Phelp_zakon_fzp1 = %APPDATA%\Malinovka\help_menu\help_zakon_fzp1.txt
Phelp_zakon_fzp2 = %APPDATA%\Malinovka\help_menu\help_zakon_fzp2.txt
Phelp_zakon_fzp3 = %APPDATA%\Malinovka\help_menu\help_zakon_fzp3.txt
Phelp_zakon_fzp4 = %APPDATA%\Malinovka\help_menu\help_zakon_fzp4.txt
files := [Phelp_help, Phelp_hotkey, Phelp_zakon_kirminal, Phelp_zakon_koap, Phelp_zakon_ustav, Phelp_zakon_ustav2, Phelp_zakon_fzp1, Phelp_zakon_fzp2, Phelp_zakon_fzp3, Phelp_zakon_fzp4]
fileexitServer := ["https://raw.githubusercontent.com/ViTokarev/malinovka/master/help_menu/"]
filename := ["help_help.txt", "help_hotkey.txt", "help_zakon_kirminal.txt", "help_zakon_koap.txt", "help_zakon_ustav.txt", "help_zakon_ustav2.txt", "help_zakon_fzp1.txt", "help_zakon_fzp2.txt", "help_zakon_fzp3.txt", "help_zakon_fzp4.txt"]
filesGUI := [help_help, help_hotkey, help_zakon_kirminal, help_zakon_koap, help_zakon_ustav, help_zakon_ustav2, help_zakon_fzp1, help_zakon_fzp2, help_zakon_fzp3, help_zakon_fzp4]
x=1
loop
{
  Downlagain:
  temp1 :=
  FileRead, temp1, % files[x]
  if ErrorLevel=1
  {
    
    UrlDownloadToFile % fileexitServer[1]filename[x], % files[x]
    goto Downlagain
  }
filesGUI[x] := temp1
x++
if x=11
  Break
}

SoundBeep, 750
FileReadLine, version, OGIBDD.ahk, 1
text := UrlDownloadToVar("https://raw.githubusercontent.com/ViTokarev/malinovka/master/OGIBDD.ahk")
UrlDownloadToVar(URL, UserAgent = "")
{
   ComObjError(false)
   WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   WebRequest.Open("GET", Url)
   UserAgent ? WebRequest.Option(WinHttpRequestOption_UserAgentString := 0) := UserAgent
   WebRequest.Send()
   if (WebRequest.ResponseText = "")
      msgbox Сервер обновлений не отвечает. Повторите позже.
   Text := WebRequest.ResponseText
   WebRequest := ""
   return Text
}
If InStr(Text, version)
  goto UpdateFail
Else
  {
  MsgBox, 4, Обновление, Есть новая версия АНК. Вы хотите обновить?`n`n(займет пару сек)
    {
     IfMsgBox Yes
        goto UpdateCode
     Else
        MsgBox, ну ок, но позже обновите.
    }
  }
UpdateFail:
FileRead, filename, %APPDATA%\Malinovka\ogibdd_name.txt
if ErrorLevel
{
  FileCreateDir,%APPDATA%\Malinovka
    MsgBox, Нажмите F1 для настройки АНК.
    filename =
}
Return

UpdateCode:
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nКопируем ваши скрипты.
FileRead, Contents, OGIBDD.ahk
key := "; END OF UPDATE CODE" ; СДЕЛАТЬ КЛЮЧ В ВЭБЕ, ВТОРОЙ СТРОКОЙ?
keyIndex = 0
CustomCodeText :=
Loop, read, OGIBDD.ahk, `r, `n
{
    if (A_Index > 500)
    {
        if (keyIndex > 500)
            CustomCodeText = %CustomCodeText%`n%A_LoopReadLine%

        If InStr(A_LoopReadLine, key)
        {
          keyIndex=%A_index%
          keyIndex++
        }
    }
}
FileDelete, OGIBDD.ahk
UrlDownloadToFile, https://raw.githubusercontent.com/ViTokarev/malinovka/master/OGIBDD.ahk, OGIBDD.ahk
FileAppend, %CustomCodeText%, OGIBDD.ahk
SplashTextOff
SoundBeep, 750
Reload
Return

F1::
GUI, Destroy
Gui Add, Text,, % filesGUI[1]
Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
Gui,  add,  button, gChangeName,  Изменить имя в приветствии (удостоверение)
WinSet TransColor, 1
Gui Show, NA
sleep 500
KeyWait, F1, D
Gui, Destroy
Return

ChangeName:
GUI, Destroy
GUI, Add, Edit, text vText, Рядовой, Ivan_Ivanov
Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
Gui,  add,  button, gChangeNameReg, Изменить
GUI, show
Return

ChangeNameReg:
  GUI Submit, NoHide
  FileDelete, %APPDATA%\Malinovka\ogibdd_name.txt
  FileAppend, %Text%, %APPDATA%\Malinovka\ogibdd_name.txt
  GUI, Destroy
Return

NumPad0:: ; представился
  SendMessage, 0x50,, 0x4190419,, A
  FileRead, rang, %APPDATA%/Malinovka/ogibdd_name.txt
  Sendinput,{F6}Здравия желаю. %rang%, инспектор ДПС ОГИБДД по Нижегородской области{ENTER}  
  Sleep 1000
  SendInput, {F6}/do Значок сотрудника «ДПС» на груди.{Enter}
  Sleep 1000
  SendInput, {F6}/me показал гражданину служебное удостоверение «МВД РОССИИ» в открытом виде.{Enter}
  Sleep 1000
  SendInput, {F6}/do ОГИБДД по НО | инспектор ДПС ОГИБДД | %rang%{Enter} 
Return

Del:: ; HELP по АНК
  Gui Add, Text,, % filesGUI[2]
  BlockInput on
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  sleep 500
  KeyWait, Del, D
  Gui, Destroy
  Send,{F6}
  Send,{F6}
  BlockInput off
Return

!r::Reload

^LButton::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/me нанес расслябляющий удар дубинкой, отправив в нокаут подозреваемого до приезда скорой{Enter}
Return

NumPad1:: ; взял паспорт у человека
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/me взял у человека паспорт.{Enter}
  Sleep 1500
  Sendinput,{F6}/do Паспорт в руке.{Enter}
  Sleep 1500
  Sendinput,{F6}/me листает страницы паспорта, изучая документ.{Enter}
  Sleep 1500
  Sendinput,{F6}/yes{Enter}
  Sleep 2500
  SendInput, {F6}/do Служебный КПК в кармане.{enter}
  sleep 1500
  SendInput, {F6}/me взял КПК в руку и включил.{enter}
  sleep 1500
  SendInput, {F6}/me ввел данные гражданина в поиск по базе "МО МВД".{Enter}
  Sleep 2500
  SendInput, {F6}/do Процесс...{Enter}
  Sleep 3000
  SendInput, {F6}/do Получил информацию.{Enter}
  Sleep 1500
  SendInput, {F6}/me выключил КПК и убрал в карман.{Enter}
  Sleep 2000
  Sendinput,{F6}/me закрыл паспорт.{Enter}
  Sleep 2000
  SendInput, {F6}/do Паспорт в руке.{enter}
  Sleep 1500
  Sendinput,{F6}/me вернул паспорт владельцу.{Enter}
Return

!NumPad1:: ; водительское удостоверение
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/me взял у человека водительское удостоверение.{Enter}
  Sleep 1500
  Sendinput,{F6}/do водительское удостоверение в руке.{Enter}
  Sleep 1500
  Sendinput,{F6}/me изучаяет информацию в документе.{Enter}
  Sleep 1500
  Sendinput,Sendinput,{F6}/yes{Enter}
  Sleep 1500
  Sendinput,{F6}/me анализирует полученную информацию.{Enter}
  Sleep 1500
  SendInput, {F6}/do водительское удостоверение в руке.{enter}
  Sleep 1500
  Sendinput,{F6}/me вернул водительское удостоверение владельцу.{Enter}
Return

^NumPad1:: ; документы на машину
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/me взял у человека ПТС.{Enter}
  Sleep 1500
  Sendinput,{F6}/do ПТС в руке.{Enter}
  Sleep 1500
  Sendinput,{F6}/me изучаяет информацию в документе.{Enter}
  Sleep 1500
  Sendinput,{F6}/yes{Enter}
  Sleep 1500
  SendInput, {F6}/do Служебный КПК в кармане.{enter}
  sleep 1500
  SendInput, {F6}/me взял КПК в руку и включил.{enter}
  sleep 1500
  SendInput, {F6}/me ввел данные ПТС в поиск по базе "МО МВД".{Enter}
  Sleep 2500
  SendInput, {F6}/do Процесс...{Enter}
  Sleep 3000
  SendInput, {F6}/do Получил информацию.{Enter}
  Sleep 1500
  SendInput, {F6}/me выключил КПК и убрал в карман.{Enter}
  Sleep 2000
  SendInput, {F6}/do ПТС в руке.{enter}
  Sleep 1500
  Sendinput,{F6}/me вернул ПТС владельцу.{Enter}
Return

NumPad2:: ; разбить окно и вытащить человека из машины
  SendMessage, 0x50,, 0x4190419,, A 
  Sendinput,{F6}/me Резким движением разбил стекло машины {Enter} 
  Sleep 1500
  Sendinput,{F6}/do Стекло разбито {Enter} 
  Sleep 1500 
  Sendinput,{F6}/me открыл дверь, вытащил человека из машины и заломал руку{Enter} 
  Sleep 1500 
  Sendinput,{F6}/do Водитель обезврежен.{Enter} ; это обязательно, чтобы водитель не /me встал и сел обратно в машину
  Sleep 1500 
  Sendinput,{F6}/b Покиньте транспорт. Если это не выполнить, будет считаться НонРп{Enter} 
Return

!NumPad2:: ; снять маску с человека (только если он в наручниках)
  SendMessage, 0x50,, 0x4190419,, A 
  Sendinput,{F6}/me быстрым движением правой руки снял маску с человека {Enter} 
  Sleep 1500 
  Sendinput,{F6}/unmask{Enter} 
  Sleep 500 
  Sendinput,{F6}/do маска в руке{Enter} 
Return 

NumPad3:: ; надеть наручники
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/me отцепил наручники от крепления на поясе и взял их в правую руку.{enter}
  sleep 500
  SendInput, {F6}/cuff {space}
return

!NumPad3:: ; снять наручники
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/me вытащил из нагрудного кармана ключ от наручников{enter}
  sleep 500
  SendInput, {F6}/do Ключ в руке.{enter}
  sleep 500
  SendInput, {F6}/me вставил ключ в наручники задержанногго{enter}
  SendInput, {F6}/uncuff {space}
return

NumPad4:: ; шлагбаум
  SendMessage, 0x50,, 0x4190419,, A
  SendInput {F6}/do Пульт управления шлагбаумом в кармане.{Enter}
  Sleep 250
  SendInput {F6}/me протянул руку в карман, достал пульт управления шлагбаумом. {enter}
  Sleep 250
  SendInput {F6}/do Пульту управления в руке.{Enter}
  Sleep 250
  SendInput {F6}/me нажал на кнопку на пульте управления шлагбаумом.{Enter}
  Sleep 250
  SendInput {F6}/do Шлагбаум активирован.{Enter}
  Sleep 100
  Sendinput,{F6}/post{Enter}
return

NumPad5:: ; посадить задержанного в машину
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/me взял преступника за руку{enter}
  sleep 500
  SendInput, {F6}/me повел преступника за собой{enter}
  sleep 500
  SendInput, {F6}/me открыл дверь машины и затолкал туда задержанного{enter}
  SendInput, {F6}/incar{space}
return

!NumPad5:: ; выкинуть из машины /eject
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/eject{space}
return

NumPad6:: ; дать розыск (если человек в МАСКЕ - РОЗЫСК ДАВАТЬ НЕЛЬЗЯ!!)
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/do Служебный КПК в кармане.{enter}
  sleep 100
  SendInput, {F6}/me взял КПК в руку и включил{enter}
  sleep 1000
  SendInput, {F6}/me ввел данные о нарушителе в базу данных «МВД»{enter}
  SendInput, {F6}/su{space}
return

!NumPad6:: ; выписать штраф (не забудь сначала проверить /pass и док машины)
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput, {F6}/me достал бланк протокола и ручку из нагрудного кармана{ENTER}
  Sleep, 1500
  Sendinput, {F6}/do Заполняет бланк...{ENTER}
  Sleep, 2500
  Sendinput, {F6}/me заполнил протокол и передал его человеку{ENTER}
  Sleep, 1500
  Sendinput, {F6}/todo Хорошо, распишитесь здесь*показывая на место для подписи{ENTER}
  Sleep, 500
  Sendinput, {F6}/n /me расписался{ENTER}
  Sendinput, {F6}/ticket{space}
return

^NumPad6:: ; ремень безопасности
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/check{space}
return

NumPad7:: ; передать человека в тюрьму
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/do Служебный КПК в кармане.{enter}
  sleep 500
  SendInput, {F6}/me взял КПК в руку и включил{enter}
  sleep 1000
  SendInput, {F6}/me ввел данные о преступнике{Enter}
  Sleep 1000
  SendInput, {F6}/me выключил КПК и убрал в карман{Enter}
  Sleep 1000
  SendInput, {F6}/me передал преступника в участок{Enter}
  SendInput, {F6}/arrest{Space}
Return

NumPad8:: ; /time для скринов/видео
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/time{Enter}
return

Numpad9:: ; фоторобот (если человек не в маске!)
  SendMessage, 0x50,, 0x4190419,, A
  SendInput,{F6}/me достал фоторобот из небольшой папки в кармане{Enter}
  Sleep 1000
  SendInput,{F6}/me сравнил лицо на изображении с лицом человека рядом{Enter}
  Sleep 1000
  SendInput,{F6}/do Лицо на изображении совпадает с лицом человеком рядом{Enter}
Return

!Numpad9:: ; воинское приветствие
  SendMessage, 0x50,, 0x4190419,, A
  SendInPut, {F6}Здравия желаю{!}{Enter}
  Sleep 1500
  SendInPut, {F6}/me выполнил воинское приветствие.{Enter}
Return

F2:: ; обыск человека
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

!F2:: ; после обыска ИЗЪЯТЬ запрещ предметы
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

^F2:: ; изъял водительское
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/me забрал у человека водительские права{Enter}
  Sleep 1500
  Sendinput,{F6}/do Водительские права в руке.{Enter}
  Sleep 1500
  Sendinput,{F6}/me переписал данные в протокол{Enter}
  Sleep 1500
  Sendinput,{F6}/do Данные записаны в протокол.{Enter}
  Sendinput,{F6}/remove{Space}
Return

F3:: ; Мегафон для погони в машине
  SendMessage, 0x50,, 0x4190419,, A 
  SendInPut, {F6}/m Водитель, остановитесь и прижмитесь к обочине.{Enter} 
  Sleep 3000 
  SendInPut, {F6}/m Остановитесь и прижмитесь к обочине, иначе это будет считаться игнорированием приказа{!}{Enter} 
  Sleep 3000
  SendInPut, {F6}/m К обочине, последний раз повторяю. Мы будем вынуждены открыть огонь.{Enter} 
Return  

!F3:: ; заглушить двигатель преступнику
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/do Ноутбук на торпеде автомобиля.{Enter}
  Sleep 1000
  Sendinput,{F6}/me Запустил в компьютере программу блокировки двигателя.{Enter}
  Sleep 1000
  Sendinput,{F6}/do Соединение с системой ГЛОНАСС.{Enter}
  Sleep 1000
  Sendinput,{F6}/me ввел данные преследуемого Т/С и выбрал "блокировка двигателя".{Enter}
  Sleep 1000
  Sendinput,{F6}/do Процесс...{Enter}
  Sleep 250
  SendInPut, {F6}/vehoff{space}
  KeyWait, Enter, D
  Sendinput,{F6}/do Попытка блокировки двигателя.{Enter}
Return  

!Numpad7:: ; выдача номеров (мл.лейтенант и выше)
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/do Гос.номера и бланк учёта на стойке сзади.{Enter}
  Sleep 500
  SendInput, {F6}/me развернулся, взял гос. номера и бланк учета.{Enter}
  Sleep 2000
  SendInput, {F6}/do Бланк и гос. номера в руке.{Enter}
  Sleep 500
  SendInput, {F6}/me положил номера на стол, начал заполнять бланк учета.{Enter}
  Sleep 500
  SendInput, {F6}/do Заполняет...{Enter}
  Sleep 3000
  SendInput, {F6}/me заполнил бланк и передал гос. номера новому владельцу.{Enter}
  SendInput, {F6}/givenumber{Space}
Return

\:: ; заготовка для ответа в /rb рацию
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/rb{space}
return

NumpadMult:: ; * дать денег
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/pay{space}
return

+NumpadMult:: ; *+shift кто онлайн
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/members{enter}
return

^NumpadMult:: ; ctrl+* поиск преступника через /setmark 
Sendinput,{F6}/setmark{space}
return

!NumpadEnter::
Sendinput,{F6}/yes{enter}
return

^!f::
Sendinput,{F6}/fix{enter}
return

!b::  ; /b откат
  SendMessage, 0x50,, 0x4190419,, A
  Sendinput,{F6}/b откат{enter}
return

!h:: ; alt+H heal
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}/do Аптечка висит на ремне.{Enter} 
  Sleep 500
  SendInput, {F6}/me достает из аптечки шприц и вкалывает себе адреналин{Enter} 
  Sleep 500
  Sendinput,{F6}/healme{enter}
return

!g:: ; alt+g дать аптечку
Sendinput,{F6}/givechest{space}
return

!1::  ; УК
  Gui Add, Text,, % filesGUI[3]
  BlockInput on
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  KeyWait LAlt, L
  Send,{F6}
  Send,{F6}
  Gui, Show, Hide
  BlockInput off
  Gui, Destroy
Return

!2::  ; КоАП
  Gui Add, Text,, % filesGUI[4]
  BlockInput on
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  KeyWait LAlt, L
  Send,{F6}
  Send,{F6}
  Gui, Show, Hide
  BlockInput off
  Gui, Destroy
Return

!3::  ; УСТАВ
  Gui Add, Text,, % filesGUI[5]
  BlockInput on
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  KeyWait LAlt, L
  Send,{F6}
  Send,{F6}
  Gui, Show, Hide
  BlockInput off
  Gui, Destroy
Return

!4::  ; УСТАВ ПРОДОЛЖЕНИЕ
  Gui Add, Text,, % filesGUI[6]
  BlockInput on
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  KeyWait LAlt, L
  Send,{F6}
  Send,{F6}
  Gui, Show, Hide
  BlockInput off
  Gui, Destroy
Return

!5::  ; ФЗ о полиции | страница 1
  Gui Add, Text,, % filesGUI[7]
  BlockInput on
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  KeyWait LAlt, L
  Send,{F6}
  Send,{F6}
  Gui, Show, Hide
  BlockInput off
  Gui, Destroy
Return

!6::
  Gui Add, Text,, % filesGUI[8]   ; ФЗ о полиции | страница 2
  BlockInput on
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  KeyWait LAlt, L
  Send,{F6}
  Send,{F6}
  Gui, Show, Hide
  BlockInput off
  Gui, Destroy
Return

!7::  ; ФЗ о полиции | страница 3
  Gui Add, Text,, % filesGUI[9]
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  KeyWait LAlt, L
  Send,{F6}
  Send,{F6}
  Gui, Show, Hide
  BlockInput off
  Gui, Destroy
Return

!8::
  Gui Add, Text,, % filesGUI[10]    ; ФЗ о полиции | страница 4
  BlockInput on
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  KeyWait LAlt, L
  Send,{F6}
  Send,{F6}
  Gui, Show, Hide
  BlockInput off
  Gui, Destroy
Return

!9::
  Gui Add, Text,,
  (
    Что-то ещё
  )
  BlockInput on
  Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
  WinSet TransColor, 1
  Gui Show, NA
  KeyWait LAlt, L
  Send,{F6}
  Send,{F6}
  Gui, Show, Hide
  BlockInput off
  Gui, Destroy
Return

; Не назначайте ниже свои ahk на клавиши которые заняты выше!
; ДАЛЬШЕ (НИЖЕ) ДОБАВЛЯЙТЕ ЛЮБЫЕ ВАШИ АНК КОТОРЫЕ НЕ УДАЛЯТСЯ ПОСЛЕ ОБНОВЛЕНИЙ! Не удаляйте строку НИЖЕ!!
; END OF UPDATE CODE