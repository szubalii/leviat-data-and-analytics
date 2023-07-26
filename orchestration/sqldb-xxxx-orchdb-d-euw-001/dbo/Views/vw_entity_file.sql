/*
  Returns successfully or in progress extracted file names for each entity
*/

CREATE VIEW [dbo].[vw_entity_file]
AS

SELECT
  e.entity_id,
  e.entity_name,
  e.layer_id,
  e.update_mode,
  e.client_field,
  e.extraction_type,
  e.pk_field_names,
  e.axbi_database_name,
  e.axbi_schema_name,
  e.base_table_name,
  e.axbi_date_field_name,
  e.adls_container_name,
  e.base_schema_name,
  e.base_sproc_name,
  e.schedule_recurrence,
  e.schedule_day,
  b.file_name
FROM
  [entity] e
LEFT JOIN
  [batch] b
  ON
    b.entity_id = e.entity_id
    -- Select only entity files that have a successful or in progress extraction activity
    AND
    b.activity_id = 21
    AND
    b.status_id IN (1, 2)
GROUP BY
  e.entity_id,
  e.entity_name,
  e.layer_id,
  e.update_mode,
  e.client_field,
  e.extraction_type,
  e.pk_field_names,
  e.axbi_database_name,
  e.axbi_schema_name,
  e.base_table_name,
  e.axbi_date_field_name,
  e.adls_container_name,
  e.base_schema_name,
  e.base_sproc_name,
  e.schedule_recurrence,
  e.schedule_day,
  b.file_name
