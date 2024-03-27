CREATE PROCEDURE [tc.dbo.vw_entity_activity].[test process base activity]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';

  INSERT INTO dbo.entity (entity_id, layer_id, base_sproc_name)
  VALUES
    (1, 6, NULL),
    (2, 6, 'up_upsert_delta_active_table');

  -- Act: 
  SELECT entity_id, expected_activity_id
  INTO actual
  FROM vw_entity_activity;

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(entity_id, expected_activity_id)
  VALUES
    (1,21),
    (1,13),
    (1,2),
    (2,21),
    (2,13),
    (2,2),
    (2,15);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO
