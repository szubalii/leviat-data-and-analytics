/*
  Returns which activities need to rerun for each entity file
*/
CREATE VIEW [dbo].[vw_scheduled_entity]
AS
SELECT
  sde.entity_id,
  sde.layer_id,
  la.activity_id,
  ba.activity_nk,
  ba.activity_order
FROM
  dbo.entity sde
LEFT JOIN 
  dbo.layer_activity la
  ON 
      la.layer_id = sde.layer_id
LEFT JOIN
  dbo.batch_activity ba
  ON la.activity_id = ba.activity_id
