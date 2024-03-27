-- Check if temp table already exists, if so drop it
IF OBJECT_ID('location_tmp', 'U') IS NOT NULL
    DROP TABLE location_tmp;
GO

-- Create shallow copy of original table 
SELECT TOP 0 * INTO location_tmp FROM dbo.location;
GO

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT location_tmp
FROM 'location.csv'
WITH (
    DATA_SOURCE = 'eds_OrchDB'
,   FIRSTROW = 2
,   FIELDTERMINATOR = ','
,   FORMAT = 'CSV'
);
GO

-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.  
--IF OBJECT_ID('#location_log', 'U') IS NOT NULL
--    DROP TABLE #location_log;

-- Merge data from temp table with original table
MERGE 
	location AS tgt 
USING 
	(SELECT * FROM location_tmp) AS src
ON 
	(tgt.location_id = src.location_id)
WHEN MATCHED AND (
	ISNULL(src.location_nk,'') <> ISNULL(tgt.location_nk,'')
	OR
	ISNULL(src.location_description,'') <> ISNULL(tgt.location_description,'')
) THEN
	UPDATE SET 
		location_nk = src.location_nk
	,	location_description = src.location_description
WHEN NOT MATCHED BY TARGET THEN
	INSERT (location_id, location_nk, location_description)
	VALUES (src.location_id, src.location_nk, src.location_description)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE 
OUTPUT     
	Deleted.location_id
,   Deleted.location_nk
,   Deleted.location_description
,   $action
,   Inserted.location_id
,   Inserted.location_nk
,   Inserted.location_description
,	GETUTCDATE() INTO [log].location;
GO

-- drop temp tables
DROP TABLE location_tmp;
GO