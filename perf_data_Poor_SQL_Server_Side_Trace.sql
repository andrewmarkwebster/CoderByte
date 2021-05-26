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

CREATE NONCLUSTERED INDEX [Idx_CaptureDateTime] ON [dbo].[TraceResults]
(
	[CaptureDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [Idx_DatabaseName_ProcedureName] ON [dbo].[TraceResults]
(
	[DatabaseName] ASC,
	[ProcedureName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [Idx_DatabaseName_TextData] ON [dbo].[TraceResults]
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

-- enable xp_cmdshell temporarily to delete the trace file
exec master.sys.sp_configure 'xp_cmdshell',1
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
   SET @OutputFileName = 'Z:\MyTraces\FileTrace' +     CONVERT(VARCHAR(20), GETDATE(),112) + REPLACE(CONVERT(VARCHAR(20), GETDATE(),108),':','')


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
   -- EXEC sp_trace_setfilter @TraceID,8,0,0,N'MyAppServer'  --Hostname
   -- EXEC sp_trace_setfilter @TraceID,35,0,0,N'DBATools' --Database name
   -- EXEC sp_trace_setfilter @TraceID,11,0,0,N'MyAppUser' --SQL login
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
WAITFOR DELAY '00:30:00';

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
FROM fn_trace_gettable(@OutputFileName + '.trc',1)


EXEC master.sys.sp_configure ''Show Advanced Options'', 1
RECONFIGURE

exec master.sys.sp_configure ''xp_cmdshell'',1
RECONFIGURE

-- Delete the trace file
DECLARE @Command VARCHAR(256)
SET @Command =  'DEL ' + @OutputFileName + '.trc'
exec master.dbo.xp_cmdshell @Command


-- Update the ProcedureName column in the TraceResults table
UPDATE [DBAPerfData].[dbo].[TraceResults]
   SET ProcedureName = 
   SUBSTRING(
   LEFT	(
      RIGHT(TextData, LEN(TextData) - CHARINDEX(' ',TextData, CHARINDEX('Exec',TextData))),
      CHARINDEX(' ', RIGHT(TextData, LEN(TextData) - CHARINDEX(' ',TextData, CHARINDEX('Exec',TextData))) + ' ')
		),1,100)
where TextData like '%exec%'




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
exec master.sys.sp_configure 'xp_cmdshell',0
GO
RECONFIGURE
GO
