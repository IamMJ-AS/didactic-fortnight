DECLARE @TIMERANGE int
DECLARE @UTCOFFSET int
DECLARE @TIMECURRENT datetime2
DECLARE @TIMECUTOFF datetime2
/******************/
set @TIMERANGE ='-10'
set @UTCOFFSET ='-5'
set @TIMECURRENT = CURRENT_TIMESTAMP
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
--AND (StartTime BETWEEN @TIMECUTOFF and @TIMECURRENT)
--order by PatientID
order by StartTimeLocal desc
select @TIMECUTOFF as 'TimeCutOff'
,@TIMECURRENT as 'TimeCurrent'
, DATEDIFF(HH,@TIMECURRENT,@TIMECUTOFF) as 'TimeDiff'