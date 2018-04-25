INSERT INTO [AMP].[dbo].[ModuleInstanceUserConfiguration_ListOfListLocation]
           ([ModuleInstanceUserConfigurationId]
           ,[ListOfListLocationID])
    -- VALUES
       SELECT ModuleInstanceUserConfiguration.Id
           ,[ListOfListLocationID] = '1'
           FROM         EnterpriseUser INNER JOIN
                      ModuleInstanceUserConfiguration ON EnterpriseUser.Id = ModuleInstanceUserConfiguration.EnterpriseUserId INNER JOIN
                      ModuleInstance ON ModuleInstanceUserConfiguration.ModuleInstanceId = ModuleInstance.Id
                      Where ModuleInstance.Module like 'Cardio%'
                      
GO


