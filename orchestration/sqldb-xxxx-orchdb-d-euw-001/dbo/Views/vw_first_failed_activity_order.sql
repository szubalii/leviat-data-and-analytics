/*
Get the index of the first non successful logged activity for each entity and file_name
Filter out potential Extract activities with status InProgress
*/
CREATE VIEW [dbo].[vw_first_failed_activity_order] AS

-- WITH
-- latest_activity_order AS (
--   SELECT
--     lba.entity_id,
--     lba.activity_id,
--     lba.activity_order,
--     lba.start_date_time,
--     lba.file_name,
--     b.status_id
--   FROM
--     vw_latest_entity_file_activity lba
--   INNER JOIN
--     dbo.batch b
--     ON
--       b.entity_id = lba.entity_id
--       AND
--       b.file_name = lba.file_name
--       AND
--       b.activity_id = lba.activity_id
--       AND
--       b.start_date_time = lba.start_date_time
-- )

SELECT
  entity_id,
  file_name,
  MIN(activity_order) AS activity_order
FROM
  vw_latest_entity_file_activity_batch
WHERE
  status_id <> 2 --@BATCH_EXECUTION_STATUS_ID__SUCCESSFUL -- 'Successful'
  AND
  activity_id <> 21 --@BATCH_ACTIVITY_ID__EXTRACT -- Extract
GROUP BY
  entity_id,
  file_name
