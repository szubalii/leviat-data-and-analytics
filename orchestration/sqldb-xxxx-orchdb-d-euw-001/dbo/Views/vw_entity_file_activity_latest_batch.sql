/*
  Returns the batch info corresponding to the latest ran activity
  for each combination of entity file activity.
  Additionally, the natural key and order of the activity is returned
*/
CREATE VIEW [dbo].[vw_entity_file_activity_latest_batch]
AS
SELECT
  efala.entity_id,
  efala.layer_id,
  efala.file_name,
  efala.expected_activity_id,
  ba.activity_nk,
  ba.activity_order,
  b.batch_id,
  efala.run_activity_id,
  efala.latest_start_date_time,
  b.status_id,
  b.output
FROM
  [dbo].[vw_entity_file_activity_latest_run] efala
LEFT JOIN
  [dbo].batch b
  ON
    b.entity_id = efala.entity_id
    AND
    b.file_name = efala.file_name
    AND
    b.activity_id = efala.run_activity_id
    AND
    b.start_date_time = efala.latest_start_date_time
LEFT JOIN
  batch_activity ba
  ON
    ba.activity_id = efala.expected_activity_id
