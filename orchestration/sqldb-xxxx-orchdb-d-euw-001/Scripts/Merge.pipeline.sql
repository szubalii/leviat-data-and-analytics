-- Check if temp table already exists, if so drop it
IF OBJECT_ID('pipeline_tmp', 'U') IS NOT NULL
    DROP TABLE pipeline_tmp;
GO

-- Create shallow copy of original table 
SELECT TOP 0 * INTO pipeline_tmp FROM dbo.pipeline;
GO

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT pipeline_tmp
FROM 'pipeline.csv'
WITH (
    DATA_SOURCE = 'eds_OrchDB'
,   FIRSTROW = 2
,   FIELDTERMINATOR = ','
,   FORMAT = 'CSV'
);
GO

-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.  
--IF OBJECT_ID('#pipeline_log', 'U') IS NOT NULL
--    DROP TABLE #pipeline_log;

-- Merge data from temp table with original table
MERGE 
    pipeline AS tgt 
USING 
    (SELECT * FROM pipeline_tmp) AS src
ON 
    (tgt.pipeline_id = src.pipeline_id)
WHEN MATCHED AND (
	ISNULL(src.pipeline_name_nk,'') <> ISNULL(tgt.pipeline_name_nk,'')
	OR
	ISNULL(src.pipeline_description,'') <> ISNULL(tgt.pipeline_description,'')
    OR
    ISNULL(src.parent_pipeline_id,0) <> ISNULL(tgt.parent_pipeline_id,0)
	OR
	ISNULL(src.pipeline_order,0) <> ISNULL(tgt.pipeline_order,0)
) THEN
    UPDATE SET 
        pipeline_name_nk = src.pipeline_name_nk
    ,   pipeline_description = src.pipeline_description
    ,   parent_pipeline_id = src.parent_pipeline_id
    ,   pipeline_order = src.pipeline_order
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        pipeline_id
    ,   pipeline_name_nk
    ,   pipeline_description
    ,   parent_pipeline_id
    ,   pipeline_order
    )
    VALUES (
        src.pipeline_id
    ,   src.pipeline_name_nk
    ,   src.pipeline_description
    ,   src.parent_pipeline_id
    ,   src.pipeline_order
    )
WHEN NOT MATCHED BY SOURCE THEN
    DELETE 
OUTPUT     
    Deleted.pipeline_id
,   Deleted.pipeline_name_nk
,   Deleted.pipeline_description
,   Deleted.parent_pipeline_id
,   Deleted.pipeline_order
,   $action
,   Inserted.pipeline_id
,   Inserted.pipeline_name_nk
,   Inserted.pipeline_description
,   Inserted.parent_pipeline_id
,   Inserted.pipeline_order
,   GETUTCDATE() INTO [log].pipeline;
GO

-- drop temp tables
DROP TABLE pipeline_tmp;
GO