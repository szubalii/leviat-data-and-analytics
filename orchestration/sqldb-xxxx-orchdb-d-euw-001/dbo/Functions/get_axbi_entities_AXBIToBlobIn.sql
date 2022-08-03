/*
    DEPRECATED FUNCTION
*/
CREATE FUNCTION [dbo].[get_axbi_entities_AXBIToBlobIn] (@adhoc bit = 0, @manual_run bit = 0, @date DATE)
RETURNS TABLE
AS RETURN
SELECT
    ent.[entity_id],
    ent.[extraction_name],
    ent.[adls_container_name],
    ent.[adls_directory_path_start],
    ent.[adls_directory_path_start] + '/In/' + FORMAT( @date, 'yyyy/MM/dd', 'en-US' )  AS [base_directory_path],
    ent.[base_schema_name],
    ent.[base_table_name],
    ent.[axbi_database_name],
    ent.[axbi_schema_name],
    ent.[axbi_date_field_name],
    ent.[schedule_recurrence]
FROM
    [dbo].[get_axbi_entities] (@adhoc, @date) ent
WHERE
    (
        @manual_run = 1
        OR 
        (
            @manual_run = 0 
            AND 
            (	
                -- get entities that were not executed today
                (
                    CAST(ent.[last_run_date] AS date) < @date
                    OR
                    ent.[last_run_date] IS NULL
                ) 
                -- get entities that were executed today, but were not Succeeded from axbi SQL server to Blob In	
                OR 
                (
                    CAST(ent.[last_run_date] AS date) = @date
                    AND 
                    ent.[last_run_status] IN ('Failed', 'InProgress')
                    AND 
                    ent.[last_run_activity] = 'AXBIToBlobIn'
                )
            )
        )
    )