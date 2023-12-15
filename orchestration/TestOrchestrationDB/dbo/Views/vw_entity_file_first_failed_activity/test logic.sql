CREATE PROCEDURE [tc.dbo.vw_entity_file_first_failed_activity].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_batch') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_batch;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_batch]';

  SELECT TOP(0) *
  INTO #vw_entity_file_activity_latest_batch
  FROM dbo.vw_entity_file_activity_latest_batch;

  -- #2
  INSERT INTO #vw_entity_file_activity_latest_batch (
    entity_id,
    file_name,
    run_activity_id,
    activity_order,
    status_id
  )
  VALUES
    (1, 'Test1.1', 21, 100, 2), -- entity 1: successful extraction
    (1, 'Test1.1', 19, 200, 4), -- entity 1: failed test duplicates
    (1, 'Test1.1', 10, 300, 2), -- entity 1: successful base ingestion
    (2, 'Test2.1', 21, 100, 1), -- entity 2: extraction in progress 
    (2, 'Test2.1', 19, 200, NULL), -- entity 2: no status for test duplicates
    (2, 'Test2.2', 21, 100, 2); -- entity 2 file 2: no failed activities 

  EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_batch SELECT * FROM #vw_entity_file_activity_latest_batch');

  -- Act: 
  SELECT entity_id, file_name, first_failed_activity_order
  INTO actual
  FROM vw_entity_file_first_failed_activity;

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    file_name VARCHAR(20),
    first_failed_activity_order INT
  );

  INSERT INTO expected(entity_id, file_name, first_failed_activity_order)
  VALUES
    (1, 'Test1.1', 200),
    (2, 'Test2.1', 200);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

