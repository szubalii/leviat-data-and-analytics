CREATE PROCEDURE [tc.dbo.get_scheduled_entity_batch_activities].[test scheduled activities for entities with multiple activities for same day but different files]
AS
BEGIN
  -- Check if the correct activities are returned for a new entities for which batches exist.
  
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  
  INSERT INTO dbo.entity (entity_id, schedule_recurrence, layer_id, update_mode)
  VALUES
    (1, 'D', 6, 'Delta'),
    (2, 'D', 6, 'Full');

  DECLARE
    @batch_id_1 UNIQUEIDENTIFIER = NEWID(),
    @batch_id_2 UNIQUEIDENTIFIER = NEWID(),
    @batch_id_3 UNIQUEIDENTIFIER = NEWID(),
    @batch_id_4 UNIQUEIDENTIFIER = NEWID(),
    @batch_id_5 UNIQUEIDENTIFIER = NEWID(),
    @batch_id_6 UNIQUEIDENTIFIER = NEWID();
  
  INSERT INTO dbo.batch (
    batch_id,
    run_id,
    start_date_time,
    entity_id,
    status_id,
    activity_id,
    directory_path,
    file_name,
    output
  )
  VALUES
    (@batch_id_1, NEWID(), '2023-06-01', 1, 2, 21, 'directory_path', 'DELTA_2023_06_01_12_00_00_000.parquet', '{}'),
    (@batch_id_2, NEWID(), '2023-06-01', 1, 4, 19, 'directory_path', 'DELTA_2023_06_01_12_00_00_000.parquet', '{}'),
    (@batch_id_3, NEWID(), '2023-06-01', 2, 2, 21, 'directory_path', 'FULL_2023_06_01_12_00_00_000.parquet', '{}'),
    (@batch_id_4, NEWID(), '2023-06-01', 2, 4, 19, 'directory_path', 'FULL_2023_06_01_12_00_00_000.parquet', '{}'),
    (@batch_id_5, NEWID(), '2023-06-01', 2, 2, 21, 'directory_path', 'FULL_2023_06_01_14_00_00_000.parquet', '{}'),
    (@batch_id_6, NEWID(), '2023-06-01', 2, 4, 19, 'directory_path', 'FULL_2023_06_01_14_00_00_000.parquet', '{}');

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

  -- SELECT cast(1 AS uniqueidentifier)

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
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', '["TestDuplicates","ProcessADLS","Load2Base","ProcessBase"]', '{"Extract": {"batch_id":"'+convert(nvarchar(36),@batch_id_1)+'", "output":{}},"CheckXUExtractionStatus": {"batch_id":"", "output":{}},"StoreXUExtractionLog": {"batch_id":"", "output":{}}}'),
    (2, 'FULL_2023_06_01_14_00_00_000.parquet',  '["TestDuplicates","ProcessADLS","Load2Base","ProcessBase"]', '{"Extract": {"batch_id":"'+convert(nvarchar(36),@batch_id_5)+'", "output":{}},"CheckXUExtractionStatus": {"batch_id":"", "output":{}},"StoreXUExtractionLog": {"batch_id":"", "output":{}}}');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END;
GO