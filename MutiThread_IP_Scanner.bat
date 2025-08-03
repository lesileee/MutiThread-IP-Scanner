@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 65001>NUL

ECHO --------------------------
ECHO  MultiThreaded IP Scanner
ECHO --------------------------

IF NOT EXIST "TMP.TXT" (
	TYPE NUL > TMP.TXT
)
SET "OPT=TMP.TXT"

IF NOT EXIST "REPORT.TXT" (
	TYPE NUL > REPORT.TXT
)
SET "RES=REPORT.TXT"


::USER INPUT
SET /P IPRANGE=Enter IP range(e.g., 192.168.1.1-254):
FOR /F "TOKENS=1,2 DELIMS=-" %%A IN ("%IPRANGE%") DO (
    SET IP_START=%%A
    SET END=%%B
)
SET PREFIX=%IP_START:~0,-1%
SET START=%IP_START:~-1%

SET MAX_THREAD=20
SET CNT=0

FOR /L %%I IN (%START%,1,%END%) DO (
    START /B "IP SCANNER" CMD /C "(PING -n 2 -w 500 %PREFIX%%%I | FIND "TTL=">NUL) && (ECHO %PREFIX%%%I ONLINE & ECHO %PREFIX%%%I>>%OPT%) || (ECHO %PREFIX%%%I OFFLINE)"
    SET /A CNT+=1
    IF !CNT! GEQ !MAX_THREAD! (
        TIMEOUT /T 3 >NUL
        SET /A CNT=0
    ) 
)

::SORT
powershell -Command "Get-Content 'TMP.txt' | Sort-Object { [version]$_ } | Out-File 'REPORT.txt' -Append"
powershell -Command "Add-Content -Path 'REPORT.txt' -Value 'ALL ONLINE IPs ARE LISTED ABOVE' "

TIMEOUT /T 5 >NUL
DEL %OPT%
ECHO -----------------------------------------
ECHO             FINISHED SCANNING
ECHO ALL RESULTS HAD BEEN SAVED TO "%CD%\%RES%"
ECHO.PRESS ANY BUTTON TO CONTINUE...
PAUSE>NUL