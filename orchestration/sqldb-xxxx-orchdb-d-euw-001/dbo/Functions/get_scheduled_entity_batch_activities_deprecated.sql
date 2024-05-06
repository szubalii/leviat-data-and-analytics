-- Write your own SQL object definition here, and it'll be included in your package.
-- drop function [dbo].[get_scheduled_entity_batch_activities]
CREATE FUNCTION [dbo].[get_scheduled_entity_batch_activities_deprecated](
    @adhoc bit = 0,
    @date DATE,
    @rerunSuccessfulFullEntities BIT = 0 -- In case a new run is required
    -- for full entities that have a successful run for the day already, set it to 1
)
RETURNS @scheduled_entity_batch_activities TABLE (
    entity_id BIGINT NOT NULL,
    entity_name VARCHAR(122),
    layer_nk VARCHAR(50),
    update_mode VARCHAR(5),
    client_field VARCHAR(127),
    extraction_type VARCHAR(5),
    pk_field_names VARCHAR(MAX),
    axbi_database_name VARCHAR(128),
    axbi_schema_name VARCHAR(128),
    base_table_name VARCHAR(128),
    axbi_date_field_name VARCHAR(128),
    adls_container_name VARCHAR(63),
    adls_directory_path_In NVARCHAR(255),
    adls_directory_path_Out NVARCHAR(255),
    base_schema_name VARCHAR(128),
    base_sproc_name VARCHAR(128),
    file_name VARCHAR(250),
    required_activities VARCHAR(MAX),
    skipped_activities VARCHAR(MAX)
) 
AS
BEGIN

    --Scenario 1: no batches done on new day
    --return complete list of scheduled entities, cross join with batch activity

    --Scenario 2: load already happened on same day
    --check which batch activities failed or did not happen and return them for corresponding scheduled entities
    
    -- declare @adhoc bit = 0, @date DATE = '2022/05/27', @rerunSuccessfulFullEntities BIT = 0;

    -- TODO
    -- When a specific activity (e.g. TestDuplicates) has NULL for file_name, but is failed, 
    -- and subsequent activities are successful with file_name value filled, 
    -- the function get_scheduled_entity_batch_activities will return TestDuplicates for required, 
    -- but the subsequent for skipped.

    DECLARE
        @BATCH_ACTIVITY_ID__EXTRACT SMALLINT = 21,
        @BATCH_ACTIVITY_ID__TEST_DUPLICATES SMALLINT = 19,
        @BATCH_ACTIVITY_ID__PROCESS_BASE SMALLINT = 15,
        @BATCH_ACTIVITY_ID__LOAD2BASE SMALLINT = 2,
        @BATCH_EXECUTION_STATUS_ID__IN_PROGRESS SMALLINT = 1,
        @BATCH_EXECUTION_STATUS_ID__SUCCESSFUL SMALLINT = 2,
        @LAYER_ID__AXBI SMALLINT = 5,
        @LAYER_ID__S4H SMALLINT = 6,
        @LAYER_ID__USA SMALLINT = 7,
        @LAYER_ID__C4C SMALLINT = 8;

    WITH
    -- -- get the scheduled entities based on the day
    scheduled_source_entities AS (
        SELECT
            e.entity_id,
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
            e.adls_directory_path_In,
            e.adls_directory_path_Out,
            e.base_schema_name,
            e.base_sproc_name,
            e.file_name
        FROM
            dbo.get_scheduled_entities(@adhoc, @date) e
        WHERE
            e.layer_id IN (@LAYER_ID__AXBI, @LAYER_ID__S4H, @LAYER_ID__USA,@LAYER_ID__C4C)
    )
    -- get the scheduled full entity batch activities
    , scheduled_full_entity_batch_activities AS (
        SELECT
            e.entity_id,
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
            e.adls_directory_path_In,
            e.adls_directory_path_Out,
            e.base_schema_name,
            e.base_sproc_name,
            e.file_name,
            la.activity_id
        FROM
            scheduled_source_entities e
        LEFT JOIN
            dbo.layer_activity la
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
        SELECT
            b.entity_id,
            -- b.activity_id,
            MAX(b.file_name) AS file_name 
        FROM
            dbo.batch b
        INNER JOIN
            scheduled_full_entity_batch_activities e
            ON e.entity_id = b.entity_id
        WHERE
            CONVERT(DATE, b.start_date_time) = @date
            AND
            b.activity_id = @BATCH_ACTIVITY_ID__EXTRACT -- Extract
            AND
            (
                (   -- For S4H entities, get all successful or in progress extracted file names 
                    b.status_id IN (@BATCH_EXECUTION_STATUS_ID__IN_PROGRESS, @BATCH_EXECUTION_STATUS_ID__SUCCESSFUL)
                    AND
                    e.layer_id = @LAYER_ID__S4H
                )
                OR ( -- For other base source entities, get only successful extracted file names
                    b.status_id = @BATCH_EXECUTION_STATUS_ID__SUCCESSFUL
                    AND
                    e.layer_id IN (@LAYER_ID__AXBI, @LAYER_ID__USA, @LAYER_ID__C4C)
                )
            )
        GROUP BY
            b.entity_id--,
            -- b.activity_id
    )

    -- join the file name to each scheduled batch activity
    , scheduled_full_entity_batch_activities_file_name AS (
        SELECT
            e.entity_id,
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
            e.adls_directory_path_In,
            e.adls_directory_path_Out,
            e.base_schema_name,
            e.base_sproc_name,
            e.activity_id,
            -- return NULL value for file_name in case successful 
            -- scheduled full entities need to rerun
            CASE
                WHEN @rerunSuccessfulFullEntities = 1
                THEN NULL
                ELSE f.file_name
            END AS file_name
        FROM
            scheduled_full_entity_batch_activities e
        LEFT JOIN
            latest_started_extract_for_day f
            ON
                f.entity_id = e.entity_id
    )

    -- get the latest start_date_time for each logged batch activity
    , logged_batch_activities AS (
        SELECT
            b.entity_id,
            b.activity_id,
            MAX(b.start_date_time) AS start_date_time,
            b.file_name
        FROM
            latest_started_extract_for_day lsefd
        INNER JOIN
            dbo.batch b
            ON
                b.entity_id = lsefd.entity_id
                AND
                b.file_name = lsefd.file_name
        -- LEFT JOIN dbo.batch_activity ba
        --     ON ba.activity_id = b.activity_id
        -- where b.entity_id = 86
        GROUP BY
            b.entity_id,
            b.activity_id,
            b.file_name
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
            b.file_name,
            b.output
        FROM
            logged_batch_activities lba
        INNER JOIN
            dbo.batch b
            ON
                b.entity_id = lba.entity_id
                AND
                b.file_name = lba.file_name
                AND
                b.activity_id = lba.activity_id
                AND
                b.start_date_time = lba.start_date_time
        LEFT JOIN dbo.batch_activity ba
            ON ba.activity_id = b.activity_id
        -- where b.entity_id = 86
    )

    -- get the latest successful logged batch activities up to the first not successful activity
    -- any successful activity after failed activities need to re-run in any case
    , first_failed_activity_order AS (
        SELECT
            entity_id,
            MIN(activity_order) AS activity_order
        FROM 
            latest_logged_batch_activities
        WHERE
            status_id <> @BATCH_EXECUTION_STATUS_ID__SUCCESSFUL -- 'Successful'
        GROUP BY
            entity_id
    )

    -- get the successful batch activities before the first failed batch activity
    , successful_logged_batch_activities_before_failure AS (
        SELECT
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
            (
                llba.activity_order < ffao.activity_order
                OR
                ffao.activity_order IS NULL
            )
            AND
            @rerunSuccessfulFullEntities != 1 -- Only get the statuses if required
            --TODO test
    )

    -- For entities with update_mode = Full,
    -- get the latest start_date_time for each logged batch activity
    -- Logic to getting latest timestamp/file name for where activity = Extract and status = Succeeded, e.g.
    -- in case where logged batch activities for the same day are missing but earlier on the same day subsequent 
    -- activities are logged and succeeded:
    -- 9:00	Extract	        I_Test_2022_04_13_09_00	Succeeded
    -- 8:00	RunXUExtraction	I_Test_2022_04_13_08_00	Succeeded

    -- scheduled full entities with potential batch activities and statuses
    , scheduled_full_entity_potential_batch_activities AS (
        SELECT
            sfeba.entity_id,
            sfeba.entity_name,
            sfeba.layer_id,
            sfeba.layer_nk,
            sfeba.client_field,
            sfeba.extraction_type,
            sfeba.update_mode,
            sfeba.pk_field_names,
            sfeba.axbi_database_name,
            sfeba.axbi_schema_name,
            sfeba.base_table_name,
            sfeba.axbi_date_field_name,
            sfeba.adls_container_name,
            sfeba.adls_directory_path_In,
            sfeba.adls_directory_path_Out,
            sfeba.base_schema_name,
            sfeba.base_sproc_name,
            sfeba.activity_id,
            lslba.batch_id,
            lslba.run_id,
            lslba.start_date_time,
            lslba.status_id,
            sfeba.file_name,
            lslba.output
        FROM
            scheduled_full_entity_batch_activities_file_name sfeba
        LEFT JOIN
            successful_logged_batch_activities_before_failure lslba
            ON 
                lslba.entity_id = sfeba.entity_id
                AND
                lslba.activity_id = sfeba.activity_id
    )
    /*
        For delta entities, for each file name that has been logged, check
        which activities have already run and what the status of the activity is.
        If one of the file name's activity is not successful, its activity needs to rerun,
        and all subsequent file name activities except for extraction need to rerun as well.

        First get all the logged batch activities for the scheduled delta entities incl. statuses.
        Then, get all the unique file names joined to the related activities for that entity layer.
        
        For delta entities, a new extraction will be triggered only if the provided date is the same
        as the current date.

        Multiple delta files for single entity can be loaded into Synapse base layer. In case of failure in one 
        of the file-names batch activities, the rest will continue until whole pipeline is finished. 
        A second run will then again pick up the correct list of file name batch activities. 
        The base table will only be truncated once at the beginning of each main.
        
        TODO Process base as separate step, maybe even separate entity?

        Get all file names based on Extract activity and status is Successful or InProgress
        Get all corresponding batch activities and statuses for the file names

        Check what the first file name is for which there is a non Successful activity.
        For all subsequent file names, the Load2Base activity needs to re-run in any case.
        For all non Successful file names, check which activities were successful before the first non Successful activity
        All subsequent activities for those file names need to re-run.

        TODO what about entities that are not scheduled but do have historic failed activities?

        What about duplicate batch activities for successful Extract, with the earlier succesful and the more recent failed?
        E.g.
        09:00	Extract	                I_Test_2022_04_13_09_00	Succeeded
        10:00	CheckXUExtractionStatus	I_Test_2022_04_13_09_00	Succeeded
        12:00	CheckXUExtractionStatus	I_Test_2022_04_13_09_00	Failed
        Only statuses of latest batch actvities for a specific file name will be processed


    */

    -- Get all scheduled delta entities
    , scheduled_delta_entities AS (
        SELECT
            e.entity_id,
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
            e.adls_directory_path_In,
            e.adls_directory_path_Out,
            e.base_schema_name,
            e.base_sproc_name,
            NULL AS file_name
        FROM
            scheduled_source_entities e
        WHERE
            e.update_mode = 'Delta'
    )

    -- get all potential delta batch activities for the new load
    , scheduled_delta_entity_batch_activities AS (
        SELECT
            sde.entity_id,
            sde.entity_name,
            sde.layer_id,
            sde.layer_nk,
            sde.client_field,
            sde.extraction_type,
            sde.update_mode,
            sde.pk_field_names,
            sde.axbi_database_name,
            sde.axbi_schema_name,
            sde.base_table_name,
            sde.axbi_date_field_name,
            sde.adls_container_name,
            sde.adls_directory_path_In,
            sde.adls_directory_path_Out,
            sde.base_schema_name,
            sde.base_sproc_name,
            sde.file_name,
            la.activity_id
        FROM
            scheduled_delta_entities sde
        LEFT JOIN 
            dbo.layer_activity la
            ON 
                la.layer_id = sde.layer_id
    )
    
    -- For delta entities: get all file names based on Extract activity where status is Successful or InProgress (S4H)
    , successful_extract_file_names_scheduled_delta_entities AS (
        SELECT
            e.entity_id,
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
            dir.base_dir_path + '/In/' + FORMAT(b.start_date_time, 'yyyy/MM/dd', 'en-US') AS adls_directory_path_In,
            dir.base_dir_path + '/Out/' + FORMAT(b.start_date_time, 'yyyy/MM/dd', 'en-US') AS adls_directory_path_Out,
            e.base_schema_name,
            e.base_sproc_name,
            b.file_name
        FROM
            scheduled_delta_entities e
        INNER JOIN 
            dbo.batch b
            ON b.entity_id = e.entity_id
        LEFT JOIN dbo.vw_adls_base_directory_path dir
            ON dir.entity_id = e.entity_id
        WHERE
            (
                (   -- For S4H entities, get all successful or in progress extracted file names 
                    b.status_id IN (@BATCH_EXECUTION_STATUS_ID__IN_PROGRESS, @BATCH_EXECUTION_STATUS_ID__SUCCESSFUL)
                    AND
                    e.layer_id = @LAYER_ID__S4H
                )
                OR ( -- For other base source entities, get only successful extracted file names
                    b.status_id = @BATCH_EXECUTION_STATUS_ID__SUCCESSFUL
                    AND
                    e.layer_id IN (@LAYER_ID__AXBI, @LAYER_ID__USA, @LAYER_ID__C4C)
                )
            )
            AND
            b.activity_id = @BATCH_ACTIVITY_ID__EXTRACT -- Extract
            AND
            CONVERT(DATE, b.start_date_time) <= @date
    )   

    -- get the latest batch activities corresponding to the file names
    -- Aggregate on the max start_date_time for cases of multiple same logged batch activity ids
    , latest_delta_file_name_batch_activities AS (
        SELECT
            sefnsde.entity_id,
            sefnsde.entity_name,
            sefnsde.layer_id,
            sefnsde.layer_nk,
            sefnsde.client_field,
            sefnsde.extraction_type,
            sefnsde.update_mode,
            sefnsde.pk_field_names,
            sefnsde.axbi_database_name,
            sefnsde.axbi_schema_name,
            sefnsde.base_table_name,
            sefnsde.axbi_date_field_name,
            sefnsde.adls_container_name,
            sefnsde.adls_directory_path_In,
            sefnsde.adls_directory_path_Out,
            sefnsde.base_schema_name,
            sefnsde.base_sproc_name,
            sefnsde.file_name,
            la.activity_id,
            ba.activity_order,
            MAX(b.start_date_time) AS start_date_time -- get the latest occurrence in case of multiple batch activities of the same activity_id
        FROM
            successful_extract_file_names_scheduled_delta_entities sefnsde
        LEFT JOIN
            dbo.layer_activity la
            ON
                la.layer_id = sefnsde.layer_id 
        LEFT JOIN
            dbo.batch b
            ON
                b.entity_id = sefnsde.entity_id
                AND
                b.file_name = sefnsde.file_name
                AND
                b.activity_id = la.activity_id
        LEFT JOIN 
            dbo.batch_activity ba
            ON 
                ba.activity_id = la.activity_id
        GROUP BY
            sefnsde.entity_id,
            sefnsde.entity_name,
            sefnsde.layer_id,
            sefnsde.layer_nk,
            sefnsde.client_field,
            sefnsde.extraction_type,
            sefnsde.update_mode,
            sefnsde.pk_field_names,
            sefnsde.axbi_database_name,
            sefnsde.axbi_schema_name,
            sefnsde.base_table_name,
            sefnsde.axbi_date_field_name,
            sefnsde.adls_container_name,
            sefnsde.adls_directory_path_In,
            sefnsde.adls_directory_path_Out,
            sefnsde.base_schema_name,
            sefnsde.base_sproc_name,
            sefnsde.file_name,
            la.activity_id,
            ba.activity_order
    )

    -- Get all potential scheduled entity batch activities
    -- Union the activities to be run for the new load
    -- and those based on successful extracted file names
    , potential_delta_entity_batch_activities AS (
        SELECT
            sde.entity_id,
            sde.entity_name,
            sde.layer_id,
            sde.layer_nk,
            sde.client_field,
            sde.extraction_type,
            sde.update_mode,
            sde.pk_field_names,
            sde.axbi_database_name,
            sde.axbi_schema_name,
            sde.base_table_name,
            sde.axbi_date_field_name,
            sde.adls_container_name,
            sde.adls_directory_path_In,
            sde.adls_directory_path_Out,
            sde.base_schema_name,
            sde.base_sproc_name,
            sde.file_name,
            sde.activity_id
        FROM
            scheduled_delta_entity_batch_activities sde
        WHERE -- Make sure to create new extraction only if provided date equals current date
            @date = CONVERT(DATE, GETUTCDATE())
        
        UNION ALL

        SELECT
            sedfnba.entity_id,
            sedfnba.entity_name,
            sedfnba.layer_id,
            sedfnba.layer_nk,
            sedfnba.client_field,
            sedfnba.extraction_type,
            sedfnba.update_mode,
            sedfnba.pk_field_names,
            sedfnba.axbi_database_name,
            sedfnba.axbi_schema_name,
            sedfnba.base_table_name,
            sedfnba.axbi_date_field_name,
            sedfnba.adls_container_name,
            sedfnba.adls_directory_path_In,
            sedfnba.adls_directory_path_Out,
            sedfnba.base_schema_name,
            sedfnba.base_sproc_name,
            sedfnba.file_name,
            sedfnba.activity_id
        FROM
            latest_delta_file_name_batch_activities sedfnba
    )

    -- Get all corresponding batch activities and statuses for the file names
    , delta_file_name_batch_activity_statuses AS (
        SELECT
            ldfnba.entity_id,
            ldfnba.entity_name,
            ldfnba.layer_id,
            ldfnba.layer_nk,
            ldfnba.client_field,
            ldfnba.extraction_type,
            ldfnba.update_mode,
            ldfnba.pk_field_names,
            ldfnba.axbi_database_name,
            ldfnba.axbi_schema_name,
            ldfnba.base_table_name,
            ldfnba.axbi_date_field_name,
            ldfnba.adls_container_name,
            ldfnba.adls_directory_path_In,
            ldfnba.adls_directory_path_Out,
            ldfnba.base_schema_name,
            ldfnba.base_sproc_name,
            ldfnba.activity_id,
            ldfnba.activity_order,
            ldfnba.file_name,
            ldfnba.start_date_time,
            b.run_id,
            b.batch_id,
            b.status_id,
            b.directory_path,
            -- b.file_name,
            b.output
        FROM
            latest_delta_file_name_batch_activities ldfnba
        LEFT JOIN
            dbo.batch b
            ON
                b.entity_id = ldfnba.entity_id
                AND
                b.file_name = ldfnba.file_name
                AND
                b.activity_id = ldfnba.activity_id
                AND
                b.start_date_time = ldfnba.start_date_time
                AND
                b.start_date_time IS NOT NULL
        -- order by ldfnba.file_name, activity_order
    )

    -- Get the index of the first non successful logged activity for each entity and file_name
    -- Filter out potential Extract activities with status InProgress
    , first_non_successful_delta_file_name_activity AS (
        SELECT
            entity_id,
            file_name,
            MIN(activity_order) AS activity_order
        FROM
            delta_file_name_batch_activity_statuses
        WHERE
            status_id <> @BATCH_EXECUTION_STATUS_ID__SUCCESSFUL
            AND
            activity_id <> @BATCH_ACTIVITY_ID__EXTRACT
        GROUP BY
            entity_id,
            file_name
    )

    -- Check what the first file name is for which there is a non Successful logged activity. 
    , first_non_successful_delta_file_name AS (
        SELECT
            entity_id,
            MIN(file_name) AS file_name
        FROM 
            first_non_successful_delta_file_name_activity
        GROUP BY
            entity_id
    )

    -- get the successful file name batch activities before the first non successful activity
    , successful_delta_file_name_activities_before_failure AS (
        SELECT
            sdfnba.entity_id,
            sdfnba.adls_directory_path_In,
            sdfnba.adls_directory_path_Out,
            sdfnba.directory_path,
            sdfnba.file_name,
            sdfnba.activity_id,
            sdfnba.run_id,
            sdfnba.batch_id,
            sdfnba.start_date_time,
            sdfnba.status_id,
            sdfnba.output
        FROM
            delta_file_name_batch_activity_statuses sdfnba
        LEFT JOIN
            first_non_successful_delta_file_name_activity fffn
            ON
                fffn.entity_id = sdfnba.entity_id
                AND
                fffn.file_name = sdfnba.file_name
        LEFT JOIN
            first_non_successful_delta_file_name fnsdfn
            ON
                fnsdfn.entity_id = sdfnba.entity_id
        WHERE
            (    -- return only those activities whose index are smaller than the first failed activity
                sdfnba.activity_order < fffn.activity_order
                OR
                fffn.activity_order IS NULL -- all batch activities for this file name are successful
            )
            AND
            (
            -- return only those activities whose file name are before the file name with the first
            -- non successful activity OR those activities that are not equal to Load2Base, i.e.
            -- for all file names after the one with the first non successful activity, the Load2Base
            -- activity needs to re-run
                sdfnba.file_name < fnsdfn.file_name
                OR (
                    sdfnba.file_name >= fnsdfn.file_name
                    AND
                    sdfnba.activity_id <> @BATCH_ACTIVITY_ID__LOAD2BASE-- Load2Base
                )
                OR
                fnsdfn.file_name IS NULL -- all batch activities of all file names are successful
            )
    )

    -- Get the potential batch activities for delta entities
    , scheduled_delta_entity_potential_batch_activities AS (
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
            dfba.adls_directory_path_In,
            dfba.adls_directory_path_Out,
            deba.directory_path,
            dfba.file_name,
            dfba.activity_id,
            deba.run_id,
            deba.batch_id,
            deba.start_date_time,
            deba.status_id,
            deba.output
        FROM
            potential_delta_entity_batch_activities dfba
        LEFT JOIN
            successful_delta_file_name_activities_before_failure deba
            ON
                deba.entity_id = dfba.entity_id
                AND
                deba.activity_id = dfba.activity_id
                AND
                deba.file_name = dfba.file_name
        -- order by dfba.entity_id, dfba.file_name, activity_id
    )



    -- union the full and delta entities
    , scheduled_entity_potential_batch_activities AS (
        SELECT
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
            file_name,
            activity_id,
            run_id,
            batch_id,
            start_date_time,
            status_id,
            output  
        FROM
            scheduled_full_entity_potential_batch_activities

        UNION ALL

        SELECT
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
            file_name,
            activity_id,
            run_id,
            batch_id,
            start_date_time,
            status_id,
            output
        FROM
            scheduled_delta_entity_potential_batch_activities
    )
    -- remove the potential batches if for that entity no primary keys and base_procedure is defined
    , scheduled_entity_potential_batch_activities_filtered AS (
        SELECT
            sepba.entity_id,
            sepba.entity_name,
            sepba.layer_id,
            sepba.layer_nk,
            sepba.update_mode,
            sepba.client_field,
            sepba.extraction_type,
            sepba.pk_field_names,
            sepba.axbi_database_name,
            sepba.axbi_schema_name,
            sepba.base_table_name,
            sepba.axbi_date_field_name,
            sepba.adls_container_name,
            sepba.adls_directory_path_In,
            sepba.adls_directory_path_Out,
            sepba.base_schema_name,
            sepba.base_sproc_name,
            -- sepba.directory_path,
            sepba.file_name,
            sepba.activity_id,
            ba.activity_nk,
            ba.activity_order,
            sepba.run_id,
            sepba.batch_id,
            sepba.start_date_time,
            sepba.status_id,
            CASE
                WHEN sepba.output IS NULL THEN '{}'
                ELSE sepba.output
            END AS output,
            CASE
                -- The Extract activity can be skipped if it's already in progress
                -- For other activities they will re-run if still in progress.
                WHEN sepba.activity_id = @BATCH_ACTIVITY_ID__EXTRACT
                THEN
                    CASE 
                        WHEN sepba.status_id IN (@BATCH_EXECUTION_STATUS_ID__IN_PROGRESS, @BATCH_EXECUTION_STATUS_ID__SUCCESSFUL)
                        THEN 0
                        ELSE 1
                    END
                ELSE
                    CASE
                        WHEN sepba.status_id = @BATCH_EXECUTION_STATUS_ID__SUCCESSFUL
                        THEN 0
                        ELSE 1
                    END
            END AS [isRequired]
        FROM
            scheduled_entity_potential_batch_activities sepba
        LEFT JOIN
            [dbo].batch_activity ba
            ON 
                ba.activity_id = sepba.activity_id
        WHERE
            (
                (ba.activity_id = @BATCH_ACTIVITY_ID__TEST_DUPLICATES AND sepba.pk_field_names IS NOT NULL)
                OR
                ba.activity_id != @BATCH_ACTIVITY_ID__TEST_DUPLICATES
            )
            AND
            (
                (ba.activity_id = @BATCH_ACTIVITY_ID__PROCESS_BASE AND sepba.base_sproc_name IS NOT NULL)
                OR
                ba.activity_id != @BATCH_ACTIVITY_ID__PROCESS_BASE
            )
        -- order by entity_id, file_name, activity_order
    )
    , transposed AS (
        SELECT
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
            CONCAT(
                '[',
                CASE
                    WHEN isRequired = 1
                    THEN CONCAT(
                        '"',
                        STRING_AGG(activity_nk, '","') WITHIN GROUP (ORDER BY activity_order ASC),
                        '"'
                    )
                END,
                ']'
            ) AS required_activities,
            CONCAT(
                '{',
                CASE
                    WHEN isRequired = 0
                    THEN STRING_AGG(
                        CONCAT(
                            '"',
                            activity_nk,
                            '": {"batch_id":"',
                            batch_id,
                            '", "output":',
                            output,
                            '}'
                        ),
                        ','
                    ) WITHIN GROUP (ORDER BY activity_order ASC)
                END,
                '}'
            ) AS skipped_activities
        FROM scheduled_entity_potential_batch_activities_filtered
        GROUP BY
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

    -- aggregate to make sure required_activities and skipped_activities
    -- are on a single line for a single file_name
    , transposed_aggregated AS (
        SELECT
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
            MIN(adls_directory_path_In) AS adls_directory_path_In,
            MIN(adls_directory_path_Out) AS adls_directory_path_Out,
            base_schema_name,
            base_sproc_name,
            file_name,
            MIN(required_activities) AS required_activities,
            MIN(skipped_activities) AS skipped_activities
        FROM transposed
        GROUP BY
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
            base_schema_name,
            base_sproc_name,
            file_name
    )

    -- Filter out the file name lines for which there are no required activities,
    -- i.e. all required activities are successful
    , transposed_filtered AS (
        SELECT
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
            file_name,
            required_activities,
            skipped_activities
        FROM
            transposed_aggregated
        WHERE
            required_activities <> '[]'
    )

    INSERT INTO @scheduled_entity_batch_activities
    SELECT
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
        file_name,
        required_activities,
        skipped_activities
    FROM transposed_filtered

    RETURN;
END
GO
