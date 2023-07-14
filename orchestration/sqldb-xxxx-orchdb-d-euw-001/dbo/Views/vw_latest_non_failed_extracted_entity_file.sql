/*
  Return the LATEST file names for entities where activity = Extract and status IN Succeeded, InProgress,
*/
CREATE VIEW [dbo].[vw_latest_non_failed_extracted_entity_file] AS

-- WITH latest_file AS (
--   SELECT
--     entity_id,
--     MAX(file_name) AS file_name
--   FROM
--     vw_non_failed_extracted_entity_file
--   GROUP BY
--     entity_id
-- )

SELECT
  entity_id,
  -- entity_name,
  -- layer_id,
  -- client_field,
  -- extraction_type,
  -- update_mode,
  -- pk_field_names,
  -- axbi_database_name,
  -- axbi_schema_name,
  -- base_table_name,
  -- axbi_date_field_name,
  -- adls_container_name,
  -- adls_directory_path_In,
  -- adls_directory_path_Out,
  -- base_schema_name,
  -- base_sproc_name,
  MAX(start_date_time) AS start_date_time,
  MAX(file_name) AS file_name
  -- lf.file_name
FROM
  vw_non_failed_extracted_entity_file
GROUP BY
  entity_id
-- LEFT JOIN
--   vw_non_failed_extracted_entity_file ef
--   ON
--     ef.entity_id = lf.entity_id
--     AND
--     ef.file_name = lf.file_name
