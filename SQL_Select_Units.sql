/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[Name]
      ,[ParentID]
  FROM [SynchronizationService].[dbo].[Locations]
  where ParentID ='UNIT'
  order by ID asc