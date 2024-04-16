-- Write your own SQL object definition here, and it'll be included in your package.
CREATE FUNCTION [dbo].[get_scheduled_entity_batch_activities_by_layer](
    @adhoc bit = 0,
    @date DATE,
    @rerunSuccessfulFullEntities BIT = 0 ,
    @layer_nk VARCHAR(50) = 'EDW'
)
RETURNS TABLE AS RETURN

    -- DECLARE @adhoc bit = 0, @date DATE = '2022/05/24';

    WITH latest_batch_activities AS (
        SELECT
            b.entity_id,
            b.activity_id,
            MAX(b.start_date_time) AS start_date_time
        FROM
            batch b
        LEFT JOIN [dbo].[entity] e
            ON e.entity_id = b.entity_id
        LEFT JOIN
            [dbo].[layer] l 
            ON l.[layer_id] = e.[layer_id]
        WHERE
            CONVERT(DATE, b.start_date_time) = @date
            AND
            l.layer_nk = @layer_nk
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
    , scheduled_entity_batch_activities AS (
        SELECT
            e.entity_id,
            e.entity_name,
            e.layer_nk,
            e.execution_order,
            e.update_mode,
            e.sproc_schema_name,
            e.sproc_name,
            e.source_schema_name,
            e.source_view_name,
            e.dest_schema_name,
            e.dest_table_name,
            e.base_table_name,
            ba.activity_nk,
            ba.activity_order,
            lb.batch_id,
            lb.status_id,
            CASE
                WHEN status_id = 2 --'Succeeded'
                THEN 0
                ELSE 1
            END AS [isRequired]
        FROM
            get_scheduled_entities(@adhoc, @date) e
        LEFT JOIN
            layer l
            ON
                l.layer_nk = e.layer_nk
        LEFT JOIN
            layer_activity la
            ON
                la.layer_id = l.layer_id
        LEFT JOIN
            batch_activity ba
            ON
                ba.activity_id = la.activity_id
        LEFT JOIN
            latest_batch lb
            ON 
                lb.entity_id = e.entity_id
                AND
                lb.activity_id = ba.activity_id
        WHERE
            e.layer_nk = @layer_nk
            -- AND (
            --     e.update_mode = 'Full' OR e.update_mode IS NULL
            -- )
    )
    , activities AS (
        SELECT
            entity_id,
            entity_name,
            layer_nk,
            execution_order,
            update_mode,
            sproc_schema_name,
            sproc_name,
            source_schema_name,
            source_view_name,
            dest_schema_name,
            dest_table_name,
            base_table_name,
            concat(
                '[',
                CASE
                    WHEN isRequired = 1 OR @rerunSuccessfulFullEntities = 1
                    THEN concat(
                        '"',
                        string_agg(activity_nk, '","') WITHIN group (ORDER BY activity_order asc),
                        '"'
                    )
                END,
                ']'
            ) AS required_activities,
            concat(
                '{',
                CASE
                    WHEN isRequired = 0 AND @rerunSuccessfulFullEntities != 1
                    THEN string_agg(
                        concat(
                            '"',
                            activity_nk,
                            '": {"batch_id":"',
                            batch_id,
                            '}'
                        ),
                        ','
                    ) WITHIN group (ORDER BY activity_order asc)
                END,
                '}'
            ) AS skipped_activities
        FROM scheduled_entity_batch_activities
        GROUP BY
            entity_id,
            entity_name,
            layer_nk,
            execution_order,
            update_mode,
            sproc_schema_name,
            sproc_name,
            source_schema_name,
            source_view_name,
            dest_schema_name,
            dest_table_name,
            base_table_name,
            isRequired
    )
    SELECT
        entity_id,
        entity_name,
        layer_nk,
        execution_order,
        update_mode,
        sproc_schema_name,
        sproc_name,
        source_schema_name,
        source_view_name,
        dest_schema_name,
        dest_table_name,
        base_table_name,
        MIN(required_activities) AS required_activities,
        MIN(skipped_activities) AS skipped_activities
    FROM activities
    GROUP BY
        entity_id,
        entity_name,
        layer_nk,
        execution_order,
        update_mode,
        sproc_schema_name,
        sproc_name,
        source_schema_name,
        source_view_name,
        dest_schema_name,
        dest_table_name,
        base_table_name
GO
