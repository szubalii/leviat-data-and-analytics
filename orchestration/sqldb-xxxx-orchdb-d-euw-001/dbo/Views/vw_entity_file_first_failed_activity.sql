/*
  Returns the first failed activity for each entity file combination
*/

CREATE VIEW [dbo].[vw_entity_file_first_failed_activity]
AS
-- WITH firstFailedActivityOrder AS (
  SELECT
    entity_id,
    file_name,
    MIN(activity_order) AS first_failed_activity_order
  FROM
    dbo.[vw_entity_file_activity_latest_batch]
  WHERE (
      -- The Extract activity can be skipped if it's already in progress
      -- For other activities they will re-run if still in progress.
      run_activity_id = 21
      AND (
        status_id NOT IN (1, 2) OR status_id IS NULL
      )
    )
    OR (
      run_activity_id <> 21
      AND (
        status_id <> 2 OR status_id IS NULL
      )
    )
  GROUP BY
    entity_id,
    file_name
-- )

