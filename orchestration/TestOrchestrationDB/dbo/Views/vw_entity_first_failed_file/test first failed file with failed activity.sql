CREATE PROCEDURE [tc.dbo.vw_entity_first_failed_file].[test first failed file with failed activity]
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
    (1, 'D', 6, 'Delta'),
    (2, 'D', 6, 'Full');
  
  INSERT INTO dbo.batch (
    start_date_time,
    entity_id,
    status_id,
    activity_id,
    file_name
  )
  VALUES
    ('2023-06-01', 1, 2, 21, 'SuccessfulFile'),
    ('2023-06-01', 1, 2, 13, 'SuccessfulFile'),
    ('2023-06-01', 1, 2, 9,  'SuccessfulFile'),
    ('2023-06-01', 1, 2, 19, 'SuccessfulFile'),
    ('2023-06-01', 1, 2, 20, 'SuccessfulFile'),
    ('2023-06-01', 1, 2, 2,  'SuccessfulFile'),
    ('2023-06-02', 1, 2, 21, 'FailedFile'),
    ('2023-06-02', 1, 2, 13, 'FailedFile'),
    ('2023-06-02', 1, 2, 9,  'FailedFile'),
    ('2023-06-02', 1, 2, 19, 'FailedFile'),
    ('2023-06-02', 1, 2, 20, 'FailedFile'),
    ('2023-06-02', 1, 4, 2,  'FailedFile'); -- Failed activity

  -- EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_batch]';

  -- SELECT TOP(0) *
  -- INTO #vw_entity_file_activity_latest_batch
  -- FROM dbo.vw_entity_file_activity_latest_batch;

  -- -- #2
  -- INSERT INTO #vw_entity_file_activity_latest_batch (
  --   entity_id,
  --   file_name,
  --   run_activity_id,
  --   status_id
  -- )
  -- VALUES
  --   (1, 'Test1', 21, 2),
  --   (1, 'Test2', 19, 4);

  -- EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_batch SELECT * FROM #vw_entity_file_activity_latest_batch');

  -- Act: 
  SELECT entity_id, first_failed_file_name
  INTO actual
  FROM vw_entity_first_failed_file;

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    first_failed_file_name VARCHAR(20)
  );

  INSERT INTO expected(entity_id, first_failed_file_name)
  VALUES
    (1, 'FailedFile'),
    (2, NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

