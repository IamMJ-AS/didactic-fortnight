-----------------------------
--Problem statment 1
-----------------------------
DECLARE @sql nvarchar(max)
DECLARE @Name varchar(100)='AdventureWorks2008'
 DECLARE c CURSOR FOR 
  SELECT     
		--'drop procedure ['+pr.name+']',
		replace(mod.definition,pr.name,pr.name+'_BAK')
FROM sys.procedures pr
INNER JOIN sys.sql_modules mod ON pr.object_id = mod.object_id
WHERE pr.Is_MS_Shipped = 0 AND pr.name ='uspGetBillOfMaterials'

OPEN c

FETCH NEXT FROM c INTO @sql
WHILE @@FETCH_STATUS = 0 
BEGIN
	print @SQL
   SET @sql = REPLACE(@sql,'''','''''')
   SET @sql = 'USE [' + @Name + ']; EXEC(''' + @sql + ''')'

   EXEC(@sql)

   FETCH NEXT FROM c INTO @sql
END             

CLOSE c
DEALLOCATE c

-------------------------------
---Problem statement 2
-------------------------------
DECLARE @sql nvarchar(max)
DECLARE @Name varchar(100)='AdventureWorks2008'
 DECLARE c CURSOR FOR 
SELECT  
		replace(mod.definition,pr.name,pr.name+'_BAK')
FROM sys.procedures pr
INNER JOIN sys.sql_modules mod ON pr.object_id = mod.object_id
WHERE pr.Is_MS_Shipped = 0 AND mod.definition  LIKE '%WITH [BOM_cte]%'

OPEN c

FETCH NEXT FROM c INTO @sql

WHILE @@FETCH_STATUS = 0 
BEGIN
   SET @sql = REPLACE(@sql,'''','''''')
   SET @sql = 'USE [' + @Name + ']; EXEC(''' + @sql + ''')'

   EXEC(@sql)

   FETCH NEXT FROM c INTO @sql
END             

CLOSE c
DEALLOCATE c

