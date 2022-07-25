CREATE VIEW [dbo].[vw_entity_batch_activity_status]
AS

-- select the full entity activities
WITH f AS (
  SELECT
    entity_id,
    layer_id,
    file_name
  FROM
    [dbo].[vw_full_entity_activity_batch_ids]
),
-- select the delta entity activities with all file-names
d AS (
  SELECT
    entity_id,
    layer_id,
    file_name
  FROM
    [dbo].[vw_delta_entity_activity_batch_ids]
),
fullAndDelta AS (
    SELECT *
    FROM f

    UNION ALL

    SELECT *
    FROM d
),
latest_activities AS (
  SELECT
    fd.[entity_id]
    ,la.activity_id
    ,fd.[file_name]
    ,MAX(b.start_date_time) AS start_date_time
  FROM
    fullAndDelta AS fd
  LEFT JOIN [dbo].[layer_activity] AS la
    ON la.layer_id = fd.layer_id
  LEFT JOIN
    batch AS b
    ON
      b.entity_id = fd.entity_id
      AND
      b.file_name = fd.file_name
      AND
      b.activity_id = la.activity_id
  GROUP BY
    fd.[entity_id]
    ,la.activity_id
    ,fd.[file_name]
)

-- add all descriptive fields and get the statuses
SELECT
	 act.[entity_id]
	,e.[entity_name]
	,e.[layer_id]
	,l.[layer_nk]
	,lo.[location_nk]
	,e.[adls_container_name]
	,e.[data_category]
	,e.[client_field]
	,e.[tool_name]
	,e.[extraction_type]
	,e.[update_mode]
	,e.[base_schema_name]
	,e.[base_table_name]
	,e.[base_sproc_name]
	,e.[axbi_database_name]
	,e.[axbi_schema_name]
	,e.[axbi_date_field_name]
	,e.[sproc_schema_name]
	,e.[sproc_name]
	,e.[source_schema_name]
	,e.[source_view_name]
	,e.[dest_schema_name]
	,e.[dest_table_name]
	,e.[execution_order]
	,e.[schedule_recurrence]
	,e.[schedule_start_date]
  ,e.[pk_field_names]
	,e.[schedule_day]
  ,act.activity_id
  ,ba.activity_nk
  ,b.[batch_id]
	,bs.[status_nk]
	,act.[start_date_time]
  ,b.[directory_path]
  ,act.[file_name]
FROM
	latest_activities AS act
LEFT JOIN
  entity AS e
  ON
    e.entity_id = act.entity_id
LEFT JOIN [dbo].[layer] l
  ON l.[layer_id] = e.[layer_id]
LEFT JOIN [dbo].[location] lo
  ON l.[location_id] = lo.[location_id]
LEFT JOIN [dbo].[batch] b
  ON 
    b.entity_id = act.entity_id
    AND
    b.file_name = act.file_name
    AND
    b.activity_id = act.activity_id
    AND
    b.start_date_time = act.start_date_time
LEFT JOIN [dbo].[batch_execution_status] bs
  ON b.[status_id] = bs.[status_id]
LEFT JOIN [dbo].[batch_activity] ba
  ON ba.[activity_id] = act.[activity_id]
