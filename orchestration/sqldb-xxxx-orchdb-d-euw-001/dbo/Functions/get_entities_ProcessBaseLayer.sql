CREATE FUNCTION [dbo].[get_entities_ProcessBaseLayer] (@adhoc bit = 0, @manual_run bit = 0, @date DATE)
RETURNS TABLE
AS RETURN
SELECT
    ent.[entity_id],
    ent.[entity_name]   AS  [extraction_name],
    ent.[extraction_type],
    ent.[base_schema_name],
    ent.[base_table_name],
	ent.[base_sproc_name],
    ent.[schedule_recurrence],
	ent.[update_mode]
FROM
    [dbo].[get_scheduled_entities] (@adhoc, @date) ent
WHERE
    ent.[base_sproc_name] is not null
    AND
	(
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
				-- get entities that were executed Succeeded today in Base Layer
				OR
				(
					CAST(ent.[last_run_date] AS date) = @date
					AND
					ent.[last_run_status] = 'Succeeded'
					AND
					ent.[last_run_activity] = 'InBaseLayer'
				)
				-- get entities that were executed today, but were not Succeeded Process Base
				OR
				(
					CAST(ent.[last_run_date] AS date) = @date
					AND
					ent.[last_run_status] IN ('Failed', 'InProgress')
					AND
					ent.[last_run_activity] = 'ProcessBase'
				)
			)
		)
	)