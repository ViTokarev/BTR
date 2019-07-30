; ###VERSION:0.3###
; тестовая сборка для обновлений71 ПРОВЕРКА КРАКЕНА НА БОМ

F8::
FileReadLine, version, OGIBDD.ahk, 1
text := UrlDownloadToVar("https://raw.githubusercontent.com/ViTokarev/malinovka/master/OGIBDD.ahk")
UrlDownloadToVar(URL, UserAgent = "")
{
   WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   WebRequest.Open("GET", Url)
   UserAgent ? WebRequest.Option(WinHttpRequestOption_UserAgentString := 0) := UserAgent
   WebRequest.Send()
   Text := WebRequest.ResponseText
   WebRequest := ""
   return Text
}
If InStr(Text, version)
  MsgBox, У вас установлена последняя версия ahk ОГИБДД
Else
  {
  MsgBox, 4, Обновление, Вы хотите обновить?
    {
     IfMsgBox Yes
        goto UpdateCode
     Else
        MsgBox, ну ок, но позже обновите.
    }
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
    if (A_Index > 50)
    {
        if (keyIndex > 50)
            CustomCodeText = %CustomCodeText% `n %A_LoopReadLine%

        If InStr(A_LoopReadLine, key)
        {
          keyIndex=%A_index%
          keyIndex++
          CustomCodeText = %A_LoopReadLine%
        }
    }
}
UrlDownloadToFile, https://raw.githubusercontent.com/ViTokarev/malinovka/master/OGIBDD.ahk, OGIBDD.ahk
FileAppend, %CustomCodeText%, OGIBDD.ahk
SplashTextOff
SoundBeep, 750
Reload
Return

; Не назначайте ниже свои ahk на клавиши которые заняты выше!
; ДАЛЬШЕ (НИЖЕ) ДОБАВЛЯЙТЕ ЛЮБЫЕ ВАШИ АНК КОТОРЫЕ НЕ УДАЛЯТСЯ ПОСЛЕ ОБНОВЛЕНИЙ! Не удаляйте строку НИЖЕ!!
; END OF UPDATE CODE
;начало

/*
тест текста после
*/


/*
найти байт поледнего ключа и по байтам стереть файл, rawWrite 0000000
найти схему на мосвкич
*/