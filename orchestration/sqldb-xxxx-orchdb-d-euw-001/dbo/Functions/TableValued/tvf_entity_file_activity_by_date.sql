/*
  Returns the activities that need to run for each entity file
*/
CREATE FUNCTION [dbo].[tvf_entity_file_activity_by_date](
  @date DATE, -- set default to current date
  @rerunSuccessfulFullEntities BIT = 0
)
RETURNS TABLE
AS
RETURN

  WITH
  entity_activity AS ( -- Run activities for new load
    SELECT
      entity_id,
      layer_id,
      NULL AS file_name,
      @date AS trigger_date,
      activity_nk,
      activity_order
    FROM
      vw_entity_activity
  ),

  full_load_entity_file_activity AS ( -- Check if for provided day activities already exist
    SELECT
      [full].entity_id,
      [full].layer_id,
      [full].file_name,
      [full].trigger_date,
      [full].activity_nk,
      [full].activity_order,
      [full].batch_id,
      [full].status_id,
      [full].output,
      [full].isRequired
    FROM
      dbo.[tvf_full_load_entity_file_activities_by_date](
        @date,
        @rerunSuccessfulFullEntities
      ) AS [full]
  ),

  entity_activity_batch AS (
    SELECT
      ea.entity_id,
      ea.layer_id,
      flefa.file_name,
      COALESCE(flefa.trigger_date, ea.trigger_date) AS trigger_date,
      ea.activity_nk,
      ea.activity_order,
      flefa.batch_id,
      flefa.status_id,
      flefa.output,
      flefa.isRequired
    FROM
      entity_activity AS ea
    LEFT JOIN
      full_load_entity_file_activity AS flefa
      ON
        flefa.entity_id = ea.entity_id
        AND
        flefa.activity_nk = ea.activity_nk
        AND
        flefa.trigger_date = ea.trigger_date

    UNION ALL

    SELECT
      [delta].entity_id,
      [delta].layer_id,
      [delta].file_name,
      [delta].trigger_date,
      [delta].activity_nk,
      [delta].activity_order,
      [delta].batch_id,
      [delta].status_id,
      [delta].output,
      [delta].isRequired
    FROM
      dbo.[vw_delta_load_entity_file_activities] [delta]
  )    

  SELECT
    entity_id,
    layer_id,
    file_name,
    trigger_date,
    activity_nk,
    activity_order,
    batch_id,
    status_id,
    COALESCE(output, '{}') AS [output],
    COALESCE(isRequired, 1) AS [isRequired]
  FROM
    entity_activity_batch AS eab

-- select * from entity
-- select * from batch
-- select * from [dbo].[tvf_entity_file_activity_isRequired]('2023-06-01', 0)
-- select * from [dbo].[tvf_entity_file_activity_isRequired]('2023-05-01', 0)
-- select * from tvf_entity_file_activity_requirements('2023-06-01', 0)

