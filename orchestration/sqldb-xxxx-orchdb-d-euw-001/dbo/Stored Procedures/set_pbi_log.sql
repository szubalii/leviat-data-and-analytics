CREATE PROCEDURE [dbo].[set_pbi_log]
    @pbi_refresh_guid UNIQUEIDENTIFIER,
    @pbi_dataset_id BIGINT,
    @run_id UNIQUEIDENTIFIER,
    @start_date_time datetime,
    @status nvarchar(50)
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @error_str VARCHAR(250) = '';
	DECLARE @status_id BIGINT = NULL;

    SET @status_id = (SELECT [status_id] FROM [dbo].[execution_status] where [status_nk] = @status);
    IF (@status_id IS NULL)
        SET @error_str += N'Status ' + @status + ' is not allowed.' + CHAR(13) + CHAR(10);

    IF (@error_str != '')
        THROW 51001, @error_str, 1;

    INSERT INTO [dbo].[pbi_log] (
        [pbi_refresh_guid],
        [pbi_dataset_id],
        [run_id],
        [start_date_time],
        [status_id]
    )
    VALUES (
        @pbi_refresh_guid,
        @pbi_dataset_id,
        @run_id,
        @start_date_time,
        @status_id
    );
END;
GO