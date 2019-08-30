﻿; ###VERSION:0.5.0###

SetWorkingDir, %A_AppData%\Malinovka

class MainInterface
{

	; AHK бинд
	Name := ;filename
	Key :=
	Description :=
	TextBind :=
	list_hotkey :=
	ListDownlBinds :=
	sumscript :=
	list_hotkey_fromrepo :=
	;AHKscriptsDonw := [ogibdd, mvd, bcrb, vich]

	fileexitServer := ["https://raw.githubusercontent.com/ViTokarev/malinovka/master/"]
	NameProfile := ["ОГИБДД", "МВД", "БЦРБ", "ВЧ"]
	AHKscriptsDonw := [ogibdd, mvd, bcrb, vich]

	Main_gui(){ ; основное окно
		Gui, Destroy
		global ChooseORGWrite
		SetWorkingDir, %A_AppData%\Malinovka

		;MsgBox, %chooseORG%
		
		;Gui, 1:Add, DropDownList, vChooseORGWrite gWriteChoise Altsubmit Choose%chooseORG%, ОГИБДД|МВД|БЦРБ|ВЧ ; то что выбранно, загружает, перекида на функцию
		Menu, ContextMain, Add, Создать свой бинд, AddCreateBind 
		Menu, ContextMain, Add, Изменить имя, ChangeName 
		Menu, ContextMain, Add, Менеджер загрузок, Download_menu
		Menu, ContextMain, Add, Удалить все мои бинды, DeleteAllMyBinds
		Menu, ContextMain, Add, Меню, MenuOnMain
		Gui, 1:Add, ListView, r20 w650 Grid AltSubmit gGLV, Name bind|Hotkeys|Описание бинда

		LV_ModifyCol(1, 100)
		LV_ModifyCol(2, 100)

		Gui, 1:Add, Button, gChangeName, Изменить свое имя
		Gui, 1:Add, Button, gLableDeleteHotkey, Удалить

		Gui, 1:Add, Button, gAddCreateBind, Создать свой бинд

		Gui, 1:Add, Button, gDownload_menu, Менеджер загрузок
		Gui, 1:Add, Button, gDeleteAllMyBinds, Удалить все мои бинды

		Gui, 1:Add, Button, gMenuOnMain, Меню


		gosub Loadmybinds
		;Menu, ContextMain, Show
		Gui, Menu, ContextMain
		Gui, 1:Show,, BRT (beta v.0.5.0)
		Return
	}

	Udpate_gui(){
		LV_Delete()
		gosub Loadmybinds
		Return
	}

	GuiMainMenu(){
		Gui, 10:Font, bolt s14
		Gui, 10:Add, Button, gOpenFolderMain, Папка АНК
		Gui, 10:Add, Button, gOpenFolderScreens, СКРИНЫ
		Gui, 10:Add, Button, gOpenChatlog, Chatlog
		Gui, 10:Add, Button, , Связь с разрабом

		Gui, 10:Show, NA
	}
	
	ChangeYourName(names, rang){
		global NewName, NewRang, ChoiseToDonwl, CheckDonwl
		IniRead, names, configBTR.ini, mandata, yourname
		IniRead, rang, configBTR.ini, mandata, yourrang
		checking = Check
		if (names == "ERROR")
		{
			names := "Никита Носов"
			IniWrite, 1, configBTR.ini, mandata, ChoiseDonwl
			checking = CheckedGray
		}
		if (rang == "ERROR")
			rang := "Пажилой Генерал"
		IniRead, ChoiseDonwl, configBTR.ini, mandata, ChoiseDonwl
		Gui, 3:font, bold s16, Arial
		Gui, 3:Add, Text, Center cRed text, ВВЕДИТЕ ИМЯ ДЛЯ УДОСТОВЕРЕНИЯ`n`nЭТО ОБЯЗАТЕЛЬНО
		Gui, 3:Add, Text, text, Полное имя:
		Gui, 3:Add, Edit, w400 text vNewName, % names
		Gui, 3:Add, Text, text, Звание:
		Gui, 3:Add, Edit, w400 text vNewRang, % rang
		if (names == "ERROR" or names == "Никита Носов")
		{
				Gui, 3:Add, Checkbox, vCheckDonwl %checking%, Скачать бинды выбранной организации
				Gui, 3:Add, DropDownList, vChoiseToDonwl AltSubmit Choose%ChoiseDonwl%, ОГИБДД|МВД|БЦРБ|ВЧ
		}
		Gui, 3:Add, Button, gChangeNameDone, Сохранить
		Gui, 1:-AlwaysOnTop
		Gui, 2:-AlwaysOnTop
		Gui, 3:Show,, BTR - задать имя.
		Return
	}

	Download_menu_gui(chooseORG){ ; основное окно
		Gui, Destroy
		global ChooseORGWrite
		global ChoiseCheckedDownl
		SetWorkingDir, %A_AppData%\Malinovka

		;MsgBox, %chooseORG%
		
		Gui, 1:Add, DropDownList, vChooseORGWrite gDownload_menu_list Altsubmit Choose%chooseORG%, ОГИБДД|МВД|БЦРБ|ВЧ ; то что выбранно, загружает, перекида на функцию
		
		Gui, 1:Add, ListView, r20 w650 gClickDownlList vChoiseCheckedDownl Checked Grid AltSubmit, Название|Hotkeys|Описание функции

		LV_ModifyCol(1, 100)
		LV_ModifyCol(2, 100)

		Gui, 1:Add, Button, gBackToMenu, Назад

		Gui, 1:Add, Button, gDonwloadChoise, Скачать выбранные
		Gui, 1:Add, Button, gRCheckAlloff, Выбрать все
		Gui, 1:Add, Button, gRCheckAll, Снять отмеченные
		GuiControl, 1:+AltSubmit, ChoiseCheckedDownl
		Gui, 1:Show
		Return
	}

	Edit_script_config(Hotkeyname){
		SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds
		Gui, 2:Destroy 
		IniRead, descript, config.ini, %Hotkeyname%, description
		Gui, 2:Font, s10
		Gui, 2:Add, Text,, Описание бинда:
		Gui, 2:Add, Edit, w650 text vdescripti, % descript
		fileway := Hotkeyname . ".ahk"
		FileRead, fileahk, % fileway
		Gui, 2:Add, Text,, В КОНЦЕ КАЖДОГО СКРИПТА ДОЛЖЕН БЫТЬ: `Return` `n`nСам бинд:
		Gui, 2:Add, Edit, w650 r25 text vcode, % fileahk
		IniRead, key, config.ini, %Hotkeyname%, key
		Gui, 2:Add, Text,, в поле ниже НАЖМИ кнопки на которые сработает бинд `n(ВКЛЮЧИТЕ АНГЛ РАСКЛАДКУ`!`!`!`!)
		Gui, 2:Add, Hotkey, vNewkey, %key%
		;Gui, 2:Add, Button, gKeyOff, Отключить кнопку
		Gui, 2:Add, Button, gSaveCode, OK
		Gui, 1:-AlwaysOnTop
		Gui, 2:Show ;, y400 w400 h400, Редактор бинда
		SetWorkingDir, %A_AppData%\Malinovka
		Return
	}

	Save_script_config(Hotkeyname, Newkey, fileahk, descripti){
		;MsgBox % Hotkeyname Newkey fileahk
		SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds
		IniWrite, %Newkey%, config.ini, %Hotkeyname%, key
		IniWrite, %descripti%, config.ini, %Hotkeyname%, description
		fileway := Hotkeyname . ".ahk"
		FileDelete, %fileway%
		FileAppend, %fileahk%, %fileway%,UTF-8
		Gui, 2:Destroy
		MainInterface.Udpate_gui()
		Return
	}

	Add_hotkey(){
		Gui, 2:Destroy
		Gui, 2:Add, Edit, vtemping , Название скрипта (!на английском!)
		Gui, 2:Add, Edit, vcomment , Описание работы, пример: Заковать в наручники
		Gui, 2:Add, Text, text, Ниже нажмите на поле и сочитание клавишь
		Gui, 2:Add, Hotkey, vkey
		Gui, 2:Add, Button, gSaveNewKey, OK
		Gui, 1:-AlwaysOnTop
		Gui, 2:Show
		Return
		}

	Add_hotkey_Saveini(key, temping, comment){
		SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds
		IniWrite, %key%, config.ini, %temping%, key
		fileway := temping . ".ahk"
		IniWrite, %fileway%, config.ini, %temping%, fileway
		IniWrite, %comment%, config.ini, %temping%, description
		;hm := FileOpen(fileway, Flags , Encoding)
		;FileAppend, `; %comment%`n, %fileway%,UTF-8
		FileAppend, %temping%: `; ВАЖНО Эту строку И ВЫШЕ не трогать`n`n`MsgBox`, Пустой скрипт`n`nReturn, %fileway%,UTF-8
		SetWorkingDir, %A_AppData%\Malinovka
		MsgBox, Добавлен новый бинд "%temping%" %fileway%
		Reload
		Return
	}

	Get_ini_config(temping, x){
		SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds
		IniRead, key, config.ini, %temping%, key
		IniRead, fileway, config.ini, %temping%, fileway
		IniRead, description, config.ini, %temping%, description
		;MsgBox % A_WorkingDir
		;MsgBox % temping key fileway description
		this.list_hotkey[x] := [temping, key, fileway, description]
		Return
	}

	Get_ini_config_fromrepo(temping, x){
		SetWorkingDir, %A_AppData%\Malinovka
		IniRead, key, bufferfile.ini, %temping%, key
		IniRead, fileway, bufferfile.ini, %temping%, fileway
		IniRead, description, bufferfile.ini, %temping%, description
		;MsgBox % temping fileway description
		this.list_hotkey_fromrepo[x] := [temping, key, fileway, description]
		Return
	}

	Load_binds_repo(WayProfile){
		SetWorkingDir, %WayProfile%
		;MsgBox % WayProfile
		LV_Delete()
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
				this.Get_ini_config(temping, x, WayProfile) ; загрузка всех данных о анк
				;MsgBox % temping keycolum description
				LV_Add("", this.list_hotkey[x][1], this.list_hotkey[x][2], this.list_hotkey[x][4])
				;MsgBox % A_LoopReadLine
			}
			}
		this.list_hotkey :=
		}

	sumscript := x
	Return
	}

	Delete_ini_hotkey_all(Hotkeyname){
		SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds
		IniDelete, config.ini, %Hotkeyname%
		FileDelete, %Hotkeyname%.ahk
		SetWorkingDir, %A_AppData%\Malinovka
		MainInterface.Main_gui()
	Return
}

	Reconfig_ahk_to_Main(){
	SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds
	FileDelete, help_gui.txt
	SetWorkingDir, %A_AppData%\Malinovka
		key := "; END OF UPDATE CODE" ; СДЕЛАТЬ КЛЮЧ В ВЭБЕ, ВТОРОЙ СТРОКОЙ?
		keyIndex = 0
		CustomCodeText :=
		Loop, read, MainBindsFileConfig.ahk, `r, `n
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

		FileDelete, MainBindsFileConfig.ahk
		FileAppend, %CustomCodeText%, MainBindsFileConfig.ahk
		;MsgBox % this.list_hotkey.1.1
		y := MainInterface.sumscript
		x := 0
		b := ""
		key := ""
		FileAppend, AHK by Vitalik_Tokarev`n, %A_AppData%\Malinovka\profile\mybinds\help_gui.txt
		FileAppend, `nЭТО ВСЕ ВАШИ АКТИВНЫЕ БИНДЫ`n, %A_AppData%\Malinovka\profile\mybinds\help_gui.txt
		Loop
		{
			x++
			;MsgBox % nameahk
			description := this.list_hotkey[x][4]
			nameahk := this.list_hotkey[x][3]
			key     := this.list_hotkey[x][2]
			temping := this.list_hotkey[x][1]
			;MsgBox % key
			if (key = b)
			{
				goto labelYes
			}
			else
			{
				inikeytotext = %inikeytotext%`nIniRead`, key%temping%`, config.ini`, %temping%`, key
				hotkeymany = %hotkeymany%`nHotkey, `%key%temping%`%, %temping%
				addresahk = %A_AppData%\Malinovka\profile\mybinds\%nameahk%
				includetotext = %includetotext%`n#Include %addresahk%
				keyforhelp := key
				keyforhelp :=RegExReplace(keyforhelp,"\!","ALT + ")
				keyforhelp :=RegExReplace(keyforhelp,"\^","CTRL + ")
				forguikey = %forguikey%`n%keyforhelp%  %description%
				;MsgBox, %inikeytotext%
			}
			labelYes:
			;inikeytotext = %inikeytotext%`nIniRead`, key%temping%`, config.ini`, %temping%`, key
			
			;MsgBox, Ini load
			

			;MsgBox, % includetotext
			if (x == MainInterface.sumscript)
			{
				FileAppend, %inikeytotext%, %A_AppData%\Malinovka\MainBindsFileConfig.ahk
				FileAppend, %hotkeymany%, %A_AppData%\Malinovka\MainBindsFileConfig.ahk
				FileAppend, `n`Return, %A_AppData%\Malinovka\MainBindsFileConfig.ahk
				FileAppend, %includetotext%, %A_AppData%\Malinovka\MainBindsFileConfig.ahk
				FileAppend, %forguikey%, %A_AppData%\Malinovka\profile\mybinds\help_gui.txt
				Break
			}
		}
	Return
	}
}
SetWorkingDir, %A_AppData%\Malinovka

IfNotExist, %A_AppData%\Malinovka\MainBindsFileConfig
{
	FileRemoveDir, %A_AppData%\Malinovka
	FileCreateDir, %A_AppData%\Malinovka\
}

way = %A_ScriptDir%\%A_ScriptName%
SetWorkingDir, %A_AppData%\Malinovka
IniWrite, %way%, configBTR.ini, options, filewayBTR
SetWorkingDir, %way%

IniRead, chooseORG, configBTR.ini, options, ChoiseProfile
if (chooseORG = "ERROR")
	{
		IniWrite, 1, configBTR.ini, options, ChoiseProfile
	}

IniRead, names, configBTR.ini, mandata, yourname
if (names == "ERROR")
	{
	UrlDownloadToFile https://raw.githubusercontent.com/ViTokarev/malinovka/master/MainBindsFileConfig.ahk, MainBindsFileConfig.ahk
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
   ;MsgBox, %Text%
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
				UrlDownloadToFile, https://raw.githubusercontent.com/ViTokarev/malinovka/master/MainBindsFileConfig.ahk, %A_AppData%\Malinovka\MainBindsFileConfig.ahk
				Reload
				}
			Else
				MsgBox, Ок, конечно, но могли добавить новые фичи для стабильности.
		}
UpdateOk:

if (names = "ERROR")
	Return
Else
	MainInterface.Main_gui()
Return

!r::Reload

/*
WriteChoise:
Gui, Submit, NoHide
IniWrite, %ChooseORGWrite%, configBTR.ini, options, ChoiseProfile
NameProfile := ["ОГИБДД", "МВД", "БЦРБ", "ВЧ"]

		WayProfileOGIBDD = %A_AppData%\Malinovka\profile\ogibdd
		WayProfileMVD = %A_AppData%\Malinovka\profile\mvd
		WayProfileBCRB = %A_AppData%\Malinovka\profile\bcrb
		WayProfileVICH = %A_AppData%\Malinovka\profile\vich
		WayProfileVICH = %A_AppData%\Malinovka\profile\adoons

		WayProfile := [WayProfileOGIBDD, WayProfileMVD, WayProfileBCRB, WayProfileVICH]
		WayProfile := WayProfile[ChooseORGWrite]
		IfNotExist, %WayProfile%
		{
			MsgBox, неудалось загрузить бинды. (Нет папки)
			LV_Delete()
		}
		Else
			MainInterface.Load_binds_repo(WayProfile)
IniRead, chooseORG, configBTR.ini, options, ChoiseProfile
Return
*/

CreateBindGUI:
MainInterface.Gui_CreateBind()
Return

SaveNewBind:
MainInterface.SetNewBind(name, key, description, TextBind)
Return

Download_menu:
	SetWorkingDir, %A_AppData%\Malinovka
	IniRead, chooseORG, configBTR.ini, options, ChoiseProfile
	MainInterface.Download_menu_gui(chooseORG)
	goto Download_menu_list
Return



Download_menu_list:
	SetWorkingDir, %A_AppData%\Malinovka
	this.LV_Delete()
	Gui, Submit, NoHide
	IniWrite, %ChooseORGWrite%, configBTR.ini, options, ChoiseProfile
	IniRead, chooseORG, configBTR.ini, options, ChoiseProfile
	LV_Delete()
	FileDelete, bufferfile.ini
	AHKscriptsDonw := ["ogibdd", "mvd", "bcrb", "vich"]
	nameforDownload := AHKscriptsDonw[chooseORG]
	urltodownload := "https://raw.githubusercontent.com/ViTokarev/malinovka/master/profile/" . nameforDownload . "/config.ini"
	;MsgBox, %urltodownload%

		;MsgBox % urltodownload
		text := wUrlDownloadToVar(urltodownload)
		wUrlDownloadToVar(URL, UserAgent = "")
		{
			ComObjError(false)
			WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
			WebRequest.Open("GET", Url)
			UserAgent ? WebRequest.Option(WinHttpRequestOption_UserAgentString := 0) := UserAgent
			WebRequest.Send()
			;if (WebRequest.ResponseText = "")
			;	msgbox Сервер с биндами не отвечает. Повторите позже.
			Text := WebRequest.ResponseText
			WebRequest := ""
			FileAppend, %Text%, bufferfile.ini
			return
		}

x=0
MainInterface.list_hotkey_fromrepo := []
iniHead := []
		Loop, read, bufferfile.ini
		{
			Loop, parse, A_LoopReadLine, %A_Tab%
			{
			temp1 := RegExMatch(A_LoopReadLine, ".*\[(.*)\]", "$1")

			if (temp1 = 1)
			{
				x++
				temping := RegExReplace(A_LoopReadLine, ".*\[(.*)\]", "$1") ; получение заголовков ini
				iniHead[x] := temping
				
				MainInterface.Get_ini_config_fromrepo(temping, x) ; загрузка всех данных о анк
				;MsgBox % temping
				;MsgBox % temping keycolum description
				LV_Add("", MainInterface.list_hotkey_fromrepo[x][1], MainInterface.list_hotkey_fromrepo[x][2], MainInterface.list_hotkey_fromrepo[x][4])
			}
			}
		}
Return

Loadmybinds:
SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds
x=1
MainInterface.list_hotkey := []
iniHead := []
		Loop, read, config.ini
		{
			Loop, parse, A_LoopReadLine, %A_Tab%
			{
			temp1 := RegExMatch(A_LoopReadLine, ".*\[(.*)\]", "$1")

			if (temp1 = 1)
			{
				temping := RegExReplace(A_LoopReadLine, ".*\[(.*)\]", "$1") ; получение заголовков ini
				iniHead[x] := temping
				MainInterface.Get_ini_config(temping, x) ; загрузка всех данных о анк
				;MsgBox % temping
				;MsgBox % temping keycolum description
				LV_Add("", MainInterface.list_hotkey[x][1], MainInterface.list_hotkey[x][2], MainInterface.list_hotkey[x][4])
				x++
			}
			}
		}
x--
MainInterface.sumscript := x
Return

BackToMenu:
	MainInterface.Main_gui()
Return

DonwloadChoise:
	Gui, 4:font, bold cDark s16, Arial
	Gui, 4:+Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
	Gui, 4:Add, Text, center vMyTextDonwload, Подготовка к загрузке биндов.
	Gui, 4:Show, Center
	SetWorkingDir, %A_AppData%\Malinovka
	IniRead, chooseORG, configBTR.ini, options, ChoiseProfile
	SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds
	AHKscriptsDonw := ["ogibdd", "mvd", "bcrb", "vich"]
	nameforDownload := AHKscriptsDonw[chooseORG]
	CheckedRows :=
	NameAllRows :=
	Sleep, 250
	GuiControl, 4:,MyTextDonwload, Скачиваем новые файлы.
	Loop
	{
	    RowNumber := LV_GetNext(RowNumber, "C")  ; Resume the search at the row after that found by the previous iteration.
	    if not RowNumber  ; The above returned zero, so there are no more selected rows.
	        break
	    ;CheckedRows .= CheckedRows ? "," RowNumber : RowNumber 
	    LV_GetText(NameBindDownl, RowNumber, 1)
	    LV_GetText(NameBindKey, RowNumber, 2)
	    LV_GetText(NameBindDescript, RowNumber, 3)
	    NameAllRows .= NameAllRows ? "," NameBindDownl : NameBindDownl
	    NameBindDownlFor := NameBindDownl . ".ahk"
		urltodownload := "https://raw.githubusercontent.com/ViTokarev/malinovka/master/profile/" . nameforDownload . "/" . NameBindDownlFor
		SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds
		UrlDownloadToFile % urltodownload, % NameBindDownlFor
		;MsgBox % NameBindDownlFor
		FileReadLine, errortestdownl, %NameBindDownlFor%, 1
		if (errortestdownl == "404: Not Found")
		{
			FileDelete, %NameBindDownlFor%
			MsgBox, Ошибка файл бинда `"%NameBindDownl%`" не скачался. (404 путь не найден)
		}
		Else
		{
		IniRead, testkey, config.ini, %NameBindDownl%, key
		if (testkey == "ERROR")
			IniWrite, %NameBindKey%, config.ini, %NameBindDownl%, key
		IniWrite, %NameBindDownlFor%, config.ini, %NameBindDownl%, fileway
		IniWrite, %NameBindDescript%, config.ini, %NameBindDownl%, description
		GuiControl, 4:,MyTextDonwload, %NameBindDownl% - скачан.
		}
	}
	;msgbox % " Rows " CheckedRows " are Checked"
	;msgbox % NameAllRows
	GuiControl, 4:,MyTextDonwload, Загрузка завершена.
	Sleep, 500
	Gui, 4:Destroy
Return

ClickDownlList:
/*
if A_GuiEvent = DoubleClick
{
    LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
    ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
}
if (A_GuiEvent = "I" and errorlevel = "c")
{
		RowNumber: = LV_GetNext()
		;msgbox % A_EventInfo
		msgbox % RowNumber
}
*/
/*
If (A_GuiEvent == "I") {
        If (ErrorLevel == "C")
        {
			ToolTip, % "Row " . A_EventInfo . " is checked."
			LV_GetText(Hotkeyname, A_EventInfo, 1)
			MsgBox % Hotkeyname
        }
        Else If (ErrorLevel == "c")
            ToolTip, % "Row " . A_EventInfo . " is unchecked."
}
*/
/*
if (A_GuiEvent = "I")
{
    if InStr(ErrorLevel, "c", true)
    {
        LV_GetText(Title, A_EventInfo, 1)
        msgbox % "Remove:`nTitle = " . Title "`nArtist = " . Artist
    }
    if InStr(ErrorLevel, "C", true)
    {
        LV_GetText(Title, A_EventInfo, 1)
        LV_GetText(Artist, A_EventInfo, 2)
        msgbox % "Insert:`nTitle = " . Title "`nArtist = " . Artist
    }
}
*/
Return

RCheckAll:
	LV_Modify(0, "-Check")
Return

RCheckAlloff:
	LV_Modify(0, "+Check")
Return

LableEditHotkey:
	RowNumber :=
	Hotkeyname :=
	RowNumber := LV_GetNext(RowNumber)
	LV_GetText(Hotkeyname, RowNumber, 1)
	MainInterface.Edit_script_config(Hotkeyname)
Return

SaveCode:
	Gui, 2:Submit
	MainInterface.Save_script_config(Hotkeyname, Newkey, code, descripti)
Return

LableDeleteHotkey:
	RowNumber :=
	Hotkeyname :=
	RowNumber := LV_GetNext(RowNumber)
	LV_GetText(Hotkeyname, RowNumber, 1)
	MainInterface.Delete_ini_hotkey_all(Hotkeyname)
Return

GuiClose:
	MainInterface.Reconfig_ahk_to_Main()
	Run "%A_AppData%\Malinovka\MainBindsFileConfig.ahk"
ExitApp

GuiContextMenu:
	Menu, MyMenuBar, Add, Редактировать, LableEditHotkey
	Menu, MyMenuBar, Add, Удалить, LableDeleteHotkey
	Menu, MyMenuBar, Show, %A_GuiX%, %A_GuiY%
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

SaveNewKey:
	GUI, Submit, NoHide
	MainInterface.Add_hotkey_Saveini(key, temping, comment)
Return

AddCreateBind:
	MainInterface.Add_hotkey()
Return

GUIallUpdateList:
	MainInterface.Main_gui()
Return

ChangeName:
Gui, 1:-AlwaysOnTop
SetWorkingDir, %A_AppData%\Malinovka
IniRead, names, configBTR.ini, mandata, yourname
IniRead, rang, configBTR.ini, mandata, yourrang

MainInterface.ChangeYourName(names, rang)
Return

ChangeNameDone:
GUI, Submit, NoHide
if (NewName == "Никита Носов")
		{
			MsgBox, Введите СВОЕ имя.
			Return

		}
SetWorkingDir, %A_AppData%\Malinovka

if (CheckDonwl == 1)
	{
	Gui, 1:Destroy
	FileDelete, bufferfile.ini
	Gui, 3:Destroy
	Gui, 4:font, bold cRed s16, Arial
	Gui, 4:+Lastfound +ToolWindow +AlwaysOnTop -Caption +Border
	Gui, 4:Add, Text, center vTextFirstDonwload, Начинаем скачивать ваши бинды 
	Gui, 4:Color, e9e9e9
	Gui, 4:Show
	AHKscriptsDonw := ["ogibdd", "mvd", "bcrb", "vich"]
	nameforDownload := AHKscriptsDonw[ChoiseToDonwl]
	urltodownload := "https://raw.githubusercontent.com/ViTokarev/malinovka/master/profile/" . nameforDownload . "/config.ini"
	whr := ComObjCreate("WinHttp.WinHttpRequest.5.1") 
	whr.Open("GET", urltodownload, true) 
	whr.Send() 
	whr.WaitForResponse() 
	listbinsfirst := whr.ResponseText ; получили список биндов
	GuiControl, 4:,TextFirstDonwload, Получаем список нужных биндов
	FileAppend, %listbinsfirst%, bufferfile.ini

x=0
MainInterface.list_hotkey_fromrepo := []
iniHead := []
		Loop, read, bufferfile.ini
		{
			Loop, parse, A_LoopReadLine, %A_Tab%
			{
			temp1 := RegExMatch(A_LoopReadLine, ".*\[(.*)\]", "$1")

			if (temp1 = 1)
			{
				x++
				temping := RegExReplace(A_LoopReadLine, ".*\[(.*)\]", "$1") ; получение заголовков ini
				iniHead[x] := temping
				;MsgBox, %temping%
				MainInterface.Get_ini_config_fromrepo(temping, x) ; загрузка всех данных о анк
			}
			}	
		}
sumscript := x
GuiControl, 4:,TextFirstDonwload, Начинаю загрузку биндов
IfNotExist %A_AppData%\Malinovka\profile\mybinds\
	FileCreateDir, %A_AppData%\Malinovka\profile\mybinds
SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds\
x=0
Loop
	{
		x++
	    NameBindDownl := MainInterface.list_hotkey_fromrepo[x][1]
	    NameBindKey := MainInterface.list_hotkey_fromrepo[x][2]
	    NameBindDescript := MainInterface.list_hotkey_fromrepo[x][4]
	    NameAllRows .= NameAllRows ? "," NameBindDownl : NameBindDownl
	    NameBindDownlFor := NameBindDownl . ".ahk"
		urltodownload := "https://raw.githubusercontent.com/ViTokarev/malinovka/master/profile/" . nameforDownload . "/" . NameBindDownlFor
		;MsgBox, %urltodownload%

		UrlDownloadToFile % urltodownload, %NameBindDownlFor%
		;MsgBox, имя папки: %nameforDownload% имя бинда: %NameBindDownlFor%

		FileReadLine, errortestdownl, %NameBindDownlFor%, 1
		if (errortestdownl == "404: Not Found")
		{
			FileDelete, %NameBindDownlFor%
			Gui, 4:Hide
			MsgBox, Ошибка файл бинда `"%NameBindDownl%`" не скачался. (404 путь не найден)
		}
		Else
		{
		IniRead, testkey, config.ini, %NameBindDownl%, key
		if (testkey == "ERROR")
		IniWrite, %NameBindKey%, config.ini, %NameBindDownl%, key
		IniWrite, %NameBindDownlFor%, config.ini, %NameBindDownl%, fileway
		IniWrite, %NameBindDescript%, config.ini, %NameBindDownl%, description
		GuiControl, 4:,TextFirstDonwload, Бинд `"%NameBindDownl%`" скачан.
		if (x == sumscript)
			Break
		}
	}
GuiControl, 4:,TextFirstDonwload, Файл конфигурации создан.
Sleep, 750
GuiControl, 4:,TextFirstDonwload, Добро пожаловать.
Sleep, 1500
}
SetWorkingDir, %A_AppData%\Malinovka
IniWrite, %NewName%, configBTR.ini, mandata, yourname
IniWrite, %NewRang%, configBTR.ini, mandata, yourrang
IniWrite, %ChoiseToDonwl%, configBTR.ini, mandata, ChoiseDonwl
;MsgBox, Ваше имя: %NewName%`nВаше звание: %NewRang%
Reload
Return

DeleteAllMyBinds:
MsgBox, 4,, Точно удалить ВСЕ ваши бинды?
	IfMsgBox, No
		Return
SetWorkingDir, %A_AppData%\Malinovka\profile
FileRemoveDir, mybinds, 1
FileCreateDir, mybinds
LV_Delete()
MainInterface.Udpate_gui()
Return

OpenFolderMain:
	Run, %A_AppData%\Malinovka
	Gui, -AlwaysOnTop
Return

OpenFolderScreens:
	Run, %A_MyDocuments%\Malinovka\screens
	Gui, -AlwaysOnTop
Return

OpenChatlog:
	Run, %A_MyDocuments%\Malinovka\chatlog.txt
	Gui, -AlwaysOnTop
Return

MenuOnMain:
	MainInterface.GuiMainMenu()
Return

UpdateHelpListZakon:
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
Return

3GuiClose:
	Gui, -AlwaysOnTop
	if (names not in "ERROR")
		MsgBox, Данные не сохранились, нажмите "сохранить"
	Else
		MsgBox, Введите свое имя и звание, без него АНК не будет работать.
Return