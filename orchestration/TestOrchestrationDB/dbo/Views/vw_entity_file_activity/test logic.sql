CREATE PROCEDURE [tc.dbo.vw_entity_file_activity].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file') IS NOT NULL DROP TABLE #vw_entity_file;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[layer_activity]';
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file]';

  SELECT TOP(0) *
  INTO #vw_entity_file
  FROM dbo.vw_entity_file;

  -- #2
  INSERT INTO #vw_entity_file (
    entity_id,
    layer_id,
    file_name
  )
  VALUES
    (1, 1, 'Test1'),
    (2, 1, NULL);

  EXEC ('INSERT INTO dbo.vw_entity_file SELECT * FROM #vw_entity_file');

  INSERT INTO dbo.layer_activity (layer_id, activity_id)
  VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 4),
    (2, 5);

  -- Act: 
  SELECT entity_id, file_name, expected_activity_id
  INTO actual
  FROM vw_entity_file_activity;

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    file_name VARCHAR(20),
    expected_activity_id INT
  );

  INSERT INTO expected(entity_id, file_name, expected_activity_id)
  VALUES
    (1, 'Test1', 1),
    (1, 'Test1', 2),
    (1, 'Test1', 3),
    (2, NULL, 1),
    (2, NULL, 2),
    (2, NULL, 3);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

