CREATE VIEW [dbo].[vw_entity_batch_activity] AS 

SELECT
  e.entity_id,
  e.entity_name,
  e.layer_id,
  e.client_field,
  e.extraction_type,
  e.update_mode,
  e.pk_field_names,
  e.axbi_database_name,
  e.axbi_schema_name,
  e.base_table_name,
  e.axbi_date_field_name,
  e.adls_container_name,
  e.base_schema_name,
  e.base_sproc_name,
  la.activity_id
FROM
  dbo.entity e
LEFT JOIN
  dbo.layer_activity la
  ON
    la.layer_id = e.layer_id
