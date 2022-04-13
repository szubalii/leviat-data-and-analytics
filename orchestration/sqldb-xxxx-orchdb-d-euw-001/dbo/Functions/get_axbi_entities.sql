CREATE  FUNCTION [dbo].[get_axbi_entities](@adhoc bit = 0, @date DATE)
RETURNS table
    AS RETURN
    SELECT 
        [entity_id],
        [entity_name]      		AS [extraction_name],
        [adls_container_name],
        [base_table_name]  		AS [adls_directory_path_start],
        [directory_path],
        [base_schema_name],
        [base_table_name],
        [axbi_database_name],
        [axbi_schema_name],
        [axbi_date_field_name],
        [schedule_recurrence]
    ,   [schedule_day]
    ,   [last_run_date]
    ,   [last_run_status]
    ,   [last_run_activity]
    ,   [pk_field_names]
    ,   [file_name]
    FROM 
        [dbo].[get_scheduled_entities](@adhoc, @date)
    WHERE
        layer_nk = 'AXBI'
GO