CREATE PROCEDURE [dbo].[change_status_pipeline_log] @status varchar(50),
                                                    @end_date_time datetime,
                                                    @run_id UNIQUEIDENTIFIER,
                                                    @message nvarchar(max)
AS
BEGIN
    declare @status_id BIGINT = Null
    declare @error_str varchar(250) = ''

    BEGIN TRY

        select @status_id = [status_id] from [dbo].[pipeline_execution_status] where [status_nk] = @status
        if (@status_id is Null)
            set @error_str = N'Status ' + @status + ' is not allowed.' + CHAR(13) + CHAR(10)

        IF (@error_str != '')
            THROW 51001, @error_str, 1;

        update [dbo].[pipeline_log]
        set [status_id]     = @status_id,
            [end_date_time] = @end_date_time,
            [message]       = @message
        where [run_id] = @run_id;

    END TRY
    BEGIN CATCH
        exec dbo.[error_handler] @run_id = @run_id;
        THROW 50001, 'Caught Error in Catch', 1
    END CATCH
end;