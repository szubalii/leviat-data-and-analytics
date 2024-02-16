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
