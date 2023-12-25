/*
  Returns which activities need to rerun for each entity file
*/
CREATE FUNCTION [dbo].[tvf_entity_file_activity_isRequired](
  @rerunSuccessfulFullEntities BIT = 0
)
RETURNS TABLE
AS
RETURN
  SELECT
    efalb.entity_id,
    efalb.layer_id,
    efalb.file_name,
    efff.first_failed_file_name,
    efalb.expected_activity_id,
    efalb.activity_nk,
    efalb.activity_order,
    efffa.first_failed_activity_order,
    efalb.batch_id,
    efalb.run_activity_id,
    -- efalb.latest_start_date_time,
    efalb.status_id,
    COALESCE(efalb.output, '{}') AS [output],
    CASE
      WHEN [full].entity_id IS NOT NULL
      THEN [dbo].[svf_get_isRequired_full_batch_activity](
        efalb.activity_order,
        efffa.first_failed_activity_order,
        @rerunSuccessfulFullEntities
      )
      WHEN delta.entity_id IS NOT NULL
      THEN [dbo].[svf_get_isRequired_delta_batch_activity](
        efalb.file_name,
        efff.first_failed_file_name,
        efalb.activity_order,
        efffa.first_failed_activity_order,
        @rerunSuccessfulFullEntities
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
