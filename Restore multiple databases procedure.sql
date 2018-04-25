CREATE PROCEDURE Multi_Restore( @SourceFile nvarchar(4000)
								,@dbprefixcount int 
								,@logbackuppath varchar (1000)
								)
As
/*
Author : Saurabh Sinha
DATE : 04/09/2014
Modified : 04/09/2014
Description :
This Procedure is created to restore multiple databases from their backups.
for example if i have to restore 100 databases with their respective backups then
I can keep all backups in same folder and run procedure.
Here all backup names in same format and must start with database name
example : master_today.bak , model_today.bak
Parameters :
--> @SourceFile = where all backup files are placed
--> @dbprefixcount = characters in backup file name after db name (Banco   + _09042014.bak)
where backup file name is dbanme + date.bak example Banco_09042014.bak
here in prefix we have 13 characters (Banco   + _09042014.bak)
--> @logbackuppath = location to take log backup when db is not in simple recovery model
SYNTAX :
EXEC dba_admin.dbo.Multi_Restore @SourceFile = 'G:\Adhoc_Backup\Saurabh\' 
					,@dbprefixcount = 13 
					,@logbackuppath = 'G:\Adhoc_Backup\'
*/
Begin
	SET NOCOUNT ON
    /* Declaring Variables */
	DECLARE @path nvarchar(4000)
	Declare @name as nvarchar (4000);   
	Declare @Backupname as nvarchar (4000); 
	DECLARE @Cmd AS VARCHAR(5000); 
	DECLARE @i as int 
	Declare @a as int 
	Declare @backuplocation varchar (5000)
	Declare @Lfile1 varchar (200) , @Lfile2 varchar  (200)
	Declare @Pfile1 varchar (2000) , @Pfile2 varchar  (2000)
	Declare @logbackup varchar (1000)
	Declare @sconfig int
	--Declare @logbackuppath varchar (1000)
	--Declare @dbprefixcount int
	--DECLARE @SourceFile AS VARCHAR(5000); 
	
/* verifying and removing temp objects*/

if exists (select 1 from sys.sysobjects where type ='U')
select @i = COUNT(*) from sys.sysobjects where type ='U'
while @i >0 
begin
SET @name = (Select top 1 name  from sys.sysobjects where type ='U' and name like '#%')
SET @CMD = 'Drop table ' + @name
Print @cmd
Exec (@cmd)
SET @i = @i-1
END

/* Create temp tables*/
Create table #fileListTable 
(
      LogicalName nvarchar(128),
      PhysicalName nvarchar(260),
      [Type] char(1),
      FileGroupName nvarchar(128),
      Size numeric(20,0),
      MaxSize numeric(20,0),
      FileID bigint,
      CreateLSN numeric(25,0),
      DropLSN numeric(25,0),
      UniqueID uniqueidentifier,
      ReadOnlyLSN numeric(25,0),
      ReadWriteLSN numeric(25,0),
      BackupSizeInBytes bigint,
      SourceBlockSize int,
      FileGroupID int,
      LogGroupGUID uniqueidentifier,
      DifferentialBaseLSN numeric(25,0),
      DifferentialBaseGUID uniqueidentifier,
      IsReadOnl bit,
      IsPresent bit,
      TDEThumbprint varbinary(32) 
)
      CREATE Table #MyTable (Results varchar(500))
      CREATE Table #MYFILES (create_date datetime ,is_directory int ,[Name] varchar (500))
      CREATE Table #MYFILES_main (id int  identity , name varchar (500))  

/*Initialization*/
	--Set @logbackuppath = 'T:\adhocbackup\'
	--SET @SourceFile = 'T:\adhocbackup\Saurabh\'
	--SET @dbprefixcount = 19----> this value is the count of prefix after db name in backupfile
	SET @backuplocation = @SourceFile
    SET @Path = @SourceFile --> Pass the path in which you want to search
    SET @cmd =  'dir ' + @path + ' /A /OS /-C'
	Set @i=1
     
	/* If XP_CMDshell is not enable , we have to enable this and disable in end */
	select @sconfig = convert (int ,value_in_use) from sys.configurations where name = 'xp_cmdshell'
	if @sconfig = 0
	Begin
		SET @cmd = 'sp_configure ''xp_cmdshell'' , 1'
		--sp_configure 'xp_cmdshell' , 1 ;
		exec (@cmd)
		reconfigure with override
	END
	/*Collecting data into temp tables */
      INSERT INTO #MyTAble
      EXEC XP_CMDSHELL @cmd 

	/* Roll backing xp_cmdshell status */
	if @sconfig = 0
	Begin
		SET @cmd = 'sp_configure ''xp_cmdshell'' , 0'
		--sp_configure 'xp_cmdshell' , 0 ;
		exec (@cmd)
		reconfigure with override
	END

      INSERT INTO #MYFILES --(create_date datetime ,is_directory int ,[Name] varchar (500))
      SELECT LEFT(Results, 20) [create_date], CASE LTRIM(RTRIM(SUBSTRING(Results, 21, 18))) 
      WHEN ''THEN 1 ELSE 0 END  as is_directory,
      SUBSTRING(Results, 40, Len(Results)) AS [name]FROM #MyTable
      WHERE ISNULL(PATINDEX('%__/__/____%', Results), 0)  != 0 

      DELETE FROM #MYFILES 
      where name in ('..','.') or is_directory =1

      insert into #MYFILES_main select name from #MYFILES
      Select @a =  count (*)  from #MYFILES_main
      
/* Checking all backup files and restoring database one by one */
While @a >= @i 
Begin
		/*Declaration */
      Declare @RestoreStatement  varchar (8000)
      Declare @recovery_model_desc  varchar (100)
      DECLARE @spid int

		/* Initialization */
      Select @Backupname = name from #MYFILES_main where id = @i
      Set @backuplocation = @SourceFile
      Set @backuplocation = @backuplocation + @Backupname
      SET @name =  LEFT(@Backupname,  LEN(@Backupname) - @dbprefixcount)
	  SET @RestoreStatement = N'RESTORE FILELISTONLY FROM DISK=N'''  + @backuplocation +  ''''
      select @recovery_model_desc  = recovery_model_desc from  sys.databases where name = @name
      select @recovery_model_desc  ,@name

      insert into #fileListTable 
      EXEC(@RestoreStatement)

      Set @Pfile1 =  Null
      Set @Pfile2 =  Null
      Select @Lfile1 = LogicalName from #fileListTable where fileid =1
      Select @Lfile2 = LogicalName from #fileListTable where fileid =2
      Select @Pfile1 =  filename from sys.sysaltfiles where dbid  =db_id(@name ) and fileid  =1
      select @Pfile2 =  filename from sys.sysaltfiles where dbid  =db_id(@name ) and fileid  = 2;

		/* Taking log backup for db not in simple recovery*/
      if @recovery_model_desc  <> 'simple'
            Begin 
                  if exists (select 1  from sys.databases where name = @name)
                  Begin
                        select @logbackup = @logbackuppath + @name +  '.log'
                        backup log @name to disk  = @logbackup;
                  End
            END
		/* Killing all user session from db before restoring */
      SELECT @spid =  min(spid)  from master.dbo.sysprocesses where dbid  = db_id(@name)
      WHILE @spid IS  NOT NULL
      BEGIN
            EXECUTE ('KILL ' + @spid)
            SELECT @spid =  min(spid)  from master.dbo.sysprocesses where dbid  = db_id(@name) AND spid > @spid
      END 
      Select @name ,@backuplocation, @Lfile1, @Pfile1
		/*Restoring database */
      If @Pfile1 is  not null
      Begin
            Restore database @name from disk  = @backuplocation with  stats =1,  
            move @Lfile1 to @Pfile1,
            move @Lfile2 to @Pfile2, Replace
      End
      Else 
      Begin
            Restore database @name from disk  = @backuplocation with  stats =1 
      END

      SET @i= @i+1
      select 'Restore for ' +@name +'  Completed '
END
	/*Dropping temp tables */
		Drop Table #MYFILES
		Drop table #MYFILES_main
		DROP Table #MyTAble
		Drop table #fileListTable
END