CREATE FUNCTION [dbo].[get_c4c_entities](@adhoc bit = 0, @date DATE)
RETURNS table
AS RETURN
    SELECT
        ent.[entity_id],
        ent.[entity_name]   AS  [extraction_name],
        ent.[adls_container_name],
        ent.[base_schema_name],
        ent.[base_table_name],
        ent.[schedule_recurrence],
        ent.[last_run_date],
        ent.[last_run_status],
        ent.[last_run_activity],
        ent.[directory_path],
        ent.[pk_field_names],
        ent.[file_name]
    FROM
        [dbo].[get_scheduled_entities] (@adhoc, @date) ent
    WHERE
        ent.layer_nk = 'C4C'
GO