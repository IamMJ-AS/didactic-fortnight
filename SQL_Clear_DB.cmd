net stop "AirStrip Synchronization Service"
net stop "AirStrip Synchronization Service"
ping 127.0.0.1 -n 6 >nul
sqlcmd -S TENPRVAIR01\SQLEXPRESS -d SynchronizationDatabase -Q "EXEC dbo.ClearDatabase"
net start "AirStrip Synchronization Service"
pause