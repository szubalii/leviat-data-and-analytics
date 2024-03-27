CREATE PROCEDURE [tc.dbo.tvf_entity_file_required_activities].[test adls directory path]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_activity_requirements', 'fake.tvf_entity_file_activity_requirements';

  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';

  INSERT INTO dbo.entity (
    entity_id, 
    layer_id, 
    data_category,
    entity_name,
    tool_name,
    extraction_type,
    update_mode
  )
  VALUES
    (2, 1, 'Dimension', 'I_Brand', 'Theobald', 'ODP', 'Full'),
    (3, 2, NULL, 'NonS4HEntityName', NULL, NULL, NULL);

  INSERT INTO dbo.layer (
    layer_id, layer_nk
  )
  VALUES
    (1, 'S4H'),
    (2, 'OTHER');

  -- Act: 
  SELECT
    entity_id,
    adls_directory_path_In,
    adls_directory_path_Out
  INTO actual
  FROM dbo.tvf_entity_file_required_activities('2024-01-01', 0);

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    entity_id,
    adls_directory_path_In,
    adls_directory_path_Out
  )
  VALUES
    (2, 'Dimension/I_Brand/Theobald/ODP/Full/In/2023/07/22', 'Dimension/I_Brand/Theobald/ODP/Full/Out/2023/07/22'),
    (3, 'NonS4HEntityName/In/2023/07/22', 'NonS4HEntityName/Out/2023/07/22');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

