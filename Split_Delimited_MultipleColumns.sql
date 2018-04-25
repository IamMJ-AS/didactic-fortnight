DECLARE @Tmp TABLE (Id INT,Name VARCHAR(20))
INSERT @Tmp SELECT 1,'Vidhyasagar,K'
INSERT @Tmp SELECT 2,'Sathya,S'
INSERT @Tmp SELECT 3,'Madhu,K'


--Using PARSENAME

SELECT Id,
       PARSENAME(REPLACE(Name,',','.'),2) Name,
	   PARSENAME(REPLACE(Name,',','.'),1) Surname
FROM @Tmp


--USING SUBSTRING & CHARINDEX
--Approach 1
SELECT Id,
       SUBSTRING(Name,1,CHARINDEX(',',Name)-1) Name,
	   SUBSTRING(Name,CHARINDEX(',',Name)+1,LEN(Name)) Surname
 FROM @Tmp

--Approach 2
SELECT Id,
       s.N1 Name,
	   t.N2 Surname
FROM @Tmp
CROSS APPLY (SELECT CHARINDEX(',',Name) AS p1)p
CROSS APPLY (SELECT SUBSTRING(Name,1,p.p1-1) AS N1)s
CROSS APPLY (SELECT SUBSTRING(Name,p.p1+1,LEN(Name)) AS N2)t


--Using XML method 

;With FormSplitXML
AS
(
  SELECT Id, Name,
    CONVERT(XML,'<r><n>'  
    + REPLACE(Name,',', '</n><n>') + '</n></r>') AS X
   FROM @Tmp
)

SELECT * INTO ##FormSplitXML FROM FormSplitXML


---Using XML method -  Manual shredding

SELECT  Id, 
 i.value('n[1]','varchar(100)') AS Name,
 i.value('n[2]','varchar(100)') AS Surname
 FROM ##FormSplitXML Spt
 CROSS APPLY Spt.X.nodes('/r') x(i)

--Using XML method - Dynamic shredding

SELECT Id,
       i.value('local-name(.)','varchar(100)') ColumnName,
       i.value('.','varchar(100)') ColumnValue
	   INTO ##temp
FROM ##FormSplitXML Spt
CROSS APPLY Spt.X.nodes('//*[text()]') x(i)


DECLARE @SQL NVARCHAR(MAX),
        @i INT,
		@MaxCount INT

SELECT @MaxCount = MAX(cnt)
FROM (
    SELECT Id
        ,COUNT(ColumnValue) AS cnt
    FROM ##temp
    GROUP BY Id
    ) X;
 
SET @i = 0;
 
WHILE @i < @MaxCount
BEGIN
    SET @i = @i + 1;
    SET @SQL = COALESCE(@Sql + ', ', '') + 'Name' + cast(@i AS NVARCHAR(10));
END
 
SET @SQL = N';WITH CTE AS (
   SELECT Id, ColumnValue, ''Name'' 
   + CAST(row_number() OVER (PARTITION BY ID ORDER BY Id DESC) AS Varchar(10)) AS RowNo
   FROM   ##temp)
SELECT *
FROM   CTE
PIVOT (MAX(ColumnValue) FOR RowNo IN (' + @SQL + N')) pvt';
 
--PRINT @SQL;
 
EXECUTE (@SQL);

--DROP TABLE ##temp
--DROP TABLE ##FormSplitXML