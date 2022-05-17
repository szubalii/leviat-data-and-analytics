-- Write your own SQL object definition here, and it'll be included in your package.
CREATE FUNCTION [dbo].[get_scheduled_edw_entity_batch_activities](
    @adhoc bit = 0,
    @date DATE
)
RETURNS TABLE AS RETURN
    WITH latest_batch_activities AS (
        select
            b.entity_id,
            b.activity_id,
            MAX(b.start_date_time) as start_date_time
        FROM
            batch b
        WHERE
            CONVERT(date, b.start_date_time) = @date
        GROUP BY
            b.entity_id,
            b.activity_id
    )
    , latest_batch AS (

        SELECT
            lb.entity_id,
            e.entity_name,
            e.layer_id,
            e.update_mode,
            b.run_id,
            b.batch_id,
            ba.activity_nk,
            ba.activity_order,
            lb.start_date_time,
            bs.status_nk
        FROM
            latest_batch_activities lb
        LEFT JOIN [dbo].[entity] e
            ON e.entity_id = lb.entity_id
        LEFT JOIN batch b
            ON
                lb.entity_id = b.entity_id
                AND
                lb.activity_id = b.activity_id
                AND
                lb.start_date_time = b.start_date_time
        LEFT JOIN [dbo].[layer] las
            ON las.[layer_id] = b.[source_layer_id]
        LEFT JOIN [dbo].[layer] lat
            ON lat.[layer_id] = b.[target_layer_id]
        -- LEFT JOIN [dbo].[location] lo
        --     ON lo.[location_id] = la.[location_id]
        LEFT JOIN [dbo].[batch_execution_status] bs
            ON bs.[status_id] = b.[status_id]
        LEFT JOIN [dbo].[batch_activity] ba
            ON ba.[activity_id] = b.[activity_id]

        WHERE
            CONVERT(date, lb.start_date_time) = @date
            -- AND
            -- b.entity_id = @entity_id
            AND (
                e.update_mode = 'Full' OR e.update_mode IS NULL
            )
            -- and
            -- lp.parent_run_id is not null
        -- ORDER BY
        --     entity_name asc, lb.start_date_time desc
        -- select * from batch
    )

    -- select * from latest_batch


    -- select
    --     entity_id,
    --     string_agg(activity_nk, ',') as required_activities
    -- from
    --     latest_batch
    -- WHERE
    --     status_nk <> 'Succeeded'
    -- group by 
    --     entity_id

    --Scenario 1: no batches done on new day
    --return complete list of scheduled entities, cross join with batch activity

    --Scenario 2: load already happened on same day
    --check which batch activities failed or did not happen and return them for corresponding scheduled entities








    -- DECLARE
    --     @date DATE = '2022/04/11';
    , scheduled_entity_batch_activities as (
        select
            e.entity_id,
            e.entity_name,
            e.layer_nk,
            e.execution_order,
            sproc_schema_name,
            sproc_name,
            source_schema_name,
            source_view_name,
            dest_schema_name,
            dest_table_name,
            ba.activity_nk,
            ba.activity_order,
            lb.batch_id,
            lb.status_nk,
            case when status_nk = 'Succeeded' then 0 else 1 end as [isRequired]
        from
            get_scheduled_entities(0, @date) e
        left join
            layer l
            ON
                l.layer_nk = e.layer_nk
        left join
            layer_activity la
            on
                la.layer_id = l.layer_id
        left join
            batch_activity ba
            on
                ba.activity_id = la.activity_id
        left join
            latest_batch lb
            on lb.entity_id = e.entity_id and
                lb.activity_nk = ba.activity_nk

        WHERE
            e.layer_nk IN ('EDW')
            AND (
                e.update_mode = 'Full' OR e.update_mode IS NULL
            )
    )
    , activities as (
        select
            entity_id,
            entity_name,
            layer_nk,
            execution_order,
            sproc_schema_name,
            sproc_name,
            source_schema_name,
            source_view_name,
            dest_schema_name,
            dest_table_name,
            concat(
                '[',
                case
                    when isRequired = 1
                    then concat(
                        '"',
                        string_agg(activity_nk, '","') within group (order by activity_order asc),
                        '"'
                    )
                end,
                ']'
            ) as required_activities,
            concat(
                '{',
                case
                    when isRequired = 0
                    then string_agg(
                        concat(
                            '"',
                            activity_nk,
                            '": {"batch_id":"',
                            batch_id,
                            '}'
                        ),
                        ','
                    ) within group (order by activity_order asc)
                end,
                '}'
            ) as skipped_activities
        from scheduled_entity_batch_activities
        group by
            entity_id,
            entity_name,
            layer_nk,
            execution_order,
            sproc_schema_name,
            sproc_name,
            source_schema_name,
            source_view_name,
            dest_schema_name,
            dest_table_name,
            isRequired
    )

    select
        entity_id,
        entity_name,
        layer_nk,
        execution_order,
        sproc_schema_name,
        sproc_name,
        source_schema_name,
        source_view_name,
        dest_schema_name,
        dest_table_name,
        MIN(required_activities) as required_activities,
        MIN(skipped_activities) as skipped_activities
    from activities
    group by
        entity_id,
        entity_name,
        layer_nk,
        execution_order,
        sproc_schema_name,
        sproc_name,
        source_schema_name,
        source_view_name,
        dest_schema_name,
        dest_table_name
GO