CREATE FUNCTION [utilities].[svf_getMaterializeTempScript](
  @DestSchema NVARCHAR(128),
  @DestTable NVARCHAR(128)
)

RETURNS NVARCHAR(MAX)
AS
BEGIN
  SET @create_tmp_script = N'
    IF OBJECT_ID(''tempdb..#' + @DestSchema + '.' + @DestTable + ']'') IS NOT NULL
      DROP TABLE [tempdb..#' + @DestSchema + '.' + @DestTable + '];
    
    SELECT *
    INTO [tempdb..#' + @DestSchema + '.' + @DestTable + ']
    FROM [' + @DestSchema + '].[' + @DestTable + '];
    GO;

    TRUNCATE TABLE [' + @DestSchema + '].[' + @DestTable + ']';

  RETURN(@create_tmp_script);
END;
