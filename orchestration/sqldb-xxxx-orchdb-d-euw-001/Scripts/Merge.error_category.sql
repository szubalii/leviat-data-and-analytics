-- Check if temp table already exists, if so drop it
IF OBJECT_ID('error_category_tmp', 'U') IS NOT NULL
    DROP TABLE error_category_tmp;
GO

-- Create shallow copy of original table 
SELECT TOP 0 * INTO error_category_tmp FROM dbo.error_category;
GO

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT error_category_tmp
FROM 'error_category.csv'
WITH (
    DATA_SOURCE = 'eds_OrchDB'
,   FIRSTROW = 2
,   FIELDTERMINATOR = ','
,   FORMAT = 'CSV'
);
GO

-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.  
--IF OBJECT_ID('error_category_log', 'U') IS NOT NULL
--    TRUNCATE TABLE error_category_log;

-- Merge data from temp table with original table
MERGE 
	error_category AS tgt 
USING 
	(SELECT * FROM error_category_tmp) AS src
ON 
	(tgt.error_category_id = src.error_category_id)
WHEN MATCHED AND (
	ISNULL(src.category_nk,'') <> ISNULL(tgt.category_nk,'')
	OR
	ISNULL(src.category_description,'') <> ISNULL(tgt.category_description,'')
) THEN
	UPDATE SET 
		category_nk = src.category_nk
	,	category_description = src.category_description
WHEN NOT MATCHED BY TARGET THEN
	INSERT (error_category_id, category_nk, category_description)
	VALUES (src.error_category_id, src.category_nk, src.category_description)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE 
OUTPUT     
	Deleted.error_category_id
,   Deleted.category_nk
,   Deleted.category_description
,   $action
,   Inserted.error_category_id
,   Inserted.category_nk
,   Inserted.category_description
,	GETUTCDATE() INTO [log].error_category;
GO

-- drop temp table
DROP TABLE error_category_tmp;
GO