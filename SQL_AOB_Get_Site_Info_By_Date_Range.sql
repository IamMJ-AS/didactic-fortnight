Use AirStripSiteConfiguration
SELECT OperationLogID 
	,Timestamp
	,Result
	,Message
	,Token
	,OperationDescription

FROM         OperationLog
WHERE     (Timestamp > '07/1/2016') --replace with starting date
		  AND OperationTypeID =2
		  --AND (UserName <>'crpsvhra')
order by OperationLogID desc