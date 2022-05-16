CREATE FUNCTION [dbo].[get_scheduled_entity_batch_activities](
    @adhoc bit = 0,
    @date DATE
)
RETURNS TABLE AS RETURN

    --Scenario 1: no batches done on new day
    --return complete list of scheduled entities, cross join with batch activity

    --Scenario 2: load already happened on same day
    --check which batch activities failed or did not happen and return them for corresponding scheduled entities
    
    declare @adhoc bit = 0, @date DATE = '2022/05/02';

    WITH
    -- -- get the scheduled entities based on the day
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
            b.activity_id = 21 -- Extract
            AND
            b.status_id IN (1, 2) -- InProgress, Succeeded
        GROUP BY
            b.entity_id--,
            -- b.activity_id
    )

    -- join the file name to each scheduled batch activity
    , scheduled_full_entity_batch_activities_file_name AS (
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
            e.activity_id,
            f.file_name
        FROM
            scheduled_full_entity_batch_activities e
        LEFT JOIN
            latest_started_extract_for_day f
            ON
                f.entity_id = e.entity_id
    )

    -- get the corresponding logged batch activities for the latest started extracted file name
    , latest_logged_batch_activities AS (
        SELECT
            b.entity_id,
            b.activity_id,
            ba.activity_order,
            b.run_id,
            b.batch_id,
            b.start_date_time,
            b.status_id,
            -- bs.status_nk,
            -- b.directory_path,
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
        LEFT JOIN [dbo].[batch_activity] ba
            ON ba.[activity_id] = b.[activity_id]
    )

    -- get the latest successful logged batch activities up to the first failed activity
    -- any successful activity after failed activities need to re-run in any case
    , first_failed_activity_order AS (
        select
            entity_id,
            min(activity_order) as activity_order
        from 
            latest_logged_batch_activities
        WHERE
            status_id = 4 -- 'Failed'
        group by
            entity_id
    )

    -- get the successful batch activities before the first failed batch activity
    , successful_logged_batch_activities_before_failure AS (
        select
            llba.entity_id,
            llba.activity_id,
            llba.run_id,
            llba.batch_id,
            llba.start_date_time,
            llba.status_id,
            -- bs.status_nk,
            -- llba.directory_path,
            llba.file_name,
            llba.output
        FROM
            latest_logged_batch_activities llba
        LEFT JOIN
            first_failed_activity_order ffao
            ON
                ffao.entity_id = llba.entity_id
        WHERE
            llba.activity_order < ffao.activity_order
            OR
            ffao.activity_order IS NULL
    )

    -- For entities with update_mode = Full,
    -- get the latest start_date_time for each logged batch activity
    -- TODO change logic to getting latest timestamp/file name for where activity = Extract and status = Succeeded, e.g.
    -- in case where logged batch activities for the same day are missing but earlier on the same day subsequent 
    -- activities are logged and succeeded:
    -- 9:00	Extract	        I_Test_2022_04_13_09_00	Succeeded
    -- 8:00	RunXUExtraction	I_Test_2022_04_13_08_00	Succeeded

    -- TODO remove RunXUExtraction for S4H? just use Extract for both S4H and AXBI and USA

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
            lslba.batch_id,
            lslba.run_id,
            lslba.start_date_time,
            lslba.status_id,
            sfeba.file_name,
            lslba.output
        from
            scheduled_full_entity_batch_activities_file_name sfeba
        left JOIN
            successful_logged_batch_activities_before_failure lslba
            on 
                lslba.entity_id = sfeba.entity_id
                and
                lslba.activity_id = sfeba.activity_id
    )
    /*
        For delta entities, for each file name that has been logged, check
        which activities have already run and what the status of the activity is.
        If one of the file name's activity is not successful, its activity needs to rerun,
        and all subsequent file name activities except for extraction need to rerun as well.

        First get all the logged batch activities for the scheduled delta entities incl. statuses.
        Then, get all the unique file names joined to the related activities for that entity layer.
        TODO how about in case of new day?

        TODO Enable loading multiple delta files for single entity into base layer. What in case of failure,
        truncate base table? 
        TODO Process base as separate step, maybe even separete entity?

        Get all file names based on Extract activity and status is Successful or InProgress
        Get all corresponding batch activities and statuses for the file names

        Check what the first file name is for which there is a Failed activity. 
        For the first failed file name, check which activities were successful before the first failed activity
        TODO: All subsequent activities (minus Extract) and file names activities need to be executed again
        
    */

    -- Get all scheduled delta entities
    , scheduled_delta_entities AS (
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
        FROM
            scheduled_source_entities e
        WHERE
            e.update_mode = 'Delta'
    )

    -- For delta entities: get all file names based on Extract activity where status is Successful or InProgress
    , successful_extract_file_names_scheduled_delta_entities AS (
        select
            e.entity_id,
            b.file_name
        FROM
            scheduled_delta_entities e
        INNER JOIN 
            batch b
            ON b.entity_id = e.entity_id
        WHERE
            b.status_id IN (1, 2) -- InProgress, Succeeded
            AND
            b.activity_id = 21 -- Extract
            AND
            CONVERT(date, b.start_date_time) <= @date
    )

    -- get all potential delta batch activities
    , scheduled_delta_entity_batch_activities AS (
        select
            sde.entity_id,
            sde.entity_name,
            sde.layer_id,
            sde.layer_nk,
            sde.client_field,
            sde.extraction_type,
            sde.update_mode,
            sde.pk_field_names,
            sde.[axbi_database_name],
            sde.[axbi_schema_name],
            sde.[base_table_name],
            sde.[axbi_date_field_name],
            sde.adls_container_name,
            sde.adls_directory_path_In,
            sde.adls_directory_path_Out,
            sde.[base_schema_name],
            sde.[base_sproc_name],
            sefnsde.file_name,
            la.activity_id
        FROM
            scheduled_delta_entities sde
        LEFT JOIN
            successful_extract_file_names_scheduled_delta_entities sefnsde
            ON
                sefnsde.entity_id = sde.entity_id
        left join layer_activity la
            on la.layer_id = sde.layer_id
    )

    -- Get all corresponding batch activities and statuses for the file names
    , successful_extract_delta_file_name_batch_activities AS (
        SELECT
            sefnsde.entity_id,
            -- sefnsde.entity_name,
            -- sefnsde.layer_id,
            -- sefnsde.layer_nk,
            -- sefnsde.client_field,
            -- sefnsde.extraction_type,
            -- sefnsde.update_mode,
            -- sefnsde.pk_field_names,
            -- sefnsde.axbi_database_name,
            -- sefnsde.axbi_schema_name,
            -- sefnsde.base_table_name,
            -- sefnsde.axbi_date_field_name,
            -- sefnsde.adls_container_name,
            -- sefnsde.base_schema_name,
            -- sefnsde.base_sproc_name,
            b.activity_id,
            ba.activity_order,
            b.run_id,
            b.batch_id,
            b.start_date_time,
            b.status_id,
            b.directory_path,
            b.file_name,
            b.output
        FROM
            successful_extract_file_names_scheduled_delta_entities sefnsde
        INNER JOIN
            batch b
            ON
                b.entity_id = sefnsde.entity_id
                AND
                b.file_name = sefnsde.file_name
        LEFT JOIN [dbo].[batch_activity] ba
            ON ba.[activity_id] = b.[activity_id]
    ) 

    -- Check what the first file name is for which there is a Failed activity. 
    , first_failed_file_name AS (
        select
            entity_id,
            MIN(file_name) as file_name
        from 
            successful_extract_delta_file_name_batch_activities
        WHERE
            status_id = 4 -- 'Failed'
        group by
            entity_id
    )

    -- get the successful file name batch activities before the first file name with a failure
    , successful_file_names_before_failure AS (
        select
            sdfnba.entity_id,
            sdfnba.activity_id,
            sdfnba.run_id,
            sdfnba.batch_id,
            sdfnba.start_date_time,
            sdfnba.status_id,
            sdfnba.directory_path,
            sdfnba.file_name,
            sdfnba.output
        FROM
            successful_extract_delta_file_name_batch_activities sdfnba
        LEFT JOIN
            first_failed_file_name fffn
            ON
                fffn.entity_id = sdfnba.entity_id
        WHERE
            sdfnba.file_name < fffn.file_name -- smaller than this should work as tested
    )

    -- get the activity order of the first failed batch activity
    , first_failed_file_name_activity_order AS (
        select
            sdfnba.entity_id,
            sdfnba.file_name,
            MIN(activity_order) as activity_order
        from 
            successful_extract_delta_file_name_batch_activities sdfnba
        LEFT JOIN
            first_failed_file_name fffn
            ON 
                fffn.entity_id = sdfnba.entity_id
                AND
                fffn.file_name = sdfnba.file_name
        WHERE
            status_id = 4 -- 'Failed'
        group by
            sdfnba.entity_id,
            sdfnba.file_name
    )

    -- For the first failed file name, check which activities were successful before the first failed activity
    , successful_file_name_batch_activities_before_failure AS (
        select
            sdfnba.entity_id,
            sdfnba.activity_id,
            sdfnba.run_id,
            sdfnba.batch_id,
            sdfnba.start_date_time,
            sdfnba.status_id,
            sdfnba.directory_path,
            sdfnba.file_name,
            sdfnba.output
        FROM
            successful_extract_delta_file_name_batch_activities sdfnba
        INNER JOIN
            first_failed_file_name_activity_order fffnao
            ON
                fffnao.entity_id = sdfnba.entity_id
                AND
                sdfnba.file_name = fffnao.file_name
        WHERE
            sdfnba.activity_order < fffnao.activity_order
            OR
            fffnao.activity_order IS NULL
    )

    -- union the successful file name batch activities
    , successful_delta_file_name_batch_activities AS (
        select 
            fffnao.entity_id,
            fffnao.activity_id,
            fffnao.run_id,
            fffnao.batch_id,
            fffnao.start_date_time,
            fffnao.status_id,
            fffnao.directory_path,
            fffnao.file_name,
            fffnao.output
        FROM
            successful_file_name_batch_activities_before_failure fffnao
        
        UNION ALL

        select
            sdfnba.entity_id,
            sdfnba.activity_id,
            sdfnba.run_id,
            sdfnba.batch_id,
            sdfnba.start_date_time,
            sdfnba.status_id,
            sdfnba.directory_path,
            sdfnba.file_name,
            sdfnba.output
        FROM
            successful_file_names_before_failure sdfnba
    )

    -- get the successful batch activities before the first failed batch activity
    -- , **** AS (
    --     select
    --         sflnba.entity_id,
    --         sflnba.activity_id,
    --         sflnba.run_id,
    --         sflnba.batch_id,
    --         sflnba.start_date_time,
    --         sflnba.status_id,
    --         -- bs.status_nk,
    --         sflnba.directory_path,
    --         sflnba.file_name,
    --         sflnba.output
    --     FROM
    --         successful_delta_file_name_batch_activities sflnba
    --     LEFT JOIN
    --         first_failed_file_name_activity_order fffnao
    --         ON
    --             fffnao.entity_id = sflnba.entity_id
    --     WHERE
    --         sflnba.activity_order < fffnao.activity_order
    -- )


    -- -- Get logged batch activities for delta entities
    -- , scheduled_delta_entity_logged_batch_activities AS (
    --     select
    --         b.entity_id,
    --         e.entity_name,
    --         e.layer_id,
    --         e.layer_nk,
    --         e.update_mode,
    --         e.client_field,
    --         e.extraction_type,
    --         e.pk_field_names,
    --         e.axbi_database_name,
    --         e.axbi_schema_name,
    --         e.base_table_name,
    --         e.axbi_date_field_name,
    --         e.adls_container_name,
    --         e.base_schema_name,
    --         e.base_sproc_name,
    --         b.run_id,
    --         b.batch_id,
    --         b.activity_id,
    --         -- ba.activity_nk,
    --         -- ba.activity_order,
    --         b.start_date_time,
    --         bs.status_nk,
    --         b.directory_path,
    --         b.file_name,
    --         b.output
    --     FROM
    --         batch b
    --     INNER JOIN scheduled_source_entities e
    --         ON e.entity_id = b.entity_id
    --     -- LEFT JOIN [dbo].[layer] las
    --     --     ON las.[layer_id] = b.[source_layer_id]
    --     -- LEFT JOIN [dbo].[layer] lat
    --     --     ON lat.[layer_id] = b.[target_layer_id]
    --     LEFT JOIN [dbo].[batch_execution_status] bs
    --         ON bs.[status_id] = b.[status_id]
    --     -- LEFT JOIN [dbo].[batch_activity] ba
    --     --     ON ba.[activity_id] = b.[activity_id]
    --     WHERE
    --         e.update_mode = 'Delta'
    -- )
    -- -- get list of files and join with corresponding layer activity
    -- -- this returns list of file names joined with each batch activity that should exist
    -- , delta_file_batch_activities as (
    --     select
    --         deba.entity_id,
    --         -- deba.entity_name,
    --         -- deba.layer_id,
    --         -- deba.layer_nk,
    --         -- deba.update_mode,
    --         -- deba.pk_field_names,
    --         -- deba.axbi_database_name,
    --         -- deba.axbi_schema_name,
    --         -- deba.base_table_name,
    --         -- deba.axbi_date_field_name,
    --         -- deba.adls_container_name,
    --         -- deba.base_schema_name,
    --         -- deba.base_sproc_name,
    --         deba.file_name,
    --         la.activity_id
    --     from scheduled_delta_entity_logged_batch_activities deba
    --     left join layer_activity la
    --     on la.layer_id = deba.layer_id
    --     group by
    --         deba.entity_id,
    --         -- deba.entity_name,
    --         -- deba.layer_id,
    --         -- deba.layer_nk,
    --         -- deba.update_mode,
    --         -- deba.pk_field_names,
    --         -- deba.axbi_database_name,
    --         -- deba.axbi_schema_name,
    --         -- deba.base_table_name,
    --         -- deba.axbi_date_field_name,
    --         -- deba.adls_container_name,
    --         -- deba.base_schema_name,
    --         -- deba.base_sproc_name,
    --         deba.file_name,
    --         la.activity_id
    -- --     -- order by file_name, activity_id
    -- )
    -- Get the potential batch activities for delta entities
    , scheduled_delta_entity_potential_batch_activities as (
        SELECT
            dfba.entity_id,
            dfba.entity_name,
            dfba.layer_id,
            dfba.layer_nk,
            dfba.client_field,
            dfba.extraction_type,
            dfba.update_mode,
            dfba.pk_field_names,
            dfba.axbi_database_name,
            dfba.axbi_schema_name,
            dfba.base_table_name,
            dfba.axbi_date_field_name,
            dfba.adls_container_name,
            dfba.base_schema_name,
            dfba.base_sproc_name,
            deba.directory_path,
            dfba.file_name,
            dfba.activity_id,
            deba.run_id,
            deba.batch_id,
            deba.start_date_time,
            deba.status_id,
            deba.output
        from scheduled_delta_entity_batch_activities dfba
        -- left JOIN
        --     scheduled_source_entities e
        --     on
        --         e.entity_id = dfba.entity_id
        left JOIN
            successful_delta_file_name_batch_activities deba
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
            adls_directory_path_In,
            adls_directory_path_Out,
            base_schema_name,
            base_sproc_name,
            -- directory_path,
            file_name,
            activity_id,
            run_id,
            batch_id,
            start_date_time,
            status_id,
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
            null as adls_directory_path_In, --TODO
            null as adls_directory_path_Out,
            base_schema_name,
            base_sproc_name,
            -- directory_path,
            file_name,
            activity_id,
            run_id,
            batch_id,
            start_date_time,
            status_id,
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
            sepba.adls_directory_path_In,
            sepba.adls_directory_path_Out,
            sepba.[base_schema_name],
            sepba.[base_sproc_name],
            -- sepba.directory_path,
            sepba.file_name,
            sepba.activity_id,
            ba.activity_nk,
            ba.activity_order,
            sepba.run_id,
            sepba.batch_id,
            sepba.start_date_time,
            sepba.status_id,
            case
                when sepba.output is null then '{}'
                else sepba.output
            end as output,
            case
                when sepba.status_id = 2 -- Succeeded
                then 0 else 1 
            end as [isRequired]
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
            adls_directory_path_In,
            adls_directory_path_Out,
            base_schema_name,
            base_sproc_name,
            -- directory_path,
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
            adls_directory_path_In,
            adls_directory_path_Out,
            base_schema_name,
            base_sproc_name,
            -- directory_path,
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
        -- directory_path,
        -- MAX(file_name) as 
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
        adls_directory_path_In,--TODO
        adls_directory_path_Out,
        [base_schema_name],
        [base_sproc_name]
        ,
        -- directory_path,
        file_name

    -- select * from get_scheduled_full_entity_batch_activities(@adhoc, @date)

    -- union all

    -- select * from get_scheduled_delta_entity_batch_activities(@adhoc, @date)
GO
