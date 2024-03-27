CREATE PROCEDURE [tc.dbo.vw_entity_file_activity].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file') IS NOT NULL DROP TABLE #vw_entity_file;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';

  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES
    (1, 6),
    (2, 6);

  INSERT INTO dbo.batch (entity_id, status_id, activity_id, file_name)
  VALUES
    (1, 1, 21, 'EXTRACT');

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
    (1, 'EXTRACT', 21),
    (1, 'EXTRACT', 13),
    (1, 'EXTRACT', 2),
    (2, NULL, 21),
    (2, NULL, 13),
    (2, NULL, 2);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

