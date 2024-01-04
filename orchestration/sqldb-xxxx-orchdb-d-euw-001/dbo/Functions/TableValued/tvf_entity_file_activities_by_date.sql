-- Write your own SQL object definition here, and it'll be included in your package.
CREATE FUNCTION [dbo].[tvf_entity_file_activities_by_date](
  @adhoc,
  @date DATE, -- set default to current date
  @rerunSuccessfulFullEntities BIT = 0 -- In case a new run is required
  -- for full entities that have a successful run for the day already, set it to 1
)
RETURNS TABLE
AS
RETURN

  WITH
  entity_file_activities AS (
    SELECT
      efr.entity_id,
      efr.layer_id,
      efr.file_name,
      COALESCE(efr.trigger_date, @date) AS trigger_date,
      efr.required_activities,
      efr.skipped_activities
    FROM
      dbo.[tvf_entity_file_required_activities](
        @adhoc,
        @date,
        @rerunSuccessfulFullEntities
      ) efr
    LEFT JOIN
      vw_full_load_entities fle
      ON
        fle.entity_id = efr.entity_id
    LEFT JOIN
      vw_delta_load_entities dle
      ON
        dle.entity_id = efr.entity_id
    WHERE (
        -- If entity is full load and date is provided,
        -- we're only interested in activities that failed 
        -- that need to rerun
        fle.entity_id IS NOT NULL
        AND (
          efr.trigger_date = @date
          OR
          efr.trigger_date IS NULL
        )
      )
      OR (
        -- for delta entities, we're interested in the activities
        -- of all delta files that need to rerun
        dle.entity_id IS NOT NULL
        AND (
          efr.trigger_date <= @date
          OR
          efr.trigger_date IS NULL
        )
      )
  )

  SELECT
    se.entity_id,
    se.layer_id,
    dbo.[svf_get_adls_directory_path](dir.base_dir_path, 'In', se.trigger_date) AS adls_directory_path_In,
    dbo.[svf_get_adls_directory_path](dir.base_dir_path, 'Out', se.trigger_date) AS adls_directory_path_Out,
    se.file_name,
    se.required_activities,
    se.skipped_activities
  FROM entity_file_activities se
  LEFT JOIN
    dbo.vw_adls_base_directory_path dir
    ON
      dir.entity_id = se.entity_id
GO
