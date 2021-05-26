USE [msdb]
GO

/****** Object:  Job [Perf_Data_Capture_IO_Requests_Longer_Than_15_Seconds]    Script Date: 03/09/2019 14:49:17 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 03/09/2019 14:49:17 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Perf_Data_Capture_IO_Requests_Longer_Than_15_Seconds', 
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
/****** Object:  Step [Perf_Data_Capture_IO_Requests_Longer_Than_15_Seconds]    Script Date: 03/09/2019 14:49:17 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Perf_Data_Capture_IO_Requests_Longer_Than_15_Seconds', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Look for I/O requests taking longer than 15 seconds in the six most recent SQL Server Error Logs (Query 30) (IO Warnings)

USE [DBAPerfData]
GO

/* Requires that the following TABLE be created first

CREATE TABLE [DBAPerfData].[dbo].[IOWarningResults] (CollectionDate datetime CONSTRAINT DF_CD DEFAULT GETDATE(), LogDate datetime, ProcessInfo sysname, LogText nvarchar(1000));

*/

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults]
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 0, 1, N''taking longer than 15 seconds'';

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults]
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 1, 1, N''taking longer than 15 seconds'';

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults]
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 2, 1, N''taking longer than 15 seconds'';

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults]
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 3, 1, N''taking longer than 15 seconds'';

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults] 
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 4, 1, N''taking longer than 15 seconds'';

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults]
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 5, 1, N''taking longer than 15 seconds'';

SELECT		CollectionDate, LogDate, ProcessInfo, LogText
FROM		[DBAPerfData].[dbo].[IOWarningResults]
ORDER BY	LogDate DESC;
', 
		@database_name=N'DBAPerfData', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily 13:0)', 
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
		@schedule_uid=N'c091fd0e-c29e-4212-bf1d-357f1b0c9e28'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


