CREATE FUNCTION [dbo].[get_c4c_entities_testDuplicates] (@adhoc bit = 0, @manual_run bit = 0, @date DATE)
RETURNS TABLE
AS RETURN
SELECT
    ent.[entity_id],
    ent.[extraction_name],
    ent.[adls_container_name],
    ent.[directory_path],
    ent.[pk_field_names],
    ent.[file_name]
FROM
    [dbo].[get_c4c_entities] (@adhoc, @date) ent
WHERE
    ent.[pk_field_names] IS NOT NULL
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
				-- get entities that were Succeeded today from USA Snowflake to Blob In
				OR 
				(
					CAST(ent.[last_run_date] AS date) = @date
					AND 
					ent.[last_run_status] = 'Succeeded'
					AND 
					ent.[last_run_activity] = 'C4CToBlobIn'
				)
			    -- get entities that were executed today, but were not Succeeded Test Duplicates
				OR
				(
					CAST(ent.[last_run_date] AS date) = @date
					AND
					ent.[last_run_status] IN ('Failed', 'InProgress')
					AND
					ent.[last_run_activity] = 'TestDuplicates'
				)
			)
		)
	)