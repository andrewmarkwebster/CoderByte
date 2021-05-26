USE [DBAPerfData]
GO

/* Requires this table to be created beforehand */
/*
CREATE TABLE [DBAPerfData].[dbo].[Poor_Query_Cache] (
 [Collection Date] [datetime] NOT NULL,
 [Execution Count] [bigint] NULL,
 [Query Text] [nvarchar](max) NULL,
 [DB Name] [sysname] NULL,
 [Total CPU Time] [bigint],
 [Avg CPU Time (ms)] [bigint] NULL,
 [Total Physical Reads] [bigint] NULL,
 [Avg Physical Reads] [bigint] NULL,
 [Total Logical Reads] [bigint] NULL,
 [Avg Logical Reads] [bigint] NULL,
 [Total Logical Writes] [bigint] NULL,
 [Avg Logical Writes] [bigint] NULL,
 [Total Duration] [bigint] NULL,
 [Avg Duration (ms)] [bigint] NULL,
 [Plan] [xml] NULL
) ON [PRIMARY]
GO
*/

INSERT INTO [DBAPerfData].[dbo].[Poor_Query_Cache]
SELECT TOP 20
    GETDATE() AS "Collection Date",
    qs.execution_count AS "Execution Count",
    SUBSTRING(qt.text,qs.statement_start_offset/2 +1, 
                 (CASE WHEN qs.statement_end_offset = -1 
                       THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2 
                       ELSE qs.statement_end_offset END -
                            qs.statement_start_offset
                 )/2
             ) AS "Query Text", 
     DB_NAME(qt.dbid) AS "DB Name",
     qs.total_worker_time AS "Total CPU Time",
     qs.total_worker_time/qs.execution_count AS "Avg CPU Time (ms)",     
     qs.total_physical_reads AS "Total Physical Reads",
     qs.total_physical_reads/qs.execution_count AS "Avg Physical Reads",
     qs.total_logical_reads AS "Total Logical Reads",
     qs.total_logical_reads/qs.execution_count AS "Avg Logical Reads",
     qs.total_logical_writes AS "Total Logical Writes",
     qs.total_logical_writes/qs.execution_count AS "Avg Logical Writes",
     qs.total_elapsed_time AS "Total Duration",
     qs.total_elapsed_time/qs.execution_count AS "Avg Duration (ms)",
     qp.query_plan AS "Plan"
FROM sys.dm_exec_query_stats AS qs 
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt 
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
WHERE 
     qs.execution_count > 50 OR
     qs.total_worker_time/qs.execution_count > 100 OR
     qs.total_physical_reads/qs.execution_count > 1000 OR
     qs.total_logical_reads/qs.execution_count > 1000 OR
     qs.total_logical_writes/qs.execution_count > 1000 OR
     qs.total_elapsed_time/qs.execution_count > 1000
ORDER BY 
     qs.execution_count DESC,
     qs.total_elapsed_time/qs.execution_count DESC,
     qs.total_worker_time/qs.execution_count DESC,
     qs.total_physical_reads/qs.execution_count DESC,
     qs.total_logical_reads/qs.execution_count DESC,
     qs.total_logical_writes/qs.execution_count DESC