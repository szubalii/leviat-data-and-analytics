CREATE FUNCTION [dbo].[get_scheduled_entity_batch_activities](
    @adhoc bit = 0,
    @date DATE
)
RETURNS TABLE AS RETURN

    --Scenario 1: no batches done on new day
    --return complete list of scheduled entities, cross join with batch activity

    --Scenario 2: load already happened on same day
    --check which batch activities failed or did not happen and return them for corresponding scheduled entities
    
    declare @adhoc bit = 0, @date DATE = '2022/05/04';

    WITH
    -- get the scheduled entities based on the day
    scheduled_source_entities AS (
        select
            e.entity_id,
            e.entity_name,
            e.layer_id,
            e.layer_nk,
            e.client_field,
            e.extraction_type,
            e.update_mode,
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
        from
            get_scheduled_entities(@adhoc, @date) e
        WHERE
            e.layer_nk IN ('S4H', 'AXBI', 'USA')
    )
    -- get the scheduled full entity batch activities
    , scheduled_full_entity_batch_activities AS (
        select
            e.entity_id,
            e.entity_name,
            e.layer_id,
            e.layer_nk,
            e.client_field,
            e.extraction_type,
            e.update_mode,
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
            la.activity_id
        from
            scheduled_source_entities e
        LEFT JOIN
            layer_activity la
            ON
                la.layer_id = e.layer_id
        WHERE
            e.update_mode = 'Full' OR e.update_mode IS NULL
    )
    -- getting latest timestamp/file name for where activity = Extract and status IN Succeeded, InProgress , e.g.
    -- in case where logged batch activities for the same day are missing but earlier on the same day subsequent 
    -- activities are logged and succeeded:
    -- 9:00	Extract	        I_Test_2022_04_13_09_00	Succeeded
    -- 8:00	RunXUExtraction	I_Test_2022_04_13_08_00	Succeeded
    , latest_started_extract_for_day AS (
        select
            b.entity_id,
            -- b.activity_id,
            MAX(b.file_name) as file_name 
        FROM
            batch b
        INNER JOIN
            scheduled_full_entity_batch_activities e
            ON e.entity_id = b.entity_id
        WHERE
            CONVERT(date, b.start_date_time) = @date
            AND
            activity_id = 21 -- Extract
            AND
            b.status_id IN (1, 2) -- InProgress, Succeeded
        GROUP BY
            b.entity_id--,
            -- b.activity_id
    )

    -- get the corresponding logged batch activities for the latest started extracted file name
    , latest_logged_batch_activities AS (
        SELECT
            b.entity_id,
            b.activity_id,
            b.run_id,
            b.batch_id,
            b.start_date_time,
            bs.status_nk,
            b.directory_path,
            b.file_name,
            b.output
        FROM
            latest_started_extract_for_day lsefd
        INNER JOIN
            batch b
            ON
                b.entity_id = lsefd.entity_id
                AND
                b.file_name = lsefd.file_name
        LEFT JOIN [dbo].[batch_execution_status] bs
            ON bs.[status_id] = b.[status_id]
    )

    -- For entities with update_mode = Full,
    -- get the latest start_date_time for each logged batch activity
    -- TODO change logic to getting latest timestamp/file name for where activity = Extract and status = Succeeded, e.g.
    -- in case where logged batch activities for the same day are missing but earlier on the same day subsequent 
    -- activities are logged and succeeded:
    -- 9:00	Extract	        I_Test_2022_04_13_09_00	Succeeded
    -- 8:00	RunXUExtraction	I_Test_2022_04_13_08_00	Succeeded

    -- TODO remove RunXUExtraction for S4H? just use Extract for both S4H and AXBI and USA

    , latest_batch_activities_for_day AS (
        select
            b.entity_id,
            b.activity_id,
            MAX(b.start_date_time) as start_date_time 
        FROM
            batch b
        INNER JOIN
            scheduled_full_entity_batch_activities e
            ON e.entity_id = b.entity_id
        WHERE
            CONVERT(date, b.start_date_time) = @date
        GROUP BY
            b.entity_id,
            b.activity_id
    )
    -- Get the corresponding status of the batch activities from the previous CTE
    , latest_batch_activity_statuses AS (
        SELECT
            lba.entity_id,
            lba.activity_id,
            b.run_id,
            b.batch_id,
            lba.start_date_time,
            bs.status_nk,
            b.directory_path,
            b.file_name,
            b.output
        FROM
            latest_batch_activities_for_day lba
        LEFT JOIN batch b
            ON 
                lba.entity_id = b.entity_id
                AND
                lba.activity_id = b.activity_id
                AND
                lba.start_date_time = b.start_date_time
        LEFT JOIN [dbo].[batch_execution_status] bs
            ON bs.[status_id] = b.[status_id]
    )
    -- scheduled full entities with potential batch activities and statuses
    , scheduled_full_entity_potential_batch_activities as (
        select
            sfeba.entity_id,
            sfeba.entity_name,
            sfeba.layer_id,
            sfeba.layer_nk,
            sfeba.client_field,
            sfeba.extraction_type,
            sfeba.update_mode,
            sfeba.pk_field_names,
            sfeba.[axbi_database_name],
            sfeba.[axbi_schema_name],
            sfeba.[base_table_name],
            sfeba.[axbi_date_field_name],
            sfeba.adls_container_name,
            sfeba.adls_directory_path_In,
            sfeba.adls_directory_path_Out,
            sfeba.[base_schema_name],
            sfeba.[base_sproc_name],
            sfeba.activity_id,
            lbas.batch_id,
            lbas.run_id,
            lbas.start_date_time,
            lbas.status_nk,
            lbas.directory_path,
            lbas.file_name,
            lbas.output
        from
            scheduled_full_entity_batch_activities sfeba
        left JOIN
            latest_batch_activity_statuses lbas
            on 
                lbas.entity_id = sfeba.entity_id
                and
                lbas.activity_id = sfeba.activity_id
    )
    /*
        For delta entities, for each file name that has been logged, check
        which activities have already run and what the status of the activity is.
        If one of the file name's activity is not successful, its activity needs to rerun,
        and all subsequent file name activities except for extraction need to rerun as well.

        First get all the logged batch activities for the scheduled delta entities incl. statuses.
        Then, get all the unique file names joined to the related activities for that entity layer.
        TODO how about in case of new day?

        Possible to load multiple delta files for single entity into base layer. What in case of failure,
        truncate base table?

    */
    -- Get logged batch activities for delta entities
    , scheduled_delta_entity_logged_batch_activities AS (
        select
            b.entity_id,
            e.entity_name,
            e.layer_id,
            e.layer_nk,
            e.update_mode,
            e.client_field,
            e.extraction_type,
            e.pk_field_names,
            e.axbi_database_name,
            e.axbi_schema_name,
            e.base_table_name,
            e.axbi_date_field_name,
            e.adls_container_name,
            e.base_schema_name,
            e.base_sproc_name,
            b.run_id,
            b.batch_id,
            b.activity_id,
            -- ba.activity_nk,
            -- ba.activity_order,
            b.start_date_time,
            bs.status_nk,
            b.directory_path,
            b.file_name,
            b.output
        FROM
            batch b
        INNER JOIN scheduled_source_entities e
            ON e.entity_id = b.entity_id
        -- LEFT JOIN [dbo].[layer] las
        --     ON las.[layer_id] = b.[source_layer_id]
        -- LEFT JOIN [dbo].[layer] lat
        --     ON lat.[layer_id] = b.[target_layer_id]
        LEFT JOIN [dbo].[batch_execution_status] bs
            ON bs.[status_id] = b.[status_id]
        -- LEFT JOIN [dbo].[batch_activity] ba
        --     ON ba.[activity_id] = b.[activity_id]
        WHERE
            e.update_mode = 'Delta'
    )
    -- get list of files and join with corresponding layer activity
    -- this returns list of file names joined with each batch activity that should exist
    , delta_file_batch_activities as (
        select
            deba.entity_id,
            -- deba.entity_name,
            -- deba.layer_id,
            -- deba.layer_nk,
            -- deba.update_mode,
            -- deba.pk_field_names,
            -- deba.axbi_database_name,
            -- deba.axbi_schema_name,
            -- deba.base_table_name,
            -- deba.axbi_date_field_name,
            -- deba.adls_container_name,
            -- deba.base_schema_name,
            -- deba.base_sproc_name,
            deba.file_name,
            la.activity_id
        from scheduled_delta_entity_logged_batch_activities deba
        left join layer_activity la
        on la.layer_id = deba.layer_id
        group by
            deba.entity_id,
            -- deba.entity_name,
            -- deba.layer_id,
            -- deba.layer_nk,
            -- deba.update_mode,
            -- deba.pk_field_names,
            -- deba.axbi_database_name,
            -- deba.axbi_schema_name,
            -- deba.base_table_name,
            -- deba.axbi_date_field_name,
            -- deba.adls_container_name,
            -- deba.base_schema_name,
            -- deba.base_sproc_name,
            deba.file_name,
            la.activity_id
    --     -- order by file_name, activity_id
    )
    -- Get the potential batch activities for delta entities
    , scheduled_delta_entity_potential_batch_activities as (
        SELECT
            dfba.entity_id,
            e.entity_name,
            e.layer_id,
            e.layer_nk,
            e.client_field,
            e.extraction_type,
            e.update_mode,
            e.pk_field_names,
            e.axbi_database_name,
            e.axbi_schema_name,
            e.base_table_name,
            e.axbi_date_field_name,
            e.adls_container_name,
            e.base_schema_name,
            e.base_sproc_name,
            deba.directory_path,
            dfba.file_name,
            dfba.activity_id,
            deba.run_id,
            deba.batch_id,
            deba.start_date_time,
            deba.status_nk,
            deba.output
        from delta_file_batch_activities dfba
        left JOIN
            scheduled_source_entities e
            on
                e.entity_id = dfba.entity_id
        left JOIN
            scheduled_delta_entity_logged_batch_activities deba
            on
                deba.entity_id = dfba.entity_id
                and
                deba.activity_id = dfba.activity_id
                and
                deba.file_name = dfba.file_name
        -- order by fba.file_name, activity_order
    )



    -- union the full and delta entities
    , scheduled_entity_potential_batch_activities AS (
        select
            entity_id,
            entity_name,
            layer_id,
            layer_nk,
            update_mode,
            client_field,
            extraction_type,
            pk_field_names,
            axbi_database_name,
            axbi_schema_name,
            base_table_name,
            axbi_date_field_name,
            adls_container_name,
            -- adls_directory_path_In,
            -- adls_directory_path_Out,
            base_schema_name,
            base_sproc_name,
            directory_path,
            file_name,
            activity_id,
            run_id,
            batch_id,
            start_date_time,
            status_nk,
            output  
        from
            scheduled_full_entity_potential_batch_activities

        UNION ALL

        select
            entity_id,
            entity_name,
            layer_id,
            layer_nk,
            update_mode,
            client_field,
            extraction_type,
            pk_field_names,
            axbi_database_name,
            axbi_schema_name,
            base_table_name,
            axbi_date_field_name,
            adls_container_name,
            -- adls_directory_path_In,
            -- adls_directory_path_Out,
            base_schema_name,
            base_sproc_name,
            directory_path,
            file_name,
            activity_id,
            run_id,
            batch_id,
            start_date_time,
            status_nk,
            output
        from
            scheduled_delta_entity_potential_batch_activities
    )
    -- remove the potential batches if for that entity no primary keys and base_procedure is defined
    , scheduled_entity_potential_batch_activities_filtered AS (
        select
            sepba.entity_id,
            sepba.entity_name,
            sepba.layer_id,
            sepba.layer_nk,
            sepba.update_mode,
            sepba.client_field,
            sepba.extraction_type,
            sepba.pk_field_names,
            sepba.[axbi_database_name],
            sepba.[axbi_schema_name],
            sepba.[base_table_name],
            sepba.[axbi_date_field_name],
            sepba.adls_container_name,
            -- sepba.adls_directory_path_In,
            -- sepba.adls_directory_path_Out,
            sepba.[base_schema_name],
            sepba.[base_sproc_name],
            sepba.directory_path,
            sepba.file_name,
            sepba.activity_id,
            ba.activity_nk,
            ba.activity_order,
            sepba.run_id,
            sepba.batch_id,
            sepba.start_date_time,
            sepba.status_nk,
            case
                when sepba.output is null then '{}'
                else sepba.output
            end as output,
            case when sepba.status_nk = 'Succeeded' then 0 else 1 end as [isRequired]
        FROM
            scheduled_entity_potential_batch_activities sepba
        left JOIN
            batch_activity ba
            on 
                ba.activity_id = sepba.activity_id
        WHERE
            (
                (ba.activity_nk = 'TestDuplicates' AND sepba.pk_field_names IS NOT NULL)
                OR
                ba.activity_nk != 'TestDuplicates'
            )
            AND
            (
                (ba.activity_nk = 'ProcessBase' AND sepba.base_sproc_name IS NOT NULL)
                OR
                ba.activity_nk != 'ProcessBase'
            )
        -- order by entity_id, file_name, activity_order
    )
    , transposed as (
        select
            entity_id,
            entity_name,
            layer_nk,
            update_mode,
            client_field,
            extraction_type,
            pk_field_names,
            axbi_database_name,
            axbi_schema_name,
            base_table_name,
            axbi_date_field_name,
            adls_container_name,
            -- adls_directory_path_In,
            -- adls_directory_path_Out,
            base_schema_name,
            base_sproc_name,
            directory_path,
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
        from scheduled_entity_potential_batch_activities_filtered
        group by
            entity_id,
            entity_name,
            layer_nk,
            update_mode,
            client_field,
            extraction_type,
            pk_field_names,
            axbi_database_name,
            axbi_schema_name,
            base_table_name,
            axbi_date_field_name,
            adls_container_name,
            -- adls_directory_path_In,
            -- adls_directory_path_Out,
            base_schema_name,
            base_sproc_name,
            directory_path,
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
        -- adls_directory_path_In,
        -- adls_directory_path_Out,
        [base_schema_name],
        [base_sproc_name],
        directory_path,
        file_name,
        MIN(required_activities) as required_activities,
        MIN(skipped_activities) as skipped_activities
    from transposed
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
        -- adls_directory_path_In,--TODO
        -- adls_directory_path_Out,
        [base_schema_name],
        [base_sproc_name],
        directory_path,
        file_name

    -- select * from get_scheduled_full_entity_batch_activities(@adhoc, @date)

    -- union all

    -- select * from get_scheduled_delta_entity_batch_activities(@adhoc, @date)
GO
