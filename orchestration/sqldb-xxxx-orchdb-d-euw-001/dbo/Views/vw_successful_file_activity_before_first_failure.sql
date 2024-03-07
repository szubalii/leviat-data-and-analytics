/*
  Get the successful batch activities before the first failed batch activity
*/
CREATE VIEW [dbo].[vw_successful_file_activity_before_first_failure] AS

-- get the latest successful logged batch activities up to the first not successful activity
-- any successful activity after failed activities need to re-run in any case
-- WITH

-- first_failed_activity_order AS (
--   SELECT
--     entity_id,
--     MIN(activity_order) AS activity_order
--   FROM
--     vw_latest_entity_batch_activity
--   WHERE
--     status_id <> 2 --@BATCH_EXECUTION_STATUS_ID__SUCCESSFUL -- 'Successful'
--   GROUP BY
--     entity_id
-- )

SELECT
  lefa.entity_id,
  lefa.activity_id,
  -- b.batch_id,
  -- b.run_id,
  -- b.status_id,
  lefa.start_date_time,
  lefa.file_name--,
  -- b.output
FROM
  vw_latest_entity_file_activity lefa
-- INNER JOIN
--   batch b
--   ON
--     b.entity_id = lefa.entity_id
--     AND
--     b.file_name = lefa.file_name
--     AND
--     b.activity_id = lefa.activity_id
--     AND
--     b.start_date_time = lefa.start_date_time
LEFT JOIN
  vw_first_failed_activity_order ffao
  ON
    ffao.entity_id = lefa.entity_id
LEFT JOIN
  vw_first_failed_file fff
  ON
    fff.entity_id = lefa.entity_id

WHERE (
    -- return only those activities whose index are smaller than the first failed activity
    lefa.activity_order < ffao.activity_order
    OR
    ffao.activity_order IS NULL
  )
  AND (
    -- return only those activities whose file name are before the file name with the first
    -- non successful activity OR those activities that are not equal to ProcessBase, i.e.
    -- for all files after the file with the first non successful activity, the ProcessBase
    -- activity needs to re-run
    lefa.file_name < fff.file_name
    OR (
      lefa.file_name >= fff.file_name
      AND
      lefa.activity_id <> 15--@BATCH_ACTIVITY_ID__PROCESS_BASE-- ProcessBase
    )
    OR
    fff.file_name IS NULL -- all batch activities of all file names are successful
  )
  -- AND
  -- @rerunSuccessfulFullEntities != 1 -- Only get the statuses if required
  --TODO test
