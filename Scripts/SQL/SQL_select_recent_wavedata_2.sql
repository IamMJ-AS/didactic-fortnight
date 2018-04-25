DECLARE @TIMERANGE int
DECLARE @UTCOFFSET int
DECLARE @TIMECUTOFF datetime2
/******************/
set @TIMERANGE ='4'
set @UTCOFFSET ='-5'
SET @TIMECUTOFF=(DATEADD(HH,@TIMERANGE,CURRENT_TIMESTAMP))
/******************/

SELECT     ID
			, PatientID
			--, ElementTypeName
			, DATEADD(HH,@UTCOFFSET,StartTime) as 'StartTimeLocal' 
			--, WaveForm
FROM         WaveData
WHERE  ID IN (
    SELECT MAX(ID)
    FROM WaveData
    GROUP BY PatientID
) 
AND (StartTime > @TIMECUTOFF)
order by PatientID

SELECT @TIMECUTOFF as '@TIMECUTOFF'
GO