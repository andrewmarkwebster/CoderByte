USE [DBAPerfData]
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
	Action_Required				varchar(100) default 'NA'
)
GO
*/

insert into [DBAPerfData].[dbo].[IndexFragInfo2] (CollectionDate, DatabaseName,ObjectName,Index_id, indexName,avg_fragmentation_percent,IndexType)

exec master.sys.sp_MSforeachdb ' USE [?]

SELECT GETDATE() AS CollectionDate, db_name() as DatabaseName, OBJECT_NAME (a.object_id) as ObjectName, 

a.index_id, b.name as IndexName, 

avg_fragmentation_in_percent, index_type_desc

-- , record_count, avg_page_space_used_in_percent --(null in limited)

FROM sys.dm_db_index_physical_stats (db_id(), NULL, NULL, NULL, NULL) AS a

JOIN sys.indexes AS b 

ON a.object_id = b.object_id AND a.index_id = b.index_id

WHERE b.index_id <> 0 and avg_fragmentation_in_percent <> 0
AND db_id() > 4'
go
 
update [DBAPerfData].[dbo].[IndexFragInfo2]
set Action_Required ='Rebuild'
where avg_fragmentation_percent >30 
go

update [DBAPerfData].[dbo].[IndexFragInfo2]
set Action_Required ='Reorganize'
where avg_fragmentation_percent <30 and avg_fragmentation_percent >5
go

select * from [DBAPerfData].[dbo].[IndexFragInfo2]
ORDER BY
	CollectionDate,
	DatabaseName,
	avg_fragmentation_percent DESC

