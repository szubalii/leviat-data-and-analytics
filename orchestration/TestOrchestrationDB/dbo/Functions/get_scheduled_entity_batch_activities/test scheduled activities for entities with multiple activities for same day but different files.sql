CREATE PROCEDURE [tc.dbo.get_scheduled_entity_batch_activities].[test scheduled activities for entities with multiple activities for same day but different files]
AS
BEGIN
  -- Check if the correct activities are returned for a new entities for which batches exist.
  
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  
  INSERT INTO dbo.entity (entity_id, schedule_recurrence, level_id, layer_id, update_mode, base_sproc_name)
  VALUES
    (1, 'D', 1, 6, 'Delta', 'up_upsert_delta_active_table'),
    (2, 'D', 1, 6, 'Full', NULL);
  
  INSERT INTO dbo.batch (
    start_date_time,
    entity_id,
    status_id,
    activity_id,
    file_name,
    output
  )
  VALUES
    ('2023-06-01', 1, 2, 21, 'DELTA_2023_06_01_12_00_00_000.parquet', '{}'),
    ('2023-06-01', 1, 4, 19, 'DELTA_2023_06_01_12_00_00_000.parquet', '{}'),
    ('2023-06-01', 2, 2, 21, 'FULL_2023_06_01_12_00_00_000.parquet', '{}'),
    ('2023-06-01', 2, 4, 19, 'FULL_2023_06_01_12_00_00_000.parquet', '{}'),
    ('2023-06-01', 2, 2, 21, 'FULL_2023_06_01_14_00_00_000.parquet', '{}'),
    ('2023-06-01', 2, 4, 19, 'FULL_2023_06_01_14_00_00_000.parquet', '{}');

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
    (1, NULL, '["Extract","CheckXUExtractionStatus","Load2Base","ProcessBase"]', '{}'),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', '["CheckXUExtractionStatus","Load2Base","ProcessBase"]', '{"Extract": {"batch_id":"", "output":{}}}'),
    (2, 'FULL_2023_06_01_14_00_00_000.parquet',  '["CheckXUExtractionStatus","Load2Base"]', '{"Extract": {"batch_id":"", "output":{}}}');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END;
GO