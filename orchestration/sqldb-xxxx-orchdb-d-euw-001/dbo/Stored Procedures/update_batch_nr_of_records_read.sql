CREATE   PROCEDURE [dbo].[update_batch_nr_of_records_read] @batch_id UNIQUEIDENTIFIER,
                                                                  @row_count BIGINT
AS
BEGIN
    UPDATE [dbo].[batch] SET [nr_of_records_read]=@row_count WHERE [batch_id] = @batch_id;
END;