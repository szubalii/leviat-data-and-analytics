CREATE PROCEDURE [tc.dbo.tvf_entity_file_activity_isRequired].[test output field value]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_batch') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_batch;
  IF OBJECT_ID('tempdb..#vw_entity_file_first_failed_activity') IS NOT NULL DROP TABLE #vw_entity_file_first_failed_activity;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_batch]';
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_first_failed_activity]';

  --vw_entity_file_activity_latest_batch
  SELECT TOP(0) *
  INTO #vw_entity_file_activity_latest_batch
  FROM dbo.vw_entity_file_activity_latest_batch;

  -- #2
  INSERT INTO #vw_entity_file_activity_latest_batch (
    [output]
    ,[entity_id]
    ,[file_name]
  )
  VALUES
    (NULL, 1, 'tst'), -- no output
    ('{}', 1, 'tst'), -- empty output
    ('{test}', 1, 'tst') -- non empty output;

  EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_batch SELECT * FROM #vw_entity_file_activity_latest_batch');

  --vw_entity_file_first_failed_activity
  SELECT TOP(0) *
  INTO #vw_entity_file_first_failed_activity
  FROM dbo.vw_entity_file_first_failed_activity;

  -- #2
  INSERT INTO #vw_entity_file_first_failed_activity (
    [entity_id]
    ,[file_name]
  )
  VALUES
    (1, 'tst');

  EXEC ('INSERT INTO dbo.vw_entity_file_first_failed_activity SELECT * FROM #vw_entity_file_first_failed_activity');

  --Act
  SELECT [output]
  INTO actual
  FROM dbo.tvf_entity_file_activity_isRequired(0);

  -- Assert:
  CREATE TABLE expected (
    [output] VARCHAR(10)
  );

  INSERT INTO expected([output])
  VALUES
    ('{}'),
    ('{}'),
    ('{test}');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

