/*
  This table valued function is used for retrieving the required activities
  for all files of a specific entity_id

*/


CREATE FUNCTION [dbo].[tvf_scheduled_base_full_entity_batch_activities](
  @date DATE -- set default to current date
)
RETURNS TABLE
AS
RETURN
  SELECT
    *
  FROM
    [dbo].[get_scheduled_entity_batch_activities]
  WHERE
    update_mode = 'Full' OR update_mode IS NULL
