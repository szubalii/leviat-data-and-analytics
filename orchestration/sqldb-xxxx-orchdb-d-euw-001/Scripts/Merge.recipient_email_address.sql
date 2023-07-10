-- Check if temp table already exists, if so drop it
IF OBJECT_ID('recipient_email_address_tmp', 'U') IS NOT NULL
    DROP TABLE recipient_email_address_tmp;
GO

-- Create shallow copy of original table 
SELECT TOP 0 * INTO recipient_email_address_tmp FROM dbo.recipient_email_address;
GO

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT recipient_email_address_tmp
FROM 'recipient_email_address.csv'
WITH (
    DATA_SOURCE = 'eds_OrchDB'
,   FIRSTROW = 2
,   FIELDTERMINATOR = ','
,   FORMAT = 'CSV'
);
GO

-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.  
--IF OBJECT_ID('#recipient_email_address_log', 'U') IS NOT NULL
--    DROP TABLE #recipient_email_address_log;

-- Merge data from temp table with original table
MERGE 
	recipient_email_address AS tgt 
USING 
	(SELECT * FROM recipient_email_address_tmp) AS src
ON 
	(tgt.id = src.id)
WHEN MATCHED AND (
	ISNULL(src.email_address,'') <> ISNULL(tgt.email_address,'')
) THEN
	UPDATE SET 
		email_address = src.email_address
WHEN NOT MATCHED BY TARGET THEN
	INSERT (id, email_address)
	VALUES (src.id, src.email_address)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE 
OUTPUT     
	Deleted.id
,   Deleted.email_address
,   $action
,   Inserted.id
,   Inserted.email_address
,	GETUTCDATE() INTO [log].recipient_email_address;
GO

-- drop temp tables
DROP TABLE recipient_email_address_tmp;
GO
