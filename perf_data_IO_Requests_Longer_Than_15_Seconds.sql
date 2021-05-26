-- Look for I/O requests taking longer than 15 seconds in the six most recent SQL Server Error Logs (Query 30) (IO Warnings)

USE [DBAPerfData]
GO

/* Requires that the following TABLE be created first

CREATE TABLE [DBAPerfData].[dbo].[IOWarningResults] (CollectionDate datetime CONSTRAINT DF_CD DEFAULT GETDATE(), LogDate datetime, ProcessInfo sysname, LogText nvarchar(1000));

*/

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults]
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 0, 1, N'taking longer than 15 seconds';

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults]
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 1, 1, N'taking longer than 15 seconds';

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults]
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 2, 1, N'taking longer than 15 seconds';

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults]
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 3, 1, N'taking longer than 15 seconds';

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults] 
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 4, 1, N'taking longer than 15 seconds';

	INSERT INTO [DBAPerfData].[dbo].[IOWarningResults]
	(LogDate, ProcessInfo, LogText)
	EXEC xp_readerrorlog 5, 1, N'taking longer than 15 seconds';

SELECT		CollectionDate, LogDate, ProcessInfo, LogText
FROM		[DBAPerfData].[dbo].[IOWarningResults]
ORDER BY	LogDate DESC;
