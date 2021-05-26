BEGIN

USE [DBAPerfData]
GO


-- Requires the following to exist

/*

CREATE TABLE [DBAPerfData].[dbo].[IndexFragInfo]
(
CollectionDate		datetime,
DatabaseName		nvarchar(128),
DatabaseID			smallint,
full_obj_name		nvarchar(384),
index_id			INT, 
[name]				nvarchar(128), 
index_type_desc		nvarchar(60), 
index_depth			tinyint,
index_level			tinyint,
[AVG Fragmentation] float, 
fragment_count		bigint,
[Rank]				bigint 
)

*/

DECLARE @command VARCHAR(1000) 
SELECT @command = 'Use [' + '?' + '] select GETDATE() AS CollectionDate, ' + '''' + '?' + '''' + ' AS DatabaseName,
DB_ID() AS DatabaseID,
QUOTENAME(DB_NAME(i.database_id), '+ '''' + '"' + '''' +')+ N'+ '''' + '.' + '''' +'+ QUOTENAME(OBJECT_SCHEMA_NAME(i.object_id, i.database_id), '+ '''' + '"' + '''' +')+ N'+ '''' + '.' + '''' +'+ QUOTENAME(OBJECT_NAME(i.object_id, i.database_id), '+ '''' + '"' + '''' +') as full_obj_name, 
i.index_id,
o.name, 
i.index_type_desc, 
i.index_depth,
i.index_level,
i.avg_fragmentation_in_percent as [AVG Fragmentation], 
i.fragment_count, 
i.rnk as Rank
from (
select *, DENSE_RANK() OVER(PARTITION by database_id ORDER BY avg_fragmentation_in_percent DESC) as rnk
from sys.dm_db_index_physical_stats(DB_ID(), default, default, default,'+ '''' + 'limited' + '''' +')
where avg_fragmentation_in_percent >0 AND 
INDEX_ID > 0 AND 
Page_Count > 500 
) as i
join sys.indexes o on o.object_id = i.object_id and o.index_id = i.index_id
where i.rnk <= 25
order by i.database_id, i.rnk;'

INSERT [DBAPerfData].[dbo].[IndexFragInfo] EXEC sp_MSForEachDB @command 

SELECT * FROM [DBAPerfData].[dbo].[IndexFragInfo]
Where DatabaseID > 4
order by DatabaseName, [RANK];


END
GO