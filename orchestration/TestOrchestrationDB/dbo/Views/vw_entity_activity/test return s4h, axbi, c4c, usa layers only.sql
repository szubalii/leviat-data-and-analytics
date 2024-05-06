CREATE PROCEDURE [tc.dbo.vw_entity_activity].[test return s4h, axbi, c4c, usa layers only]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';

  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES
    (1, 5),
    (2, 6),
    (3, 7),
    (4, 8),
    (5, 9);

  -- Act: 
  SELECT entity_id
  INTO actual
  FROM vw_entity_activity
  WHERE layer_id NOT IN (5, 6, 7, 8);

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO
