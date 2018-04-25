Use AirStripSiteConfiguration
SELECT     OperationLogID, Timestamp, OperationTypeID, OperationDescription, Token, DeviceId, UserName, Result, EntityID, ClientExeVersion, ClientApiVersion, ClientPlatformOS, ClientPlatformVersion, DeviceModel, OtherData, Message
FROM         OperationLog
WHERE     (Timestamp > '04/13/2012') AND (OperationDescription = 'Logon Attempt') AND (UserName <>'crpsvhra')
