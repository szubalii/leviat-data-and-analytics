CREATE PROCEDURE [dbo].[update_batch_status]
	@batch_id UNIQUEIDENTIFIER,
	@status VARCHAR(50) = NULL,
	@size_bytes BIGINT = NULL,
	@file_path NVARCHAR(250) = NULL,
    @directory_path NVARCHAR(250) = NULL,
	@file_name NVARCHAR(250) = NULL,
	@run_id UNIQUEIDENTIFIER = NULL,
	@entity_id BIGINT = NULL,
	@end_date_time DATETIME = NULL,
	@output NVARCHAR(MAX) = NULL

AS
BEGIN
    DECLARE @status_id BIGINT = NULL;
    DECLARE @error_str VARCHAR(250) = ''
    DECLARE @update_set_str NVARCHAR(4000) = ''
    DECLARE @status_id_str NVARCHAR(4000)
    DECLARE @size_bytes_str NVARCHAR(4000)
    DECLARE @file_path_str NVARCHAR(4000)
    DECLARE @directory_path_str NVARCHAR(4000)
    DECLARE @file_name_str NVARCHAR(4000)
    DECLARE @end_date_time_str NVARCHAR(4000)
    DECLARE @output_str NVARCHAR(4000)
	DECLARE @sql_str NVARCHAR(4000) = ''
	DECLARE @params NVARCHAR(500) = N'
        @status_id BIGINT,
        @batch_id UNIQUEIDENTIFIER,
        @file_path NVARCHAR(250),
        @directory_path NVARCHAR(250),
        @file_name NVARCHAR(250),
        @end_date_time DATETIME,
        @size_bytes BIGINT,
		@output NVARCHAR(MAX)'

    BEGIN TRY

		IF (@status IS NOT NULL)
		BEGIN
			SELECT @status_id = [status_id] FROM [dbo].[batch_execution_status] where [status_nk] = @status
			IF (@status_id IS NULL)
				SET @error_str = N'Status ' + @status + ' is not allowed.'
		END

        IF (@batch_id IS NULL)
            SET @error_str = @error_str + N'Batch_Id for entity_id: ' + ltrim(str(@entity_id)) + ', run_id: ' + convert(nvarchar(50), @run_id) + '  is not listed in the batch table.' + CHAR(13) + CHAR(10)

		IF @error_str != ''
			THROW 51001, @error_str, 1


		SET	@sql_str = 'UPDATE [dbo].[batch] SET '

        IF @status_id IS NOT NULL
			SET @status_id_str = '[status_id] = @status_id'

		IF @size_bytes IS NOT NULL
			SET @size_bytes_str = '[size_bytes] = @size_bytes'

		If @file_path IS NOT NULL
			SET @file_path_str = '[file_path] = @file_path'

        If @directory_path IS NOT NULL
			SET @directory_path_str = '[directory_path] = @directory_path'
        
        If @file_name IS NOT NULL
			SET @file_name_str = '[file_name] = @file_name'

	    IF @end_date_time IS NOT NULL
			SET @end_date_time_str = '[end_date_time] = @end_date_time'

        IF @output IS NOT NULL
            SET @output_str = '[output] = @output'

        SET @update_set_str = CONCAT_WS(', ', @status_id_str,
            @size_bytes_str,
            @file_path_str,
            @directory_path_str,
            @file_name_str,
            @end_date_time_str,
            @output_str
        )

		SET @sql_str = @sql_str + @update_set_str + ' WHERE [batch_id] = @batch_id'

		EXEC sp_executesql
            @sql_str,
            @params,
            @status_id = @status_id,
            @batch_id = @batch_id,
            @size_bytes = @size_bytes,
            @file_path = @file_path,
            @directory_path = @directory_path,
            @file_name = @file_name,
            @end_date_time=@end_date_time,
            @output=@output

    END TRY
    BEGIN CATCH
		exec dbo.[error_handler] @run_id = @run_id,  @batch_id = @batch_id, @entity_id = @entity_id;
		THROW 50001, 'Caught Error in Catch', 1
    END CATCH
END
GO
