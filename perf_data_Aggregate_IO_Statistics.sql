USE [DBAPerfData]
GO

/* Requires that the following TABLE be created first

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [DBAPerfData].[dbo].[Aggregate_IO_Statistics](
	[CollectionDate] [datetime] NOT NULL,
	[I/O Rank] [bigint] NULL,
	[DB Name] [nvarchar](128) NULL,
	[Total I/O (MB)] [decimal](12, 2) NULL,
	[I/O Percent] [decimal](5, 2) NULL
) ON [PRIMARY]

GO

*/

WITH AggregateIOStatistics
AS
(SELECT DB_NAME(database_id) AS [DB Name],
CAST(SUM(num_of_bytes_read + num_of_bytes_written)/1048576 AS DECIMAL(12, 2)) AS io_in_mb
FROM sys.dm_io_virtual_file_stats(NULL, NULL) AS [DM_IO_STATS]
GROUP BY database_id)
INSERT INTO [DBAPerfData].[dbo].[Aggregate_IO_Statistics]
SELECT GETDATE() AS CollectionDate, ROW_NUMBER() OVER(ORDER BY io_in_mb DESC) AS [I/O Rank], [DB Name], io_in_mb AS [Total I/O (MB)],
       CAST(io_in_mb/ SUM(io_in_mb) OVER() * 100.0 AS DECIMAL(5,2)) AS [I/O Percent]
FROM AggregateIOStatistics
ORDER BY [I/O Rank]
