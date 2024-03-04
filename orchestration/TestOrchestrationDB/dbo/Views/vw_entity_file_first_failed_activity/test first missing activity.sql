CREATE PROCEDURE [tc.dbo.vw_entity_file_first_failed_activity].[test first missing activity]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  -- IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_batch') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_batch;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  
  INSERT INTO dbo.entity (entity_id, schedule_recurrence, layer_id, update_mode)
  VALUES
    (1, 'D', 6, 'Full'),
    (2, 'D', 6, 'Delta');
  
  INSERT INTO dbo.batch (
    entity_id,
    status_id,
    activity_id,
    start_date_time,
    file_name
  )
  VALUES
    (1, 2, 21, '2023-06-01 12:00:00.000', 'SuccessfulFile_2023_06_01_12_00_00_000.parquet'),
    (1, 2, 13, '2023-06-01 12:00:00.000', 'SuccessfulFile_2023_06_01_12_00_00_000.parquet'),
    (1, 2, 19, '2023-06-01 12:00:00.000', 'SuccessfulFile_2023_06_01_12_00_00_000.parquet'),
    (1, 2, 20, '2023-06-01 12:00:00.000', 'SuccessfulFile_2023_06_01_12_00_00_000.parquet'),
    (1, 2, 2,  '2023-06-01 12:00:00.000', 'SuccessfulFile_2023_06_01_12_00_00_000.parquet'),
    (1, 2, 15, '2023-06-01 12:00:00.000', 'SuccessfulFile_2023_06_01_12_00_00_000.parquet'),
    (1, 2, 21, '2023-06-02 12:00:00.000', 'MissingActivity_2023_06_02_12_00_00_000.parquet'),
    (1, 2, 13, '2023-06-02 12:00:00.000', 'MissingActivity_2023_06_02_12_00_00_000.parquet'); -- Missing activities

  -- Act: 
  SELECT entity_id, file_name, first_failed_activity_order
  INTO actual
  FROM vw_entity_file_first_failed_activity;

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual

  INSERT INTO expected(entity_id, file_name, first_failed_activity_order)
  VALUES
    (1, 'MissingActivity_2023_06_02_12_00_00_000.parquet', 200),
    (2, NULL, 100);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

