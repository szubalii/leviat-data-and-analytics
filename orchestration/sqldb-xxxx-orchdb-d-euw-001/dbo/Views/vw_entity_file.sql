CREATE VIEW [dbo].[vw_entity_file]
AS
-- WITH entity_file AS (
SELECT
  e.entity_id,
  e.layer_id,
  e.update_mode,
  b.file_name
FROM
  [entity] e
LEFT JOIN
  [batch] b
  ON
    b.entity_id = e.entity_id
-- Select only entity files that have a successful or in progress extraction activity
WHERE
  b.activity_id = 21
  AND
  b.status_id IN (1, 2)
GROUP BY
  e.entity_id,
  e.layer_id,
  e.update_mode,
  b.file_name
-- )

-- SELECT
--   entity_id,
--   layer_id,
--   update_mode,
--   file_name,
--   trigger_date
-- FROM
--   entity_file
  -- trigger_date
