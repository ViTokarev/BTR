; ###VERSION.0.1###
SetWorkingDir, %A_AppData%\Malinovka\profile\

Gosub MainCode

Ins::
	way = %A_WorkingDir%
	SetWorkingDir, %A_AppData%\Malinovka
	IniRead, wayToBTR, configBTR.ini, options, filewayBTR
	Run % wayToBTR
ExitApp

!r::Reload
Return


MainCode:
; END OF UPDATE CODE'n
