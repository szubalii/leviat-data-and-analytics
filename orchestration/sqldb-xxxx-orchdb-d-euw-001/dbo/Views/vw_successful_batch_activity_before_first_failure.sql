CREATE VIEW [dbo].[vw_successful_batch_activity_before_first_failure] AS

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

-- get the successful batch activities before the first failed batch activity
SELECT
  leba.entity_id,
  leba.activity_id,
  b.batch_id,
  b.run_id,
  b.status_id,
  leba.start_date_time,
  leba.file_name,
  b.output
FROM
  vw_latest_entity_batch_activity leba
INNER JOIN
  batch b
  ON
    b.entity_id = leba.entity_id
    AND
    b.file_name = leba.file_name
    AND
    b.activity_id = leba.activity_id
    AND
    b.start_date_time = leba.start_date_time
LEFT JOIN
  vw_first_failed_activity_order ffao
  ON
    ffao.entity_id = leba.entity_id

WHERE
  (
    leba.activity_order < ffao.activity_order
    OR
    ffao.activity_order IS NULL
  )
  -- AND
  -- @rerunSuccessfulFullEntities != 1 -- Only get the statuses if required
  --TODO test
