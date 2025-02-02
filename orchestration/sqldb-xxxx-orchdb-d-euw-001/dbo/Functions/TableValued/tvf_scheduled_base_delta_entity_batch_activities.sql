/*
  This table valued function is used for retrieving the required activities
  for all files of a specific entity_id

*/


CREATE FUNCTION [dbo].[tvf_scheduled_base_delta_entity_batch_activities](
  @adhoc BIT,
  @date DATE -- set default to current date
)
RETURNS TABLE
AS
RETURN
  SELECT
    *
  FROM
    [dbo].[get_scheduled_entity_batch_activities](
      @adhoc,
      @date,
      0
    )
  WHERE
    update_mode = 'Delta'
