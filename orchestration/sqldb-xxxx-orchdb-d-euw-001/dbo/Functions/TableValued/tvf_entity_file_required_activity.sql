/*
  Returns which activities need to rerun for each entity file
*/
CREATE FUNCTION [dbo].[tvf_entity_file_required_activity](
  @rerunSuccessfulFullEntities BIT = 0
)
RETURNS TABLE
AS
RETURN
  SELECT
    efalb.entity_id,
    efalb.entity_name,
    efalb.layer_id,
    efalb.update_mode,
    efalb.client_field,
    efalb.extraction_type,
    efalb.pk_field_names,
    efalb.axbi_database_name,
    efalb.axbi_schema_name,
    efalb.base_table_name,
    efalb.axbi_date_field_name,
    efalb.adls_container_name,
    efalb.base_schema_name,
    efalb.base_sproc_name,
    efalb.schedule_recurrence,
    efalb.schedule_day,
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
    [dbo].[svf_get_isRequired_batch_activity](
      efalb.update_mode,
      efalb.file_name,
      efff.first_failed_file_name,
      efalb.activity_order,
      efffa.first_failed_activity_order,
      @rerunSuccessfulFullEntities
    ) AS isRequired
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
