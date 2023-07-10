CREATE VIEW [dbo].[vw_successful_batch_activity_before_first_failure] AS

-- get the latest successful logged batch activities up to the first not successful activity
-- any successful activity after failed activities need to re-run in any case
WITH first_failed_activity_order AS (
  SELECT
    entity_id,
    MIN(activity_order) AS activity_order
  FROM
    vw_latest_entity_batch_activity
  WHERE
    status_id <> 2 --@BATCH_EXECUTION_STATUS_ID__SUCCESSFUL -- 'Successful'
  GROUP BY
    entity_id
)

-- get the successful batch activities before the first failed batch activity
SELECT
  leba.entity_id,
  leba.activity_id,
  leba.run_id,
  leba.batch_id,
  leba.start_date_time,
  leba.status_id,
  leba.file_name,
  leba.output
FROM
  vw_latest_entity_batch_activity leba
INNER JOIN
  vw_full_load_entities f
  ON
    f.entity_id = leba.entity_id
LEFT JOIN
  first_failed_activity_order ffao
  ON
    ffao.entity_id = leba.entity_id

WHERE
  (
    leba.activity_order < ffao.activity_order
    OR
    ffao.activity_order IS NULL
  )
