CREATE VIEW [dbo].[vw_successful_delta_file_activity_before_failure] AS

WITH
-- Get the index of the first non successful logged activity for each entity and file_name
-- Filter out potential Extract activities with status InProgress
first_non_successful_delta_file_activity AS (
  SELECT
    leba.entity_id,
    leba.file_name,
    MIN(leba.activity_order) AS activity_order
  FROM
    vw_latest_entity_batch_activity leba
  INNER JOIN
    vw_full_load_entities f
  ON
    f.entity_id = leba.entity_id
  WHERE
    leba.status_id <> 2 --@BATCH_EXECUTION_STATUS_ID__SUCCESSFUL
    AND
    leba.activity_id <> 21 --@BATCH_ACTIVITY_ID__EXTRACT
  GROUP BY
    leba.entity_id,
    leba.file_name
)

-- Check what the first file name is for which there is a non Successful logged activity. 
, first_non_successful_delta_file AS (
  SELECT
    entity_id,
    MIN(file_name) AS file_name
  FROM
    first_non_successful_delta_file_activity
  GROUP BY
    entity_id
)

SELECT
  leba.entity_id,
  -- leba.adls_directory_path_In,
  -- leba.adls_directory_path_Out,
  -- leba.directory_path,
  leba.file_name,
  leba.activity_id,
  leba.run_id,
  leba.batch_id,
  leba.start_date_time,
  leba.status_id,
  leba.output
FROM
  vw_latest_entity_batch_activity leba
LEFT JOIN
  first_non_successful_delta_file_activity fffn
  ON
    fffn.entity_id = leba.entity_id
    AND
    fffn.file_name = leba.file_name
LEFT JOIN
  first_non_successful_delta_file fnsdfn
  ON
    fnsdfn.entity_id = leba.entity_id
WHERE
  (    -- return only those activities whose index are smaller than the first failed activity
    leba.activity_order < fffn.activity_order
    OR
    fffn.activity_order IS NULL -- all batch activities for this file name are successful
  )
  AND
  (
  -- return only those activities whose file name are before the file name with the first
  -- non successful activity OR those activities that are not equal to Load2Base, i.e.
  -- for all file names after the one with the first non successful activity, the Load2Base
  -- activity needs to re-run
    leba.file_name < fnsdfn.file_name
    OR (
      leba.file_name >= fnsdfn.file_name
      AND
      leba.activity_id <> 2 --@BATCH_ACTIVITY_ID__LOAD2BASE-- Load2Base
    )
    OR
    fnsdfn.file_name IS NULL -- all batch activities of all file names are successful
  )
