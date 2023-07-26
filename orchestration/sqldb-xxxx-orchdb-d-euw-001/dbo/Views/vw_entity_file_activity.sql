/*
  Returns the expected activities to run for each 
  entity file combination
*/
CREATE VIEW [dbo].[vw_entity_file_activity]
AS
SELECT
  ef.entity_id,
  ef.entity_name,
  ef.layer_id,
  ef.update_mode,
  ef.client_field,
  ef.extraction_type,
  ef.pk_field_names,
  ef.axbi_database_name,
  ef.axbi_schema_name,
  ef.base_table_name,
  ef.axbi_date_field_name,
  ef.adls_container_name,
  ef.base_schema_name,
  ef.base_sproc_name,
  ef.schedule_recurrence,
  ef.schedule_day,
  ef.file_name,
  la.activity_id AS expected_activity_id
FROM
  [dbo].[vw_entity_file] ef
LEFT JOIN
  [layer_activity] la
  ON
    la.layer_id = ef.layer_id
