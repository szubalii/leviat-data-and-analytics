-- Write your own SQL object definition here, and it'll be included in your package.
CREATE FUNCTION [dbo].[get_scheduled_edw_entity_batch_activities](
    @adhoc bit = 0,
    @date DATE
)
RETURNS TABLE AS RETURN

    -- DECLARE @adhoc bit = 0, @date DATE = '2022/05/24';

    WITH latest_batch_activities AS (
        select
            b.entity_id,
            b.activity_id,
            MAX(b.start_date_time) as start_date_time
        FROM
            batch b
        LEFT JOIN [dbo].[entity] e
            ON e.entity_id = b.entity_id
        WHERE
            CONVERT(date, b.start_date_time) = @date
            AND
            e.layer_id = 4 -- 'EDW'
        GROUP BY
            b.entity_id,
            b.activity_id
    )
    , latest_batch AS (

        SELECT
            lb.entity_id,
            b.run_id,
            b.batch_id,
            b.activity_id,
            lb.start_date_time,
            b.status_id
        FROM
            latest_batch_activities lb
        LEFT JOIN batch b
            ON
                lb.entity_id = b.entity_id
                AND
                lb.activity_id = b.activity_id
                AND
                lb.start_date_time = b.start_date_time
    )

    -- DECLARE
    --     @date DATE = '2022/04/11';
    , scheduled_entity_batch_activities as (
        select
            e.entity_id,
            e.entity_name,
            e.layer_nk,
            e.execution_order,
            e.sproc_schema_name,
            e.sproc_name,
            e.source_schema_name,
            e.source_view_name,
            e.dest_schema_name,
            e.dest_table_name,
            ba.activity_nk,
            ba.activity_order,
            lb.batch_id,
            lb.status_id,
            case
                when status_id = 2 --'Succeeded'
                then 0
                else 1
            end as [isRequired]
        from
            get_scheduled_entities(@adhoc, @date) e
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
            on 
                lb.entity_id = e.entity_id
                and
                lb.activity_id = ba.activity_id

        WHERE
            e.layer_nk IN ('EDW')
            -- AND (
            --     e.update_mode = 'Full' OR e.update_mode IS NULL
            -- )
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
