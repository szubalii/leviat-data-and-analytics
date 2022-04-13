CREATE FUNCTION [dbo].[get_USASnowflake_entities_BlobInToBlobOut] (@adhoc bit = 0, @manual_run bit = 0, @date DATE)
RETURNS TABLE
AS RETURN
SELECT
    ent.[entity_id],
    ent.[extraction_name],
    ent.[base_schema_name],
    ent.[base_table_name],
    ent.[schedule_recurrence],
    ent.[adls_container_name],
    ent.[adls_directory_path_start] + '/In/' + FORMAT( @date, 'yyyy/MM/dd', 'en-US' )     AS [source_adls_directory_path],
    ent.[adls_directory_path_start] + '/Out/' + FORMAT( @date, 'yyyy/MM/dd', 'en-US' )    AS [target_adls_directory_path],
    ent.[file_name]
FROM
    [dbo].[get_USASnowflake_entities] (@adhoc, @date) ent
WHERE
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
					-- get entities that were executed today, but were not Succeeded from In to Out blob storage
				OR
				(
					CAST(ent.[last_run_date] AS date) = @date
					AND
					ent.[last_run_status] IN ('Failed', 'InProgress')
					AND
					ent.[last_run_activity] = 'USASnowflakeBlobInToBlobOut'
				)
				-- get entities that were Succeeded today from USA Snowflake check TestDuplicates
				OR
				(
					CAST(ent.[last_run_date] AS date) = @date
					AND
					ent.[last_run_status] = 'Succeeded'
					AND
					ent.[last_run_activity] = 'TestDuplicates'
					AND
                    ent.[pk_field_names] is not NULL
				)
				-- get entities that were Succeeded today from USA Snowflake To In but don't have PK
				OR
				(
					CAST(ent.[last_run_date] AS date) = @date
					AND
					ent.[last_run_status] = 'Succeeded'
					AND 
					ent.[last_run_activity] = 'USASnowflakeToBlobIn'
					AND
					ent.[pk_field_names] is NULL
				)
			)
		)
	)