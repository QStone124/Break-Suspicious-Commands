@echo off


:: DSC
:: Made By James3407
:: Batch Script


:: Request 
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0" 



:: MAIN
echo Please tell me which batch file to scan
set /p filepath=
move "%filepath%*.*" "%cd%\box"
cd box
SETLOCAL ENABLEDELAYEDEXPANSION
for %%c in (*.cmd *.bat) do set filename=%%c
ren *.bat *.txt
ren *.cmd *.txt
cd ..
del /s /q "%cd%\Bsname.txt"
echo.%filename%>>Bsname.txt
box\fart.exe Bsname.txt bat txt
cls


:: FILENAME
FOR /F %%i IN (Bsname.txt) DO @echo %%i
FOR /F %%i IN (Bsname.txt) DO set fn=%%i 

:: SCAN
cd box
fart.exe %fn% del CrashByCSC
fart.exe %fn% reg CrashByCSC
fart.exe %fn% powershell CrashByCSC
fart.exe %fn% curl CrashByCSC
fart.exe %fn% ren CrashByCSC
fart.exe %fn% "cd /s /q" CrashByCSC
ren *.txt *.bat
cls
echo Done in removing suspicious commands
pause


