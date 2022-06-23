CREATE VIEW [dbo].[vw_delta_entity_activity_batch_ids]
AS

-- Get all files names based on the Extract activity where status is Successful or InProgress

SELECT
  e.entity_id,
  e.layer_id,
  b.file_name
FROM
  entity AS e
LEFT JOIN
  batch AS b
  ON
    b.entity_id = e.entity_id
    AND
    b.activity_id = 21 -- Extract
    AND ( (   -- For S4H entities, get all successful or in progress extracted file names 
      b.status_id IN (1, 2)
      AND
      e.layer_id = 6 -- S4H
      )
      OR ( -- For other base source entities, get only successful extracted file names
          b.status_id = 2
          AND
          e.layer_id IN (5, 7)
      )
    )
WHERE
  e.update_mode = 'Delta'
