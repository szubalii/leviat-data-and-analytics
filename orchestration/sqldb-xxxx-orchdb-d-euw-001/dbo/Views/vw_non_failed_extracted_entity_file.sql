/* 
  Return file names for entities where activity = Extract and status IN Succeeded, InProgress,
  In case where logged batch activities for the same day are missing but earlier on the same day 
  subsequent activities are logged and succeeded:
  9:00	Extract	        I_Test_2022_04_13_09_00	Succeeded
  8:00	RunXUExtraction	I_Test_2022_04_13_08_00	Succeeded
*/

CREATE VIEW [dbo].[vw_non_failed_extracted_entity_file] AS

SELECT
  e.entity_id,
  -- e.entity_name,
  -- e.layer_id,
  -- e.client_field,
  -- e.extraction_type,
  -- e.update_mode,
  -- e.pk_field_names,
  -- e.axbi_database_name,
  -- e.axbi_schema_name,
  -- e.base_table_name,
  -- e.axbi_date_field_name,
  -- e.adls_container_name,
  -- dir.base_dir_path + '/In/' + FORMAT(b.start_date_time, 'yyyy/MM/dd', 'en-US') AS adls_directory_path_In,
  -- dir.base_dir_path + '/Out/' + FORMAT(b.start_date_time, 'yyyy/MM/dd', 'en-US') AS adls_directory_path_Out,
  -- e.base_schema_name,
  -- e.base_sproc_name,
  b.start_date_time,
  b.file_name
FROM
  dbo.entity e
INNER JOIN
  dbo.batch b
  ON b.entity_id = e.entity_id
-- LEFT JOIN dbo.vw_adls_base_directory_path dir
--   ON dir.entity_id = e.entity_id
WHERE
  -- CONVERT(DATE, b.start_date_time) = @date
  -- AND
  b.activity_id = 21 --@BATCH_ACTIVITY_ID__EXTRACT
  AND
  (
    (   -- For S4H entities, get all successful or in progress extracted file names 
      b.status_id IN (
        1, --@BATCH_EXECUTION_STATUS_ID__IN_PROGRESS
        2  --@BATCH_EXECUTION_STATUS_ID__SUCCESSFUL
      )
      AND
      e.layer_id = 6 --@LAYER_ID__S4H
    )
    OR ( -- For other base source entities, get only successful extracted file names
      b.status_id = 2 --@BATCH_EXECUTION_STATUS_ID__SUCCESSFUL
      AND
      e.layer_id IN (
        5, --@LAYER_ID__AXBI
        7, --@LAYER_ID__USA
        8  --@LAYER_ID__C4C
      )
    )
  )
  --TODO delta
  -- AND
  -- CONVERT(DATE, b.start_date_time) <= @date
  -- --TODO full
  -- AND
  -- CONVERT(DATE, b.start_date_time) = @date
