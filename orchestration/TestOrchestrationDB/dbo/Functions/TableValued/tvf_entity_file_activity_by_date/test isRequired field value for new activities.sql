CREATE PROCEDURE [tc.dbo.tvf_entity_file_activity_by_date].[test isRequired field value for new activities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- EXEC tSQLt.FakeFunction 'dbo.tvf_full_load_entity_file_activities_by_date', 'fake.tvf_full_load_entity_file_activities_by_date';

  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  -- EXEC tSQLt.FakeTable '[dbo]', '[vw_delta_load_entity_file_activities]';

  INSERT INTO dbo.entity (
    entity_id, 
    level_id,
    layer_id,
    update_mode,
    base_sproc_name
  )
  VALUES
    (1, 1, 6, 'Delta', 'up_upsert_delta_active_table'),
    (2, 1, 6, 'Full', NULL),
    (3, 1, 6, 'Full', NULL);
  
  INSERT INTO dbo.batch (
    start_date_time,
    entity_id,
    status_id,
    activity_id,
    file_name
  )
  VALUES
    ('2023-06-01', 1, 2, 21, 'DELTA_2023_06_01_12_00_00_000.parquet'),
    ('2023-06-01', 2, 2, 21, 'FULL_2023_06_01_12_00_00_000.parquet');

  -- Act: 
  SELECT
    entity_id,
    file_name,
    activity_nk,
    isRequired
  INTO actual
  FROM dbo.tvf_entity_file_activity_by_date('2023-06-01', 0);

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    entity_id,
    file_name,
    activity_nk,
    isRequired
  )
  VALUES
    (1, NULL, 'CheckXUExtractionStatus', 1),	
	  (1, NULL, 'Extract', 1),	
	  (1, NULL, 'Load2Base', 1),	
	  (1, NULL, 'ProcessBase', 1),	
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'CheckXUExtractionStatus', 1),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'Extract', 0),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'Load2Base', 1),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'ProcessBase', 1),
    (2, 'FULL_2023_06_01_12_00_00_000.parquet', 'CheckXUExtractionStatus', 1),
    (2, 'FULL_2023_06_01_12_00_00_000.parquet', 'Extract', 0),
    (2, 'FULL_2023_06_01_12_00_00_000.parquet', 'Load2Base', 1),
    (3, NULL, 'CheckXUExtractionStatus', 1),	
	  (3, NULL, 'Extract', 1),	
	  (3, NULL, 'Load2Base', 1);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO