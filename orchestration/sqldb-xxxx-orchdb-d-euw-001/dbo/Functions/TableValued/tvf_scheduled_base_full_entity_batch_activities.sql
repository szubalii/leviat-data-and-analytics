/*
  This table valued function is used for retrieving the required activities
  for all files of a specific entity_id

*/


CREATE FUNCTION [dbo].[tvf_scheduled_base_full_entity_batch_activities](
  @adhoc BIT = 0,
  @date DATE, -- set default to current date
  @rerunSuccessfulFullEntities BIT = 0 -- In case a new run is required
  -- for full entities that have a successful run for the day already, set it to 1
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
      @rerunSuccessfulFullEntities
    )
  WHERE
    update_mode = 'Full' OR update_mode IS NULL
