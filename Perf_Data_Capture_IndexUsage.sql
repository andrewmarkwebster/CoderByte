USE [msdb]
GO

/****** Object:  Job [Perf_Data_Capture_IndexUsage]    Script Date: 03/09/2019 14:48:54 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 03/09/2019 14:48:54 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Perf_Data_Capture_IndexUsage', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'WEETABIX\xaw', 
		@notify_email_operator_name=N'InfrastructureAlerts', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Perf_Data_Capture_IndexUsage]    Script Date: 03/09/2019 14:48:54 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Perf_Data_Capture_IndexUsage', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [DBAPerfData]
GO


-- Requires the following to exist

/*

CREATE TABLE [DBAPerfData].[dbo].[IndexUsage](
	[CollectionDate] [datetime] NOT NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[Table_Name] [nvarchar](128) NULL,
	[Index_Name] [sysname] NULL,
	[Index_Type] [nvarchar](60) NULL,
	[IndexSizeKB] [bigint] NULL,
	[NumOfSeeks] [bigint] NOT NULL,
	[NumOfScans] [bigint] NOT NULL,
	[NumOfLookups] [bigint] NOT NULL,
	[NumOfUpdates] [bigint] NOT NULL,
	[LastSeek] [datetime] NULL,
	[LastScan] [datetime] NULL,
	[LastLookup] [datetime] NULL,
	[LastUpdate] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [DBAPerfData].[dbo].[IndexUsageReads](
	[CollectionDate] [datetime] NOT NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[ObjectName] [nvarchar](128) NULL,
	[IndexName] [sysname] NULL,
	[index_id] [int] NOT NULL,
	[user_seeks] [bigint] NULL,
	[user_scans] [bigint] NULL,
	[user_lookups] [bigint] NULL,
	[Total Reads] [bigint] NULL,
	[Writes] [bigint] NULL,
	[Index Type] [nvarchar](60) NULL,
	[Fill Factor] [tinyint] NOT NULL,
	[has_filter] [bit] NULL,
	[filter_definition] [nvarchar](max) NULL,
	[last_user_scan] [datetime] NULL,
	[last_user_lookup] [datetime] NULL,
	[last_user_seek] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [DBAPerfData].[dbo].[IndexUsageWrites](
	[CollectionDate] [datetime] NOT NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[ObjectName] [nvarchar](128) NULL,
	[IndexName] [sysname] NULL,
	[index_id] [int] NOT NULL,
	[Writes] [bigint] NULL,
	[Total Reads] [bigint] NULL,
	[Index Type] [nvarchar](60) NULL,
	[Fill Factor] [tinyint] NOT NULL,
	[has_filter] [bit] NULL,
	[filter_definition] [nvarchar](max) NULL,
	[last_system_update] [datetime] NULL,
	[last_user_update] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

*/

DECLARE @command VARCHAR(1500) 
SELECT @command =
 '' USE [?]
SELECT	GETDATE() AS CollectionDate
		,db_name() AS DatabaseName
		,OBJECT_NAME(IX.OBJECT_ID) Table_Name
	   ,IX.name AS Index_Name
	   ,IX.type_desc Index_Type
	   ,SUM(PS.[used_page_count]) * 8 IndexSizeKB
	   ,IXUS.user_seeks AS NumOfSeeks
	   ,IXUS.user_scans AS NumOfScans
	   ,IXUS.user_lookups AS NumOfLookups
	   ,IXUS.user_updates AS NumOfUpdates
	   ,IXUS.last_user_seek AS LastSeek
	   ,IXUS.last_user_scan AS LastScan
	   ,IXUS.last_user_lookup AS LastLookup
	   ,IXUS.last_user_update AS LastUpdate
-- INTO	[DBAPerfData].[dbo].[IndexUsage]
FROM sys.indexes IX
INNER JOIN sys.dm_db_index_usage_stats IXUS ON IXUS.index_id = IX.index_id AND IXUS.OBJECT_ID = IX.OBJECT_ID
INNER JOIN sys.dm_db_partition_stats PS on PS.object_id=IX.object_id
WHERE OBJECTPROPERTY(IX.OBJECT_ID,'' + '''''''' + ''IsUserTable'' + '''''''' + '') = 1
AND DB_ID() > 4
GROUP BY OBJECT_NAME(IX.OBJECT_ID) ,IX.name ,IX.type_desc ,IXUS.user_seeks ,IXUS.user_scans ,IXUS.user_lookups,IXUS.user_updates ,IXUS.last_user_seek ,IXUS.last_user_scan ,IXUS.last_user_lookup ,IXUS.last_user_update''

INSERT INTO [DBAPerfData].[dbo].[IndexUsage] ( [CollectionDate], [DatabaseName], [Table_Name], [Index_Name], [Index_Type], [IndexSizeKB], [NumOfSeeks], [NumOfScans], [NumOfLookups], [NumOfUpdates], [LastSeek], [LastScan], [LastLookup], [LastUpdate] )
exec master.sys.sp_MSforeachdb @command


SELECT @command =
 '' USE [?] 
--- Index Read/Write stats (all tables in current DB) ordered by Reads  (Query 70) (Overall Index Usage - Reads)
SELECT GETDATE() AS CollectionDate, db_name() AS DatabaseName, OBJECT_NAME(i.[object_id]) AS [ObjectName], i.[name] AS [IndexName], i.index_id, 
       s.user_seeks, s.user_scans, s.user_lookups,
	   s.user_seeks + s.user_scans + s.user_lookups AS [Total Reads], 
	   s.user_updates AS [Writes],  
	   i.[type_desc] AS [Index Type], i.fill_factor AS [Fill Factor], i.has_filter, i.filter_definition, 
	   s.last_user_scan, s.last_user_lookup, s.last_user_seek
--INTO	[DBAPerfData].[dbo].[IndexUsageReads]
FROM sys.indexes AS i WITH (NOLOCK)
LEFT OUTER JOIN sys.dm_db_index_usage_stats AS s WITH (NOLOCK)
ON i.[object_id] = s.[object_id]
AND i.index_id = s.index_id
AND s.database_id = DB_ID()
WHERE OBJECTPROPERTY(i.[object_id],'' + '''''''' + ''IsUserTable'' + '''''''' + '') = 1
AND DB_ID() > 4
ORDER BY s.user_seeks + s.user_scans + s.user_lookups DESC OPTION (RECOMPILE);'' -- Order by reads
------

-- Show which indexes in the current database are most active for Reads
INSERT INTO [DBAPerfData].[dbo].[IndexUsageReads]
(
	[CollectionDate],
	[DatabaseName],
	[ObjectName],
	[IndexName],
	[index_id],
	[user_seeks],
	[user_scans],
	[user_lookups],
	[Total Reads],
	[Writes],
	[Index Type],
	[Fill Factor],
	[has_filter],
	[filter_definition],
	[last_user_scan],
	[last_user_lookup],
	[last_user_seek]
)
exec master.sys.sp_MSforeachdb @command


SELECT @command =
 '' USE [?] 
--- Index Read/Write stats (all tables in current DB) ordered by Writes  (Query 71) (Overall Index Usage - Writes)
SELECT GETDATE() AS CollectionDate, db_name() AS DatabaseName, OBJECT_NAME(i.[object_id]) AS [ObjectName], i.[name] AS [IndexName], i.index_id,
	   s.user_updates AS [Writes], s.user_seeks + s.user_scans + s.user_lookups AS [Total Reads], 
	   i.[type_desc] AS [Index Type], i.fill_factor AS [Fill Factor], i.has_filter, i.filter_definition,
	   s.last_system_update, s.last_user_update
--INTO	[DBAPerfData].[dbo].[IndexUsageWrites]
FROM sys.indexes AS i WITH (NOLOCK)
LEFT OUTER JOIN sys.dm_db_index_usage_stats AS s WITH (NOLOCK)
ON i.[object_id] = s.[object_id]
AND i.index_id = s.index_id
AND s.database_id = DB_ID()
WHERE OBJECTPROPERTY(i.[object_id],'' + '''''''' + ''IsUserTable'' + '''''''' + '') = 1
AND DB_ID() > 4
ORDER BY s.user_updates DESC OPTION (RECOMPILE);''						 -- Order by writes
------

-- Show which indexes in the current database are most active for Writes
INSERT INTO [DBAPerfData].[dbo].[IndexUsageWrites]
(
	[CollectionDate],
	[DatabaseName],
	[ObjectName],
	[IndexName],
	[index_id],
	[Writes],
	[Total Reads],
	[Index Type],
	[Fill Factor],
	[has_filter],
	[filter_definition],
	[last_system_update],
	[last_user_update]
)
exec master.sys.sp_MSforeachdb @command
GO
', 
		@database_name=N'DBAPerfData', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily 04:00', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190902, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=235959, 
		@schedule_uid=N'1eeea343-5936-473c-a03f-705fb8e9905b'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


