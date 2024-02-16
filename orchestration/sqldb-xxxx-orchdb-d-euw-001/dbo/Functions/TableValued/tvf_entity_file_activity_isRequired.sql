/*
  Returns the activities that need to run for each entity file
*/
CREATE FUNCTION [dbo].[tvf_entity_file_activity_isRequired](
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

  entity_file_activity AS ( -- Check if for provided day activities already exist
    SELECT
      efalb.entity_id,
      efalb.layer_id,
      efalb.file_name,
      efalb.trigger_date,
      -- efff.first_failed_file_name,
      -- efalb.expected_activity_id,
      efalb.activity_nk,
      efalb.activity_order,
      -- efffa.first_failed_activity_order,
      efalb.batch_id,
      -- efalb.run_activity_id,
      -- efalb.latest_start_date_time,
      efalb.status_id,
      efalb.output,
      -- COALESCE(efalb.output, '{}') AS [output],
      CASE
        WHEN [full].entity_id IS NOT NULL
        THEN [dbo].[svf_get_isRequired_full_batch_activity](
          -- efalb.batch_id,
          efalb.file_name,
          efalb.activity_order,
          efffa.first_failed_activity_order,
          @rerunSuccessfulFullEntities
        )
        WHEN delta.entity_id IS NOT NULL
        THEN [dbo].[svf_get_isRequired_delta_batch_activity](
          efalb.file_name,
          efff.first_failed_file_name,
          efalb.activity_order,
          efffa.first_failed_activity_order
        )
      END AS isRequired
    FROM
      dbo.[vw_entity_file_activity_latest_batch] efalb
    LEFT JOIN
      dbo.[vw_entity_file_first_failed_activity] efffa
      ON
        efffa.entity_id = efalb.entity_id
        AND
        efffa.file_name = efalb.file_name
    LEFT JOIN
      dbo.[vw_entity_first_failed_file] efff
      ON
        efff.entity_id = efalb.entity_id
    LEFT JOIN
      dbo.[vw_full_load_entities] [full]
      ON
        [full].entity_id = efalb.entity_id
    LEFT JOIN
      dbo.[vw_delta_load_entities] delta
      ON
        delta.entity_id = efalb.entity_id
    WHERE (
        [full].entity_id IS NOT NULL
        AND
        efalb.trigger_date = @date
      )
      OR (
        [delta].entity_id IS NOT NULL
        AND
        efalb.trigger_date <= @date /*TODO check if correct*/
      )
  )

  SELECT
    ea.entity_id,
    ea.layer_id,
    efa.file_name,
    COALESCE(efa.trigger_date, ea.trigger_date) AS trigger_date,
    ea.activity_nk,
    ea.activity_order,
    efa.batch_id,
    efa.status_id,
    COALESCE(efa.output, '{}') AS [output],
    COALESCE(efa.isRequired, 1) AS [isRequired]
  FROM
    entity_activity AS ea
  LEFT JOIN
    entity_file_activity AS efa
    ON
      efa.entity_id = ea.entity_id
      AND
      efa.activity_nk = ea.activity_nk
      AND
      efa.trigger_date = ea.trigger_date

-- select * from entity
-- select * from batch
-- select * from [dbo].[tvf_entity_file_activity_isRequired]('2023-06-01', 0)
-- select * from [dbo].[tvf_entity_file_activity_isRequired]('2023-05-01', 0)
-- select * from tvf_entity_file_activity_requirements('2023-06-01', 0)

