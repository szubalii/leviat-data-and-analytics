CREATE PROCEDURE [tc.dbo.vw_entity_activity].[test required batch activities for entities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  -- EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  -- EXEC tSQLt.FakeTable '[dbo]', '[location]';
  -- EXEC tSQLt.FakeTable '[dbo]', '[batch]';

  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES
    (1, 6),
    (2, 5);
  -- INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  -- VALUES (6, 'S4H', 1);
  -- INSERT INTO dbo.location (location_id, location_nk)
  -- VALUES (1, 'S4H');
  -- INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  -- VALUES
  --   (NEWID(), 1, NEWID(), 1, 21, 'EXTRACT'),     -- entity 1: EXTRACT in progress
  --   (NEWID(), 2, NEWID(), 1, 1,  'NON-EXTRACT'), -- entity 2: NON-EXTRACT in progress
  --   (NEWID(), 3, NEWID(), 4, 21, 'EXTRACT'),     -- entity 3: EXTRACT failed
  --   (NEWID(), 4, NEWID(), 2, 21, 'EXTRACT');     -- entity 4: EXTRACT successful

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
    (6,21),
    (6,13),
    (6,9),
    (6,19),
    (6,20),
    (6,2),
    (5,21),
    (5,19),
    (5,20),
    (5,2);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO
