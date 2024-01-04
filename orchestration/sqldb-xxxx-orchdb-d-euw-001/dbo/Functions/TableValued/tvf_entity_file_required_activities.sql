/*
  Returns only those entity files for which
  required activities exist
*/
CREATE FUNCTION [dbo].[tvf_entity_file_required_activities](
  @adhoc BIT = 0,
  @date DATE,
  @rerunSuccessfulFullEntities BIT = 0
)
RETURNS TABLE
AS
RETURN

  SELECT
    entity_id,
    layer_id,
    file_name,
    trigger_date,
    required_activities,
    skipped_activities
  FROM
    [dbo].[tvf_entity_file_activity_requirements](
      @adhoc,
      @date,
      @rerunSuccessfulFullEntities
    )
  WHERE
    -- filter out entity files for which no required activities exist
    required_activities IS NOT NULL
    AND
    required_activities <> '[]'
