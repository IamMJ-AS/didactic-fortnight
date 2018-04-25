SELECT top 10
		[ID]
      ,[Name]
      ,[TimeStamp]
  FROM [SynchronizationService].[dbo].[SyncTimes]
 where Name like 'WaveData Sync; patientID:%'
 order by TimeStamp Desc
GO