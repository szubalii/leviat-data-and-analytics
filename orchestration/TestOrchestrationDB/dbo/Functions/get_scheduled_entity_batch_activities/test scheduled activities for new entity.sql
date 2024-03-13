CREATE PROCEDURE [tc.dbo.get_scheduled_entity_batch_activities].[test scheduled activities for new entity]
AS
BEGIN
  -- Check if the correct activities are returned for a new entities for which no batches exist.
  
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  
  INSERT INTO dbo.entity (entity_id, schedule_recurrence, layer_id, update_mode, base_sproc_name)
  VALUES
    (1, 'D', 6, 'Delta', 'up_upsert_delta_active_table'),
    (2, 'D', 6, 'Full', NULL);

  -- Act: 
  SELECT
    entity_id,
    file_name,
    required_activities,
    skipped_activities
  INTO actual
  FROM dbo.get_scheduled_entity_batch_activities(
    0, '2023-06-01', 0
  );

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;
  
  INSERT INTO expected (
    entity_id,
    file_name,
    required_activities,
    skipped_activities
  ) VALUES
    (1, NULL, '["Extract","CheckXUExtractionStatus","TestDuplicates","Load2Base","ProcessBase"]', '{}'),
    (2, NULL, '["Extract","CheckXUExtractionStatus","TestDuplicates","Load2Base"]', '{}');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END;
GO

-- select * from tvf_entity_file_activity_by_date
-- select * from vw_delta_load_entity_file_activities
-- select * from vw_entity_file
-- select * from batch
-- select * from entity

-- truncate table batch

-- truncate table batch

--   SELECT
--     entity_id,
--     file_name,
--     required_activities,
--     skipped_activities
--   -- INTO actual
--   FROM dbo.get_scheduled_entity_batch_activities(
--     0, '2023-06-01', 0
--   );

-- insert into batch_activity (activity_id,activity_nk,activity_description,activity_order,is_deprecated)
-- values
-- (1,'AXBIToBlobIn','AXBI Data is loaded from SQL Server into In blob storage folder - Data Lake',NULL,1),
-- (2,'Load2Base','Data is loaded into Synapse base layer - Dedicated SQL Pool',400,0),
-- (3,'Skipped','Skipped batch',NULL,1),
-- (4,'CheckExtraction','Checking that the data has been extraction from S4H',NULL,1),
-- (5,'S4HCheckFileName','Checking S4H files in blob storage',NULL,1),
-- (6,'BasetoEDWExecGenericSP','Load data using a generic function sp_materialize_view',NULL,1),
-- (7,'BasetoEDWExecCustomSP','Load data using a custom function',NULL,1),
-- (8,'RunXUExtraction','Start Xtract Universal Extraction via web url call',120,1),
-- (9,'StoreXUExtractionLog','Get Logs',160,0),
-- (10,'ProcessEDW','Load data into edw layer - Dedicated SQL Pool',600,0),
-- (11,'S4HBlobInToBlobOut','S4H Data is loaded from In to Out blob storage folder - Data Lake',NULL,1),
-- (12,'S4HToBlobIn','The data has been extracted to a folder IN on the Blob Storage',NULL,1),
-- (13,'CheckXUExtractionStatus','Get the status of the XU Extraction',140,0),
-- (14,'XUExtractionLogsToBlobStorage','Load XU extraction logs to blob storage',NULL,1),
-- (15,'ProcessBase','Execute any logic in the Synapse Base layer',500,0),
-- (16,'USASnowflakeToBlobIn','Snowflake USA Data is loaded from SQL Server into In blob storage folder - Data Lake',NULL,1),
-- (17,'USASnowflakeBlobInToBlobOut','Snowflake USA Data is loaded from In to Out blob storage folder - Data Lake',NULL,1),
-- (18,'USASnowflakeCheckFileName','Checking Snowflake USA files in blob storage',NULL,1),
-- (19,'TestDuplicates','Checking for duplicates in parquet files',200,0),
-- (20,'ProcessADLS','Process raw parquet files from the ADLS In folder and copy them to the ADLS Out folder',300,0),
-- (21,'Extract','Extract source data and store in the ADLS In folder',100,0),
-- (22,'ProcessDQ','Load data to the Data Quality schema',500,0),
-- (23,'UnloadSFTP','Unload report to SFTP server',700,0);

-- insert into dbo.location (location_id,location_nk,location_description)
-- values
-- (1,'SQL Server AXBI',NULL),
-- (2,'S4H',NULL),
-- (3,'Data Lake',NULL),
-- (4,'Dedicated SQL Pool',NULL),
-- (5,'PowerBI',NULL),
-- (6,'Snowflake USA',NULL),
-- (7,'SAP C4C',NULL),
-- (8,'SFTP',NULL);


-- insert into layer (layer_id,layer_nk,location_id,layer_description)
-- values
-- (1,'In',3,'Azure Data Lake Storage - In Folder'),
-- (2,'Out',3,'Azure Data Lake Storage - Out Folder'),
-- (3,'Base',4,'Dedicated SQL Pool - Base Layer'),
-- (4,'EDW',4,'Dedicated SQL Pool - EDW Layer'),
-- (5,'AXBI',1,'SQL Server AXBI'),
-- (6,'S4H',2,'S4H CAX'),
-- (7,'USA',6,'Snowflake USA'),
-- (8,'C4C',7,'SAP C4C'),
-- (10,'DQ',4,'Data Quality'),
-- (11,'ANME',3,'Azure Data Lake Storage - ancon-me folder'),
-- (12,'ANAC',3,'Azure Data Lake Storage - ancon-conolly-aus folder'),
-- (13,'ISAU',3,'Azure Data Lake Storage - isedio-aus folder'),
-- (14,'HMMY',3,'Azure Data Lake Storage - halfen-moment-my folder'),
-- (15,'HMSG',3,'Azure Data Lake Storage - halfen-moment-sg folder'),
-- (16,'HMIN',3,'Azure Data Lake Storage - halfen-moment-in folder'),
-- (17,'HMPH',3,'Azure Data Lake Storage - halfen-moment-ph folder'),
-- (18,'ANUK',3,'Azure Data Lake Storage - ancon-uk folder'),
-- (19,'ISUK',3,'Azure Data Lake Storage - isedio folder'),
-- (20,'SFTP',8,'SFTP server');

-- insert into dbo.layer_activity
-- values
-- (4,10),
-- (5,21),
-- (5,19),
-- (5,20),
-- (5,2),
-- (6,21),
-- (6,13),
-- (6,9),
-- (6,19),
-- (6,20),
-- (6,2),
-- (7,21),
-- (7,19),
-- (7,20),
-- (7,2),
-- (8,21),
-- (8,19),
-- (8,20),
-- (8,2),
-- (10,22),
-- (5,15),
-- (6,15),
-- (7,15),
-- (8,15),
-- (11,19),
-- (11,20),
-- (11,2),
-- (11,15),
-- (12,19),
-- (12,20),
-- (12,2),
-- (12,15),
-- (13,19),
-- (13,20),
-- (13,2),
-- (13,15),
-- (14,19),
-- (14,20),
-- (14,2),
-- (14,15),
-- (15,19),
-- (15,20),
-- (15,2),
-- (15,15),
-- (16,19),
-- (16,20),
-- (16,2),
-- (16,15),
-- (17,19),
-- (17,20),
-- (17,2),
-- (17,15),
-- (18,19),
-- (18,20),
-- (18,2),
-- (18,15),
-- (19,19),
-- (19,20),
-- (19,2),
-- (19,15),
-- (20,23);