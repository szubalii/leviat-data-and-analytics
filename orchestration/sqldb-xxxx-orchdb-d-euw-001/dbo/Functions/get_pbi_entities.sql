CREATE FUNCTION [dbo].[get_pbi_entities] (@adhoc bit = 0, @date DATE)
RETURNS table
AS RETURN
    SELECT
        pbi.pbi_dataset_id,
        pbi.dataset_name,
        pbi0.workspace_guid,
        pbi0.dataset_guid
    FROM
        dbo.pbi_dataset_entity pbi
    LEFT JOIN [dbo].[get_scheduled_entities] (@adhoc, @date) ent ON pbi.entity_id = ent.entity_id
    LEFT JOIN dbo.pbi_dataset pbi0 ON pbi0.pbi_dataset_id = pbi.pbi_dataset_id
    WHERE
        ent.[last_run_date] IS NOT NULL
        AND
        (
            pbi0.[schedule_recurrence] = 'D'
            OR (
                pbi0.[schedule_recurrence] = 'A'
                AND
                @adhoc = 1
            )
            OR (
                pbi0.[schedule_recurrence] = 'W'
                AND
                pbi0.[schedule_day] = DATEPART(dw, @date)
            )
        )
    group by pbi.pbi_dataset_id,
        pbi.dataset_name,
        pbi0.workspace_guid,
        pbi0.dataset_guid
    HAVING max(ent.[last_run_status]) = 'Succeeded' AND min(ent.[last_run_status]) = 'Succeeded'
