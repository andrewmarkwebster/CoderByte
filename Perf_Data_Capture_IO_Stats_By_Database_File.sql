USE [msdb]
GO

/****** Object:  Job [Perf_Data_Capture_IO_Stats_By_Database_File]    Script Date: 03/09/2019 14:49:38 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 03/09/2019 14:49:38 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Perf_Data_Capture_IO_Stats_By_Database_File', 
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
/****** Object:  Step [Perf_Data_Capture_IO_Stats_By_Database_File]    Script Date: 03/09/2019 14:49:38 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Perf_Data_Capture_IO_Stats_By_Database_File', 
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

/* Requires the following TABLE to be created first

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [DBAPerfData].[dbo].[IO_Stats_By_Database_File](
	[CollectionDate] [datetime] NOT NULL,
	[Database Name] [nvarchar](128) NULL,
	[avg_read_latency_ms] [numeric](10, 1) NULL,
	[avg_write_latency_ms] [numeric](10, 1) NULL,
	[avg_io_latency_ms] [numeric](10, 1) NULL,
	[File Size (MB)] [decimal](18, 2) NULL,
	[physical_name] [nvarchar](260) NOT NULL,
	[type_desc] [nvarchar](60) NULL,
	[io_stall_read_ms] [bigint] NOT NULL,
	[num_of_reads] [bigint] NOT NULL,
	[io_stall_write_ms] [bigint] NOT NULL,
	[num_of_writes] [bigint] NOT NULL,
	[io_stalls] [bigint] NULL,
	[total_io] [bigint] NULL,
	[Resource Governor Total Read IO Latency (ms)] [bigint] NOT NULL,
	[Resource Governor Total Write IO Latency (ms)] [bigint] NOT NULL
) ON [PRIMARY]

GO
*/

-- Calculates average stalls per read, per write, and per total input/output for each database file  (Query 29) (IO Latency by File)
INSERT INTO [DBAPerfData].[dbo].[IO_Stats_By_Database_File]
SELECT GETDATE() AS CollectionDate, DB_NAME(fs.database_id) AS [Database Name], CAST(fs.io_stall_read_ms/(1.0 + fs.num_of_reads) AS NUMERIC(10,1)) AS [avg_read_latency_ms],
CAST(fs.io_stall_write_ms/(1.0 + fs.num_of_writes) AS NUMERIC(10,1)) AS [avg_write_latency_ms],
CAST((fs.io_stall_read_ms + fs.io_stall_write_ms)/(1.0 + fs.num_of_reads + fs.num_of_writes) AS NUMERIC(10,1)) AS [avg_io_latency_ms],
CONVERT(DECIMAL(18,2), mf.size/128.0) AS [File Size (MB)], mf.physical_name, mf.type_desc, fs.io_stall_read_ms, fs.num_of_reads, 
fs.io_stall_write_ms, fs.num_of_writes, fs.io_stall_read_ms + fs.io_stall_write_ms AS [io_stalls], fs.num_of_reads + fs.num_of_writes AS [total_io],
io_stall_queued_read_ms AS [Resource Governor Total Read IO Latency (ms)], io_stall_queued_write_ms AS [Resource Governor Total Write IO Latency (ms)] 

FROM sys.dm_io_virtual_file_stats(null,null) AS fs
INNER JOIN sys.master_files AS mf WITH (NOLOCK)
ON fs.database_id = mf.database_id
AND fs.[file_id] = mf.[file_id]
ORDER BY avg_io_latency_ms DESC OPTION (RECOMPILE);
', 
		@database_name=N'DBAPerfData', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily 13:00', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190815, 
		@active_end_date=99991231, 
		@active_start_time=130000, 
		@active_end_time=235959, 
		@schedule_uid=N'b2bdffb7-ae2c-4253-8196-c62f55e4ac69'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


