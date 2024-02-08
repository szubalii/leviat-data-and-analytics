BULK INSERT dbo.batch_activity
FROM '/Master Data/batch_activity.csv'
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