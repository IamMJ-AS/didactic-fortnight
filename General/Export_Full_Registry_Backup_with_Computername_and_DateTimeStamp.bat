@ECHO OFF
TITLE Begin Launch Sequence
SET month=%date:~4,2%
SET day=%date:~7,2%
SET year=%date:~10,4%
SET hour=%time:~0,2%
SET minutes=%time:~3,2%
SET seconds=%time:~6,2%
SET DateStamp=%year%%month%%day%_%hour%%minutes%%seconds%

::
ECHO regedit /E %cd%\%computername%_full_backup_%DateStamp%.reg
ECHO Is this correct?
CHOICE /T 10 /D N /M "Press y to continue or N to abort" 
IF ERRORLEVEL 2 GOTO REDLIGHT
IF ERRORLEVEL 1 GOTO GREENLIGHT

:GREENLIGHT
ECHO The gremlins are starting to create a backup
TITLE Creating Backup...
regedit /E %cd%\%computername%_full_backup_%DateStamp%.reg
TITLE Backup created!
ECHO Backup Created!
GOTO ENDING

:REDLIGHT
TITLE Expected ERROR - Ha Ha Ha
ECHO Seems like something was lost in translation, better luck next time. 
GOTO ENDING

:ENDING
ECHO Gooodbye!
pause

