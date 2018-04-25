@echo off

IF EXIST "C:\inetpub\logs\LogFiles\W3SVC3" (
goto DeleteLogs
) ELSE (
echo.
echo ********************************************************************************************************
echo *  *                                                                           *  *                                                             *  *
echo ****Please call D-SCOPE SYSTEMS TO CORRECT THIS ISSUE***UNABLE TO CLEAR IIS LOGS***
echo *  *                                                                           *  *                                                             *  *
echo ********************************************************************************************************
echo.
echo.
pause
)

:DeleteLogs
del /q  "C:\inetpub\logs\LogFiles\W3SVC3"
del /q  "C:\inetpub\logs\LogFiles\W3SVC2"