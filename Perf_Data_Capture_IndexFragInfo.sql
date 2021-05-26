USE [msdb]
GO

/****** Object:  Job [Perf_Data_Capture_IndexFragInfo]    Script Date: 03/09/2019 14:48:29 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 03/09/2019 14:48:29 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Perf_Data_Capture_IndexFragInfo', 
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
/****** Object:  Step [Perf_Data_Capture_IndexFragInfo]    Script Date: 03/09/2019 14:48:30 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Perf_Data_Capture_IndexFragInfo', 
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
CREATE TABLE [DBAPerfData].[dbo].[IndexFragInfo2]
(
	CollectionDate				datetime,
	DatabaseName				varchar(100),
	ObjectName					varchar(100),
	Index_id					int, 
	indexName					varchar(100),
	avg_fragmentation_percent	float,
	IndexType					varchar(100),
	Action_Required				varchar(100) default ''NA''
)
GO
*/

insert into [DBAPerfData].[dbo].[IndexFragInfo2] (CollectionDate, DatabaseName,ObjectName,Index_id, indexName,avg_fragmentation_percent,IndexType)

exec master.sys.sp_MSforeachdb '' USE [?]

SELECT GETDATE() AS CollectionDate, db_name() as DatabaseName, OBJECT_NAME (a.object_id) as ObjectName, 

a.index_id, b.name as IndexName, 

avg_fragmentation_in_percent, index_type_desc

-- , record_count, avg_page_space_used_in_percent --(null in limited)

FROM sys.dm_db_index_physical_stats (db_id(), NULL, NULL, NULL, NULL) AS a

JOIN sys.indexes AS b 

ON a.object_id = b.object_id AND a.index_id = b.index_id

WHERE b.index_id <> 0 and avg_fragmentation_in_percent <> 0
AND db_id() > 4''
go
 
update [DBAPerfData].[dbo].[IndexFragInfo2]
set Action_Required =''Rebuild''
where avg_fragmentation_percent >30 
go

update [DBAPerfData].[dbo].[IndexFragInfo2]
set Action_Required =''Reorganize''
where avg_fragmentation_percent <30 and avg_fragmentation_percent >5
go

select * from [DBAPerfData].[dbo].[IndexFragInfo2]
ORDER BY
	DatabaseName,
	avg_fragmentation_percent DESC

', 
		@database_name=N'DBAPerfData', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily 03:00', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190902, 
		@active_end_date=99991231, 
		@active_start_time=30000, 
		@active_end_time=235959, 
		@schedule_uid=N'b20abc44-25a3-4a41-a68c-dc8c3b521410'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


