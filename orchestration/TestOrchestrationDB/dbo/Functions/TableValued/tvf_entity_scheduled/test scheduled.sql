CREATE PROCEDURE [tc.dbo.tvf_entity_scheduled].[test scheduled]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer_activity]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';

  INSERT INTO dbo.entity (
    entity_id,
    entity_name,
    layer_id,
    data_category,
    tool_name,
    extraction_type,
    update_mode
  )
  VALUES
    (1, 's4h', 6, 'DIMENSION', 'Theobald', 'Table', 'Full'),
    (2, 'axbi', 5, NULL, NULL, NULL, 'Delta');

  INSERT INTO dbo.layer_activity (layer_id, activity_id)
  VALUES
    (6, 1),
    (6, 2),
    (5, 1),
    (5, 2);

  INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
  VALUES
    (1, 'Load2Base', 400),
    (2, 'ProcessBase', 500);

  -- Act: 
  SELECT 
    entity_id,
    layer_id,
    activity_id,
    activity_nk,
    activity_order
  INTO actual
  FROM dbo.tvf_entity_scheduled;

  -- Assert:
  SELECT
    entity_id,
    layer_id,
    activity_id,
    activity_nk,
    activity_order
  INTO expected
  FROM actual
  WHERE 1=0;

  INSERT INTO expected(
    entity_id,
    layer_id,
    activity_id,
    activity_nk,
    activity_order
  )
  VALUES
    (1, 6, 1, 'Load2Base', 400),
    (1, 6, 2, 'ProcessBase', 500),
    (2, 5, 1, 'Load2Base', 400),
    (2, 5, 2, 'ProcessBase', 500),;

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO
