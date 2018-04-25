
SELECT     ID, PatientID, ElementTypeName, StartTime, WaveForm
FROM         WaveData
WHERE     (ID IN
                          (SELECT     MAX(ID) AS Expr1
                            FROM          WaveData AS WaveData_1
                            GROUP BY PatientID))
 order by PatientID asc