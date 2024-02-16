CREATE PROCEDURE [tc.dbo.tvf_full_load_entity_file_activities_by_date].[test date filter]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';

  INSERT INTO dbo.entity (
    entity_id, 
    layer_id,
    update_mode
  )
  VALUES
    (1, 6, 'Full');
  
  INSERT INTO dbo.batch (
    start_date_time,
    entity_id,
    status_id,
    activity_id,
    file_name
  )
  VALUES
    ('2023-05-01', 1, 2, 21, 'FULL_2023_05_01.parquet'),
    ('2023-06-01', 1, 2, 21, 'FULL_2023_06_01.parquet');

  -- Act: 
  SELECT
    entity_id,
    file_name
  INTO actual
  FROM dbo.tvf_full_load_entity_file_activities_by_date('2023-06-01', 0)
  GROUP BY
    entity_id,
    file_name;

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    entity_id,
    file_name
  )
  VALUES
    (1, 'FULL_2023_06_01.parquet');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO