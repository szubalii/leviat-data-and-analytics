/*
  Returns the expected activities to run for each 
  entity file combination
*/
CREATE VIEW [dbo].[vw_entity_activity]
AS
SELECT
  e.entity_id,
  e.layer_id,
  la.activity_id AS expected_activity_id,
  ba.activity_nk,
  ba.activity_order
FROM
  [dbo].[entity] e
LEFT JOIN
  [layer_activity] la
  ON
    la.layer_id = e.layer_id
LEFT JOIN
  [batch_activity] ba
  ON
    ba.activity_id = la.activity_id
WHERE
  -- Don't return activities for ProcessBase activity if base_sproc_name value is not defined
  NOT(la.activity_id = 15 AND e.base_sproc_name IS NULL)
  AND
  -- Don't return activities for TestDuplicates activity if no primary key fields are defined
  NOT(la.activity_id = 19 AND e.pk_field_names IS NULL)
  AND
  -- Return entities from the following layers only: S4H, AXBI, C4C, USA
  e.layer_id IN (5, 6, 7, 8)
