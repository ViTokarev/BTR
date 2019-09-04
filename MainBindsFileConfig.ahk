; ###VERSION.0.3###
SetWorkingDir, %A_AppData%\Malinovka
IniRead, names, configBTR.ini, mandata, yourname
IniRead, rang, configBTR.ini, mandata, yourrang
IniRead, keyhelp, configBTR.ini, options, keyhelp
if (keyhelp == "ERROR")
	IniWrite, Del, configBTR.ini, options, keyhelp
	IniRead, keyhelp, configBTR.ini, options, keyhelp
Hotkey, %keyhelp%, keyhelp
SetWorkingDir, %A_AppData%\Malinovka\profile\mybinds

SoundBeep, 750
goto MainCode

Ins::
	SetWorkingDir, %A_AppData%\Malinovka
	IniWrite, 0, configBTR.ini, options, triggeron
	way = %A_WorkingDir%\%A_ScriptName%
	SetWorkingDir, %A_AppData%\Malinovka
	IniRead, wayToBTR, configBTR.ini, options, filewayBTR
	Run % wayToBTR
ExitApp

keyhelp:
	FileRead, help_guikey, %A_AppData%\Malinovka\profile\mybinds\help_gui.txt
	Gui, Destroy
	Gui Add, Text,, % help_guikey
	BlockInput on
	Gui +Lastfound +ToolWindow +AlwaysOnTop -Caption -Border
	WinSet TransColor, 1
	Gui Show, NA
	Sleep, 200
	KeyWait, %keyhelp%, D
	Send,{F6}
	Send,{F6}
	Gui, Show, Hide
	BlockInput off
	Gui, Destroy
Return

!r::Reload
Return


MainCode:
; END OF UPDATE CODE
