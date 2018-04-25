SELECT distinct [LocationId]
		,[LocationName]
      ,[SiteName]
      ,[HospitalName]
   FROM [cardio].[dbo].[Ecg]
  order by LocationId ASC