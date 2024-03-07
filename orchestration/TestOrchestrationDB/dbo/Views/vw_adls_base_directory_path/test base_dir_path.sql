CREATE PROCEDURE [tc.dbo.vw_adls_base_directory_path].[test base_dir_path]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';

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

  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES
    (6, 'S4H', 1),
    (5, 'AXBI', 2);

  INSERT INTO dbo.location (location_id, location_nk)
  VALUES
    (1, 'S4H'),
    (2, 'AXBI');

  -- Act: 
  SELECT entity_id, layer_nk, base_dir_path
  INTO actual
  FROM dbo.vw_adls_base_directory_path;

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    layer_nk VARCHAR(4),
    base_dir_path VARCHAR(120)
  );

  INSERT INTO expected(entity_id, layer_nk, base_dir_path)
  VALUES
    (1, 'S4H', 'DIMENSION/s4h/Theobald/Table/Full'),
    (2, 'AXBI', 'axbi');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO
