CREATE VIEW [dbo].[vw_full_entity_activity_batch_ids]
AS

-- Get the latest start date of the extract activity for each full entity
WITH 
start_date_time AS (
  SELECT
    e.entity_id,
    e.layer_id,
    MAX(start_date_time) AS start_date_time
  FROM
    entity AS e
  LEFT JOIN
    batch AS b
    ON
      b.entity_id = e.entity_id
      AND
      b.activity_id = 21 -- Extract
  WHERE
    e.update_mode = 'Full'
    OR
    e.update_mode IS NULL
  GROUP BY
    e.entity_id,
    e.layer_id
)
-- Get the file name related to the start date from above
SELECT
  sdt.entity_id,
  sdt.layer_id,
  b.file_name
FROM
  start_date_time AS sdt
LEFT JOIN
  batch AS b
  ON
    b.entity_id = sdt.entity_id
    AND
    b.start_date_time = sdt.start_date_time
    AND
    b.activity_id = 21
