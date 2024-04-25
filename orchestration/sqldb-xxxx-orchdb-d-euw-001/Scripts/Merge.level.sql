-- Check if temp table already exists, if so drop it
IF OBJECT_ID('level_tmp', 'U') IS NOT NULL
    DROP TABLE level_tmp;
GO

-- Create shallow copy of original table 
SELECT TOP 0 * INTO level_tmp FROM dbo.level;
GO

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT level_tmp
FROM 'level.csv'
WITH (
    DATA_SOURCE = 'eds_OrchDB'
,   FIRSTROW = 2
,   FIELDTERMINATOR = ','
,   FORMAT = 'CSV'
);
GO

-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.  
--IF OBJECT_ID('level_log', 'U') IS NOT NULL
--    TRUNCATE TABLE level_log;

-- Merge data from temp table with original table
MERGE 
	level AS tgt 
USING 
	(SELECT * FROM level_tmp) AS src
ON 
	(tgt.level_id = src.level_id)
WHEN MATCHED AND (
	ISNULL(src.level_nk,'') <> ISNULL(tgt.level_nk,'')
) THEN
	UPDATE SET 
		level_nk = src.level_nk
WHEN NOT MATCHED BY TARGET THEN
	INSERT (level_id, level_nk)
	VALUES (src.level_id, src.level_nk)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE 
OUTPUT     
	Deleted.level_id
,   Deleted.level_nk
,   $action
,   Inserted.level_id
,   Inserted.level_nk
,	GETUTCDATE() INTO [log].level;
GO

-- drop temp tables
DROP TABLE level_tmp;
GO