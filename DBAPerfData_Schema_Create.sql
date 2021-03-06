
USE [DBAPerfData]
GO
/****** Object:  Table [dbo].[Aggregate_IO_Statistics]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aggregate_IO_Statistics](
	[CollectionDate] [datetime] NOT NULL,
	[I/O Rank] [bigint] NULL,
	[DB Name] [nvarchar](128) NULL,
	[Total I/O (MB)] [decimal](12, 2) NULL,
	[I/O Percent] [decimal](5, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Aggregate_IO_Statistics_FromDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aggregate_IO_Statistics_FromDate](
	[CollectionDate] [datetime] NOT NULL,
	[I/O Rank] [bigint] NULL,
	[DB Name] [nvarchar](128) NULL,
	[Total I/O (MB)] [decimal](12, 2) NULL,
	[I/O Percent] [decimal](5, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Aggregate_IO_Statistics_ToDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aggregate_IO_Statistics_ToDate](
	[CollectionDate] [datetime] NOT NULL,
	[I/O Rank] [bigint] NULL,
	[DB Name] [nvarchar](128) NULL,
	[Total I/O (MB)] [decimal](12, 2) NULL,
	[I/O Percent] [decimal](5, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dba_errorLog]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dba_errorLog](
	[errorLog_id] [int] IDENTITY(1,1) NOT NULL,
	[errorType] [char](3) NULL,
	[errorDate] [datetime] NULL,
	[errorLine] [int] NULL,
	[errorMessage] [nvarchar](4000) NULL,
	[errorNumber] [int] NULL,
	[errorProcedure] [nvarchar](126) NULL,
	[procParameters] [nvarchar](4000) NULL,
	[errorSeverity] [int] NULL,
	[errorState] [int] NULL,
	[databaseName] [nvarchar](255) NULL,
 CONSTRAINT [PK_errorLog_errorLogID] PRIMARY KEY CLUSTERED 
(
	[errorLog_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dba_perfCounterMonitor]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dba_perfCounterMonitor](
	[capture_id] [int] IDENTITY(1,1) NOT NULL,
	[captureDate] [smalldatetime] NOT NULL,
	[objectName] [nvarchar](128) NOT NULL,
	[counterName] [nvarchar](128) NOT NULL,
	[instanceName] [nvarchar](128) NOT NULL,
	[value] [real] NOT NULL,
	[valueType] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_dba_perfCounterMonitor] PRIMARY KEY CLUSTERED 
(
	[capture_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dba_perfCounterMonitorConfig]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dba_perfCounterMonitorConfig](
	[objectName] [nvarchar](128) NOT NULL,
	[counterName] [nvarchar](128) NOT NULL,
	[instanceName] [nvarchar](128) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Drive_Level_Latency_Info]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drive_Level_Latency_Info](
	[CollectionDate] [datetime] NOT NULL,
	[Drive] [nvarchar](2) NULL,
	[Volume Mount Point] [nvarchar](256) NULL,
	[Read Latency] [bigint] NULL,
	[Write Latency] [bigint] NULL,
	[Overall Latency] [bigint] NULL,
	[Avg Bytes/Read] [bigint] NULL,
	[Avg Bytes/Write] [bigint] NULL,
	[Avg Bytes/Transfer] [bigint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Drive_Level_Latency_Info_FromDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drive_Level_Latency_Info_FromDate](
	[CollectionDate] [datetime] NOT NULL,
	[Drive] [nvarchar](2) NULL,
	[Volume Mount Point] [nvarchar](256) NULL,
	[Read Latency] [bigint] NULL,
	[Write Latency] [bigint] NULL,
	[Overall Latency] [bigint] NULL,
	[Avg Bytes/Read] [bigint] NULL,
	[Avg Bytes/Write] [bigint] NULL,
	[Avg Bytes/Transfer] [bigint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Drive_Level_Latency_Info_ToDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drive_Level_Latency_Info_ToDate](
	[CollectionDate] [datetime] NOT NULL,
	[Drive] [nvarchar](2) NULL,
	[Volume Mount Point] [nvarchar](256) NULL,
	[Read Latency] [bigint] NULL,
	[Write Latency] [bigint] NULL,
	[Overall Latency] [bigint] NULL,
	[Avg Bytes/Read] [bigint] NULL,
	[Avg Bytes/Write] [bigint] NULL,
	[Avg Bytes/Transfer] [bigint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IndexFragInfo2]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IndexFragInfo2](
	[CollectionDate] [datetime] NULL,
	[DatabaseName] [varchar](100) NULL,
	[ObjectName] [varchar](100) NULL,
	[Index_id] [int] NULL,
	[indexName] [varchar](100) NULL,
	[avg_fragmentation_percent] [float] NULL,
	[IndexType] [varchar](100) NULL,
	[Action_Required] [varchar](100) NULL DEFAULT ('NA')
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IndexUsage]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndexUsage](
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
/****** Object:  Table [dbo].[IndexUsageReads]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndexUsageReads](
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
/****** Object:  Table [dbo].[IndexUsageWrites]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndexUsageWrites](
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
/****** Object:  Table [dbo].[IO_Stats_By_Database_File]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IO_Stats_By_Database_File](
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
/****** Object:  Table [dbo].[IO_Stats_By_Database_File_FromDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IO_Stats_By_Database_File_FromDate](
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
/****** Object:  Table [dbo].[IO_Stats_By_Database_File_ToDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IO_Stats_By_Database_File_ToDate](
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
/****** Object:  Table [dbo].[IOWarningResults]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IOWarningResults](
	[CollectionDate] [datetime] NULL,
	[LogDate] [datetime] NULL,
	[ProcessInfo] [nvarchar](128) NOT NULL,
	[LogText] [nvarchar](1000) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IOWarningResults_FromDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IOWarningResults_FromDate](
	[CollectionDate] [datetime] NULL,
	[LogDate] [datetime] NULL,
	[ProcessInfo] [nvarchar](128) NOT NULL,
	[LogText] [nvarchar](1000) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IOWarningResults_ToDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IOWarningResults_ToDate](
	[CollectionDate] [datetime] NULL,
	[LogDate] [datetime] NULL,
	[ProcessInfo] [nvarchar](128) NOT NULL,
	[LogText] [nvarchar](1000) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Poor_IO_Queries]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poor_IO_Queries](
	[CollectionDate] [datetime] NOT NULL,
	[Query_Text] [nvarchar](max) NULL,
	[execution_count] [bigint] NOT NULL,
	[total_logical_reads] [bigint] NOT NULL,
	[last_logical_reads] [bigint] NOT NULL,
	[total_logical_writes] [bigint] NOT NULL,
	[last_logical_writes] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[last_worker_time] [bigint] NOT NULL,
	[total_elapsed_time_in_S] [bigint] NULL,
	[last_elapsed_time_in_S] [bigint] NULL,
	[last_execution_time] [datetime] NULL,
	[query_plan] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Poor_IO_Queries_FromDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poor_IO_Queries_FromDate](
	[CollectionDate] [datetime] NOT NULL,
	[Query_Text] [nvarchar](max) NULL,
	[execution_count] [bigint] NOT NULL,
	[total_logical_reads] [bigint] NOT NULL,
	[last_logical_reads] [bigint] NOT NULL,
	[total_logical_writes] [bigint] NOT NULL,
	[last_logical_writes] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[last_worker_time] [bigint] NOT NULL,
	[total_elapsed_time_in_S] [bigint] NULL,
	[last_elapsed_time_in_S] [bigint] NULL,
	[last_execution_time] [datetime] NULL,
	[query_plan] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Poor_IO_Queries_ToDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poor_IO_Queries_ToDate](
	[CollectionDate] [datetime] NOT NULL,
	[Query_Text] [nvarchar](max) NULL,
	[execution_count] [bigint] NOT NULL,
	[total_logical_reads] [bigint] NOT NULL,
	[last_logical_reads] [bigint] NOT NULL,
	[total_logical_writes] [bigint] NOT NULL,
	[last_logical_writes] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[last_worker_time] [bigint] NOT NULL,
	[total_elapsed_time_in_S] [bigint] NULL,
	[last_elapsed_time_in_S] [bigint] NULL,
	[last_execution_time] [datetime] NULL,
	[query_plan] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Poor_Query_Cache]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poor_Query_Cache](
	[Collection Date] [datetime] NOT NULL,
	[Execution Count] [bigint] NULL,
	[Query Text] [nvarchar](max) NULL,
	[DB Name] [nvarchar](128) NULL,
	[Total CPU Time] [bigint] NULL,
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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Poor_Query_Cache_FromDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poor_Query_Cache_FromDate](
	[Collection Date] [datetime] NOT NULL,
	[Execution Count] [bigint] NULL,
	[Query Text] [nvarchar](max) NULL,
	[DB Name] [nvarchar](128) NULL,
	[Total CPU Time] [bigint] NULL,
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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Poor_Query_Cache_ToDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poor_Query_Cache_ToDate](
	[Collection Date] [datetime] NOT NULL,
	[Execution Count] [bigint] NULL,
	[Query Text] [nvarchar](max) NULL,
	[DB Name] [nvarchar](128) NULL,
	[Total CPU Time] [bigint] NULL,
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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TraceResults]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TraceResults](
	[CaptureDateTime] [datetime] NULL,
	[TextData] [varchar](4000) NULL,
	[Duration] [bigint] NULL,
	[Duration_Sec] [decimal](10, 1) NULL,
	[DurationInSeconds] [decimal](10, 1) NULL,
	[Reads] [bigint] NULL,
	[Writes] [bigint] NULL,
	[CPU] [bigint] NULL,
	[StartTime] [datetime] NULL,
	[Hostname] [varchar](100) NULL,
	[ApplicationName] [varchar](100) NULL,
	[LoginName] [varchar](100) NULL,
	[DatabaseName] [varchar](100) NULL,
	[ProcedureName] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TraceResults_SP_Top20_FromDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TraceResults_SP_Top20_FromDate](
	[ProcedureName] [varchar](100) NULL,
	[DatabaseName] [varchar](100) NULL,
	[TimeImpact] [bigint] NULL,
	[IOImpact] [bigint] NULL,
	[CPUImpact] [bigint] NULL,
	[ExecutionCount] [int] NULL,
	[AvgDuration] [bigint] NULL,
	[AvgIOs] [bigint] NULL,
	[AvgCPU] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TraceResults_SP_Top20_ToDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TraceResults_SP_Top20_ToDate](
	[ProcedureName] [varchar](100) NULL,
	[DatabaseName] [varchar](100) NULL,
	[TimeImpact] [bigint] NULL,
	[IOImpact] [bigint] NULL,
	[CPUImpact] [bigint] NULL,
	[ExecutionCount] [int] NULL,
	[AvgDuration] [bigint] NULL,
	[AvgIOs] [bigint] NULL,
	[AvgCPU] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TraceResults_SQL_Top20_FromDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TraceResults_SQL_Top20_FromDate](
	[TextData] [varchar](4000) NULL,
	[DatabaseName] [varchar](100) NULL,
	[TimeImpact] [bigint] NULL,
	[IOImpact] [bigint] NULL,
	[CPUImpact] [bigint] NULL,
	[ExecutionCount] [int] NULL,
	[AvgDuration] [bigint] NULL,
	[AvgIOs] [bigint] NULL,
	[AvgCPU] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TraceResults_SQL_Top20_ToDate]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TraceResults_SQL_Top20_ToDate](
	[TextData] [varchar](4000) NULL,
	[DatabaseName] [varchar](100) NULL,
	[TimeImpact] [bigint] NULL,
	[IOImpact] [bigint] NULL,
	[CPUImpact] [bigint] NULL,
	[ExecutionCount] [int] NULL,
	[AvgDuration] [bigint] NULL,
	[AvgIOs] [bigint] NULL,
	[AvgCPU] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [Idx_CaptureDateTime]    Script Date: 03/09/2019 14:57:03 ******/
CREATE NONCLUSTERED INDEX [Idx_CaptureDateTime] ON [dbo].[TraceResults]
(
	[CaptureDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_DatabaseName_ProcedureName]    Script Date: 03/09/2019 14:57:03 ******/
CREATE NONCLUSTERED INDEX [Idx_DatabaseName_ProcedureName] ON [dbo].[TraceResults]
(
	[DatabaseName] ASC,
	[ProcedureName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_DatabaseName_TextData]    Script Date: 03/09/2019 14:57:03 ******/
CREATE NONCLUSTERED INDEX [Idx_DatabaseName_TextData] ON [dbo].[TraceResults]
(
	[DatabaseName] ASC
)
INCLUDE ( 	[TextData]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dba_errorLog] ADD  CONSTRAINT [DF_errorLog_errorType]  DEFAULT ('sys') FOR [errorType]
GO
ALTER TABLE [dbo].[dba_errorLog] ADD  CONSTRAINT [DF_errorLog_errorDate]  DEFAULT (getdate()) FOR [errorDate]
GO
/****** Object:  StoredProcedure [dbo].[dba_logError_sp]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
Create Procedure [dbo].[dba_logError_sp]
(
    /* Declare Parameters */
      @errorType            char(3)         = 'sys'
    , @app_errorProcedure   varchar(50)     = ''
    , @app_errorMessage     nvarchar(4000)  = ''
    , @procParameters       nvarchar(4000)  = ''
    , @userFriendly         bit             = 0
    , @forceExit            bit             = 1
    , @returnError          bit             = 1
)
As
/***************************************************************
    Name:       dba_logError_sp
 
    Author:     Michelle F. Ufford, http://sqlfool.com
 
    Purpose:    Retrieves error information and logs in the 
                        dba_errorLog table.
 
        @errorType = options are "app" or "sys"; "app" are custom 
                application errors, i.e. business logic errors;
                "sys" are system errors, i.e. PK errors
 
        @app_errorProcedure = stored procedure name, 
                needed for app errors
 
        @app_errorMessage = custom app error message
 
        @procParameters = optional; log the parameters that were passed
                to the proc that resulted in an error
 
        @userFriendly = displays a generic error message if = 1
 
        @forceExit = forces the proc to rollback and exit; 
                mostly useful for application errors.
 
        @returnError = returns the error to the calling app if = 1
 
    Called by:	Another stored procedure
 
    Date        Initials    Description
	----------------------------------------------------------------------------
    2008-12-16  MFU         Initial Release
****************************************************************
    Exec dbo.dba_logError_sp
        @errorType          = 'app'
      , @app_errorProcedure = 'someTableInsertProcName'
      , @app_errorMessage   = 'Some app-specific error message'
      , @userFriendly       = 1
      , @forceExit          = 1
      , @returnError        = 1;
****************************************************************/
 
Set NoCount On;
Set XACT_Abort On;
 
Begin
 
    /* Declare Variables */
    Declare	@errorNumber            int
            , @errorProcedure       varchar(50)
            , @dbName               sysname
            , @errorLine            int
            , @errorMessage         nvarchar(4000)
            , @errorSeverity        int
            , @errorState           int
            , @errorReturnMessage   nvarchar(4000)
            , @errorReturnSeverity  int
            , @currentDateTime      smalldatetime;
 
    Declare @errorReturnID Table (errorID varchar(10));
 
    /* Initialize Variables */
    Select @currentDateTime = GetDate();
 
    /* Capture our error details */
    If @errorType = 'sys' 
    Begin
 
        /* Get our system error details and hold it */
        Select 
              @errorNumber      = Error_Number()
            , @errorProcedure   = Error_Procedure()
            , @dbName           = DB_Name()
            , @errorLine        = Error_Line()
            , @errorMessage     = Error_Message()
            , @errorSeverity    = Error_Severity()
            , @errorState       = Error_State() ;
 
    End
    Else
    Begin
 
    	/* Get our custom app error details and hold it */
        Select 
              @errorNumber      = 0
            , @errorProcedure   = @app_errorProcedure
            , @dbName           = DB_Name()
            , @errorLine        = 0
            , @errorMessage     = @app_errorMessage
            , @errorSeverity    = 0
            , @errorState       = 0 ;
 
    End;
 
    /* And keep a copy for our logs */
    Insert Into dbo.dba_errorLog
    (
          errorType
        , errorDate
        , errorLine
        , errorMessage
        , errorNumber
        , errorProcedure
        , procParameters
        , errorSeverity
        , errorState
        , databaseName
	)
    OutPut Inserted.errorLog_id Into @errorReturnID
    Values
    (
          @errorType
        , @currentDateTime
        , @errorLine
        , @errorMessage
        , @errorNumber
        , @errorProcedure
        , @procParameters
        , @errorSeverity
        , @errorState
        , @dbName
    );
 
    /* Should we display a user friendly message to the application? */
    If @userFriendly = 1
        Select @errorReturnMessage = 'An error has occurred in the database (' + errorID + ')'
        From @errorReturnID;
    Else 
        Select @errorReturnMessage = @errorMessage;
 
    /* Do we want to force the application to exit? */
    If @forceExit = 1
        Select @errorReturnSeverity = 15
    Else
        Select @errorReturnSeverity = @errorSeverity;
 
    /* Should we return an error message to the calling proc? */
    If @returnError = 1
        Raiserror 
        (
              @errorReturnMessage
            , @errorReturnSeverity
            , 1
        ) With NoWait;
 
    Set NoCount Off;
    Return 0;
 
End

GO
/****** Object:  StoredProcedure [dbo].[dba_perfCounterMonitor_sp]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Now create SP to capture and convert the selected SQL Performance Counters ..

Create Procedure [dbo].[dba_perfCounterMonitor_sp]
 
        /* Declare Parameters */
          @samplePeriod    int      =  240  /* how long to sample, in seconds */
        , @sampleRate      char(8)  =  '00:00:15'  /* how frequently to sample, in seconds */
        , @displayResults  bit      =  0  /* display the results when done */
As
/*********************************************************************************
    Name:       dba_perfCounterMonitor_sp
 
    Author:     Michelle Ufford, http://sqlfool.com
 
    Purpose:    Monitors performance counters.  Uses the dba_perfCounterMonitorConfig
                table to manage which perf counters to monitor.  
 
                @samplePeriod - specifies how long the process will try to monitor
                                performance counters; in seconds.
 
                @sampleRate - how long inbetween samples; in seconds.
 
                The average values over sample period is then logged to the
                dba_perfCounterMonitor table.
 
    Notes:      There are 3 basic types of performance counter calculations:
 
                Value/Base: these calculations require 2 counters. The value 
                            counter (cntr_type = 537003264) has to be divided 
                            by the base counter (cntr_type = 1073939712).
 
                Per Second: these counters are store cumulative values; the
                            value must be compared at 2 different times to
                            calculate the difference (cntr_type = 537003264).
 
                Point In Time:  these counters show what the value of the
                                counter is at the current point-in-time 
                                (cntr_type = 65792).  No calculation is 
                                necessary to derive the value.
 
    Called by:  DBA
 
    Date        User    Description
    ----------------------------------------------------------------------------
    2009-09-04  MFU     Initial Release
*********************************************************************************
    Exec dbo.dba_perfCounterMonitor_sp
          @samplePeriod     = 60
        , @sampleRate       = '00:00:01'
        , @displayResults   = 1;
*********************************************************************************/
 
Set NoCount On;
Set XACT_Abort On;
Set Ansi_Padding On;
Set Ansi_Warnings On;
Set ArithAbort On;
Set Concat_Null_Yields_Null On;
Set Numeric_RoundAbort Off;
 
Begin
 
    /* Declare Variables */
    Declare @startTime datetime
        , @endTime datetime
        , @iteration int;
 
    Select @startTime = GetDate()
        , @iteration = 1;
 
    Declare @samples Table
    (
          iteration     int             Not Null
        , objectName    nvarchar(128)   Not Null
        , counterName   nvarchar(128)   Not Null
        , instanceName  nvarchar(128)   Not Null
        , cntr_value    float           Not Null
        , base_value    float           Null
        , cntr_type     bigint          Not Null
    );
 
    Begin Try
 
        /* Start a new transaction */
        Begin Transaction;
 
        /* Grab all of our counters */
        Insert Into @samples
        Select @iteration
            , RTrim(dopc.object_name)
            , RTrim(dopc.counter_name)
            , RTrim(dopc.instance_name)
            , RTrim(dopc.cntr_value)
            , (Select cntr_value From sys.dm_os_performance_counters As dopc1
                Where dopc1.object_name = pcml.objectName
                And dopc1.counter_name = pcml.counterName + ' base'
                And dopc1.instance_name = IsNull(pcml.instanceName, dopc.instance_name))
            , dopc.cntr_type
        From sys.dm_os_performance_counters As dopc
        Join dbo.dba_perfCounterMonitorConfig As pcml
            On dopc.object_name = pcml.objectName
                And dopc.counter_name = pcml.counterName
                And dopc.instance_name = IsNull(pcml.instanceName, dopc.instance_name);
 
        /* During our sample period, grab our counter values and store the results */
        While GetDate() < DateAdd(second, @samplePeriod, @startTime)
        Begin
 
            Set @iteration = @iteration + 1;
 
            Insert Into @samples
            Select @iteration
                , RTrim(dopc.object_name)
                , RTrim(dopc.counter_name)
                , RTrim(dopc.instance_name)
                , dopc.cntr_value
                , (Select cntr_value From sys.dm_os_performance_counters As dopc1
                    Where dopc1.object_name = pcml.objectName
                    And dopc1.counter_name = pcml.counterName + ' base'
                    And dopc1.instance_name = IsNull(pcml.instanceName, dopc.instance_name))
                , dopc.cntr_type
            From sys.dm_os_performance_counters As dopc
            Join dbo.dba_perfCounterMonitorConfig As pcml
                On dopc.object_name = pcml.objectName
                    And dopc.counter_name = pcml.counterName
                    And dopc.instance_name = IsNull(pcml.instanceName, dopc.instance_name);
 
            /* Wait for a small delay */
            WaitFor Delay @sampleRate;
 
        End;
 
        /* Grab our end time for calculations */
        Set @endTime = GetDate();
 
        /* Store the average of our point-in-time counters */
        Insert Into dbo.dba_perfCounterMonitor 
        (
			  captureDate
			, objectName
			, counterName
			, instanceName
			, value
			, valueType
		) 
		Select @startTime
		    , objectName
		    , counterName
		    , instanceName
		    , Avg(cntr_value)
		    , 'value'
		From @samples
		Where cntr_type = 65792
		Group By objectName
		    , counterName
		    , instanceName;
 
        /* Store the average of the value vs the base for cntr_type = 537003264 */
        Insert Into dbo.dba_perfCounterMonitor 
        (
			  captureDate
			, objectName
			, counterName
			, instanceName
			, value
			, valueType
		) 
		Select @startTime
		    , objectName
		    , counterName
		    , instanceName
		    , 100 * ( Avg(cntr_value)/Avg(IsNull(base_value, 1)) )
		    , 'percent'
		From @samples
		Where cntr_type = 537003264
		Group By objectName
		    , counterName
		    , instanceName;
 
        /* Compare the first and last values for our cumulative, per-second counters */
        Insert Into dbo.dba_perfCounterMonitor 
        (
			  captureDate
			, objectName
			, counterName
			, instanceName
			, value
			, valueType
		) 
		Select @startTime
		    , objectName
		    , counterName
		    , instanceName
		    , (Max(cntr_value) - Min(cntr_value)) / DateDiff(second, @startTime, @endTime)
		    , 'value'
		From @samples
		Where cntr_type = 272696576
        Group By objectName
		    , counterName
		    , instanceName;
 
        /* Should we display the results of our most recent execution?  */
        If @displayResults = 1
            Select captureDate
                , objectName
                , counterName
                , instanceName
                , value
                , valueType
            From dbo.dba_perfCounterMonitor With (NoLock)
            Where captureDate = Cast(@startTime As smalldatetime)
            Order By objectName
                , counterName
                , instanceName;
 
        /* If you have an open transaction, commit it */
        If @@TranCount > 0
            Commit Transaction;
 
    End Try
    Begin Catch
 
        /* Whoops, there was an error... rollback! */
        If @@TranCount > 0
            Rollback Transaction;
 
        /* Return an error message and log it */
        Execute dbo.dba_logError_sp;
 
    End Catch;
 
    Set NoCount Off;
    Return 0;
End

GO
/****** Object:  StoredProcedure [dbo].[usp_Compare_Perf_Data]    Script Date: 03/09/2019 14:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_Compare_Perf_Data]
(
 @FromDate	DATETIME= NULL
,@ToDate	DATETIME= NULL
)
AS
BEGIN
DECLARE @FDate DATETIME
DECLARE @TDate DATETIME

SET @FDate = ISNULL(@FromDate ,GETDATE())
SET @TDate = ISNULL(@ToDate , GETDATE())

-- Return SP Execution Summary Data

SELECT 'Executing usp_Compare_Perf_Data';
SELECT 'Compare From Date is: ' + CONVERT(VARCHAR, @FromDate,105)
SELECT 'Compare To Date is: ' + CONVERT(VARCHAR, @ToDate,105)


-- Process Poor_IO_Queries

-- Get Poor_IO_Queries for @FromDate

IF OBJECT_ID('DBAPerfData.dbo.Poor_IO_Queries_FromDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.Poor_IO_Queries_FromDate;

SELECT	'Poor_IO_Queries for ' + CONVERT(VARCHAR, @FromDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[Poor_IO_Queries_FromDate]
FROM	[DBAPerfData].[dbo].[Poor_IO_Queries]
WHERE	CollectionDate >= @FromDate
AND		CollectionDate <= DateAdd(hh, 24, @FromDate)
ORDER BY
		CollectionDate DESC, 
		total_logical_reads DESC

-- Get Poor_IO_Queries for @ToDate

IF OBJECT_ID('DBAPerfData.dbo.Poor_IO_Queries_ToDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.Poor_IO_Queries_ToDate;

SELECT	'Poor_IO_Queries for ' + CONVERT(VARCHAR, @ToDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[Poor_IO_Queries_ToDate]
FROM	[DBAPerfData].[dbo].[Poor_IO_Queries]
WHERE	CollectionDate >= @ToDate
AND		CollectionDate <= DateAdd(hh, 24, @ToDate)
ORDER BY
		CollectionDate DESC, 
		total_logical_reads DESC


-- Process Poor_Query_Cache

-- Get Poor_Query_Cache for @FromDate

IF OBJECT_ID('DBAPerfData.dbo.Poor_Query_Cache_FromDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.Poor_Query_Cache_FromDate;

SELECT	'Poor_Query_Cache for ' + CONVERT(VARCHAR, @FromDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[Poor_Query_Cache_FromDate]
FROM	[DBAPerfData].[dbo].[Poor_Query_Cache]
WHERE	[Collection Date] >= @FromDate
AND		[Collection Date] <= DateAdd(hh, 24, @FromDate)
ORDER BY
		[Collection Date] DESC, 
		[Execution Count] DESC,
		[Avg Duration (ms)] DESC,
		[Avg CPU Time (ms)] DESC,
		[Avg Physical Reads] DESC,
		[Avg Logical Reads] DESC,
		[Total Logical Writes] DESC

-- Get Poor_Query_Cache for @ToDate

IF OBJECT_ID('DBAPerfData.dbo.Poor_Query_Cache_ToDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.Poor_Query_Cache_ToDate;

SELECT	'Poor_Query_Cache for ' + + CONVERT(VARCHAR, @ToDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[Poor_Query_Cache_ToDate]
FROM	[DBAPerfData].[dbo].[Poor_Query_Cache]
WHERE	[Collection Date] >= @ToDate
AND		[Collection Date] <= DateAdd(hh, 24, @ToDate)
ORDER BY
		[Collection Date] DESC, 
		[Execution Count] DESC,
		[Avg Duration (ms)] DESC,
		[Avg CPU Time (ms)] DESC,
		[Avg Physical Reads] DESC,
		[Avg Logical Reads] DESC,
		[Total Logical Writes] DESC


-- Process TraceResults

-- Get Poor_SQL_TraceResults for @FromDate

IF OBJECT_ID('DBAPerfData.dbo.TraceResults_SP_Top20_FromDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.TraceResults_SP_Top20_FromDate;

SELECT	'Poor_SQL_TraceResults for ' + CONVERT(VARCHAR, @FromDate,105)

-- Now Report Top 20 Poorly Performing SP SQL executions by Time Impact
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
INTO	DBAPerfData.dbo.TraceResults_SP_Top20_FromDate
FROM	[DBAPerfData].[dbo].[TraceResults]
WHERE	[CaptureDateTime] >= @FromDate
AND		[CaptureDateTime] <= DateAdd(hh, 24, @FromDate)
GROUP BY ProcedureName, DatabaseName
ORDER BY SUM(CAST(duration AS BIGINT)) DESC

IF OBJECT_ID('DBAPerfData.dbo.TraceResults_SQL_Top20_FromDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.TraceResults_SQL_Top20_FromDate;

-- Now Report Top 20 Poorly Performing SQL executions by Time Impact
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
INTO	[DBAPerfData].[dbo].[TraceResults_SQL_Top20_FromDate]
FROM	[DBAPerfData].[dbo].[TraceResults]
WHERE	[CaptureDateTime] >= @FromDate
AND		[CaptureDateTime] <= DateAdd(hh, 24, @FromDate)
GROUP BY TextData, DatabaseName
ORDER BY SUM(CAST(duration AS BIGINT)) DESC



-- Get Poor_SQL_TraceResults for @ToDate

SELECT	'Poor_SQL_TraceResults for ' + + CONVERT(VARCHAR, @ToDate,105)

IF OBJECT_ID('DBAPerfData.dbo.TraceResults_SP_Top20_ToDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.TraceResults_SP_Top20_ToDate;

-- Now Report Top 20 Poorly Performing SP SQL executions by Time Impact
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
INTO	[DBAPerfData].[dbo].[TraceResults_SP_Top20_ToDate]
FROM	[DBAPerfData].[dbo].[TraceResults]
WHERE	[CaptureDateTime] >= @ToDate
AND		[CaptureDateTime] <= DateAdd(hh, 24, @ToDate)
GROUP BY ProcedureName, DatabaseName
ORDER BY SUM(CAST(duration AS BIGINT)) DESC


IF OBJECT_ID('DBAPerfData.dbo.TraceResults_SQL_Top20_ToDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.TraceResults_SQL_Top20_ToDate;


-- Now Report Top 20 Poorly Performing SQL executions by Time Impact
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
INTO	[DBAPerfData].[dbo].[TraceResults_SQL_Top20_ToDate]
FROM	[DBAPerfData].[dbo].[TraceResults]
WHERE	[CaptureDateTime] >= @ToDate
AND		[CaptureDateTime] <= DateAdd(hh, 24, @ToDate)
GROUP BY TextData, DatabaseName
ORDER BY SUM(CAST(duration AS BIGINT)) DESC



-- Process Aggregate_IO_Statistics

-- Get Aggregate_IO_Statistics for @FromDate

IF OBJECT_ID('DBAPerfData.dbo.Aggregate_IO_Statistics_FromDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.Aggregate_IO_Statistics_FromDate;

SELECT	'Aggregate_IO_Statistics for ' + CONVERT(VARCHAR, @FromDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[Aggregate_IO_Statistics_FromDate]
FROM	[DBAPerfData].[dbo].[Aggregate_IO_Statistics]
WHERE	[CollectionDate] >= @FromDate
AND		[CollectionDate] <= DateAdd(hh, 24, @FromDate)
ORDER BY
		[CollectionDate] DESC, 
		[I/O Rank]

-- Get Aggregate_IO_Statistics for @ToDate

IF OBJECT_ID('DBAPerfData.dbo.Aggregate_IO_Statistics_ToDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.Aggregate_IO_Statistics_ToDate;

SELECT	'Aggregate_IO_Statistics for ' + + CONVERT(VARCHAR, @ToDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[Aggregate_IO_Statistics_ToDate]
FROM	[DBAPerfData].[dbo].[Aggregate_IO_Statistics]
WHERE	[CollectionDate] >= @ToDate
AND		[CollectionDate] <= DateAdd(hh, 24, @ToDate)
ORDER BY
		[CollectionDate] DESC, 
		[I/O Rank]

-- Process Drive_Level_Latency_Info

-- Get Drive_Level_Latency_Info for @FromDate

IF OBJECT_ID('DBAPerfData.dbo.Drive_Level_Latency_Info_FromDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.Drive_Level_Latency_Info_FromDate;

SELECT	'Drive_Level_Latency_Info for ' + CONVERT(VARCHAR, @FromDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[Drive_Level_Latency_Info_FromDate]
FROM	[DBAPerfData].[dbo].[Drive_Level_Latency_Info]
WHERE	[CollectionDate] >= @FromDate
AND		[CollectionDate] <= DateAdd(hh, 24, @FromDate)
ORDER BY
		[CollectionDate] DESC, 
		[Overall Latency]

-- Get Drive_Level_Latency_Info for @ToDate

IF OBJECT_ID('DBAPerfData.dbo.Drive_Level_Latency_Info_ToDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.Drive_Level_Latency_Info_ToDate;

SELECT	'Drive_Level_Latency_Info ' + + CONVERT(VARCHAR, @ToDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[Drive_Level_Latency_Info_ToDate]
FROM	[DBAPerfData].[dbo].[Drive_Level_Latency_Info]
WHERE	[CollectionDate] >= @ToDate
AND		[CollectionDate] <= DateAdd(hh, 24, @ToDate)
ORDER BY
		[CollectionDate] DESC, 
		[Overall Latency]

-- Process IO_Stats_By_Database_File

-- Get IO_Stats_By_Database_File for @FromDate

IF OBJECT_ID('DBAPerfData.dbo.IO_Stats_By_Database_File_FromDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.IO_Stats_By_Database_File_FromDate;

SELECT	'IO_Stats_By_Database_File for ' + CONVERT(VARCHAR, @FromDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[IO_Stats_By_Database_File_FromDate]
FROM	[DBAPerfData].[dbo].[IO_Stats_By_Database_File]
WHERE	[CollectionDate] >= @FromDate
AND		[CollectionDate] <= DateAdd(hh, 24, @FromDate)
ORDER BY
		[CollectionDate] DESC, 
		avg_io_latency_ms DESC

-- Get IO_Stats_By_Database_Filefor @ToDate

IF OBJECT_ID('DBAPerfData.dbo.IO_Stats_By_Database_File_ToDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.IO_Stats_By_Database_File_ToDate;

SELECT	'IO_Stats_By_Database_File ' + + CONVERT(VARCHAR, @ToDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[IO_Stats_By_Database_File_ToDate]
FROM	[DBAPerfData].[dbo].[IO_Stats_By_Database_File]
WHERE	[CollectionDate] >= @ToDate
AND		[CollectionDate] <= DateAdd(hh, 24, @ToDate)
ORDER BY
		[CollectionDate] DESC, 
		avg_io_latency_ms DESC


-- Process IOWarningResults

-- Get IOWarningResults for @FromDate

IF OBJECT_ID('DBAPerfData.dbo.IOWarningResults_FromDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.IOWarningResults_FromDate;

SELECT	'IOWarningResults for ' + CONVERT(VARCHAR, @FromDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[IOWarningResults_FromDate]
FROM	[DBAPerfData].[dbo].[IOWarningResults]
WHERE	[CollectionDate] >= @FromDate
AND		[CollectionDate] <= DateAdd(hh, 24, @FromDate)
ORDER BY
		[CollectionDate] DESC, 
		LogDate DESC

-- Get IOWarningResults @ToDate

IF OBJECT_ID('DBAPerfData.dbo.IOWarningResults_ToDate', 'U') IS NOT NULL 
  DROP TABLE DBAPerfData.dbo.IOWarningResults_ToDate;

SELECT	'IOWarningResults ' + + CONVERT(VARCHAR, @ToDate,105)

SELECT	*
INTO	[DBAPerfData].[dbo].[IOWarningResults_ToDate]
FROM	[DBAPerfData].[dbo].[IOWarningResults]
WHERE	[CollectionDate] >= @ToDate
AND		[CollectionDate] <= DateAdd(hh, 24, @ToDate)
ORDER BY
		[CollectionDate] DESC, 
		LogDate DESC


END


GO
USE [master]
GO
ALTER DATABASE [DBAPerfData] SET  READ_WRITE 
GO
