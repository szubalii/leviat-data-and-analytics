-- Write your own SQL object definition here, and it'll be included in your package.
EXEC tSQLt.NewTestClass 'EntityFile';
GO

CREATE PROCEDURE [EntityFile].[test filtered for EXTRACT activity only]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';

  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (1, 6);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 1, NEWID(), 1, 21, 'EXTRACT'); -- S4H EXTRACT in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 1, NEWID(), 1, 1, 'NON-EXTRACT'); -- S4H NON-EXTRACT in progress

  -- Act: 
  SELECT entity_id, file_name
  INTO actual
  FROM vw_non_failed_extracted_entity_file
  WHERE file_name <> 'EXTRACT';

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

CREATE PROCEDURE [EntityFile].[test filtered for S4H successful or in-progress, or non-S4H successful]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';


  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (1, 5);
  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (2, 6);
  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (3, 7);
  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (4, 8);
  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (5, 0);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (5, 'AXBI', 1);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (7, 'USA', 1);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (8, 'C4C', 1);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (0, 'OTHER', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'DUMMY');
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 1, NEWID(), 1, 21, 'in progress'); -- AXBI in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 21, 'successful'); -- AXBI successful
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 2, NEWID(), 1, 21, 'in progress'); -- S4H in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 2, NEWID(), 2, 21, 'successful'); -- S4H successful
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 2, NEWID(), 4, 21, 'failed'); -- S4H failed
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 3, NEWID(), 1, 21, 'in progress'); -- USA in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 3, NEWID(), 2, 21, 'successful'); -- USA successful
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 4, NEWID(), 1, 21, 'in progress'); -- C4C in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 4, NEWID(), 2, 21, 'successful'); -- C4C successful
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 5, NEWID(), 1, 21, 'in progress'); -- OTHER in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 5, NEWID(), 2, 21, 'successful'); -- OTHER successful

  -- Act: 
  SELECT entity_id, file_name
  INTO actual
  FROM vw_non_failed_extracted_entity_file

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    file_name VARCHAR(20)
  );

  INSERT INTO expected(entity_id, file_name) SELECT 1, 'successful';
  INSERT INTO expected(entity_id, file_name) SELECT 2, 'in progress';
  INSERT INTO expected(entity_id, file_name) SELECT 2, 'successful';
  INSERT INTO expected(entity_id, file_name) SELECT 3, 'successful';
  INSERT INTO expected(entity_id, file_name) SELECT 4, 'successful';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO




