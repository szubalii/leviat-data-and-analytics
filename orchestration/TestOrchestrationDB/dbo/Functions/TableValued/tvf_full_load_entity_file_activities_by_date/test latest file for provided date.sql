CREATE PROCEDURE [tc.dbo.tvf_full_load_entity_file_activities_by_date].[test latest file for provided date]
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
    (1, 6, 'Full'),
    (2, 6, 'Full');
  
  INSERT INTO dbo.batch (
    start_date_time,
    entity_id,
    status_id,
    activity_id,
    file_name
  )
  VALUES
    ('2023-06-01', 1, 2, 21, 'FULL_2023_06_01_12_00_00_000.parquet'),
    ('2023-06-01', 1, 2, 21, 'FULL_2023_06_01_14_00_00_000.parquet');

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
    (1, 'FULL_2023_06_01_14_00_00_000.parquet'),
    (2, NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

-- truncate table batch

-- WITH

--   -- for full load entities, get the most recent file for the provided date
-- full_entity_file_activity_date AS ( -- Check if for provided day activities already exist
--   SELECT
--     efalb.entity_id,
--     efalb.layer_id,
--     efalb.trigger_date,
--     MAX(efalb.file_name) AS file_name
--   FROM
--     dbo.[vw_entity_file_activity_latest_batch] efalb
--   INNER JOIN
--     dbo.[vw_full_load_entities] [full]
--     ON
--       [full].entity_id = efalb.entity_id
--   WHERE
--     efalb.trigger_date = '2023-06-01'
--   GROUP BY
--     efalb.entity_id,
--     efalb.layer_id,
--     efalb.trigger_date
-- )

-- SELECT
--   fe.entity_id,
--   fe.layer_id,
--   fe.trigger_date,
--   fe.file_name,
--   efalb.activity_nk,
--   efalb.activity_order,
--   efalb.batch_id,
--   efalb.status_id,
--   efalb.output--,
--   -- [dbo].[svf_get_isRequired_full_batch_activity](
--   --   -- efalb.batch_id,
--   --   efalb.file_name,
--   --   efalb.activity_order,
--   --   efffa.first_failed_activity_order,
--   --   @rerunSuccessfulFullEntities
--   -- ) AS isRequired

--   -- dbo.[svf_get_adls_directory_path](dir.base_dir_path, 'In', se.trigger_date) AS adls_directory_path_In,
--   -- dbo.[svf_get_adls_directory_path](dir.base_dir_path, 'Out', se.trigger_date) AS adls_directory_path_Out,
--   -- se.file_name,
--   -- se.required_activities,
--   -- se.skipped_activities
-- FROM
--   full_entity_file_activity_date fe
-- LEFT JOIN
--   dbo.vw_entity_file_activity_latest_batch efalb
--   ON
--     efalb.entity_id = fe.entity_id
--     AND
--     efalb.file_name = fe.file_name



-- SELECT
--     entity_id,
--     file_name
--   -- INTO actual
--   FROM dbo.tvf_full_load_entity_file_activities_by_date('2023-06-01', 0)
--   GROUP BY
--     entity_id,
--     file_name;