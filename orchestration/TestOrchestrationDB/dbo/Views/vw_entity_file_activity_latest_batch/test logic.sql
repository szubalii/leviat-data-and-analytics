CREATE PROCEDURE [tc.dbo.vw_entity_file_activity_latest_batch].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_run') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_run;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_run]';

  SELECT TOP(0) *
  INTO #vw_entity_file_activity_latest_run
  FROM dbo.vw_entity_file_activity_latest_run;

  -- #2
  INSERT INTO #vw_entity_file_activity_latest_run (
    entity_id,
    file_name,
    expected_activity_id,
    run_activity_id,
    latest_start_date_time
  )
  VALUES
    (1, 'Test1', 21, 21, '2023-07-20 12:00:00.000'),
    (1, 'Test1', 19, 19, '2023-07-20 13:00:00.000'),
    (1, 'Test1', 2, NULL, NULL),
    (2, NULL, 21, NULL, NULL),
    (2, NULL, 19, NULL, NULL),
    (2, NULL, 2, NULL, NULL);

  EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_run SELECT * FROM #vw_entity_file_activity_latest_run');

  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name, start_date_time, [output])
  VALUES
    (NEWID(), 0, NEWID(), 2, 21, 'Test0', '2023-07-20 12:00:00.000', '{"timestamp":"2023-07-20 12:00"}'),
    (NEWID(), 1, NEWID(), 2, 21, 'Test1', '2023-07-20 11:00:00.000', '{"timestamp":"2023-07-20 11:00"}'),
    (NEWID(), 1, NEWID(), 2, 21, 'Test1', '2023-07-20 12:00:00.000', '{"timestamp":"2023-07-20 12:00"}'), -- entity 1: EXTRACT successful
    (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 12:30:00.000', '{"timestamp":"2023-07-20 12:30"}'), -- entity 1: Test Duplicates earlier
    (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 13:00:00.000', '{"timestamp":"2023-07-20 13:00"}'); -- entity 1: Test Duplicates later

  INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
  VALUES
    (21, 'Extract', 100),
    (19, 'GetStatus', 150),
    ( 2, 'TestDuplicates', 200),
    (10, 'DUMMY', NULL);

  -- Act: 
  SELECT entity_id, file_name, expected_activity_id, activity_nk, activity_order, latest_start_date_time, status_id, [output]
  INTO actual
  FROM vw_entity_file_activity_latest_batch;

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    file_name VARCHAR(20),
    expected_activity_id INT,
    activity_nk VARCHAR(100),
    activity_order INT,
    latest_start_date_time DATETIME,
    status_id INT,
    [output] VARCHAR(100)
  );

  INSERT INTO expected(entity_id, file_name, expected_activity_id, activity_nk, activity_order, latest_start_date_time, status_id, [output])
  VALUES
    (1, 'Test1', 21, 'Extract',   100, '2023-07-20 12:00:00.000', 2, '{"timestamp":"2023-07-20 12:00"}'),
    (1, 'Test1', 19, 'GetStatus', 150, '2023-07-20 13:00:00.000', 2, '{"timestamp":"2023-07-20 13:00"}'),
    (1, 'Test1', 2, 'TestDuplicates', 200, NULL, NULL, NULL),
    (2, NULL, 21, 'Extract',   100, NULL, NULL, NULL),
    (2, NULL, 19, 'GetStatus', 150, NULL, NULL, NULL),
    (2, NULL,  2, 'TestDuplicates', 200, NULL, NULL, NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

