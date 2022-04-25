-- Write your own SQL object definition here, and it'll be included in your package.
CREATE FUNCTION [dbo].[get_scheduled_entity_batch_activities](
    @adhoc bit = 0,
    @date DATE
)
RETURNS TABLE AS RETURN

    WITH pipelines AS (
        select
            b.entity_id,
            pl.parent_run_id,
            MIN(pl.start_date_time) as parent_run_start_time
        from
            batch b
        LEFT JOIN [dbo].[pipeline_log] pl
            ON pl.[run_id] = b.[run_id]
        WHERE
            CONVERT(date, b.start_date_time) = @date
            -- AND
            -- b.entity_id = @entity_id
        group by
            b.entity_id,
            pl.parent_run_id
    ),
    latest_pipeline_start_date_time AS (
        select
            entity_id,
            max(parent_run_start_time) as latest_parent_run_start_time
        from pipelines
        group by entity_id
    ),
    latest_pipeline AS (
        select
            p.entity_id,
            p.parent_run_id,
            lp.latest_parent_run_start_time
        from pipelines p
        left join latest_pipeline_start_date_time lp
            on lp.entity_id = p.entity_id and
                lp.latest_parent_run_start_time = p.parent_run_start_time
        where latest_parent_run_start_time is not null
    ),
    latest_batch AS (

        SELECT
            pl.parent_run_id,
            pl.start_date_time AS pipeline_start_date_time,
            e.entity_name,
            e.entity_id,
            e.layer_id,
            e.update_mode,
            b.start_date_time,
            ba.activity_nk,
            ba.activity_order,
            bs.status_nk,
            b.directory_path,
            b.file_name
        FROM
            [dbo].[batch] b
        LEFT JOIN [dbo].[entity] e
            ON e.entity_id = b.entity_id
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
        LEFT JOIN [dbo].[pipeline_log] pl
            ON pl.[run_id] = b.[run_id]
        LEFT JOIN latest_pipeline lp
            ON lp.parent_run_id = pl.parent_run_id and
            lp.entity_id = b.entity_id


        WHERE
            CONVERT(date, b.start_date_time) = @date
            -- AND
            -- b.entity_id = @entity_id
            AND
            e.update_mode = 'Full'
            and
            lp.parent_run_id is not null
        -- ORDER BY
        --     entity_name asc, start_date_time desc
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

    select
        e.entity_id,
        e.entity_name,
        e.layer_nk,
        e.client_field,
        e.extraction_type,
        e.pk_field_names,
        e.[axbi_database_name],
        e.[axbi_schema_name],
        e.[base_table_name],
        e.[axbi_date_field_name],
        e.adls_container_name,
        e.adls_directory_path_In,
        e.adls_directory_path_Out,
        e.[base_schema_name],
        e.[base_sproc_name],
        e.file_name,
        concat('["', string_agg(ba.activity_nk,'","')
            within group (order by ba.activity_order asc), '"]')
            as required_activities,
        '{}' as skipped_activities
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
        e.layer_nk IN ('S4H', 'AXBI', 'USA')
        AND
        e.update_mode = 'Full'
        -- and
        -- CONVERT(date, b.start_date_time) = @date
    group by
        e.entity_id,
        e.entity_name,
        e.layer_nk,
        e.client_field,
        e.extraction_type,
        e.pk_field_names,
        e.[axbi_database_name],
        e.[axbi_schema_name],
        e.[base_table_name],
        e.[axbi_date_field_name],
        e.adls_container_name,
        e.adls_directory_path_In,
        e.adls_directory_path_Out,
        e.[base_schema_name],
        e.[base_sproc_name],
        e.file_name
    order by entity_id--, ba.activity_order
        -- and
        -- CONVERT(date, b.start_date_time) = @date
    -- order by entity_id, activity_order

-- select * from get_scheduled_entities(0, '2022/04/11')
GO
