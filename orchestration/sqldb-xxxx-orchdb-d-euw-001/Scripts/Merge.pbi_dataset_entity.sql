-- Check if temp table already exists, if so drop it
IF OBJECT_ID('pbi_dataset_entity_tmp', 'U') IS NOT NULL
    DROP TABLE pbi_dataset_entity_tmp;

-- Create shallow copy of original table 
SELECT TOP 0 * INTO pbi_dataset_entity_tmp FROM dbo.pbi_dataset_entity;

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT pbi_dataset_entity_tmp
FROM 'pbi_dataset_entity.csv'
WITH (
    DATA_SOURCE = 'AzureBlobStorageOrchDB'
,   FIRSTROW = 2
,   FIELDTERMINATOR = ','
,   FORMAT = 'CSV'
);

-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.  
--IF OBJECT_ID('#pbi_dataset_entity_log', 'U') IS NOT NULL
--    DROP TABLE #pbi_dataset_entity_log;

-- Merge data from temp table with original table
MERGE 
    pbi_dataset_entity AS tgt 
USING 
    (SELECT * FROM pbi_dataset_entity_tmp) AS src
ON 
    (tgt.pbi_dataset_id = src.pbi_dataset_id)
    AND
    (tgt.entity_id = src.entity_id)
WHEN MATCHED AND (
	ISNULL(src.dataset_name,'') <> ISNULL(tgt.dataset_name,'')
    OR
	ISNULL(src.entity_name,'') <> ISNULL(tgt.entity_name,'')
) THEN
    UPDATE SET
        dataset_name = src.dataset_name
    ,   entity_name = src.entity_name
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        pbi_dataset_id
    ,	dataset_name
    ,   entity_id
    ,   entity_name
    )
    VALUES (
        src.pbi_dataset_id
    ,   src.dataset_name
    ,   src.entity_id
    ,   src.entity_name
    )
WHEN NOT MATCHED BY SOURCE THEN
    DELETE 
OUTPUT     
    Deleted.pbi_dataset_id
,   Deleted.dataset_name
,   Deleted.entity_id
,   Deleted.entity_name
,   $action
,   Inserted.pbi_dataset_id
,   Inserted.dataset_name
,   Inserted.entity_id
,   Inserted.entity_name
,   GETUTCDATE() INTO [log].pbi_dataset_entity;

-- drop temp tables
DROP TABLE pbi_dataset_entity_tmp;