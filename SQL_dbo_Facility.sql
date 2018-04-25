/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [FacilityID]
      ,[SiteID]
      ,[FacilityName]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[ChartSpeed]
      ,[PaperType]
      ,[TimeZoneInformation]
      ,[AllowGraceLogins]
      ,[ExpirePasswords]
      ,[MaskOBLinkFetalStripAnnotations]
      ,[PasswordExpirationWarning]
      ,[SystemMessage]
      ,[MaskPHIOnOBLink]
      ,[DataVersion]
      ,[InsertTime]
      ,[Sequence]
      ,[IsInactive]
  FROM [AirstripOB].[dbo].[Facility]