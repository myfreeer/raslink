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
:Main
call :BeginDateAndTime
set v4dns1=223.5.5.5
set v4dns2=223.6.6.6
set v6dns=2001:470:20::2
set _u=USERNAME HERE
set _p=PASSWORD HERE
FOR /F "skip=4 eol=命 DELIMS= " %%l IN ('net share') DO @net share %%l /delete
if not exist %ALLUSERSPROFILE%\Microsoft\Network\Connections\Pbk ( md %ALLUSERSPROFILE%\Microsoft\Network\Connections\Pbk\ ) else ( rasphone.exe /h 宽带连接 )
copy /y "%~dp0\rasphone.pbk" "%ALLUSERSPROFILE%\Microsoft\Network\Connections\Pbk\rasphone.pbk"||pause
rasdial.exe 宽带连接 %_u% %_p% ||rasdial.exe 宽带连接 %_u% %_p% /PHONEBOOK:"%ALLUSERSPROFILE%\Microsoft\Network\Connections\Pbk\rasphone.pbk ||rasdial.exe 宽带连接 %_u% %_p% /PHONEBOOK:"%~dp0\rasphone.pbk"||pause
call :antispy
ping -n 1 2001:4860:4860::8888 >nul && call :ipv6 ||call :ipv4
call :EndDateAndTime
timeout /t 1200

:Keep-alive
rasphone.exe /h 宽带连接
rasdial.exe 宽带连接 %_u% %_p% ||rasdial.exe 宽带连接 %_u% %_p% /PHONEBOOK:"%ALLUSERSPROFILE%\Microsoft\Network\Connections\Pbk\rasphone.pbk ||rasdial.exe 宽带连接 %_u% %_p% /PHONEBOOK:"%~dp0\rasphone.pbk"||rasphone.exe /h 宽带连接
timeout /t 620
goto :Keep-alive

:ipv6
echo ipv6 enabled
attrib -r -s -h %systemroot%\system32\drivers\etc\hosts
if exist hosts.txt type hosts.txt >%systemroot%\system32\drivers\etc\hosts
attrib +r %systemroot%\system32\drivers\etc\hosts
exit /B

:ipv4
echo ipv4 only
attrib -r -s -h %systemroot%\system32\drivers\etc\hosts
if exist hostsv4.txt type hostsv4.txt >%systemroot%\system32\drivers\etc\hosts
attrib +r %systemroot%\system32\drivers\etc\hosts
exit /B

:antispy
@SCHTASKS /Change /DISABLE /TN "Microsoft\Office\Office ClickToRun Service Monitor" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Application Experience\AitAgent" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Application Experience\StartupAppTask" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Autochk\Proxy" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Office\OfficeTelemetry\AgentFallBack2016" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Office\OfficeTelemetry\OfficeTelemetryAgentLogOn2016" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Maintenance\WinSAT" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\ActivateWindowsSearch" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\ConfigureInternetTimeService" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\DispatchRecoveryTasks" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\ehDRMInit" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\InstallPlayReady" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\mcupdate" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\MediaCenterRecoveryTask" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\ObjectStoreRecoveryTask" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\OCURActivate" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\OCURDiscovery" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\PBDADiscovery" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\PBDADiscoveryW1" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\PBDADiscoveryW2" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\PvrRecoveryTask" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\PvrScheduleTask" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\RegisterSearch" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\ReindexSearchRoot" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\SqlLiteRecoveryTask" >nul 2>nul
@SCHTASKS /Change /DISABLE /TN "Microsoft\Windows\Media Center\UpdateRecordPath" >nul 2>nul
exit /B


:BeginDateAndTime
set start=%time%
SET startdate=%date%
FOR /F "DELIMS=" %%T IN ('TIME /T') DO SET starttime=%%T
SET @HOUR=%starttime:~0,2%
SET @SUFFIX=%starttime:~5,1%
IF /I "%@SUFFIX%"=="A" IF %@HOUR% EQU 12 SET @HOUR=00
IF /I "%@SUFFIX%"=="P" IF %@HOUR% LSS 12 SET /A @HOUR=%@HOUR% + 12
SET @NOW=%@HOUR%%starttime:~3,2%
SET @NOW=%@NOW: =0%
set Year=
for /f "skip=2" %%x in ('wmic Path Win32_LocalTime get Year^,Month^,Day^,Hour^,Minute^,Second /Format:List') do (
  if not defined Year set %%x
)
if %Hour% LSS 12 (
  set ampm=AM
  if %Hour%==0 set Hour=12
) else (
  set ampm=PM
  set /a Hour-=12
)
if %Minute% LSS 10 set Minute=0%Minute%
if %Hour% LSS 10 set Hour=0%Hour%
if %Second% LSS 10 set Second=0%Second%
set StartTimestamp=%Hour%:%Minute%:%Second% %ampm%
SET StartTimestamp1=%time:~0,2%:%time:~3,2%:%Second%
echo 进程开始于 %startdate% // %StartTimestamp% -- %StartTimestamp1% //
exit /B

:EndDateAndTime
set end=%time%
set options="tokens=1-4 delims=:."
for /f %options% %%a in ("%start%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%end%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100
set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %hours% lss 0 set /a hours = 24%hours%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if 1%ms% lss 100 set ms=0%ms%
set /a totalsecs = %hours%*3600 + %mins%*60 + %secs% 
SET enddate=%date%
FOR /F "DELIMS=" %%T IN ('TIME /T') DO SET endtime=%%T
SET @HOUR=%endtime:~0,2%
SET @SUFFIX=%endtime:~5,1%
IF /I "%@SUFFIX%"=="A" IF %@HOUR% EQU 12 SET @HOUR=00
IF /I "%@SUFFIX%"=="P" IF %@HOUR% LSS 12 SET /A @HOUR=%@HOUR% + 12
SET @NOW=%@HOUR%%endtime:~3,2%
SET @NOW=%@NOW: =0%
set Year=
for /f "skip=2" %%x in ('wmic Path Win32_LocalTime get Year^,Month^,Day^,Hour^,Minute^,Second /Format:List') do (
  if not defined Year set %%x
)
if %Hour% LSS 12 (
  set ampm=AM
  if %Hour%==0 set Hour=12
) else (
  set ampm=PM
  set /a Hour-=12
)
if %Minute% LSS 10 set Minute=0%Minute%
if %Hour% LSS 10 set Hour=0%Hour%
if %Second% LSS 10 set Second=0%Second%
set EndTimestamp=%Hour%:%Minute%:%Second% %ampm%
SET EndTimestamp1=%time:~0,2%:%time:~3,2%:%Second%
echo:
echo 进程完成于 %date% // %EndTimestamp% -- %EndTimestamp1% //
IF %mins% GEQ 1 (
goto :WithMinutes
) else ( 
goto :WithoutMinutes
)
:WithMinutes
echo 进程耗时 %mins%分钟%secs%秒（共计%totalsecs%秒）。
goto :End
:WithoutMinutes
echo 进程耗时 %totalsecs% 秒。
:End
exit /B
