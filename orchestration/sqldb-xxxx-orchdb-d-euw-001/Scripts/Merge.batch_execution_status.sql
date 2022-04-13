-- Check if temp table already exists, if so drop it
IF OBJECT_ID('batch_execution_status_tmp', 'U') IS NOT NULL
    DROP TABLE batch_execution_status_tmp;

-- Create shallow copy of original table 
SELECT TOP 0 * INTO batch_execution_status_tmp FROM dbo.batch_execution_status;

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT batch_execution_status_tmp
FROM 'batch_execution_status.csv'
WITH (
    DATA_SOURCE = 'eds_OrchDB'
,   FIRSTROW = 2
,   FIELDTERMINATOR = ','
,   FORMAT = 'CSV'
);

-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.  
--IF OBJECT_ID('batch_execution_status_log', 'U') IS NOT NULL
--    TRUNCATE TABLE batch_execution_status_log;

-- Merge data from temp table with original table
MERGE 
	batch_execution_status AS tgt 
USING 
	(SELECT * FROM batch_execution_status_tmp) AS src
ON 
	(tgt.status_id = src.status_id)
WHEN MATCHED AND (
	ISNULL(src.status_nk,'') <> ISNULL(tgt.status_nk,'')
	OR
	ISNULL(src.status_description,'') <> ISNULL(tgt.status_description,'')
) THEN
	UPDATE SET 
		status_nk = src.status_nk
	,	status_description = src.status_description
WHEN NOT MATCHED BY TARGET THEN
	INSERT (status_id, status_nk, status_description)
	VALUES (src.status_id, src.status_nk, src.status_description)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE 
OUTPUT     
	Deleted.status_id
,   Deleted.status_nk
,   Deleted.status_description
,   $action
,   Inserted.status_id
,   Inserted.status_nk
,   Inserted.status_description 
,	GETUTCDATE() INTO [log].batch_execution_status;

-- drop temp table
DROP TABLE batch_execution_status_tmp;