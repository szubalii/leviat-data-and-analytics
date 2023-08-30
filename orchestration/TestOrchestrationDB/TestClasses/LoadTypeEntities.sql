-- Write your own SQL object definition here, and it'll be included in your package.
EXEC tSQLt.NewTestClass 'LoadTypeEntities';
GO

CREATE PROCEDURE [LoadTypeEntities].[test vw_full_load_entities contains full load entities only]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';

  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, update_mode)
  VALUES
    (1, 'full', 6, 'Full'),
    (2, 'delta', 6, 'Delta');
  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, update_mode)
  VALUES (3, 'null', 6, NULL);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');

  -- Act: 
  SELECT le.entity_id, entity_name
  INTO actual
  FROM vw_full_load_entities le
  INNER JOIN entity e
    ON
      e.entity_id = le.entity_id
      AND (
        e.update_mode <> 'Full'
        AND
        e.update_mode IS NOT NULL
      );

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

CREATE PROCEDURE [LoadTypeEntities].[test vw_delta_load_entities contains delta load entities only]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';

  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, update_mode)
  VALUES
    (1, 'full', 6, 'Full'),
    (2, 'delta', 6, 'Delta'),
    (3, 'null', 6, NULL);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');

  -- Act: 
  SELECT le.entity_id, entity_name
  INTO actual
  FROM vw_delta_load_entities le
  INNER JOIN entity e
    ON
      e.entity_id = le.entity_id
      AND
      e.update_mode <> 'Delta';

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO
