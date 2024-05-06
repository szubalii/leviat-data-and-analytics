-- Check if temp table already exists, if so drop it
IF OBJECT_ID('pbi_dataset_tmp', 'U') IS NOT NULL
    DROP TABLE pbi_dataset_tmp;
GO

-- Create shallow copy of original table 
SELECT TOP 0 * INTO pbi_dataset_tmp FROM dbo.pbi_dataset;
GO

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT pbi_dataset_tmp
FROM 'pbi_dataset.csv'
WITH (
    DATA_SOURCE = 'eds_OrchDB'
,   FIRSTROW = 2
,   FIELDTERMINATOR = ','
,   FORMAT = 'CSV'
);
GO

-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.  
--IF OBJECT_ID('#pbi_dataset_log', 'U') IS NOT NULL
--    DROP TABLE #pbi_dataset_log;

-- Merge data from temp table with original table
MERGE 
    pbi_dataset AS tgt 
USING 
    (SELECT * FROM pbi_dataset_tmp) AS src
ON 
    (tgt.pbi_dataset_id = src.pbi_dataset_id)
WHEN MATCHED AND (
	ISNULL(src.workspace_guid,'') <> ISNULL(tgt.workspace_guid,'')
	OR
	ISNULL(src.workspace_name,'') <> ISNULL(tgt.workspace_name,'')
    OR
	ISNULL(src.dataset_guid,'') <> ISNULL(tgt.dataset_guid,'')
    OR
	ISNULL(src.dataset_name,'') <> ISNULL(tgt.dataset_name,'')
    OR
	ISNULL(src.schedule_recurrence,'') <> ISNULL(tgt.schedule_recurrence,'')
    OR
	ISNULL(src.schedule_day, -1) <> ISNULL(tgt.schedule_day, -1)
) THEN
    UPDATE SET
    	workspace_guid = src.workspace_guid
    ,	workspace_name = src.workspace_name
    ,	dataset_guid = src.dataset_guid
    ,	dataset_name = src.dataset_name
    ,	schedule_recurrence = src.schedule_recurrence
    ,	schedule_day = src.schedule_day
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        pbi_dataset_id
    ,	workspace_guid
    ,	workspace_name
    ,   dataset_guid
    ,   dataset_name
    ,   schedule_recurrence
    ,   schedule_day
    )
    VALUES (
        src.pbi_dataset_id
    ,	src.workspace_guid
    ,	src.workspace_name
    ,   src.dataset_guid
    ,   src.dataset_name
    ,   src.schedule_recurrence
    ,   src.schedule_day
    )
WHEN NOT MATCHED BY SOURCE THEN
    DELETE 
OUTPUT     
    Deleted.pbi_dataset_id
,   Deleted.workspace_guid
,   Deleted.workspace_name
,   Deleted.dataset_guid
,   Deleted.dataset_name
,   Deleted.schedule_recurrence
,   Deleted.schedule_day
,   $action
,   Inserted.pbi_dataset_id
,   Inserted.workspace_guid
,   Inserted.workspace_name
,   Inserted.dataset_guid
,   Inserted.dataset_name
,   Inserted.schedule_recurrence
,   Inserted.schedule_day
,   GETUTCDATE() INTO [log].pbi_dataset;
GO

-- drop temp tables
DROP TABLE pbi_dataset_tmp;
GO