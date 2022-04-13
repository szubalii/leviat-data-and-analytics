CREATE PROCEDURE [utilities].[sp_update_statistics]
    @schema VARCHAR (128)
,   @table  VARCHAR (128)
AS
BEGIN
    DECLARE @update_stats_script NVARCHAR(MAX) = N'
        UPDATE STATISTICS ['+@schema+'].['+@table+']';
    
    EXECUTE sp_executesql @update_stats_script;
END;