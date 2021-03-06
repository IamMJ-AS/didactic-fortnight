/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[PatientID]
      ,[VendorKey]
      ,[ElementTypeName]
      ,(DATEADD(HH,-5,RecordTime)) AS RecordTimeLocal
      --,(DATEADD(HH,-5,UpdateTime)) AS UpdateTimeLocal
      ,[UpdateTime]
      ,[Value]
  FROM [SynchronizationService].[dbo].[CurrentElementData]
	--where ElementTypeName = 'UnitName'
  order by ID desc
  