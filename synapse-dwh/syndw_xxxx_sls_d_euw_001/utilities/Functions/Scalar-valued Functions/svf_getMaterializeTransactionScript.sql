CREATE FUNCTION [utilities].[svf_getMaterializeTransactionScript](
  @DestSchema NVARCHAR(128),
  @DestTable NVARCHAR(128),
  @SourceSchema NVARCHAR(128),
  @SourceView NVARCHAR(128),
  -- @Columns NVARCHAR(MAX),
  -- @DeleteBeforeInsert BIT,
	@t_jobId VARCHAR(36),
	@t_jobDtm DATETIME,
	@t_lastActionCd VARCHAR(1),
	@t_jobBy NVARCHAR(128)
)

RETURNS NVARCHAR(MAX)
AS
BEGIN

/*
  This script is used in sp_materialize_view and handles
  the materialization of the provided source view output into the 
  provided destination table.

  Start a transaction so in case of failures, deletion of records is rolled back.

  This also makes sure that the distribution type and indexes of the original table is kept

  Additional doc about transaction use in SQL Pool:
  https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-develop-transactions#transaction-state
*/
  -- Retrieve the column list by selecting those columns that exist both in the source view as in the destination table
  DECLARE @Columns NVARCHAR(MAX) = (
    SELECT
      STRING_AGG( '[' + CAST(vc.COLUMN_NAME AS NVARCHAR(MAX)) + ']', ',' + CHAR(13) + CHAR(10))
        WITHIN GROUP ( ORDER BY vc.ORDINAL_POSITION ) AS column_names
    FROM
      INFORMATION_SCHEMA.COLUMNS vc
    INNER JOIN
      INFORMATION_SCHEMA.COLUMNS tc
      ON
        tc.TABLE_NAME = @DestTable
        AND
        tc.TABLE_SCHEMA = @DestSchema
        AND
        vc.TABLE_NAME = @SourceView
        AND
        vc.TABLE_SCHEMA = @SourceSchema
        AND
        tc.COLUMN_NAME = vc.COLUMN_NAME
    WHERE
      tc.COLUMN_NAME NOT IN ('t_jobId', 't_jobDtm', 't_lastActionCd', 't_jobBy')
  );

  DECLARE @insert_script NVARCHAR(MAX) = N'
BEGIN TRANSACTION;

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

  DECLARE @error_msg NVARCHAR(MAX) = (SELECT COALESCE(ERROR_MESSAGE(), ''''));
  DECLARE @error_msg2 NVARCHAR(MAX) = ''Failed to materialize data for [' + @SourceSchema + '].[' + @SourceView + '] into [' + @DestSchema + '].[' + @DestTable + ']:'' + CHAR(13) + CHAR(10) + @error_msg;

  THROW 50001, @error_msg2, 1;
END CATCH;

IF @@TRANCOUNT > 0
  COMMIT TRANSACTION;';

  RETURN(@insert_script);
END;
