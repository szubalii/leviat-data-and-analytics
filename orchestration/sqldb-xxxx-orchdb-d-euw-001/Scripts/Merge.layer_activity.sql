-- Truncate table
TRUNCATE TABLE [dbo].[layer_activity];
GO

-- Bulk insert data into table (does not work on actual #temp tables)
BULK INSERT layer_activity
FROM 'layer_activity.csv'
WITH (
    DATA_SOURCE = 'eds_OrchDB',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	FORMAT = 'CSV'
);
GO
