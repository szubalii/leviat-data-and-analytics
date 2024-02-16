CREATE PROCEDURE [tc.dbo.vw_entity_file_first_failed_activity].[test first failed activity]
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
    entity_id,
    status_id,
    activity_id,
    file_name
  )
  VALUES
    (1, 2, 21, 'SuccessfulFile'),
    (1, 2, 13, 'SuccessfulFile'),
    (1, 2, 9,  'SuccessfulFile'),
    (1, 2, 19, 'SuccessfulFile'),
    (1, 2, 20, 'SuccessfulFile'),
    (1, 2, 2,  'SuccessfulFile'),
    (1, 4, 21, 'FailedExtraction'), -- Failed extraction
    (1, 2, 13, 'FailedExtraction'),
    (1, 2, 9,  'FailedExtraction'),
    (1, 2, 19, 'FailedExtraction'),
    (1, 2, 20, 'FailedExtraction'),
    (1, 4, 2,  'FailedExtraction'),
    (1, 2, 21, 'FailedActivity'),
    (1, 2, 13, 'FailedActivity'),
    (1, 2, 9,  'FailedActivity'),
    (1, 2, 19, 'FailedActivity'),
    (1, 2, 20, 'FailedActivity'),
    (1, 4, 2,  'FailedActivity'); -- Failed activity

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
  SELECT entity_id, file_name, first_failed_activity_order
  INTO actual
  FROM vw_entity_file_first_failed_activity;

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual

  INSERT INTO expected(entity_id, file_name, first_failed_activity_order)
  VALUES
    (1, 'SuccessfulFile', NULL),
    (1, 'FailedExtraction', 100),
    (1, 'FailedActivity', 400);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

