-- Check if temp table already exists, if so drop it
IF OBJECT_ID('layer_tmp', 'U') IS NOT NULL
    DROP TABLE layer_tmp;
GO

-- Create shallow copy of original table 
SELECT TOP 0 * INTO layer_tmp FROM dbo.layer;
GO

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT layer_tmp
FROM 'layer.csv'
WITH (
    DATA_SOURCE = 'eds_OrchDB'
,   FIRSTROW = 2
,   FIELDTERMINATOR = ','
,   FORMAT = 'CSV'
);
GO

-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.  
--IF OBJECT_ID('layer_log', 'U') IS NOT NULL
--    TRUNCATE TABLE layer_log;

-- Merge data from temp table with original table
MERGE 
	layer AS tgt 
USING 
	(SELECT * FROM layer_tmp) AS src
ON 
	(tgt.layer_id = src.layer_id)
WHEN MATCHED AND (
	ISNULL(src.layer_nk,'') <> ISNULL(tgt.layer_nk,'')
	OR
	ISNULL(src.layer_description,'') <> ISNULL(tgt.layer_description,'')
	OR
	ISNULL(src.location_id,0) <> ISNULL(tgt.location_id,0)
) THEN
	UPDATE SET 
		layer_nk = src.layer_nk
	,	layer_description = src.layer_description
	,	location_id = src.location_id
WHEN NOT MATCHED BY TARGET THEN
	INSERT (layer_id, layer_nk, layer_description, location_id)
	VALUES (src.layer_id, src.layer_nk, src.layer_description, src.location_id)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE 
OUTPUT     
	Deleted.layer_id
,   Deleted.layer_nk
,   Deleted.layer_description
,	Deleted.location_id
,   $action
,   Inserted.layer_id
,   Inserted.layer_nk
,   Inserted.layer_description
,	Inserted.location_id
,	GETUTCDATE() INTO [log].layer;
GO

-- drop temp tables
DROP TABLE layer_tmp;
GO