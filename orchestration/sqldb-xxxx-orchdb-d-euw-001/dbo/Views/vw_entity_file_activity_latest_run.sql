/*
  Returns the latest ran activity for each 
  entity file activity combination
*/
CREATE VIEW [dbo].[vw_entity_file_activity_latest_run]
AS
SELECT
  efa.entity_id,
  efa.layer_id,
  efa.file_name,
  efa.expected_activity_id,
  b.activity_id AS run_activity_id,
  MAX(b.start_date_time) AS latest_start_date_time
FROM
  [dbo].[vw_entity_file_activity] efa
LEFT JOIN
  [dbo].batch b
  ON
    b.entity_id = efa.entity_id
    AND
    b.file_name = efa.file_name
    AND
    b.activity_id = efa.expected_activity_id
GROUP BY
  efa.entity_id,
  efa.layer_id,
  efa.file_name,
  efa.expected_activity_id,
  b.activity_id
