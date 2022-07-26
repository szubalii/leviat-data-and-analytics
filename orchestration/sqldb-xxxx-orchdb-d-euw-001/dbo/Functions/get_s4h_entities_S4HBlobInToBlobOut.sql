/*
    DEPRECATED FUNCTION
*/
CREATE FUNCTION [dbo].[get_s4h_entities_S4HBlobInToBlobOut] (@adhoc bit = 0, @manual_run bit = 0, @date DATE)
RETURNS TABLE
AS RETURN
SELECT
    ent.[entity_id],
    ent.[extraction_name],
    ent.[base_schema_name],
    ent.[base_table_name],
    ent.[schedule_recurrence],
    ent.[adls_container_name],
    ent.[base_directory_path] + '/In/' + FORMAT( @date, 'yyyy/MM/dd', 'en-US' ) 	AS source_adls_directory_path,
	ent.[base_directory_path] + '/Out/' + FORMAT( @date, 'yyyy/MM/dd', 'en-US' ) 	AS target_adls_directory_path,
    ent.[file_name],
    ent.[client_field],
    ent.[extraction_type]
FROM
    [dbo].[get_s4h_entities] (@adhoc, @date) ent
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
					ent.[last_run_activity] IN ('S4HBlobInToBlobOut')
				)
					-- get entities that were executed today, and successful in TestDuplicates
				OR 
				(
					CAST(ent.[last_run_date] AS date) = @date
					AND 
					ent.[last_run_status] = 'Succeeded'
					AND 
					ent.[last_run_activity] = 'TestDuplicates'
					AND
                    ent.[pk_field_names] IS NOT NULL
				)
				OR
				(
					CAST(ent.[last_run_date] AS date) = @date
					AND 
					ent.[last_run_status] = 'Succeeded'
					AND 
   					ent.[last_run_activity] IN ('S4HToBlobIn')
					AND
                    ent.[pk_field_names] IS NULL

				)
			)
		)
	)