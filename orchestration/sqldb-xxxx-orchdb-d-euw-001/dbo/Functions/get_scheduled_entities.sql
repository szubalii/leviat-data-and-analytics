CREATE FUNCTION [dbo].[get_scheduled_entities](
    @adhoc bit = 0,
    @date DATE
)
RETURNS @schedule_entities_table TABLE
(
    [entity_id]                 BIGINT NOT NULL
    ,[entity_name]              VARCHAR(112)
    ,[layer_id]                 BIGINT NOT NULL
    ,[layer_nk]                 VARCHAR (50) NOT NULL
    ,[location_nk]              VARCHAR (50) NOT NULL
    ,[adls_container_name]      VARCHAR(63)
    ,[adls_directory_path_In]   NVARCHAR(255)
    ,[adls_directory_path_Out]  NVARCHAR(255)
    ,[data_category]            VARCHAR(9)
    ,[client_field]             VARCHAR(127)
    ,[tool_name]                VARCHAR(8)
    ,[extraction_type]          VARCHAR(5)
    ,[update_mode]              VARCHAR(5)
    ,[base_schema_name]         VARCHAR(128)
    ,[base_table_name]          VARCHAR(112)
    ,[base_sproc_name]          VARCHAR(128)
    ,[axbi_database_name]       VARCHAR(128)
    ,[axbi_schema_name]         VARCHAR(128)
    ,[axbi_date_field_name]     VARCHAR(128)
    ,[sproc_schema_name]        VARCHAR(128)
    ,[sproc_name]               VARCHAR(128)
    ,[source_schema_name]       VARCHAR(128)
    ,[source_view_name]         VARCHAR(128)
    ,[dest_schema_name]         VARCHAR(128)
    ,[dest_table_name]          VARCHAR(112)
    ,[execution_order]          INT
    ,[schedule_recurrence]      VARCHAR(5)
    ,[schedule_start_date]      DATETIME
    ,[pk_field_names]           VARCHAR(MAX)
    ,[schedule_day]             INT
    ,[last_batch_id]            UNIQUEIDENTIFIER
    ,[last_run_status]          VARCHAR (50)
    ,[last_run_date]            DATETIME
    ,[last_run_activity]        VARCHAR (50)
    ,[file_path]                VARCHAR (250)
    ,[directory_path]           VARCHAR (250)
    ,[file_name]                VARCHAR (250)
)
AS
BEGIN

    DECLARE @day_of_month INT = DAY(@date);
    DECLARE @day_of_week INT = DATEPART(dw, @date);

    WITH baseDirPath AS (
        SELECT
            entity_id,
            layer_nk,
            CASE
                WHEN l.[layer_nk] = 'S4H'
                THEN CONCAT_WS('/',
                    e.[data_category],
                    e.[entity_name],
                    e.[tool_name],
                    e.[extraction_type],
                    e.[update_mode]
                )
                ELSE [entity_name]
            END AS baseDirPath
        FROM [dbo].[entity] e
        LEFT JOIN [dbo].[layer] l
            ON l.layer_id = e.layer_id
    )

    INSERT INTO @schedule_entities_table
    SELECT
         ent.[entity_id]
        ,ent.[entity_name]
        ,ent.[layer_id]
        ,ent.[layer_nk]
        ,ent.[location_nk]
        ,ent.[adls_container_name]
        ,baseDirPath.baseDirPath + '/In/' + FORMAT(@date, 'yyyy/MM/dd', 'en-US') AS adls_directory_path_In
        ,baseDirPath.baseDirPath + '/Out/' + FORMAT(@date, 'yyyy/MM/dd', 'en-US') AS adls_directory_path_Out
        ,ent.[data_category]
        ,ent.[client_field]
        ,ent.[tool_name]
        ,ent.[extraction_type]
        ,ent.[update_mode]
        ,ent.[base_schema_name]
        ,ent.[base_table_name]
        ,ent.[base_sproc_name]
        ,ent.[axbi_database_name]
        ,ent.[axbi_schema_name]
        ,ent.[axbi_date_field_name]
        ,ent.[sproc_schema_name]
        ,ent.[sproc_name]
        ,ent.[source_schema_name]
        ,ent.[source_view_name]
        ,ent.[dest_schema_name]
        ,ent.[dest_table_name]
        ,ent.[execution_order]
        ,ent.[schedule_recurrence]
        ,ent.[schedule_start_date]
        ,ent.[pk_field_names]
        ,ent.[schedule_day]
        ,ent.[last_batch_id]
        ,ent.[last_run_status]
        ,ent.[last_run_date]
        ,ent.[last_run_activity]
        ,ent.[file_path]
        ,ent.[directory_path]
        ,ent.[file_name]
    FROM
       [dbo].[vw_get_entity_status] ent
    LEFT JOIN
        baseDirPath
        ON
            baseDirPath.entity_id = ent.entity_id
    WHERE (
        -- Daily load is only executed on workdays.

        -- Account for situations where entities need to run at beginning or end of the month
        -- and these days are in the weekend.
        ent.[schedule_recurrence] = 'D'
        OR
        (
            ent.[schedule_recurrence] = 'A'
            AND
            @adhoc = 1
        )
        OR (
            ent.[schedule_recurrence] = 'W'
            AND
            [schedule_day] = @day_of_week
        )
        OR (
            ent.[schedule_recurrence] = 'M'
            AND (
                [schedule_day] = @day_of_month
                -- Beginning of month (schedule_day = 1) and
                -- first day of month falls in weekend
                OR (
                    [schedule_day] = 1
                    AND
                    @day_of_month IN (2, 3)
                    AND
                    @day_of_week = 2 --Monday
                )
                -- End of month (schedule_day = 0) and
                -- last day of month falls in weekend
                OR (
                    [schedule_day] = 0
                    AND (
                        @day_of_month = DAY(EOMONTH(@date))
                        OR (
                            @day_of_week = 2 --Monday
                            AND
                            @day_of_month IN (1, 2)
                        )
                    )
                )
            )
        )
    )
    RETURN;
END