/*---------------------------------------------------------------------------------------------------------------------------------*/
/* Title:	   Performance_Tune_Interview3_DB.sql                                                                                  */
/* Date:	   26/05/2021                                                                                                          */
/* Author:	   Andy Webster                                                                                                        */
/* Purpose:    To implement a number of actions to improve the performance                                                         */
/*			   of the Interview3 database in Azure                                                                                 */
/* Parameters: None                                                                                                                */
/* Execution:  sqlcmd -S  interview-testing-server.database.windows.net -i C:\CoderByte_Test\Performance_Tune_Interview3_DB.sql.   */
/*---------------------------------------------------------------------------------------------------------------------------------*/
/* Change Control                                                                                                                  */
/* Version         Date           Author           Nature of Change                                                                */
/* 1.0             26/05/2021     Andy Webster     Initial Prototype Version                                                       */
/*---------------------------------------------------------------------------------------------------------------------------------*/

/* Use appropriate database */
USE [Master]
GO

/* Run Ola Hallenegren Maintenance solution in master DB from https://ola.hallengren.com/ */
sqlcmd -S  interview-testing-server.database.windows.net -i C:\CoderByte_Test\MaintenanceSolution.sql

/* Now switch context to User Database Interview3 */
USE [Interview3]
GO

/* Now optimise all Indexes with fragmentation */
EXECUTE [master].[dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationLevel1 = 5,
@FragmentationLevel2 = 30,
@UpdateStatistics = 'ALL',
@OnlyModifiedStatistics = 'Y'

/* Now Update all Statistics */
EXECUTE [master].[dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = NULL,
@FragmentationHigh = NULL,
@UpdateStatistics = 'ALL'

/* Now update table and index fill factors from 100%  default to 80% to allow faster inserts and updates */
/* For Example */
USE [Interview3];  
GO 
-- rebuilds the named index   
-- with a fill factor of 80 on the [dbo].[LegacyActivities] table.  

ALTER INDEX IDX_LegacyActivities_ClaimReference ON [dbo].[LegacyActivities]  
REBUILD WITH (FILLFACTOR = 80);   
GO  
 

/* Rename spX named stored procedures to uspX naming convention to avoid search in master DB for SP */
EXEC sp_rename 'Interview3.dbo.sp_alterdiagram', 'Interview3.dbo.usp_alterdiagram';  
GO

EXEC sp_rename 'Interview3.dbo.sp_creatediagram', 'Interview3.dbo.usp_creatediagram';  
GO

EXEC sp_rename 'Interview3.dbo.sp_dropdiagram', 'Interview3.dbo.usp_dropdiagram';  
GO

EXEC sp_rename 'Interview3.dbo.sp_helpdiagramdefinition', 'Interview3.dbo.usp_helpdiagramdefinition';  
GO

EXEC sp_rename 'Interview3.dbo.sp_helpdiagrams', 'Interview3.dbo.usp_helpdiagrams';  
GO

EXEC sp_rename 'Interview3.dbo.sp_renamediagram', 'Interview3.dbo.usp_renamediagram';  
GO

EXEC sp_rename 'Interview3.dbo.sp_upgraddiagrams', 'Interview3.dbo.usp_upgraddiagrams';  
GO

/* Now create any missing indexes in the Database as reported by SQL Server DMVs */ 
/* Typically these will be PK, FK and Search (or Join) predicates */
/* Use DBAPerfData (see below) to monitor perfmance of user DB as indexes are created and if not improved, rollback index creation */

/* Use Index Usage DMVs results from DBAPefData Database (see below) to drop and unused indexes */

/* Now use fully qualified names to optimise execution of Stored procedures */

/*
DECLARE @ClaimReference NVARCHAR(50) = 'BAP914444847'
DECLARE @Filter NVARCHAR(MAX) = NULL
DECLARE @Category NVARCHAR(50) = NULL
DECLARE @Start DATETIME = NULL
DECLARE @End DATETIME = NULL
DECLARE @Skip INT = 0
DECLARE @Take INT = 100
DECLARE @SortDescending BIT = 1

EXECUTE [Interview3].[dbo].[usp_GetLegacyActivityTimeline] 
   @ClaimReference
  ,@Filter
  ,@Category
  ,@Start
  ,@End
  ,@Skip
  ,@Take
  ,@SortDescending
GO
*/

/*
DECLARE @LegacyActivityIds udtt_stringlist

INSERT @LegacyActivityIds
VALUES
--Claim - BAP914444847
('16433'),
('16437'),
('16424'),
('16434'),
('16422'),
('16440'),
('16416'),
('16432'),
('134'),
('16445'),
('16417'),
('16415'),
('16430'),
('16428'),
('16420'),
('16421'),
('10767'),
('16442'),
('16426'),
('16425'),
('16431'),
('16436'),
('16443'),
('16446'),
('16412'),
('16423'),
('16435'),
('16419'),
('16429'),
('16427'),
('16414'),
('16439'),
('16418'),
('16438'),
('16441'),
('16447'),
('16413'),
('16444')

EXECUTE [Interview3].[dbo].[usp_GetActivityEnrichments] 
   @LegacyActivityIds
GO

*/

/* Now setup a DBA performance tuning Database to capture various metrics to use to improve performance on an ongoing process */

/*
The following procedure is proposed to implement a DBA SQL Server Performance Data capture database and SQL Server Reporting Services Reports of performance data from this database of historical performance data for the comparison of before and after data from performance tuning and optimisation exercises for the demonstration of improvements in SQL Server performance.
*/

/* The implementation procedure is as follows; */

/*
-	On the target SQL server, run the SQL script DBAPerfData_Database_Create.sql to create the DBAPerfData SQL Server database.

-	On the target SQL server, run the SQL script DBAPerfData_Schema_Create.sql to create the tables, indexes and stored procedures in the DBAPerfData database.

-	On the target SQL server, run the SQL script Perf_Data_Capture_Poor_SQL_History.sql to create and schedule the SQL Agent Job Perf_Data_Capture_Poor_SQL_History
-	On the target SQL server, run the SQL script Perf_Data_Capture_Aggregate_IO_Statistics.sql to create and schedule the SQL Agent Job Perf_Data_Capture_Aggregate_IO_Statistics
-	On the target SQL server, run the SQL script Perf_Data_Capture_Drive_Level_Latency_Info.sql to create and schedule the SQL Agent Job Perf_Data_Capture_Drive_Level_Latency_Info
-	On the target SQL server, run the SQL script Perf_Data_Capture_IndexFragInfo.sql to create and schedule the SQL Agent Job Perf_Data_Capture_IndexfragInfo
-	On the target SQL server, run the SQL script Perf_Data_Capture_IndexUsage.sql to create and schedule the SQL Agent Job Perf_Data_Capture_IndexUsage
-	On the target SQL server, run the SQL script Perf_Data_Capture_IO_Requests_Longer_Than_15_Seconds.sql to create and schedule the SQL Agent Job Perf_Data_Capture_IO_Requests_Longer_Than_15_Seconds
-	On the target SQL server, run the SQL script Perf_Data_Capture_IO_Stats_By_Database_File.sql to create and schedule the SQL Agent Job Perf_Data_Capture_IO_Stats_By_Database_File
-	On the target SQL server, run the SQL script Perf_Data_Capture_Poor_IO_Queries.sql to create and schedule the SQL Agent Job Perf_Data_Capture_Poor_IO_Queries
-	On the target SQL server, run the SQL script Perf_Data_Capture_Poor_SQL_TraceResults_0030.sql to create and schedule the SQL Agent Job Perf_Data_Capture_Poor_SQL_TraceResults_0030
-	On the target SQL server, run the SQL script Perf_Data_Capture_Poor_SQL_TraceResults_1400.sql to create and schedule the SQL Agent Job Perf_Data_Capture_Poor_SQL_TraceResults_1400
-	On the target SQL server, run the SQL script Perf_Data_Capture_SQL_Perfmon_Counters.sql to create and schedule the SQL Agent Job Perf_Data_Capture_SQL_Perfmon_Counters
-	On a suitable SQL Server Reporting Services Instance, deploy the SSRS Reports; TransPerSec.rdl, BatchReqPerSec.rdl, IndexfragPercent.rdl, IndexUsage.rdl. 
    These SSRS reports have already been deployed to the SSRS instance at http://CoderByte/Reports/browse/ 
	Please note, the reports should all be configured with the Data Source to prompt the user for Windows user name and password credentials
-	You can compare Performance Data between a FromDate and a ToDate by running the stored procedure usp_Compare_Perf_Data supplying a FromDate and ToDate parameter e.g.

Using the following SQL;
EXEC [DBAPerfData].[dbo].[usp_Compare_Perf_Data] @FromDate = '2019-08-15 00:00:00.000', @ToDate = '2019-08-23 00:00:00.000'
This stored procedure will extract the relevant performance data for the two given dates (in this case a FromDate of 2019-08-15 and a ToDate of 2019-08-23) and populate the Tables ending in _FromDate and _ToDate with the data for the relevant dates, allowing data comparison between data captured on these dates.

With limited time for the CoderByte test I have elaborated on all the T-SQL tables, scripts and procdedures in the above SQL script files from a recent implementation
Detailed explanation available on request */

USE [DBAPerfData]
GO

/*
Now run the provided Queries and SSRS reports to analyze Database performance and make optimisation decisions 
*/

