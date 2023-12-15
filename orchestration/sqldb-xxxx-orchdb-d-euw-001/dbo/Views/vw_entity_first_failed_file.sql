/*
  Returns the first file that contains any failed activities
  for each entity
*/

CREATE VIEW [dbo].[vw_entity_first_failed_file]

AS

WITH entityFailedFile AS (
  SELECT
    entity_id,
    file_name
  FROM
    [vw_entity_file_activity_latest_batch]
  WHERE
    -- activity_id <> 21
    -- AND
    status_id <> 2
  GROUP BY
    entity_id,
    file_name
)

SELECT
  entity_id,
  MIN(file_name) AS first_failed_file_name
FROM
  entityFailedFile
GROUP BY
  entity_id
