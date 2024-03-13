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
-- Don't return activities for ProcessBase activity if base_sproc_name value is not defined
WHERE
  NOT(la.activity_id = 15 AND base_sproc_name IS NULL)
