CREATE FUNCTION [dbo].[get_USASnowflake_entities](@adhoc bit = 0, @date DATE)
RETURNS TABLE
AS RETURN
SELECT ent.[entity_id],
       ent.[entity_name]          AS [extraction_name],
       ent.[adls_container_name],
       ent.[base_table_name]      AS [adls_directory_path_start],
       ent.[base_schema_name],
       ent.[base_table_name],
       ent.[axbi_database_name]   AS [source_database_name],
       ent.[axbi_schema_name]     AS [source_schema_name],
       ent.[axbi_date_field_name] AS [source_date_field_name],
       ent.[schedule_recurrence],
       ent.[last_run_date],
       ent.[last_run_status],
       ent.[last_run_activity],
       -- ent.[file_path],
       ent.[directory_path],
       ent.[file_name],
       ent.[pk_field_names]
FROM
     [dbo].[get_scheduled_entities](@adhoc, @date) ent
WHERE
    ent.layer_nk='USA'
GO
