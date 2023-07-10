EXEC tSQLt.NewTestClass 'ScheduledEntities';
GO

CREATE PROCEDURE [ScheduledEntities].[test get adhoc scheduled entities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';

  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, schedule_recurrence)
  VALUES (1, 'non-adhoc', 6, 'D');
  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, schedule_recurrence)
  VALUES (2, 'adhoc', 6, 'A');
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');

  -- Act: 
  SELECT entity_id, entity_name, schedule_recurrence
  INTO actual
  FROM dbo.get_scheduled_entities(1, GETDATE());

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    entity_name VARCHAR(112),
    schedule_recurrence VARCHAR(5)
  );

  INSERT INTO expected(entity_id, entity_name, schedule_recurrence) SELECT 1, 'non-adhoc', 'D';
  INSERT INTO expected(entity_id, entity_name, schedule_recurrence) SELECT 2, 'adhoc', 'A';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [ScheduledEntities].[test get non-adhoc scheduled entities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';

  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, schedule_recurrence)
  VALUES (1, 'non-adhoc', 6, 'D');
  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, schedule_recurrence)
  VALUES (2, 'adhoc', 6, 'A');
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');

  -- Act: 
  SELECT entity_id, entity_name, schedule_recurrence
  INTO actual
  FROM dbo.get_scheduled_entities(0, GETDATE());

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    entity_name VARCHAR(112),
    schedule_recurrence VARCHAR(5)
  );

  INSERT INTO expected(entity_id, entity_name, schedule_recurrence) SELECT 1, 'non-adhoc', 'D';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO