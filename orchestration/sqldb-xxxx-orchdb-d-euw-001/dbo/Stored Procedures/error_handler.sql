CREATE PROCEDURE [dbo].[error_handler] 
    @run_id [UNIQUEIDENTIFIER] = NULL,
    @category varchar(25) = 'InternalError',
    @entity_id [bigint] = NULL,
    @batch_id UNIQUEIDENTIFIER = NULL,   
    @pbi_dataset_id      [bigint] = NULL,                    
    @isADF bit = 1
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE
        @ErrMsgRes nvarchar(4000),
        @ErrorMessage nvarchar(4000),
        @ErrorSeverity tinyint,
        @ErrorState tinyint,
        @ErrorNumber int,
        @ErrorProcedure sysname,
        @LineNumber int

    SELECT 
        @ErrorMessage = ERROR_MESSAGE()
    ,   @ErrorSeverity = ERROR_SEVERITY()
    ,   @ErrorState = ERROR_STATE()
    ,   @ErrorNumber = ERROR_NUMBER()
    ,   @ErrorProcedure = ERROR_PROCEDURE()
    ,   @LineNumber = error_line();

    IF @ErrorMessage NOT LIKE ' *** Error:%'
        BEGIN
            SET @ErrMsgRes = ' *** Error: '
            +   CHAR(13) + CHAR(10) 
            +   'Procedure: ' + coalesce(quotename(@ErrorProcedure), '< SQL>') 
            +   ', ErrorState: ' + ltrim(str(@ErrorState))
            +   ', ErrorSeverity: ' + ltrim(str(@ErrorSeverity))
            +   '. ErrorNumber: ' + ltrim(str(@ErrorNumber))
            +   ', ErrorLine: ' + ltrim(str(@LineNumber))
            +   CHAR(13) + CHAR(10) 
            +   'ErrorMessage: ' + @ErrorMessage + ' *** '
                               
        END

    --if @isADF = 1
    EXECUTE [dbo].[log_exception] @run_id=@run_id, @category=@category, @entity_id=@entity_id, @batch_id=@batch_id, @error_msg=@ErrMsgRes, @pbi_dataset_id=@pbi_dataset_id;
    THROW 51000, @ErrMsgRes, 1;
END

