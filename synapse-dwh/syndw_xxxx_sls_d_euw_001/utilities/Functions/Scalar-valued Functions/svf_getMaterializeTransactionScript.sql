CREATE FUNCTION [utilities].[svf_getMaterializeTransactionScript](
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

-- This script is used in sp_materialize_view and handles
-- the materialization of the provided source view output into the 
-- provided destination table.
  DECLARE @insert_script NVARCHAR(MAX) = N'
BEGIN TRANSACTION

DELETE FROM [' + @DestSchema + '].[' + @DestTable + '];

BEGIN TRY
  INSERT INTO [' + @DestSchema + '].[' + @DestTable + '](' + @Columns + ',t_jobId,t_jobDtm,t_lastActionCd,t_jobBy)
SELECT ' + @Columns + '
,	''' + @t_jobId + ''' AS t_jobId
,	''' + CONVERT(NVARCHAR(23), @t_jobDtm, 121) + ''' AS t_jobDtm
,	''' + @t_lastActionCd + ''' AS t_lastActionCd
,	''' + @t_jobBy + ''' AS t_jobBy
FROM [' + @SourceSchema + '].[' + @SourceView + '];
END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;

  THROW 50001, ''Failed to materialize data from [' + @SourceSchema + '].[' + @SourceView + '] into [' + @DestSchema + '].[' + @DestTable + ']'', 1;
END CATCH;

IF @@TRANCOUNT > 0
  COMMIT TRANSACTION';

  RETURN(@insert_script);
END;
