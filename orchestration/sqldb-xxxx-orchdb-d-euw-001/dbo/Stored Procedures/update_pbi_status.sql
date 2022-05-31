CREATE PROCEDURE [dbo].[update_pbi_status] 
	@pbi_refresh_guid UNIQUEIDENTIFIER,
  @pbi_dataset_id BIGINT,
	@status VARCHAR(50),
	@run_id UNIQUEIDENTIFIER,
	@end_date_time DATETIME,
  @message NVARCHAR (4000)

AS
BEGIN
    DECLARE @status_id BIGINT = NULL;
    DECLARE @error_str VARCHAR(250) = '';
	  DECLARE @sql_str NVARCHAR(4000) = '';
	  DECLARE @params NVARCHAR(500) = N'
        @status_id BIGINT,
        @pbi_refresh_guid UNIQUEIDENTIFIER,
        @pbi_dataset_id BIGINT,
        @message NVARCHAR(4000),
        @end_date_time DATETIME';

    BEGIN TRY

		IF (@status IS NOT NULL)
		BEGIN
			SELECT @status_id = [status_id] FROM [dbo].[execution_status] where [status_nk] = @status
			IF (@status_id IS NULL)
				SET @error_str = N'Status ' + @status + ' is not allowed.'
		END

    IF (@pbi_refresh_guid IS NULL)
      SET @error_str = @error_str + N'Refresh_guid for pbi_dataset_id: ' + ltrim(str(@pbi_dataset_id)) + ', run_id: ' + convert(nvarchar(50), @run_id) + '  is not listed in the pbi refresh table.' + CHAR(13) + CHAR(10)

		IF @error_str != ''
			THROW 51001, @error_str, 1;

    IF @pbi_dataset_id IS NOT NULL
			SET @sql_str = @sql_str + 'UPDATE [dbo].[pbi_log] SET [pbi_dataset_id] = @pbi_dataset_id'

		IF @status_id IS NOT NULL
			SET @sql_str = @sql_str + ', [status_id] = @status_id'

	  IF @end_date_time IS NOT NULL
			SET @sql_str = @sql_str + ', [end_date_time] = @end_date_time';

    IF @message IS NOT NULL
			SET @sql_str = @sql_str + ', [message] = @message';

		SET @sql_str = @sql_str + ' WHERE [pbi_refresh_guid] = @pbi_refresh_guid ';

		EXEC sp_executesql 
            @sql_str,
            @params,
            @status_id = @status_id,
            @end_date_time = @end_date_time,
            @pbi_refresh_guid = @pbi_refresh_guid,
            @pbi_dataset_id = @pbi_dataset_id,
            @message = @message

    END TRY

    BEGIN CATCH
		exec dbo.[error_handler] @run_id = @run_id, @pbi_dataset_id = @pbi_dataset_id ;
		THROW 50001, 'Caught Error in Catch', 1
    END CATCH
END;
GO