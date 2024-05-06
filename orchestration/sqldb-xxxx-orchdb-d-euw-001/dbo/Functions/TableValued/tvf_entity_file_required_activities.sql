/*
  Returns only those entity files for which
  required activities exist
*/
CREATE FUNCTION [dbo].[tvf_entity_file_required_activities](
  @date DATE, -- set default to current date
  @rerunSuccessfulFullEntities BIT = 0
)
RETURNS TABLE
AS
RETURN

  SELECT
    se.entity_id,
    se.layer_id,
    dbo.[svf_get_adls_directory_path](dir.base_dir_path, 'In', se.trigger_date) AS adls_directory_path_In,
    dbo.[svf_get_adls_directory_path](dir.base_dir_path, 'Out', se.trigger_date) AS adls_directory_path_Out,
    se.file_name,
    se.trigger_date,
    se.required_activities,
    se.skipped_activities
  FROM
    [dbo].[tvf_entity_file_activity_requirements](
      @date,
      @rerunSuccessfulFullEntities
    ) se
  LEFT JOIN
    dbo.vw_adls_base_directory_path dir
    ON
      dir.entity_id = se.entity_id
  WHERE
    -- filter out entity files for which no required activities exist
    required_activities IS NOT NULL
    AND
    required_activities <> '[]'
