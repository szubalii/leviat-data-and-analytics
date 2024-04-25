/*
  This table valued function is used for retrieving the scheduled BASE delta entities

*/


CREATE FUNCTION [dbo].[tvf_scheduled_base_delta_entities](
  @adhoc BIT,
  @date DATE -- set default to current date
)
RETURNS TABLE
AS
RETURN
  SELECT
    entity_id,
    entity_name,
    base_schema_name,
    base_table_name,
    base_sproc_name
  FROM
    dbo.[entity] e
  INNER JOIN
    dbo.[vw_delta_load_entities] d
    ON
      d.entity_id = e.entity_id
  INNER JOIN
    dbo.[tvf_scheduled_entities](
      @adhoc,
      @date
    ) se
    ON
      se.entity_id = e.entity_id
  WHERE
    e.level_nk = 'BASE'
