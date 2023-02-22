CREATE VIEW [dbo].[vw_get_entity_status]
AS
SELECT
	 ent.[entity_id]
	,ent.[entity_name]
	,ent.[layer_id]
	,la.[layer_nk]
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
	,CONVERT(
		VARCHAR
		,DATEADD(
			DAY
			,-1 * DATEPART(DAY, GETDATE()) + 1
			,DATEADD(
				MONTH
				, -1 * ent.[reload_period_in_months]
				, GETDATE()
			)
		)
		,111
	)								AS [load_from]
	,ent.[sproc_schema_name]
	,ent.[sproc_name]
	,ent.[source_schema_name]
	,ent.[source_view_name]
	,ent.[dest_schema_name]
	,ent.[dest_table_name]
	,ent.[execution_order]
	,ent.[schedule_recurrence]
	,ent.[schedule_start_date]
    ,ent.[pk_field_names]
	,ent.[schedule_day]
    ,b.[batch_id]                   AS [last_batch_id]
	,bs.[status_nk]					AS [last_run_status]
	,md.[last_run_date]
	,ba.[activity_nk]				AS [last_run_activity]
    ,b.[file_path]
    ,b.[directory_path]
    ,b.[file_name]
FROM
	[dbo].[entity] ent
LEFT JOIN (
    SELECT
        [entity_id],
        MAX([start_date_time]) AS [last_run_date]
    FROM
        [dbo].[batch]
    GROUP BY
        [entity_id]
) md 
    ON ent.[entity_id] = md.[entity_id]
LEFT JOIN [dbo].[layer] la
    ON ent.[layer_id] = la.[layer_id]
LEFT JOIN [dbo].[location] lo
    ON la.[location_id] = lo.[location_id]
LEFT JOIN [dbo].[batch] b
    ON b.[entity_id] = ent.[entity_id]
    AND b.[start_date_time] = md.[last_run_date]
LEFT JOIN [dbo].[batch_execution_status] bs
    ON b.[status_id] = bs.[status_id]
LEFT JOIN [dbo].[batch_activity] ba
    ON b.[activity_id] = ba.[activity_id]