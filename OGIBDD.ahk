FileEncoding, UTF-8		;	тестовая сборка для обновлений

SoundBeep, 750
Return

F1::
UrlDownloadToFile, https://github.com/ViTokarev/malinovka/OGIBDD.ahk
sleep, 2000
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nСкачиваем обновленную версию.
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nЗапускаем обновленную версию.
sleep, 2000
Return
