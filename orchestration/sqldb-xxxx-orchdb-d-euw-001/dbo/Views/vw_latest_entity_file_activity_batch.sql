CREATE VIEW [dbo].[vw_latest_entity_file_activity_batch]
AS

SELECT
  efa.entity_id,
  efa.file_name,
  efa.activity_id,
  efa.activity_nk,
  efa.activity_order,
  efa.start_date_time,
  b.batch_id,
  b.status_id,
  b.output,
  CASE
    -- The Extract activity can be skipped if it's already in progress
    -- For other activities they will re-run if still in progress.
    WHEN efa.activity_id = 21 --@BATCH_ACTIVITY_ID__EXTRACT
    THEN
      CASE
        WHEN b.status_id IN (
          1, --@BATCH_EXECUTION_STATUS_ID__IN_PROGRESS
          2  --@BATCH_EXECUTION_STATUS_ID__SUCCESSFUL
        )
        THEN 0
        ELSE 1
      END
    ELSE
      CASE
        WHEN b.status_id = 2 --@BATCH_EXECUTION_STATUS_ID__SUCCESSFUL
        THEN 0
        ELSE 1
      END
  END AS [isRequired]
FROM
  [vw_latest_entity_file_activity] efa
INNER JOIN
  dbo.batch b
  ON
    b.entity_id = efa.entity_id
    AND
    b.file_name = efa.file_name
    AND
    b.activity_id = efa.activity_id
    AND
    b.start_date_time = efa.start_date_time
