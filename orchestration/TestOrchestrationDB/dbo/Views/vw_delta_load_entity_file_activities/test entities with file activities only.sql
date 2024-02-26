CREATE PROCEDURE [tc.dbo.vw_delta_load_entity_file_activities].[test entities with file activities only]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- EXEC tSQLt.FakeFunction 'dbo.tvf_full_load_entity_file_activities_by_date', 'fake.tvf_full_load_entity_file_activities_by_date';

  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  -- EXEC tSQLt.FakeTable '[dbo]', '[vw_delta_load_entity_file_activities]';

  INSERT INTO dbo.entity (
    entity_id, 
    layer_id,
    update_mode
  )
  VALUES
    (1, 6, 'Delta'),
    (2, 6, 'Delta');
  
  INSERT INTO dbo.batch (
    -- batch_id,
    -- run_id,
    start_date_time,
    entity_id,
    status_id,
    activity_id,
    file_name
  )
  VALUES
    ('2023-06-01', 1, 2, 21, 'DELTA_2023_06_01_12_00_00_000.parquet');

  -- Act: 
  SELECT
    entity_id
  INTO actual
  FROM dbo.vw_delta_load_entity_file_activities
  GROUP BY
    entity_id;

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    entity_id
  )
  VALUES
    (1);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO