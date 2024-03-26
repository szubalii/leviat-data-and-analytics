CREATE FUNCTION [utilities].[svf_getMaterializeTempScript](
  @DestSchema NVARCHAR(128),
  @DestTable NVARCHAR(128)
)

RETURNS NVARCHAR(MAX)
AS
BEGIN
  DECLARE @create_tmp_script NVARCHAR(MAX) = N'
IF OBJECT_ID(''tempdb..#' + @DestSchema + '_' + @DestTable + ''') IS NOT NULL
  DROP TABLE [tempdb..#' + @DestSchema + '_' + @DestTable + '];

SELECT *
INTO [#' + @DestSchema + '_' + @DestTable + ']
FROM [' + @DestSchema + '].[' + @DestTable + '];

TRUNCATE TABLE [' + @DestSchema + '].[' + @DestTable + ']';

  RETURN(@create_tmp_script);
END;
