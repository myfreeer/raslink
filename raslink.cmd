@echo off
setlocal EnableExtensions EnableDelayedExpansion
color 1f
:--------------------------------------------------------------------------
REG QUERY "HKU\S-1-5-19" >nul 2>&1
if %errorlevel% NEQ 0 goto :UACPrompt
goto :gotAdmin
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~fs0 %*", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /b
:gotAdmin
pushd "%~dp0"
:--------------------------------------------------------------------------
title rasdial(pppoe)

set _u=USERNAME HERE
set _p=PASSWORD HERE

if not exist C:\ProgramData\Microsoft\Network\Connections\Pbk ( md C:\ProgramData\Microsoft\Network\Connections\Pbk\ ) else ( rasphone.exe /h 宽带连接 )
copy /y "%~dp0\rasphone.pbk" "C:\ProgramData\Microsoft\Network\Connections\Pbk\rasphone.pbk"||pause
rasdial.exe 宽带连接 %_u% %_p% ||rasdial.exe 宽带连接 %_u% %_p% /PHONEBOOK:"C:\ProgramData\Microsoft\Network\Connections\Pbk\rasphone.pbk ||rasdial.exe 宽带连接 %_u% %_p% /PHONEBOOK:"%~dp0\rasphone.pbk"||pause
timeout /t 120
:Keep-alive
rasphone.exe /h 宽带连接
rasdial.exe 宽带连接 %_u% %_p% ||rasdial.exe 宽带连接 %_u% %_p% /PHONEBOOK:"C:\ProgramData\Microsoft\Network\Connections\Pbk\rasphone.pbk ||rasdial.exe 宽带连接 %_u% %_p% /PHONEBOOK:"%~dp0\rasphone.pbk"||rasphone.exe /h 宽带连接
timeout /t 620
goto :Keep-alive
