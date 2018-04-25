SELECT  distinct (Mrn)
, LocationID
, Patients.PatientID
, LastName

, Locations.Name
--, CurrentElementData.ElementTypeName
--, CurrentElementData.Value
, CurrentElementData.RecordTime
, CurrentElementData.UpdateTime
--,WaveData.ElementTypeName AS Expr1
, WaveData.StartTime
, WaveData.EndTime
, WaveData.WaveForm

FROM         Locations RIGHT OUTER JOIN
             CurrentElementData RIGHT OUTER JOIN
             WaveData RIGHT OUTER JOIN
            Patients ON WaveData.PatientID = Patients.PatientID ON CurrentElementData.PatientID = Patients.PatientID ON Locations.ID = Patients.LocationID
            
             --where 
            --where WaveForm IS NOT NULL 
           -- AND LocationID IN (353,315,368,360)
            Where InactiveTimeStamp is NULL
            
            Order by LocationID
                      