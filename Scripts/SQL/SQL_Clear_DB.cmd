net stop "AirStrip Synchronization Service"
net stop "AirStrip Synchronization Service"
ping 127.0.0.1 -n 6 >nul
sqlcmd -S BMH-VAPP-001 -U AOBUser -P airstrip -d SynchronizationDatabase -Q "EXEC dbo.ClearDatabase"
sqlcmd -S BMH-VAPP-001 -U AOBUser -P airstrip -Q "use AirStripSiteConfiguration truncate table SessionAuthorizationLocation"
sqlcmd -S BMH-VAPP-001 -U AOBUser -P airstrip -Q "DBCC SHRINKDATABASE (SynchronizationDatabase)"
sqlcmd -S BMH-VAPP-001 -U AOBUser -P airstrip -Q "DBCC SHRINKDATABASE (AirStripSiteConfiguration)"
net start "AirStrip Synchronization Service"
pause