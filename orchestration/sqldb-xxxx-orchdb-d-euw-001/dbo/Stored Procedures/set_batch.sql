CREATE PROCEDURE [dbo].[set_batch]
    @batch_id UNIQUEIDENTIFIER,
    @run_id UNIQUEIDENTIFIER,
    @start_date_time datetime,
    @entity_id BIGINT,
    @status nvarchar(50),
    @activity nvarchar(50),
    @file_path nvarchar(250) = NULL,
    @directory_path nvarchar(250) = NULL,
    @file_name nvarchar(250) = NULL,
    @source_layer varchar(50),
    @target_layer varchar(50),
    @size_bytes BIGINT = NULL,
    @s4h_environment varchar(16) = NULL,
    @s4h_client_id BIGINT = NULL
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @error_str VARCHAR(250) = '';
	DECLARE @status_id BIGINT = NULL;
    DECLARE @activity_id BIGINT = NULL;
	DECLARE @source_layer_id BIGINT;
	DECLARE @target_layer_id BIGINT;

    SET @status_id = (SELECT [status_id] FROM [dbo].[batch_execution_status] where [status_nk] = @status);
    IF (@status_id IS NULL)
        SET @error_str += N'Status ' + @status + ' is not allowed.' + CHAR(13) + CHAR(10);

    SET @activity_id = (SELECT [activity_id] FROM [dbo].[batch_activity] where [activity_nk] = @activity);
    IF (@activity_id IS NULL)
        SET @error_str += @error_str + N'Activity ' + @activity + ' is not allowed.' + CHAR(13) + CHAR(10);

    SET @source_layer_id = (SELECT [layer_id] FROM [dbo].[layer] where [layer_nk] = @source_layer);
    IF (@source_layer_id IS NULL)
        SET @error_str += @error_str + N'Source layer ' + @source_layer + ' is not allowed.' + CHAR(13) + CHAR(10);

    SET @target_layer_id = (SELECT [layer_id] FROM [dbo].[layer] where [layer_nk] = @target_layer);
    IF (@target_layer_id IS NULL)
        SET @error_str += @error_str + N'Target layer ' + @target_layer + ' is not allowed.' + CHAR(13) + CHAR(10);

    IF (@error_str != '')
        THROW 51001, @error_str, 1;

    INSERT INTO [dbo].[batch] (
        [batch_id],
        [run_id],
        [start_date_time],
        [entity_id],
        [status_id],
        [activity_id],
        [source_layer_id],
        [target_layer_id],
        [file_path],
        [directory_path],
        [file_name],
        [size_bytes],
        [s4h_environment],
        [s4h_client_id]
    )
    VALUES (
        @batch_id,
        @run_id,
        @start_date_time,
        @entity_id,
        @status_id,
        @activity_id,
        @source_layer_id,
        @target_layer_id,
        @file_path,
        @directory_path,
        @file_name,
        @size_bytes,
        @s4h_environment,
        @s4h_client_id
    );
END;
GO