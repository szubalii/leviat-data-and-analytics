CREATE PROCEDURE [tc.dbo.tvf_entity_file_activity_by_date].[test delta union]
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
    update_mode,
    base_sproc_name
  )
  VALUES
    (1, 6, 'Delta', 'up_upsert_delta_active_table'),
    (2, 6, 'Delta', 'up_upsert_delta_active_table');
  
  INSERT INTO dbo.batch (
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
    entity_id,
    file_name,
    activity_nk
  INTO actual
  FROM dbo.tvf_entity_file_activity_by_date('2023-06-01', 0);

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    entity_id,
    file_name,
    activity_nk
  )
  VALUES

    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'CheckXUExtractionStatus'),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'Extract'),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'Load2Base'),
    (1, 'DELTA_2023_06_01_12_00_00_000.parquet', 'ProcessBase'),
    (1, NULL, 'CheckXUExtractionStatus'),
    (1, NULL, 'Extract'),
    (1, NULL, 'Load2Base'),
    (1, NULL, 'ProcessBase'),
    (2, NULL, 'CheckXUExtractionStatus'),
    (2, NULL, 'Extract'),
    (2, NULL, 'Load2Base'),
    (2, NULL, 'ProcessBase');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

-- SELECT
--   entity_id,
--   file_name,
--   activity_nk
-- -- INTO actual
-- FROM dbo.tvf_entity_file_activity_by_date('2023-06-01', 0);

-- SELECT
--       [delta].entity_id,
--       [delta].layer_id,
--       [delta].file_name,
--       [delta].trigger_date,
--       [delta].activity_nk,
--       [delta].activity_order,
--       [delta].batch_id,
--       [delta].status_id,
--       [delta].output,
--       [delta].isRequired
--     FROM
--       dbo.[vw_delta_load_entity_file_activities] [delta]

-- select * from entity
-- truncate table entity

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
