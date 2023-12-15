CREATE PROCEDURE [tc.dbo.vw_entity_file_activity_latest_run].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_activity') IS NOT NULL DROP TABLE #vw_entity_file_activity;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity]';

  SELECT TOP(0) *
  INTO #vw_entity_file_activity
  FROM dbo.vw_entity_file_activity;

  -- #2
  INSERT INTO #vw_entity_file_activity (
    entity_id,
    file_name,
    expected_activity_id
  )
  VALUES
    (1, 'Test1', 21),
    (1, 'Test1', 19),
    (1, 'Test1', 2),
    (2, NULL, 21),
    (2, NULL, 19),
    (2, NULL, 2);

  EXEC ('INSERT INTO dbo.vw_entity_file_activity SELECT * FROM #vw_entity_file_activity');

  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name, start_date_time)
  VALUES
    (NEWID(), 1, NEWID(), 2, 21, 'Test1', '2023-07-20 12:00'), -- entity 1: EXTRACT successful
    (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 12:30'), -- entity 1: Test Duplicates earlier
    (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 13:00'); -- entity 1: Test Duplicates later

  -- Act: 
  SELECT entity_id, file_name, expected_activity_id, latest_start_date_time
  INTO actual
  FROM vw_entity_file_activity_latest_run;

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    file_name VARCHAR(20),
    expected_activity_id INT,
    latest_start_date_time DATETIME
  );

  INSERT INTO expected(entity_id, file_name, expected_activity_id, latest_start_date_time)
  VALUES
    (1, 'Test1', 21, '2023-07-20 12:00'),
    (1, 'Test1', 19, '2023-07-20 13:00'),
    (1, 'Test1', 2, NULL),
    (2, NULL, 21, NULL),
    (2, NULL, 19, NULL),
    (2, NULL, 2, NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

