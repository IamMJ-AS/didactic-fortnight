SELECT     Patients.PatientID,Patients.Mrn, Patients.LastName, Locations.Name AS LocationsName,Patients.DateOfBirth, SyncTimes.Name,
                      Patients.InactiveTimeStamp,  SyncTimes.TimeStamp
FROM         Locations RIGHT OUTER JOIN
                      Patients ON Locations.ID = Patients.LocationID LEFT OUTER JOIN
                      SyncTimes ON Patients.ID = SyncTimes.ID