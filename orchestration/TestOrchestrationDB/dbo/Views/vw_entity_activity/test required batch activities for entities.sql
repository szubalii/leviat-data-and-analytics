CREATE PROCEDURE [tc.dbo.vw_entity_activity].[test required batch activities for entities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';

  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES
    (1, 6),
    (2, 5);

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
    (1,19),
    (1,2),
    (1,15),
    (2,21),
    (2,19),
    (2,2),
    (2,15);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO
