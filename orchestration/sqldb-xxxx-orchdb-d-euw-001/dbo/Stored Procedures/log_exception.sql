CREATE PROCEDURE [dbo].[log_exception] 
    @run_id UNIQUEIDENTIFIER
,   @category varchar(50)
,   @entity_id BIGINT
,   @batch_id UNIQUEIDENTIFIER = Null
,   @error_msg NVARCHAR(MAX)
,   @pbi_dataset_id BIGINT = Null
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @category_id BIGINT = NULL;
	DECLARE @is_batch_id BIT = 0;
    DECLARE @error_str VARCHAR(250) = '';

    SET @category_id = (SELECT [error_category_id] FROM [dbo].[error_category] WHERE [category_nk] = @category);
    IF (@category_id IS NULL)
        SET @error_str += N'Category ' + @category + ' is not listed in the error_category table.' + CHAR(13) + CHAR(10);

    -- IF @batch_id IS NOT NULL AND NOT EXISTS(SELECT [batch_id] FROM [dbo].[batch] WHERE [batch_id] = @batch_id)
    --     SET @error_str += N'Batch with batch_id = ' + convert(nvarchar(36), @batch_id) + ' is not listed in the batches table.' + CHAR(13) + CHAR(10);

    IF @error_str != ''
        THROW 51001, @error_str, 1;

    INSERT INTO [dbo].[exception] ([run_id], [error_category_id], [entity_id], [batch_id], [error_message], [pbi_dataset_id])
    VALUES (@run_id, @category_id, @entity_id, @batch_id, @error_msg, @pbi_dataset_id);
END;