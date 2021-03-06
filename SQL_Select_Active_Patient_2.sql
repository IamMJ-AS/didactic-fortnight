/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
    --  ,[EncounterID]
      ,[LocationID]
      --,[Mrn]
      ,[PatientID]
     -- ,[AlternateID]
      --,[FirstName]
      ,[LastName]
     -- ,[MiddleName]
     -- ,[DateOfBirth]
     -- ,[InactiveTimeStamp]
  FROM [SynchronizationService].[dbo].[Patients]
  where InactiveTimeStamp is NULL
  order by LocationID asc
  