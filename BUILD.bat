@echo off
Setlocal EnableDelayedExpansion
echo.
echo Dii Party ISO Builder
echo Patcher by Lami and edited by Exorcism, Mod by NicholassTV
echo Powered by WIT by Wiimm
pause

echo.
echo Checking files...
IF NOT EXIST "SUP" (
    echo.
    echo Cannot find the SUP folder
    echo Please be sure to run this in the same directory as 
    echo the SUP folder
    pause
    echo Closing Down...
    exit
)
IF EXIST Wii_Party (
    GOTO CHECK
)

echo.
echo Unpacking The game...
wit\wit.exe extract -s ../ -1 -n SUP.01 . Wii_Party --psel=DATA -ovv

:CHECK
IF EXIST Wii_Party\files\locale\en_EU\boot\strap.arc.lz (
	SET GAMEID=SUPP01
	SET LETTER=P
	echo Detected version: PAL
	GOTO COPY
	)
IF EXIST Wii_Party\files\locale\en_US\boot\strap.arc.lz (
	SET GAMEID=SUPE01
	SET LETTER=E
	echo Detected version: NTSC-U
	GOTO COPY
	)
IF EXIST Wii_Party\files\locale\fr_FR\boot\strap.arc.lz (
	SET GAMEID=SUPJ01
	SET LETTER=J
	echo Detected version: NTSC-J
	GOTO COPY
	)
IF EXIST Wii_Party\files\locale\ko_KR\boot\strap.arc.lz (
	SET GAMEID=SUPK01
	SET LETTER=K
	echo Detected version: NTSC-K
	GOTO COPY
	)

echo.
echo Cannot find a valid Wii Party ISO/WBFS file.
echo Please make sure you have one in the same directory
echo as this script. Exiting...
IF EXIST "Wii_Party" (
    del /q Wii_Party
)
pause
exit

:COPY
echo.
echo Copying Files...
 xcopy "SUP\" "Wii_Party\files\" /i /e /y

:TYPE
echo.
echo Copying is complete
echo Time to selct the output format
echo 1. ISO
echo 2. WBFS
echo 3. Extracted Filesystem
SET /P FILETYPE=Enter the number corresponding to the format you want: 

IF %FILETYPE%==1 (
	SET FILE=iso
	GOTO BUILD
	)
IF %FILETYPE%==2 (
	SET FILE=wbfs
	GOTO BUILD
	)
IF %FILETYPE%==3 (
    SET FILE=extr
	GOTO DONE
	)
echo.
echo Invalid option. (Tip: choose the number)
pause
GOTO TYPE

:BUILD
echo.
echo Now rebuilding your %FILE%
wit\wit.exe copy Wii_Party "Dii Party [%GAMEID%].%FILE%" -ovv --id=....01
GOTO DONE

:DONE
if %FILE%==extr (
    ren Wii_Party "Dii Party [%GAMEID%]"
    echo.
    echo All Done!
    pause
    exit
)
echo.
echo All Done!
echo Cleaning up...
rmdir Wii_Party /s /q
pause
exit