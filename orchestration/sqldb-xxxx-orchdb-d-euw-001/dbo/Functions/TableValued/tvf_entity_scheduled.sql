/*
  Returns which activities need to rerun for each entity file
*/
CREATE FUNCTION [dbo].[tvf_entity_scheduled](
  @adhoc BIT = 0,
  @date DATE,
  @rerunSuccessfulFullEntities BIT = 0
)
RETURNS TABLE
AS
RETURN
  SELECT
    sde.entity_id,
    sde.layer_id,
    sde.file_name,
    la.activity_id,
    ba.activity_nk,
    ba.activity_order
  FROM
    dbo.get_scheduled_entities(@adhoc, @date) sde
  LEFT JOIN 
    dbo.layer_activity la
    ON 
        la.layer_id = sde.layer_id
  LEFT JOIN
    dbo.batch_activity ba
    ON la.activity_id = ba.activity_id
