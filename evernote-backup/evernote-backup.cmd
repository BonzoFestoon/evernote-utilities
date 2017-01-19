
@echo off
cls
set ROOT_PATH=E:\evernote-backup
set ZIP_APP_PATH=C:\OneDrive\Portable Apps\PortableApps\7-ZipPortable\App\7-Zip
REM Get the date and time
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set DATETIME_STAMP=%YYYY%%MM%%DD%T%HH%%Min%
set BACKUP_PATH=%ROOT_PATH%\%DATETIME_STAMP%
REM ENScript App Path Reg Key - Value stored in default
set ENSCRIPT_REG="HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\ENScript.exe"
REM Check to see if ENScript is installed
reg query %ENSCRIPT_REG% /ve 2>nul || (echo ENScript not installed! & exit /b 1)
REM Get the full path to ENScript from the registry
set ENSCRIPT_PATH=
for /f "tokens=2,*" %%a in ('reg query %ENSCRIPT_REG% /ve ^| findstr ^(Default^)') do (
    set ENSCRIPT_PATH=%%b
)

mkdir %BACKUP_PATH%

for /f "tokens=*" %%n in ('"%ENSCRIPT_PATH%" listNotebooks') do (
	"%ENSCRIPT_PATH%" exportNotes /q notebook:\""%%n"\" /f "%BACKUP_PATH%\%%n.enex"
	if errorlevel 0 (
		REM Plain ZIP - "%ZIP_APP_PATH%\7z.exe" a -mx9 "%BACKUP_PATH%\%%n.zip" "%BACKUP_PATH%\%%n.enex"
		REM 7Z format resulted in noticably smaller archives
		"%ZIP_APP_PATH%\7z.exe" a -t7z -mx9 -sdel "%BACKUP_PATH%\%%n.7z" "%BACKUP_PATH%\%%n.enex" >nul
		REM Add notes to log the backup success or failure
		if errorlevel 0 (
			echo Backed up %%n to "%BACKUP_PATH%\%%n.7z" | "%ENSCRIPT_PATH%" createNote /n "%%n" /i "Backed up all notes" /t Backup /t Log
		) else (
			echo FAILED to back up %%n to "%BACKUP_PATH%\%%n.7z" | "%ENSCRIPT_PATH%" createNote /n "%%n" /i "FAILED to back up all notes" /t Backup /t Log /t ERROR
		)
	)
)