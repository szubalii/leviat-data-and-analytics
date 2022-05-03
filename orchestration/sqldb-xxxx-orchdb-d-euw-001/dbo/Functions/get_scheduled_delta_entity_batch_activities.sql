-- Write your own SQL object definition here, and it'll be included in your package.
CREATE FUNCTION [dbo].[get_scheduled_delta_entity_batch_activities](
    @adhoc bit = 0,
    @date DATE
)
RETURNS TABLE AS RETURN

    WITH delta_file_batch_activities AS (
        select
            b.entity_id,
            e.entity_name,
            e.layer_id,
            e.update_mode,
            b.run_id,
            b.batch_id,
            b.activity_id,
            ba.activity_nk,
            ba.activity_order,
            b.start_date_time,
            bs.status_nk,
            b.file_name,
            b.output
            -- MAX(b.start_date_time) as start_date_time
        FROM
            batch b
        LEFT JOIN [dbo].[entity] e
            ON e.entity_id = b.entity_id
        -- LEFT JOIN batch b
        --     ON 
        --         b.entity_id = b.entity_id
        --         AND
        --         b.activity_id = b.activity_id
        --         AND
        --         b.start_date_time = b.start_date_time
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
            -- CONVERT(date, b.start_date_time) = @date
            -- and
            b.entity_id = 386--@entity_name
        -- GROUP BY
        --     b.entity_id,
        --     b.activity_id
    )
    -- get list of files and join with corresponding layer activity
    , file_batch_activities as (
        select
            dfba.entity_id,
            dfba.entity_name,
            dfba.layer_id,
            dfba.update_mode,
            -- dfba.run_id,
            -- dfba.batch_id,
            -- dfba.activity_nk,
            -- dfba.activity_order,
            -- dfba.start_date_time,
            -- dfba.status_nk,
            dfba.file_name,
            la.activity_id
        from delta_file_batch_activities dfba
        left join layer_activity la
        on la.layer_id = dfba.layer_id
        group by
            dfba.entity_id,
            dfba.entity_name,
            dfba.layer_id,
            dfba.update_mode,
            -- dfba.run_id,
            -- dfba.batch_id,
            -- dfba.activity_nk,
            -- dfba.activity_order,
            -- dfba.start_date_time,
            -- dfba.status_nk,
            dfba.file_name,
            la.activity_id
        -- order by file_name, activity_id
    )
    , potential_batch_activities as (
        SELECT
            fba.entity_id,
            fba.entity_name,
            fba.layer_id,
            fba.update_mode,
            fba.file_name,
            fba.activity_id,
            dfba.run_id,
            dfba.batch_id,
            ba.activity_nk,
            ba.activity_order,
            dfba.start_date_time,
            dfba.status_nk,
            dfba.output
        from file_batch_activities fba
        left JOIN
            delta_file_batch_activities dfba
            on
                dfba.entity_id = fba.entity_id
                and
                dfba.activity_id = fba.activity_id
                and
                dfba.file_name = fba.file_name
        left JOIN
            batch_activity ba
            on ba.activity_id = fba.activity_id
        -- order by fba.file_name, activity_order
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
            pba.file_name,
            pba.activity_nk,
            pba.activity_order,
            pba.batch_id,
            pba.status_nk,
            start_date_time,
            case
                when pba.output is null then '{}'
                else pba.output
            end as output,
            case when status_nk = 'Succeeded' then 0 else 1 end as [isRequired]
        from
            get_scheduled_entities(0, @date) e
        -- left join
        --     layer l
        --     ON
        --         l.layer_nk = e.layer_nk
        -- left join
        --     layer_activity la
        --     on
        --         la.layer_id = l.layer_id
        -- left join
        --     batch_activity ba
        --     on
        --         ba.activity_id = la.activity_id
        left join
            potential_batch_activities pba
            on pba.entity_id = e.entity_id

        WHERE
            e.layer_nk IN ('S4H', 'AXBI', 'USA')
            AND (
                e.update_mode = 'Delta'
            )
            AND
            (
                (pba.activity_nk = 'TestDuplicates' AND e.pk_field_names IS NOT NULL)
                OR
                pba.activity_nk != 'TestDuplicates'
            )
            AND
            (
                (pba.activity_nk = 'ProcessBase' AND e.base_sproc_name IS NOT NULL)
                OR
                pba.activity_nk != 'ProcessBase'
            )
            and e.entity_id = 386
        -- order by 
    )
    , activities as (
        select
            entity_id,
            entity_name,
            layer_nk,
            client_field,
            extraction_type,
            pk_field_names,
            [axbi_database_name],
            [axbi_schema_name],
            [base_table_name],
            [axbi_date_field_name],
            adls_container_name,
            adls_directory_path_In,
            adls_directory_path_Out,
            [base_schema_name],
            [base_sproc_name],
            file_name,
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
                            '", "output":',
                            output,
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
            client_field,
            extraction_type,
            pk_field_names,
            [axbi_database_name],
            [axbi_schema_name],
            [base_table_name],
            [axbi_date_field_name],
            adls_container_name,
            adls_directory_path_In,
            adls_directory_path_Out,
            [base_schema_name],
            [base_sproc_name],
            file_name,
            isRequired
    )

    select
        entity_id,
        entity_name,
        layer_nk,
        client_field,
        extraction_type,
        pk_field_names,
        [axbi_database_name],
        [axbi_schema_name],
        [base_table_name],
        [axbi_date_field_name],
        adls_container_name,
        adls_directory_path_In,
        adls_directory_path_Out,
        [base_schema_name],
        [base_sproc_name],
        file_name,
        MIN(required_activities) as required_activities,
        MIN(skipped_activities) as skipped_activities
    from activities
    group by
        entity_id,
        entity_name,
        layer_nk,
        client_field,
        extraction_type,
        pk_field_names,
        [axbi_database_name],
        [axbi_schema_name],
        [base_table_name],
        [axbi_date_field_name],
        adls_container_name,
        adls_directory_path_In,
        adls_directory_path_Out,
        [base_schema_name],
        [base_sproc_name],
        file_name
GO
