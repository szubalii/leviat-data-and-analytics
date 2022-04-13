CREATE FUNCTION [dbo].[get_edw_entities] (@adhoc bit = 0, @manual_run bit = 0, @date DATE)
RETURNS TABLE
AS RETURN
SELECT
    ent.[entity_id],
    ent.[entity_name],
    ent.[layer_nk] AS [source_layer],
    'EDW' AS [target_layer],
    ent.[sproc_schema_name],
    ent.[sproc_name],
    ent.[source_schema_name],
    ent.[source_view_name],
    ent.[dest_schema_name],
    ent.[dest_table_name],
    ent.[execution_order],
    ent.[schedule_recurrence],
    ent.[pk_field_names]
FROM
    [dbo].[get_scheduled_entities] (@adhoc, @date) ent
WHERE
    ent.[layer_nk] = 'EDW'
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
                    -- get entities that were executed today, but were not Succeeded in EDW Layer	
                OR 
                (
                    CAST(ent.[last_run_date] AS date) = @date
                    AND 
                    ent.[last_run_status] IN ('Failed', 'InProgress')
                    AND 
                    ent.[last_run_activity] IN (
                        'InEDWLayer',
                        'BasetoEDWExecGenericSP',
                        'BasetoEDWExecCustomSP'
                    )
                )
            )
        )
    )