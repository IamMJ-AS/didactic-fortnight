/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[EncounterID]
      ,[LocationID]
      ,[Mrn]
      ,[PatientID]
      ,[AlternateID]
      ,[FirstName]
      ,[LastName]
      ,[MiddleName]
      ,[DateOfBirth]
      --,[InactiveTimeStamp]
  FROM [SynchronizationService].[dbo].[Patients]
 -- WHERE ID IN (30,31)
 where InactiveTimeStamp is NULL
 order by ID asc
 