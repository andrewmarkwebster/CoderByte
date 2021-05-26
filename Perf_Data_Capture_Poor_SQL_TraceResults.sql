USE [msdb]
GO

/****** Object:  Job [Perf_Data_Capture_Poor_SQL_TraceResults]    Script Date: 22/08/2019 15:05:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 22/08/2019 15:05:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Perf_Data_Capture_Poor_SQL_TraceResults', 
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
/****** Object:  Step [Capture_Poor_SQL_TraceResults]    Script Date: 22/08/2019 15:05:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Capture_Poor_SQL_TraceResults', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
USE [DBAPerfData]
GO

/* Requires this table to be created beforehand */
/*
CREATE TABLE [DBAPerfData].[dbo].[TraceResults] 
(
 CaptureDateTime DATETIME,
 TextData VARCHAR(4000),
 Duration BIGINT,
 Duration_Sec DECIMAL(10,1),
 DurationInSeconds DECIMAL(10,1),
 Reads BIGINT,
 Writes BIGINT,
 CPU BIGINT,
 StartTime DATETIME,
 Hostname VARCHAR(100),
 ApplicationName VARCHAR(100),
 LoginName VARCHAR(100),
 DatabaseName VARCHAR(100),
 ProcedureName VARCHAR(100)
)
GO

CREATE NONCLUSTERED INDEX [Idx_CaptureDateTime] ON [DBAPerfData].[dbo].[TraceResults]
(
	[CaptureDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [Idx_DatabaseName_ProcedureName] ON [DBAPerfData].[dbo].[TraceResults]
(
	[DatabaseName] ASC,
	[ProcedureName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [Idx_DatabaseName_TextData] ON [DBAPerfData].[dbo].[TraceResults]
(
	[DatabaseName] ASC
)
INCLUDE ( 	[TextData]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


*/

EXEC master.sys.sp_configure ''Show Advanced Options'', 1
GO
RECONFIGURE
GO

exec master.sys.sp_configure ''xp_cmdshell'',1
GO
RECONFIGURE
GO

   
   /****************************************************************************************
    STEP 1 : DEFINING THE TRACE    
   ***************************************************************************************/
   SET NOCOUNT ON;
   DECLARE @rc INT
   DECLARE @TraceID INT
   DECLARE @MaxFileSize BIGINT
   DECLARE @OutputFileName NVARCHAR(256)
   SET @MaxFileSize = 20480


   --Replace The H:\MyTraces with a valid folder in your environment
   SET @OutputFileName = ''Z:\MyTraces\FileTrace'' +     CONVERT(VARCHAR(20), GETDATE(),112) + REPLACE(CONVERT(VARCHAR(20), GETDATE(),108),'':'','''')


   --sp_trace_create @traceid,@options,@tracefile,@maxfilesize,@stoptime ,@filecount 
   EXEC @rc = sp_trace_create @TraceID OUTPUT, 2, @OutputFileName, @MaxFileSize, NULL,20
   
   /****************************************************************************************
    STEP 2 : DEFINING THE EVENT AND COLUMNS
   *****************************************************************************************/
  
   DECLARE @Status INT
   SET @Status = 1
  
   --sp_trace_setevent @traceid ,@eventid ,@columnid,@on 

   --RPC:Completed event

   EXEC sp_trace_setevent @TraceID, 10, 16, @Status 
   EXEC sp_trace_setevent @TraceID, 10, 1,  @Status
   EXEC sp_trace_setevent @TraceID, 10, 17, @Status
   EXEC sp_trace_setevent @TraceID, 10, 14, @Status
   EXEC sp_trace_setevent @TraceID, 10, 18, @Status
   EXEC sp_trace_setevent @TraceID, 10, 12, @Status
   EXEC sp_trace_setevent @TraceID, 10, 13, @Status
   EXEC sp_trace_setevent @TraceID, 10, 8,  @Status
   EXEC sp_trace_setevent @TraceID, 10, 10, @Status
   EXEC sp_trace_setevent @TraceID, 10, 11, @Status
   EXEC sp_trace_setevent @TraceID, 10, 35, @Status


   --SQL:BatchCompleted event

   EXEC sp_trace_setevent @TraceID, 12, 16, @Status
   EXEC sp_trace_setevent @TraceID, 12, 1,  @Status
   EXEC sp_trace_setevent @TraceID, 12, 17, @Status
   EXEC sp_trace_setevent @TraceID, 12, 14, @Status
   EXEC sp_trace_setevent @TraceID, 12, 18, @Status
   EXEC sp_trace_setevent @TraceID, 12, 12, @Status
   EXEC sp_trace_setevent @TraceID, 12, 13, @Status
   EXEC sp_trace_setevent @TraceID, 12, 8,  @Status
   EXEC sp_trace_setevent @TraceID, 12, 10, @Status
   EXEC sp_trace_setevent @TraceID, 12, 11, @Status
   EXEC sp_trace_setevent @TraceID, 12, 35, @Status

   /****************************************************************************************
    STEP 3 : DEFINING THE Filter condition
   *****************************************************************************************/
   --sp_trace_setfilter @traceid ,@columnid,@logical_operator,@comparison_operator,@value
   -- EXEC sp_trace_setfilter @TraceID,8,0,0,N''MyAppServer''  --Hostname
   -- EXEC sp_trace_setfilter @TraceID,35,0,0,N''DBATools'' --Database name
   -- EXEC sp_trace_setfilter @TraceID,11,0,0,N''MyAppUser'' --SQL login
   /****************************************************************************************
    STEP 4 : Start the trace
   *****************************************************************************************/
   EXEC sp_trace_setstatus @TraceID, 1
   /****************************************************************************************
     Display the trace Id and traceFilename
   *****************************************************************************************/
   SELECT @TraceID,@OutputFileName

-- Now the trace is running and you can verify the currently running trace using the below query

SELECT * FROM ::fn_trace_getinfo(NULL)

-- Wait for 30 minutes
WAITFOR DELAY ''00:30:00'';

EXEC master.sys.sp_configure ''Show Advanced Options'', 1
RECONFIGURE

exec master.sys.sp_configure ''xp_cmdshell'',1
RECONFIGURE


-- Once it ran for the desired time , you can stop the trace using the below script

   --sp_trace_setstatus [ @traceid = ] trace_id , [ @status = ] status
--    DECLARE @traceid INT
--    DECLARE @status INT
--    SET @traceid =2
    SET @status =0
    EXEC sp_trace_setstatus @traceid,@status
    SET @status =2
    EXEC sp_trace_setstatus @traceid,@status



-- To view the content of the trace file. If you have added more column in the trace , add that column in the below select statement also.You can insert the output into a table for further analysis of the trace.

INSERT INTO [DBAPerfData].[dbo].[TraceResults] 
(CaptureDateTime, TextData, Duration, Duration_Sec, DurationInSeconds, Reads, Writes, CPU, StartTime, Hostname, ApplicationName, LoginName, DatabaseName)
SELECT
GETDATE(), SUBSTRING(TextData,1,4000), Duration, Duration_Sec = cast(duration/1000/1000.0 as Dec(10,1)), Duration/1000000 as DurationInSeconds, Reads, Writes, CPU, StartTime, SUBSTRING(Hostname,1,100), SUBSTRING(ApplicationName,1,100), SUBSTRING(LoginName,1,100), SUBSTRING(DatabaseName,1,100)
FROM fn_trace_gettable(@OutputFileName + ''.trc'',1)


EXEC master.sys.sp_configure ''Show Advanced Options'', 1
RECONFIGURE

exec master.sys.sp_configure ''xp_cmdshell'',1
RECONFIGURE

-- Delete the trace file
DECLARE @Command VARCHAR(256)
SET @Command =  ''DEL '' + @OutputFileName + ''.trc''
exec master.dbo.xp_cmdshell @Command


-- Update the ProcedureName column in the TraceResults table
UPDATE [DBAPerfData].[dbo].[TraceResults]
   SET ProcedureName = 
   SUBSTRING(
   LEFT	(
      RIGHT(TextData, LEN(TextData) - CHARINDEX('' '',TextData, CHARINDEX(''Exec'',TextData))),
      CHARINDEX('' '', RIGHT(TextData, LEN(TextData) - CHARINDEX('' '',TextData, CHARINDEX(''Exec'',TextData))) + '' '')
		),1,100)
where TextData like ''%exec%''




-- Now Report Top 20 Poorly Performing SP SQL executions by Time Impact
/*
SELECT TOP (20)
ProcedureName,
DatabaseName,
SUM(CAST(duration AS BIGINT)) AS TimeImpact,
SUM(CAST(Reads AS BIGINT)) AS IOImpact,
SUM(CAST(CPU AS BIGINT)) AS CPUImpact,
COUNT(*) AS ExecutionCount,
AVG(CAST(Duration AS BIGINT)) AS AvgDuration,
AVG(CAST(Reads AS BIGINT)) AS AvgIOs,
AVG(CAST(CPU AS BIGINT)) AS AvgCPU
FROM [DBAPerfData].[dbo].[TraceResults]
GROUP BY ProcedureName, DatabaseName
ORDER BY SUM(CAST(duration AS BIGINT)) DESC
*/

-- Now Report Top 20 Poorly Performing SQL executions by Time Impact
/*
SELECT TOP (20)
TextData,
DatabaseName,
SUM(CAST(duration AS BIGINT)) AS TimeImpact,
SUM(CAST(Reads AS BIGINT)) AS IOImpact,
SUM(CAST(CPU AS BIGINT)) AS CPUImpact,
COUNT(*) AS ExecutionCount,
AVG(CAST(Duration AS BIGINT)) AS AvgDuration,
AVG(CAST(Reads AS BIGINT)) AS AvgIOs,
AVG(CAST(CPU AS BIGINT)) AS AvgCPU
FROM [DBAPerfData].[dbo].[TraceResults]
GROUP BY TextData, DatabaseName
ORDER BY SUM(CAST(duration AS BIGINT)) DESC
*/


/*
SELECT *
FROM fn_trace_gettable(@OutputFileName,1)
*/
  
-- Below query will help us to list the events and columns capturing as part of a trace.
/*
SELECT 
t.EventID, 
t.ColumnID, 
e.name AS Event_Description, 
c.name AS Column_Description FROM ::fn_trace_geteventinfo(2) t   --Change the trace id to appropriate one 
JOIN sys.trace_events e ON t.eventID = e.trace_event_id
JOIN sys.trace_columns c ON t.columnid = c.trace_column_id 
*/

-- disable xp_cmdshell
exec master.sys.sp_configure ''xp_cmdshell'',0
GO
RECONFIGURE
GO
', 
		@database_name=N'DBAPerfData', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily 14:00', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190814, 
		@active_end_date=99991231, 
		@active_start_time=140000, 
		@active_end_time=235959, 
		@schedule_uid=N'a4015aa3-42ff-41c0-886a-9ce28c37d2a3'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


