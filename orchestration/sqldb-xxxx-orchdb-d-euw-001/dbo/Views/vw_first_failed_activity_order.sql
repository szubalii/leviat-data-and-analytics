CREATE VIEW [dbo].[vw_first_failed_activity_order] AS

WITH
latest_activity_order AS (
  SELECT
    lba.entity_id,
    lba.activity_id,
    lba.activity_order,
    lba.start_date_time,
    lba.file_name,
    b.status_id
  FROM
    vw_latest_entity_batch_activity lba
  INNER JOIN
    dbo.batch b
    ON
      b.entity_id = lba.entity_id
      AND
      b.file_name = lba.file_name
      AND
      b.activity_id = lba.activity_id
      AND
      b.start_date_time = lba.start_date_time
)

SELECT
  entity_id,
  MIN(activity_order) AS activity_order
FROM
  latest_activity_order
WHERE
  status_id <> 2 --@BATCH_EXECUTION_STATUS_ID__SUCCESSFUL -- 'Successful'
GROUP BY
  entity_id
