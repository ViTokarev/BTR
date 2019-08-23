; ###VERSION.0.4.7###

SetWorkingDir, %A_AppData%\Malinovka

class MainInterface
{
	iniHead := [] ; заргрузка заголовков config.ini
	list_hotkey := []
	rownumber :=
	sumscript :=
	firstlaunch :=

	Create_gui(){
		Gui, 1:Default
		Gui, 1:Add, ListView, r20 w650 y50 gGLV Grid AltSubmit, Название|Hotkeys|Описание функции
		Gui, 1:Add, Text, text cRed, ВЫЗВАТЬ ЭТОТ МЕНЕДЖЕР КНОПКА: INSERT
		Gui, 1:Add, Text, text, Alt+R - перезагрузит АНК. (даже во время игры)    Использовать бинды сможете после закрытия этого окна.
		Gui, 1:Add, Text, text x500 y423, AHK by Vitalik_Tokarev
		Gui, 1:Add, Button, x10 y10 gLableGetGotkey, Добавить
		Gui, 1:Add, Button, x70 y10 gLableDeleteHotkey, Удалить
		Gui, 1:Add, Button, x127 y10 gChangeName, Изменить свое имя
		Gui, 1:Add, Button, x277 y10 gDonwloadAllAHKOffical, Восстановить АНК (удалить всё и скачать)
		Gui, 1:Add, Button, x550 y10 gMenuOnMain, Меню
		
		;
    	this.Load_ini_hotkey()
    	LV_ModifyCol(1, 100)
    	LV_ModifyCol(2, 100)
    	LV_ModifyCol(3, 300)
    	;LV_ModifyCol(4, 50)
    	Gui, 1:+AlwaysOnTop
		Gui, 1:Show, NA
		Return
		}
	
	Udpate_gui(){
		Gui, 2:Destroy
		Gui, 1:Default
		Gui, 1:+AlwaysOnTop
		LV_Delete()
		this.Load_ini_hotkey()

		Return
	}

	GuiMainMenu(){
		Gui, -AlwaysOnTop
		Gui, 10:Font, bolt s14
		Gui, 10:Add, Button, gOpenFolderMain, Папка АНК
		Gui, 10:Add, Button, gOpenFolderScreens, СКРИНЫ
		Gui, 10:Add, Button, gOpenChatlog, Chatlog
		Gui, 10:Add, Button, gAddersHelp, Связь с разрабом

		Gui, 10:Show, NA
	}

	Add_hotkey(){
		LableGetGotkey:
		Gui, 2:Destroy
		Gui, 2:Add, Edit, vtemping , Название скрипта (на английском!)
		Gui, 2:Add, Edit, vcomment , Описание работы, пример: Заковать в наручники
		Gui, 2:Add, Text, text, Ниже нажмите на поле и сочитание клавишь
		Gui, 2:Add, Hotkey, vkey
		Gui, 2:Add, Button, gSaveNewKey, OK
		Gui, 1:-AlwaysOnTop
		Gui, 2:Show
		Return
		}

	Add_hotkey_Saveini(key, temping, comment){
		SetWorkingDir, %A_AppData%\Malinovka\profile
		IniWrite, %key%, config.ini, %temping%, key
		fileway := temping . ".ahk"
		IniWrite, %fileway%, config.ini, %temping%, fileway
		;hm := FileOpen(fileway, Flags , Encoding)
		FileAppend, `; %comment%`n, %fileway%,UTF-8
		FileAppend, Hotkey`, `%key%temping%`%`, %temping%`nreturn`n`n%temping%: `; ВАЖНО Эту строку И ВЫШЕ не трогать`n`;МЕСТО ДЛЯ СКРИПТА`n`nReturn, %fileway%
		SetWorkingDir, %A_AppData%\Malinovka
		Gui, Destroy
		MainInterface.Udpate_gui()
		Return
	}

	Add_ini_config(){
		LabelAddIni:
		Gui, 2:Destroy
		Gui, 2:Add, Text,,  
		Gui, 2:Add, Edit, text , Описание работы, пример: Заковать в наручники
		Gui, 2:Add, Text, text, Ниже нажмите на поле и сочитание клавишь
		Gui, 2:Add, Hotkey, vMyHotkey
		Gui, 2:Add, Button, , OK
		Gui, 1:-AlwaysOnTop
		Gui, 2:Show
		MainInterface.Udpate_gui()
		Return
	}

	Delete_ini_hotkey_all(Hotkeyname){
		SetWorkingDir, %A_AppData%\Malinovka\profile
		IniDelete, config.ini, %Hotkeyname%
		FileDelete, %Hotkeyname%.ahk
		SetWorkingDir, %A_AppData%\Malinovka
		Gui, 1:-AlwaysOnTop
		MsgBox, %Hotkeyname% - удален
		MainInterface.Udpate_gui()
	Return
	}
	

	Edit_script_config(Hotkeyname){
		;MsgBox % Hotkeyname
		SetWorkingDir, %A_AppData%\Malinovka\profile
		Gui, 2:Destroy 
		fileway := Hotkeyname . ".ahk"
		FileRead, fileahk, % fileway
		Gui, 2:Add, Text,, В КОНЦЕ КАЖДОГО СКРИПТА ДОЛЖЕН БЫТЬ: `Return
		Gui, 2:Add, Edit, w700 r30 text vcode, % fileahk
		IniRead, key, config.ini, %Hotkeyname%, key
		Gui, 2:Add, Text,, В этом поле можно задать клавиши на которые сработает бинд (ВКЛЮЧИТЕ АНГЛ РАСКЛАДКУ`!`!`!`!)
		Gui, 2:Add, Hotkey, vNewkey, %key%
		Gui, 2:Add, Button, gKeyOff, Отключить кнопку
		Gui, 2:Add, Button, gSaveCode, OK
		Gui, 1:-AlwaysOnTop
		Gui, 2:Show ;, y400 w400 h400, Редактор бинда
		SetWorkingDir, %A_AppData%\Malinovka
		Return
	}

	Save_script_config(Hotkeyname, Newkey, fileahk){
		;MsgBox % Hotkeyname Newkey fileahk
		SetWorkingDir, %A_AppData%\Malinovka\profile
		IniWrite, %Newkey%, config.ini, %Hotkeyname%, key
		fileway := Hotkeyname . ".ahk"
		FileDelete, %fileway%
		FileAppend, %fileahk%, %fileway%,UTF-8
		SetWorkingDir, %A_AppData%\Malinovka
		;FileAppend, `n#Include %A_AppData%\Malinovka\profile\%fileway%, %A_AppData%\Malinovka\MainBinds.ahk
		Gui, 2:Destroy
		MainInterface.Udpate_gui()
		Return
	}

	Get_ini_config(temping, x){
		IniRead, key, config.ini, %temping%, key
		IniRead, fileway, config.ini, %temping%, fileway
		FileReadLine, description, %fileway%, 1
		this.list_hotkey[x] := [temping, key, fileway, description]
		Return
	}

	ChangeYourName(names, rang){
		global NewName, NewRang
		if (names == "ERROR")
			names := "Никита Носов"
		if (rang == "ERROR")
			rang := "Пажилой Генерал"
		Gui, 3:font, bold s16, Arial
		Gui, 3:Add, Text, Center cRed text, ВВЕДИТЕ ИМЯ ДЛЯ УДОСТОВЕРЕНИЯ`n`nЭТО ОБЯЗАТЕЛЬНО
		Gui, 3:Add, Text, text, Полное имя:
		Gui, 3:Add, Edit, w400 text vNewName, % names
		Gui, 3:Add, Text, text, Звание:
		Gui, 3:Add, Edit, w400 text vNewRang, % rang
		Gui, 3:Add, Button, gChangeNameDone, Сохранить
		Gui, 1:-AlwaysOnTop
		Gui, 2:-AlwaysOnTop
		Gui, 3:Show
		Return
	}

	Load_ini_hotkey(){
	SetWorkingDir, %A_AppData%\Malinovka\profile
	x=0
	this.list_hotkey := []
		Loop, read, config.ini
		{
			Loop, parse, A_LoopReadLine, %A_Tab%
			{
			temp1 := RegExMatch(A_LoopReadLine, ".*\[(.*)\]", "$1")

			if (temp1 = 1)
			{
				x++
				this.iniHead[x] := A_LoopReadLine
				temping := RegExReplace(A_LoopReadLine, ".*\[(.*)\]", "$1") ; получение заголовков ini
				this.Get_ini_config(temping, x) ; загрузка всех данных о анк
				;MsgBox % temping keycolum description
				LV_Add("", this.list_hotkey[x][1], this.list_hotkey[x][2], this.list_hotkey[x][4])
			}
			}
		}
	this.sumscript := x
	SetWorkingDir, %A_AppData%\Malinovka
	Return
	}

	Reconfig_ahk_to_Main(){
	SetWorkingDir, %A_AppData%\Malinovka\profile
	FileDelete, help_gui.txt
	SetWorkingDir, %A_AppData%\Malinovka
		key := "; END OF UPDATE CODE" ; СДЕЛАТЬ КЛЮЧ В ВЭБЕ, ВТОРОЙ СТРОКОЙ?
		keyIndex = 0
		CustomCodeText :=
		Loop, read, MainBinds.ahk, `r, `n
		{
				if (A_Index = 1)
					CustomCodeText = %A_LoopReadLine%

				if (A_Index > 1)
		    	{
		    		CustomCodeText = %CustomCodeText%`n%A_LoopReadLine%

			        If InStr(A_LoopReadLine, key)
			        {
			        	Break
			        }
		    	}
		}
		FileDelete, MainBinds.ahk
		FileAppend, %CustomCodeText%, MainBinds.ahk
		y := this.sumscript
		x := 0
		b := ""
		key := ""
		FileAppend, AHK by Vitalik_Tokarev`n, %A_AppData%\Malinovka\profile\help_gui.txt
		FileAppend, ! - это АЛЬТ   ||   ^ - это CTRL`n, %A_AppData%\Malinovka\profile\help_gui.txt
		Loop
		{
			x++
			description := this.list_hotkey[x][4]
			nameahk := this.list_hotkey[x][3]
			key     := this.list_hotkey[x][2]
			temping := this.list_hotkey[x][1]
			
			if (key = b)
			{
				goto labelYes
			}
			else
			{
				inikeytotext = %inikeytotext%`nIniRead`, key%temping%`, config.ini`, %temping%`, key
				forguikey = %forguikey%`n%key% %description%
				hotkeymany = %hotkeymany%`nHotkey, `%key%temping%`%, %temping%
				addresahk = %A_AppData%\Malinovka\profile\%nameahk%
				includetotext = %includetotext%`n#Include %addresahk%
			}
			labelYes:
			;inikeytotext = %inikeytotext%`nIniRead`, key%temping%`, config.ini`, %temping%`, key
			
			;MsgBox, Ini load
			

			;MsgBox, % includetotext
			if (x == this.sumscript)
			{
				FileAppend, %inikeytotext%, %A_AppData%\Malinovka\MainBinds.ahk
				FileAppend, %hotkeymany%, %A_AppData%\Malinovka\MainBinds.ahk
				FileAppend, `n`Return, %A_AppData%\Malinovka\MainBinds.ahk
				FileAppend, %includetotext%, %A_AppData%\Malinovka\MainBinds.ahk
				FileAppend, %forguikey%, %A_AppData%\Malinovka\profile\help_gui.txt
				Break
			}
		}
	}

}

; MAIN FUNCTION
if !FileExist("%APPDATA%\Malinovka\help_menu")
	FileCreateDir, %APPDATA%\Malinovka\help_menu
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
x++
if x=11
  Break
}

way = %A_ScriptDir%\%A_ScriptName%
SetWorkingDir, %A_AppData%\Malinovka
IniWrite, %way%, configBTR.ini, options, filewayBTR
SetWorkingDir, %way%

IniRead, names, configBTR.ini, mandata, yourname
if (names == "ERROR")
	{
	UrlDownloadToFile https://raw.githubusercontent.com/ViTokarev/malinovka/master/MainBinds.ahk, MainBinds.ahk
	Gosub DonwloadAllAHKOffical
	goto ChangeName
	}
;CHECK UPDATE
FileReadLine, version, %A_ScriptDir%\%A_ScriptName%, 1
text := UrlDownloadToVar("https://raw.githubusercontent.com/ViTokarev/malinovka/master/BTR.ahk")
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
		goto UpdateOk
	Else
		{
		Gui, -AlwaysOnTop
		MsgBox, 4, Обновление, Есть новая версия программы! Вы хотите обновить?`n`n(займет пару сек)
			IfMsgBox Yes
				{
				UrlDownloadToFile, https://raw.githubusercontent.com/ViTokarev/malinovka/master/BTR.ahk, %A_ScriptDir%\%A_ScriptName%
				UrlDownloadToFile, https://raw.githubusercontent.com/ViTokarev/malinovka/master/MainBinds.ahk, %A_AppData%\Malinovka\MainBinds.ahk
				Reload
				}
			Else
				MsgBox, Ок, конечно, но могли добавить новые фичи для стабильности.
		}
UpdateOk:

if (names = "ERROR")
	Return
Else
	MainInterface.Create_gui()

Return

Ins::
if (GUI = Show)
	goto GuiClose
Else
	MainInterface.Create_gui()
Return

!r::Reload
Return

SaveNewKey:
GUI, Submit, NoHide
MainInterface.Add_hotkey_Saveini(key, temping, comment)
Return

LableDeleteHotkey:
	RowNumber :=
	Hotkeyname :=
	RowNumber := LV_GetNext(RowNumber)
	LV_GetText(Hotkeyname, RowNumber, 1)
	MainInterface.Delete_ini_hotkey_all(Hotkeyname)
Return

GLV:
if A_GuiEvent = DoubleClick
{
	RowNumber :=
	Hotkeyname :=
	RowNumber := LV_GetNext(RowNumber)
	LV_GetText(Hotkeyname, RowNumber, 1)
	MainInterface.Edit_script_config(Hotkeyname)
}
Return

SaveCode:
	Gui, 2:Submit
	MainInterface.Save_script_config(Hotkeyname, Newkey, code)
Return

3GuiClose:
	Gui, -AlwaysOnTop
	if (names not in "ERROR")
		MsgBox, Данные не сохранились, нажмите "сохранить"
	Else
		MsgBox, Введите свое имя и звание, без него АНК не будет работать.
Return

2GuiClose:
	MainInterface.Udpate_gui()
Return

GuiClose:
	MainInterface.Reconfig_ahk_to_Main()
	Run "%A_AppData%\Malinovka\MainBinds.ahk"
ExitApp

ReconfigAHK:
	MainInterface.Reconfig_ahk_to_Main()
Return

OpenFolderMain:
	Run, %A_AppData%\Malinovka
	Gui, -AlwaysOnTop
Return

DonwloadAllAHKOffical:
Gui, 4:font, bold cRed s16, Arial
Gui, 4:+Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
if (names = "ERROR")
	{
	Gui, 4:Add, Text,, Подождите, идёт подготовка к первому запуску. Процесс...
	Gui, 4:Show
	}
Else
{
	Gui, 1:-AlwaysOnTop
	MsgBox, Обновление. Уверен? Если нет - жми АЛЬТ+R
	Gui, 4:Add, Text,, Обновление. Процесс...
	Gui, 4:Show
}
SetWorkingDir, %A_AppData%\Malinovka\
FileRemoveDir, help_menu
FileRemoveDir, profile
FileCreateDir, profile
SetWorkingDir, %A_AppData%\Malinovka\profile\

;Loop, %A_WorkingDir%\*.ahk*
;    FileDelete, A_LoopFileName

fileexitServer := ["https://raw.githubusercontent.com/ViTokarev/malinovka/master/profile/"]
filename := ["arrest.ahk", "b.ahk", "check.ahk", "crashwindow.ahk", "cuff.ahk", "eject.ahk", "givechest.ahk", "givenumber.ahk", "healme.ahk", "hello.ahk", "incar.ahk", "megafon.ahk", "members.ahk", "paper.ahk", "passOGIDBB.ahk", "pay.ahk", "photoface.ahk", "post.ahk", "remove.ahk", "removelic.ahk", "search.ahk", "su.ahk", "takecarpass.ahk", "takelic.ahk", "takepass.ahk", "ticket.ahk", "time.ahk", "tome.ahk", "uncuff.ahk", "unmask.ahk", "vehoff.ahk", "yes.ahk", "zakonFZpolice.ahk", "zakonFZpolice2.ahk", "zakonFZpolice3.ahk", "zakonFZpolice4.ahk", "zakonKoAP.ahk", "zakonYK.ahk", "zakonYstav.ahk", "zakonYstav2.ahk"]
x=0
loop
{
    UrlDownloadToFile % fileexitServer[1]filename[x], % filename[x]
x++
if x=41
  Break
}
if (names = "ERROR")
{
	FileDelete, config.ini
	UrlDownloadToFile https://raw.githubusercontent.com/ViTokarev/malinovka/master/profile/config.ini, config.ini
}
Else
{
	Gui, 4:Hide
	MsgBox, 4, ОСТОРОЖНО, Вы хотите так же сбросить назначенные клавиши?`n`nПока мы только обновили содержимое биндов`, НО НЕ ВАШИ НАЗНАЧЕНЫЕ КНОПКИ.
	IfMsgBox Yes
		{
		Gui, 4:Show
		FileDelete, config.ini
		UrlDownloadToFile https://raw.githubusercontent.com/ViTokarev/malinovka/master/profile/config.ini, config.ini
		}
	MainInterface.Create_gui()
}
Gui, 4:Destroy
Return

ChangeName:
Gui, 1:-AlwaysOnTop
SetWorkingDir, %A_AppData%\Malinovka
IniRead, names, configBTR.ini, mandata, yourname
IniRead, rang, configBTR.ini, mandata, yourrang

MainInterface.ChangeYourName(names, rang)
Return

ChangeNameDone:
Gui, 1:-AlwaysOnTop
GUI, Submit, NoHide
SetWorkingDir, %A_AppData%\Malinovka
IniWrite, %NewName%, configBTR.ini, mandata, yourname
IniWrite, %NewRang%, configBTR.ini, mandata, yourrang
MsgBox, Ваше имя: %NewName%`nВаше звание: %NewRang%
Reload
Return

AddersHelp:
Gui, 1:-AlwaysOnTop
MsgBox, ОФИЦАЛЬНЫЙ КПК ОГИБДД Малиновка 01`n`nСвежие версии - https://github.com/ViTokarev/malinovka `n`nВК - https://vk.com/wagneror `n`nDiscord - sed_oi#7351`n`nВсегда ваш - Полковник ОГИБДД[01] Токарев В.П. (Август 2019)
Return

KeyOff:
	SetWorkingDir, %A_AppData%\Malinovka\profile
	IniWrite, "", config.ini, %Hotkeyname%, key
	MainInterface.Edit_script_config(Hotkeyname)
	SetWorkingDir, %A_AppData%\Malinovka
Return

MenuOnMain:
	MainInterface.GuiMainMenu()
Return

OpenFolderScreens:
	Run, %A_MyDocuments%\Malinovka\screens
	Gui, -AlwaysOnTop
Return

OpenChatlog:
	Run, %A_MyDocuments%\Malinovka\chatlog.txt
	Gui, -AlwaysOnTop
Return