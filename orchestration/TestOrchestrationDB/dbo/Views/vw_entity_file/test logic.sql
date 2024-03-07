CREATE PROCEDURE [tc.dbo.vw_entity_file].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';

  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES
    (1, 6),
    (2, 6),
    (3, 6),
    (4, 6),
    (5, 6);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES
    (NEWID(), 1, NEWID(), 1, 21, 'EXTRACT'),     -- entity 1: EXTRACT in progress
    (NEWID(), 2, NEWID(), 1, 1,  'NON-EXTRACT'), -- entity 2: NON-EXTRACT in progress
    (NEWID(), 3, NEWID(), 4, 21, 'EXTRACT'),     -- entity 3: EXTRACT failed
    (NEWID(), 4, NEWID(), 2, 21, 'EXTRACT');     -- entity 4: EXTRACT successful

  -- Act: 
  SELECT entity_id, file_name
  INTO actual
  FROM vw_entity_file;

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    file_name VARCHAR(20)
  );

  INSERT INTO expected(entity_id, file_name)
  VALUES
    (1, 'EXTRACT'),
    (2, NULL),
    (3, NULL),
    (4, 'EXTRACT'),
    (5, NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO
