CREATE PROCEDURE [tc.dbo.vw_entity_activity].[test no test-duplicates activity when no primary key fields]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';

  INSERT INTO dbo.entity (entity_id, layer_id, pk_field_names)
  VALUES
    (1, 6, NULL),
    (2, 6, 'pk_field');

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
    (2,19),
    (2,2);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO
