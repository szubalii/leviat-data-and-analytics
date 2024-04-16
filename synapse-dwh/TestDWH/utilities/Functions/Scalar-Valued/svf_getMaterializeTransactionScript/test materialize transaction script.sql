CREATE PROCEDURE [tc.utilities.svf_getMaterializeTransactionScript].[test materialize transaction script]
AS
BEGIN

  IF OBJECT_ID('edw.dim_test') IS NOT NULL DROP TABLE [edw].[dim_test];

  CREATE TABLE [edw].[dim_test](
    [id] INT,
    [t_applicationId] VARCHAR(32),
    [t_jobId] VARCHAR(36),
    [t_jobDtm] DATETIME,
    [t_lastActionCd] VARCHAR(1),
    [t_jobBy] NVARCHAR(128)
  );

  DECLARE
    @DestSchema NVARCHAR(128) = 'edw',
    @DestTable NVARCHAR(128) = 'dim_test',
    @SourceSchema NVARCHAR(128) = 'edw',
    @SourceView NVARCHAR(128) = 'vw_TestMaterialize',
    @t_jobId VARCHAR(36) = '1',
    @t_jobDtm DATETIME = '2024-03-26',
    @t_lastActionCd VARCHAR(1) = 'I',
    @t_jobBy NVARCHAR(128) = 'system_user';

  -- DECLARE @Columns NVARCHAR(MAX) = (
  --   SELECT
  --     STRING_AGG( '[' + CAST(vc.COLUMN_NAME AS NVARCHAR(MAX)) + ']', ',' + CHAR(13) + CHAR(10))
  --       WITHIN GROUP ( ORDER BY vc.ORDINAL_POSITION ) AS column_names
  --   FROM
  --     INFORMATION_SCHEMA.COLUMNS vc
  --   INNER JOIN
  --     INFORMATION_SCHEMA.COLUMNS tc
  --     ON
  --       tc.TABLE_NAME = @DestTable
  --       AND
  --       tc.TABLE_SCHEMA = @DestSchema
  --       AND
  --       vc.TABLE_NAME = @SourceView
  --       AND
  --       vc.TABLE_SCHEMA = @SourceSchema
  --       AND
  --       tc.COLUMN_NAME = vc.COLUMN_NAME
  -- );

  DECLARE
    @actual NVARCHAR(MAX) = [utilities].[svf_getMaterializeTransactionScript](
      @DestSchema,
      @DestTable,
      @SourceSchema,
      @SourceView,
      -- @Columns,
      @t_jobId,
      @t_jobDtm,
      @t_lastActionCd,
      @t_jobBy
    ),
    @expected NVARCHAR(MAX) = N'
BEGIN TRANSACTION;

DELETE FROM [edw].[dim_test];

BEGIN TRY
  INSERT INTO [edw].[dim_test]([id],'
    + CHAR(13) + CHAR(10) +
    '[t_applicationId],t_jobId,t_jobDtm,t_lastActionCd,t_jobBy)
SELECT [id],'
  + CHAR(13) + CHAR(10) +
  '[t_applicationId]
,	''1'' AS t_jobId
,	''2024-03-26 00:00:00.000'' AS t_jobDtm
,	''I'' AS t_lastActionCd
,	''system_user'' AS t_jobBy
FROM [edw].[vw_TestMaterialize];
END TRY
BEGIN CATCH

  IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;

  DECLARE @error_msg NVARCHAR(MAX) = (SELECT COALESCE(ERROR_MESSAGE(), ''''));
  DECLARE @error_msg2 NVARCHAR(MAX) = ''Failed to materialize data for [edw].[vw_TestMaterialize] into [edw].[dim_test]:'' + CHAR(13) + CHAR(10) + @error_msg;

  THROW 50001, @error_msg2, 1;
END CATCH;

IF @@TRANCOUNT > 0
  COMMIT TRANSACTION;';

  EXEC tSQLt.AssertEqualsString @expected, @actual;

  DROP TABLE [edw].[dim_test];


END
