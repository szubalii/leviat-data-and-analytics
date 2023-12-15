CREATE PROCEDURE [tc.dbo.vw_entity_first_failed_file].[test logic]
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
    status_id
  )
  VALUES
    (1, 'Test1', 21, 2),
    (1, 'Test2', 19, 4);

  EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_batch SELECT * FROM #vw_entity_file_activity_latest_batch');

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
    (1, 'Test2');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

