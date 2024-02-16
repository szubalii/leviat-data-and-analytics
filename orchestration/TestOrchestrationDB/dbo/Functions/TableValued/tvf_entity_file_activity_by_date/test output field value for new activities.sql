CREATE PROCEDURE [tc.dbo.tvf_entity_file_activity_by_date].[test output field value for new activities]
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
    (2, 6, 'Full');
  
  INSERT INTO dbo.batch (
    start_date_time,
    entity_id,
    status_id,
    activity_id,
    file_name,
    output
  )
  VALUES
    ('2023-06-01', 1, 2, 21, 'DELTA_2023_06_01_12_00_00_000.parquet', 'test_output'),
    ('2023-06-01', 2, 2, 21, 'FULL_2023_06_01_12_00_00_000.parquet', 'test_output');

  -- Act: 
  SELECT
    entity_id,
    file_name,
    activity_nk,
    output
  INTO actual
  FROM dbo.tvf_entity_file_activity_by_date('2023-06-01', 0);

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    entity_id,
    file_name,
    activity_nk,
    output
  )
  VALUES

    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'CheckXUExtractionStatus', '{}'),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'Extract', 'test_output'),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'Load2Base', '{}'),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'ProcessADLS', '{}'),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'ProcessBase', '{}'),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'StoreXUExtractionLog', '{}'),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'TestDuplicates', '{}'),
    (2, 'FULL_2023_06_01_12_00_00_000.parquet', 'CheckXUExtractionStatus', '{}'),
    (2, 'FULL_2023_06_01_12_00_00_000.parquet', 'Extract', 'test_output'),
    (2, 'FULL_2023_06_01_12_00_00_000.parquet', 'Load2Base', '{}'),
    (2, 'FULL_2023_06_01_12_00_00_000.parquet', 'ProcessADLS', '{}'),
    (2, 'FULL_2023_06_01_12_00_00_000.parquet', 'ProcessBase', '{}'),
    (2, 'FULL_2023_06_01_12_00_00_000.parquet', 'StoreXUExtractionLog', '{}'),
    (2, 'FULL_2023_06_01_12_00_00_000.parquet', 'TestDuplicates', '{}');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

-- SELECT
--     entity_id,
--     file_name
--   FROM
--     [vw_entity_file_activity_latest_batch]
--   WHERE
--     -- activity_id <> 21
--     -- AND
--     status_id <> 2
--   GROUP BY
--     entity_id,
--     file_name


-- select * from vw_delta_load_entity_file_activities
-- select * from [vw_entity_first_failed_file]
-- select * from vw_entity_file_first_failed_activity

-- SELECT
--   entity_id,
--   file_name,
--   MIN(activity_order) AS first_failed_activity_order
-- FROM
--   dbo.[vw_entity_file_activity_latest_batch]
-- WHERE
--   (
--       run_activity_id <> 21
--       AND (
--         status_id <> 2 OR status_id IS NULL
--       )
--     )
-- GROUP BY
--   entity_id,
--   file_name

-- select * from vw_entity_file_activity_latest_batch
-- select * from vw_entity_file_activity_latest_run
-- select * from vw_entity_file_activity
-- select * from vw_entity_file
-- select * from batch
