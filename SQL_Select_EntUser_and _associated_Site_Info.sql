SELECT     EnterpriseUser.Id, EnterpriseUser.Name, EnterpriseUser.ActiveDirectoryUsername, EnterpriseUser.ContactPhoneNumber, EnterpriseUser.ContactEmail, 
                      EnterpriseUser.AirstripId, EnterpriseUser.MessagingEnabled, EnterpriseUser.FirstName, EnterpriseUser.LastName, EnterpriseUser.UserModuleTypeId, 
                      Site_EnterpriseUser.SiteId, Site.Name AS Expr1, Site.ClientTimeout, Site.LogoUrl, Site.DualAuthenticationEnabled, Site.HttpClientConfigurationId, Site.TimeZoneName, 
                      Site.ShortLabel, Site.TouchIdEnabled, EnterpriseUser.IsInactive
FROM         Site_EnterpriseUser INNER JOIN
                      Site ON Site_EnterpriseUser.SiteId = Site.ID RIGHT OUTER JOIN
                      EnterpriseUser ON Site_EnterpriseUser.EnterpriseUserId = EnterpriseUser.Id