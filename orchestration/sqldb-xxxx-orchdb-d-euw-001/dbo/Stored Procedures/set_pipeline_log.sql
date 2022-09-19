CREATE   PROCEDURE [dbo].[set_pipeline_log] @pipeline_name varchar(50),
                                                    @status varchar(50),
                                                    @start_date_time datetime,
                                                    @run_id UNIQUEIDENTIFIER,
                                                    @parent_run_id varchar(36),
                                                    @user_name varchar(50) = Null,
                                                    @message nvarchar(max) = Null,
                                                    @parameters nvarchar(max)
AS
begin
    declare @pipeline_id BIGINT = Null;
    declare @status_id BIGINT = Null;
    declare @error_str varchar(250) = '';

    BEGIN TRY

        select @status_id = [status_id] from [dbo].[pipeline_execution_status] where [status_nk] = @status
        if (@status_id is null)
            set @error_str = N'Status ' + @status + ' is not allowed.' + CHAR(13) + CHAR(10)

        select @pipeline_id = [pipeline_id] from [dbo].[pipeline] where [pipeline_name_nk] = @pipeline_name
        if (@pipeline_id is null)
            SET @error_str = @error_str + N'pipeline name ' + @pipeline_name + ' is not allowed.' + CHAR(13) + CHAR(10)

        IF (@error_str != '')
             THROW 51001, @error_str, 1;

        Insert into [dbo].[pipeline_log] 
        (
          [run_id]
        , [parent_run_id]
        , [pipeline_id]
        , [start_date_time]
        , [status_id]
        , [user_name]
        , [message]
        , [parameters]
        )
        values 
        (
              @run_id
            , @parent_run_id
            , @pipeline_id
            , @start_date_time
            , @status_id
            , @user_name
            , @message
            , @parameters
        )
    END TRY
    BEGIN CATCH
		exec dbo.[error_handler] @run_id = @run_id;
        THROW 50001, 'Caught Error in Catch', 1
    END CATCH
end;