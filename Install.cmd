@ECHO OFF
cls

ECHO This will install Box applications and their prerequisites.
ECHO.
ECHO **********************INSTRUCTIONS*********************
ECHO.
ECHO Please close all windows that are currently open.
ECHO.
ECHO Watch for new windows being created.
ECHO.
ECHO If you receive a Yes or No prompt, please press Yes
ECHO.
ECHO If you receive a Run or Cancel prompt, please press Run
ECHO.
ECHO *******************************************************
ECHO.

pause

ECHO. 
ECHO -------------------------------------------------------
ECHO.
ECHO ***************Installing Prerequisites****************
ECHO.
ECHO -------------------------------------------------------
ECHO.

if exist "C:\Program Files\Microsoft.NET\RedistList\AssemblyList_4_client.xml" goto VSTOOLS

ECHO *************Installing Microsoft .Net 4.0*************
ECHO *************(this may take a little bit)**************

.\installers\dotNetFx40_Full_setup.exe /norestart /q /log .\logs\Net4-%username%.txt

ECHO.
ECHO -------------------------------------------------------
ECHO.

:VSTOOLS
ECHO ***Installing MS Visual Studio Tools for Office 2010***
.\installers\vstor_redist.exe /norestart /q /log .\logs\VSTools-%username%.txt

ECHO.
ECHO -------------------------------------------------------
ECHO.
ECHO ***************Prerequisites installed!****************
ECHO.
ECHO -------------------------------------------------------
ECHO.
ECHO ***********Checking Bit Version of MS Office***********
ECHO.							   
ECHO -------------------------------------------------------

for /f "skip=4 tokens=1-3*" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Office\14.0\Outlook /v Bitness') do (
	if %%k == x86 goto 32Office
	if %%k == x64 goto 64Office
	goto BoxSync
	)

:32Office
ECHO.
ECHO *****Installing Box Applications for 32-bit Office*****
ECHO.
ECHO -------------------------------------------------------
ECHO.
ECHO ***********Installing Box for Outlook 32-bit***********

msiexec /i installers\BoxMSOutlook32.msi /passive /log .\logs\BoxOutlook-%username%.txt

ECHO.
ECHO -------------------------------------------------------
ECHO.
ECHO ***********Installing Box for Office 32-bit************

msiexec /i installers\BoxMSOffice32.msi /passive /log .\logs\BoxOffice-%username%.txt

ECHO.
goto BoxSync

:64Office
ECHO.
ECHO *****Installing Box Applications for 64-bit Office*****
ECHO.
ECHO -------------------------------------------------------
ECHO.
ECHO **********Installing Box for Outlook 64-bit************

msiexec /i installers\BoxMSOutlook64.msi /passive /log .\logs\BoxOutlook-%username%.txt

ECHO.
ECHO -------------------------------------------------------
ECHO.
ECHO ***********Installing Box for Office 64-bit************

msiexec /i installers\BoxMSOffice64.msi /passive /log .\logs\BoxOffice-%username%.txt

ECHO.
goto 64bit

:BoxSync
ECHO -------------------------------------------------------
ECHO.
ECHO ***********Checking Bit Version for Box Sync***********
ECHO.
ECHO -------------------------------------------------------

IF [%PROCESSOR_ARCHITECTURE%] == [AMD64] goto 64Bit

REM This is the 32-bit installation file for Box Sync.

ECHO.
ECHO ********Installing Box Sync for Windows 32-bit*********

msiexec /i installers\BoxSyncWindows32.msi /passive /log .\logs\BoxSync-%username%.txt

ECHO.
ECHO -------------------------------------------------------
ECHO.
goto end

:64bit

REM This is the 64-bit installation file for Box Sync.

ECHO.
ECHO *********Installing Box Sync for Windows 64-bit********

msiexec /i installers\BoxSyncWindows64.msi /passive /log .\logs\BoxSync-%username%.txt

ECHO.
ECHO -------------------------------------------------------
ECHO.
goto end

:end
ECHO                        All done!
ECHO.
ECHO -------------------------------------------------------
pause