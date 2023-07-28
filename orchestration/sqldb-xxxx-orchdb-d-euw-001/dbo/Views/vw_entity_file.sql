/*
  Returns successfully or in progress extracted file names for each entity
*/

CREATE VIEW [dbo].[vw_entity_file]
AS

SELECT
  e.entity_id,
  e.layer_id,
  b.file_name
FROM
  [entity] e
LEFT JOIN
  [batch] b
  ON
    b.entity_id = e.entity_id
    -- Select only entity files that have a successful or in progress extraction activity
    AND
    b.activity_id = 21
    AND
    b.status_id IN (1, 2)
GROUP BY
  e.entity_id,
  e.layer_id,
  b.file_name
