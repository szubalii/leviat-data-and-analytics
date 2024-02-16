BULK INSERT dbo.batch_activity
FROM '/Master Data/batch_activity.csv'
WITH (FORMAT = 'CSV'
      , FIRSTROW = 2
      , FIELDQUOTE = '\'
      , FIELDTERMINATOR = ','
      , ROWTERMINATOR = '0x0a');
GO

BULK INSERT dbo.batch_execution_status
FROM '/Master Data/batch_execution_status.csv'
WITH (FORMAT = 'CSV'
      , FIRSTROW = 2
      , FIELDQUOTE = '\'
      , FIELDTERMINATOR = ','
      , ROWTERMINATOR = '0x0a');
GO

BULK INSERT dbo.error_category
FROM '/Master Data/error_category.csv'
WITH (FORMAT = 'CSV'
      , FIRSTROW = 2
      , FIELDQUOTE = '\'
      , FIELDTERMINATOR = ','
      , ROWTERMINATOR = '0x0a');
GO

BULK INSERT dbo.location
FROM '/Master Data/location.csv'
WITH (FORMAT = 'CSV'
      , FIRSTROW = 2
      , FIELDQUOTE = '\'
      , FIELDTERMINATOR = ','
      , ROWTERMINATOR = '0x0a');
GO

BULK INSERT dbo.layer
FROM '/Master Data/layer.csv'
WITH (FORMAT = 'CSV'
      , FIRSTROW = 2
      , FIELDQUOTE = '\'
      , FIELDTERMINATOR = ','
      , ROWTERMINATOR = '0x0a');
GO

BULK INSERT dbo.layer_activity
FROM '/Master Data/layer_activity.csv'
WITH (FORMAT = 'CSV'
      , FIRSTROW = 2
      , FIELDQUOTE = '\'
      , FIELDTERMINATOR = ','
      , ROWTERMINATOR = '0x0a');
GO


-- :r .\Merge.entity.sql
-- :r .\Merge.pbi_dataset.sql
-- :r .\Merge.pbi_dataset_entity.sql
-- :r .\Merge.pipeline.sql
-- :r .\Merge.pipeline_execution_status.sql
-- :r .\Merge.recipient_email_address.sql