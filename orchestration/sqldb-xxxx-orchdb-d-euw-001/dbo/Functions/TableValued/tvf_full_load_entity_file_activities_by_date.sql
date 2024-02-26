/*
This function returns the activities for the latest file for the provided date.

*/

CREATE FUNCTION [dbo].[tvf_full_load_entity_file_activities_by_date](
  @date DATE, -- set default to current date
  @rerunSuccessfulFullEntities BIT = 0 -- In case a new run is required
  -- for full entities that have a successful run for the day already, set it to 1
)
RETURNS TABLE
AS
RETURN

  WITH

  -- for full load entities, get the most recent file for the provided date
  full_entity_file_activity_date AS ( -- Check if for provided day activities already exist
    SELECT
      efalb.entity_id,
      MAX(efalb.file_name) AS file_name
    FROM
      dbo.[vw_entity_file_activity_latest_batch] efalb
    WHERE
      efalb.trigger_date = @date
    GROUP BY
      efalb.entity_id
  )

  SELECT
    [full].entity_id,
    ea.layer_id,
    COALESCE(efalb.trigger_date, @date) AS trigger_date,
    efalb.file_name,
    ea.activity_nk,
    ea.activity_order,
    efalb.batch_id,
    efalb.status_id,
    efalb.output,
    [dbo].[svf_get_isRequired_full_batch_activity](
      -- efalb.batch_id,
      efalb.file_name,
      ea.activity_order,
      efffa.first_failed_activity_order,
      @rerunSuccessfulFullEntities
    ) AS isRequired
  FROM
    vw_full_load_entities [full]
  LEFT JOIN
    vw_entity_activity ea
    ON
      ea.entity_id = [full].entity_id
  LEFT JOIN
    full_entity_file_activity_date fef
    ON
      fef.entity_id = [full].entity_id
  LEFT JOIN
    dbo.vw_entity_file_activity_latest_batch efalb
    ON
      efalb.entity_id = [full].entity_id
      AND
      efalb.file_name = fef.file_name
  LEFT JOIN
    dbo.[vw_entity_file_first_failed_activity] efffa
    ON
      efffa.entity_id = efalb.entity_id
      AND
      efffa.file_name = efalb.file_name


  /* USE full load entities with entity_activity as SOURCE */

  -- SELECT
  --   fe.entity_id,
  --   fe.layer_id,
  --   fe.trigger_date,
  --   fe.file_name,
  --   efalb.activity_nk,
  --   efalb.activity_order,
  --   efalb.batch_id,
  --   efalb.status_id,
  --   efalb.output,
  --   [dbo].[svf_get_isRequired_full_batch_activity](
  --     -- efalb.batch_id,
  --     efalb.file_name,
  --     efalb.activity_order,
  --     efffa.first_failed_activity_order,
  --     @rerunSuccessfulFullEntities
  --   ) AS isRequired

  --   -- dbo.[svf_get_adls_directory_path](dir.base_dir_path, 'In', se.trigger_date) AS adls_directory_path_In,
  --   -- dbo.[svf_get_adls_directory_path](dir.base_dir_path, 'Out', se.trigger_date) AS adls_directory_path_Out,
  --   -- se.file_name,
  --   -- se.required_activities,
  --   -- se.skipped_activities
  -- FROM
  --   full_entity_file_activity_date fe
  -- LEFT JOIN
  --   dbo.vw_entity_file_activity_latest_batch efalb
  --   ON
  --     efalb.entity_id = fe.entity_id
  --     AND
  --     efalb.file_name = fe.file_name
  -- LEFT JOIN
  --   dbo.[vw_entity_file_first_failed_activity] efffa
  --   ON
  --     efffa.entity_id = efalb.entity_id
  --     AND
  --     efffa.file_name = efalb.file_name
GO
