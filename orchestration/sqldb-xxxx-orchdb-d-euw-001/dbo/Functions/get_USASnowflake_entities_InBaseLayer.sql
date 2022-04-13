CREATE FUNCTION [dbo].[get_USASnowflake_entities_InBaseLayer] (@adhoc bit = 0, @manual_run bit = 0, @date DATE)
RETURNS TABLE
AS RETURN
SELECT
    ent.[entity_id],
    ent.[extraction_name],
    ent.[base_schema_name],
    ent.[base_table_name],
    ent.[schedule_recurrence],
    ent.[adls_container_name],
    ent.[directory_path],
    ent.[file_name],
	'Out'           as [source_layer],
    'Base'          as [target_layer]
FROM
    [dbo].[get_USASnowflake_entities] (@adhoc, @date) ent
WHERE (
	directory_path IS NOT NULL
	AND
	file_name IS NOT NULL
	AND (
		@manual_run = 1
		OR 
		(
			@manual_run = 0
			AND 
			(
				(
					-- get entities that were not executed today
					CAST(ent.[last_run_date] AS date) < @date
					OR
					ent.[last_run_date] IS NULL
				)
					-- get entities that were executed today, but were not Succeeded in Base Layer	
				OR 
				(
					CAST(ent.[last_run_date] AS date) = @date
					AND 
					ent.[last_run_status] IN ('Failed', 'InProgress')
					AND 
					ent.[last_run_activity] = 'InBaseLayer'
				)
					-- get entities that were Succeeded today from In to Blob Out
				OR (
					CAST(ent.[last_run_date] AS date) = @date
					AND 
					ent.[last_run_status] = 'Succeeded'
					AND 
					ent.[last_run_activity] = 'USASnowflakeBlobInToBlobOut'
				)
			)
		)
	)
)