CREATE FUNCTION [utilities].[svf_getMaterializeInsertScript](
  @DestSchema NVARCHAR(128),
  @DestTable NVARCHAR(128),
  @SourceSchema NVARCHAR(128),
  @SourceView NVARCHAR(128),
  @Columns NVARCHAR(MAX),
	@t_jobId VARCHAR(36),
	@t_jobDtm DATETIME,
	@t_lastActionCd VARCHAR(1),
	@t_jobBy NVARCHAR(128)
)

RETURNS NVARCHAR(MAX)
AS
BEGIN


  DECLARE @insert_script NVARCHAR(MAX) = N'
BEGIN TRY
  INSERT INTO 
    [' + @DestSchema + '].[' + @DestTable + '](' + @Columns + ',t_jobId,t_jobDtm,t_lastActionCd,t_jobBy) 
  SELECT 
      ' + @Columns + '
  ,	''' + @t_jobId + ''' AS t_jobId
  ,	''' + CONVERT(NVARCHAR(23), @t_jobDtm, 121) + ''' AS t_jobDtm
  ,	''' + @t_lastActionCd + ''' AS t_lastActionCd
  ,	''' + @t_jobBy + ''' AS t_jobBy
  FROM 
    [' + @SourceSchema + '].[' + @SourceView + ']
END TRY
BEGIN CATCH
  TRUNCATE TABLE [' + @DestSchema + '].[' + @DestTable + '];

  INSERT INTO
    [' + @DestSchema + '].[' + @DestTable + ']
  SELECT
    *
  FROM
    [tempdb..#' + @DestSchema + '.' + @DestTable + '] 
END CATCH';

  RETURN(@insert_script);
END;
