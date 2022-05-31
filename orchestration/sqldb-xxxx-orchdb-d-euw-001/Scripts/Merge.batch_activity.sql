-- Check if temp table already exists, if so drop it
IF OBJECT_ID('batch_activity_tmp', 'U') IS NOT NULL
    DROP TABLE batch_activity_tmp;

-- Create shallow copy of original table 
SELECT TOP 0 * INTO batch_activity_tmp FROM dbo.batch_activity;

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT batch_activity_tmp
FROM 'batch_activity.csv'
WITH (
	DATA_SOURCE = 'eds_OrchDB',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	FORMAT = 'CSV'
);

-- Empty any potentially existing data in the logging
-- from the OUTPUT clause.  
--IF OBJECT_ID('batch_activity_log', 'U') IS NOT NULL
--    TRUNCATE TABLE batch_activity_log;

-- Merge data from temp table with original table
MERGE 
	batch_activity AS tgt 
USING 
	(SELECT * FROM batch_activity_tmp) AS src
ON 
	(tgt.activity_id = src.activity_id)
WHEN MATCHED AND (
	ISNULL(src.activity_nk,'') <> ISNULL(tgt.activity_nk,'')
	OR
	ISNULL(src.activity_description,'') <> ISNULL(tgt.activity_description,'')
) THEN
	UPDATE SET 
		activity_nk = src.activity_nk
	,	activity_description = src.activity_description
WHEN NOT MATCHED BY TARGET THEN
	INSERT (activity_id, activity_nk, activity_description)
	VALUES (src.activity_id, src.activity_nk, src.activity_description)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE 
OUTPUT     
	Deleted.activity_id
,   Deleted.activity_nk
,   Deleted.activity_description
,   $action
,   Inserted.activity_id
,   Inserted.activity_nk
,   Inserted.activity_description
,	GETUTCDATE() INTO [log].batch_activity;

-- drop temp table
DROP TABLE batch_activity_tmp;