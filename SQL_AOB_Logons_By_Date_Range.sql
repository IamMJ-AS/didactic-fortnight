Use AirStripSiteConfiguration
SELECT OperationLogID 
	,Timestamp
	,UserName
	,Result
	,Message
	
--,OperationTypeID
--,OperationDescription
--,Token
--,DeviceId
--,EntityID
--,ClientExeVersion
--,ClientApiVersion
--,ClientPlatformOS
--,ClientPlatformVersion
--,DeviceModel
--,OtherData


FROM         OperationLog
WHERE     (Timestamp > '04/13/2012') 
		  AND (OperationDescription = 'Logon Attempt') 
		  --AND (UserName <>'crpsvhra')
order by OperationLogID desc