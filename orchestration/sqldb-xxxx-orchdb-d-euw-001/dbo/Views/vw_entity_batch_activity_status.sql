CREATE VIEW [dbo].[vw_entity_batch_activity_status]
AS
SELECT
	 ent.[entity_id]
	,ent.[entity_name]
	,ent.[layer_id]
	,l.[layer_nk]
	,lo.[location_nk]
	,ent.[adls_container_name]
	,ent.[data_category]
	,ent.[client_field]
	,ent.[tool_name]
	,ent.[extraction_type]
	,ent.[update_mode]
	,ent.[base_schema_name]
	,ent.[base_table_name]
	,ent.[base_sproc_name]
	,ent.[axbi_database_name]
	,ent.[axbi_schema_name]
	,ent.[axbi_date_field_name]
	,ent.[edw_sproc_schema_name]	AS [sproc_schema_name]
	,ent.[edw_sproc_name]			AS [sproc_name]
	,ent.[edw_source_schema_name]	AS [source_schema_name]
	,ent.[edw_source_view_name]		AS [source_view_name]
	,ent.[edw_dest_schema_name]		AS [dest_schema_name]
	,ent.[edw_dest_table_name]		AS [dest_table_name]
	,ent.[edw_execution_order]		AS [execution_order]
	,ent.[schedule_recurrence]
	,ent.[schedule_start_date]
  ,ent.[pk_field_names]
	,ent.[schedule_day]
  ,la.activity_id
  ,ba.activity_nk
  ,b.[batch_id]
	,bs.[status_nk]
	,b.[start_date_time]
  ,b.[directory_path]
  ,b.[file_name]
FROM
	[dbo].[entity] ent
LEFT JOIN [dbo].[layer_activity] la
	ON la.layer_id = ent.layer_id
LEFT JOIN (
  SELECT
    [entity_id],
    [activity_id],
    MAX([start_date_time]) AS [last_run_date]
  FROM
    [dbo].[batch]
  GROUP BY
    [entity_id],
    [activity_id]
) md 
  ON
    ent.[entity_id] = md.[entity_id]
    AND
    la.activity_id = md.activity_id
LEFT JOIN [dbo].[layer] l
  ON ent.[layer_id] = l.[layer_id]
LEFT JOIN [dbo].[location] lo
  ON l.[location_id] = lo.[location_id]
LEFT JOIN [dbo].[batch] b
  ON 
    b.[entity_id] = md.[entity_id]
    AND
    b.activity_id = md.activity_id
    AND
    b.[start_date_time] = md.[last_run_date]
LEFT JOIN [dbo].[batch_execution_status] bs
  ON b.[status_id] = bs.[status_id]
LEFT JOIN [dbo].[batch_activity] ba
  ON ba.[activity_id] = la.[activity_id]
