CREATE PROCEDURE [tc.utilities.svf_getMaterializeInsertScript].[test materialize insert script]
AS
BEGIN

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

  DECLARE @Columns NVARCHAR(MAX) = (
    SELECT
      non_t_job_col_names
    FROM
      utilities.vw_MaterializeColumnList
    WHERE
      table_name = @DestTable
      AND
      schema_name = @DestSchema
  );

  DECLARE
    @actual NVARCHAR(MAX) = [utilities].[svf_getMaterializeInsertScript](
      @DestSchema,
      @DestTable,
      @SourceSchema,
      @SourceView,
      @Columns,
      @t_jobId,
      @t_jobDtm,
      @t_lastActionCd,
      @t_jobBy
    ),
    @expected NVARCHAR(MAX) = N'
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
  TRUNCATE TABLE [edw].[dim_test];

  INSERT INTO [edw].[dim_test]
  SELECT *
  FROM [#edw_dim_test];

  THROW 50001, ''Failed to materialize data from [edw].[vw_TestMaterialize] into [edw].[dim_test]'', 1;
END CATCH';

  -- TODO include where clause where extraction DTm is higher in delta vw than active

  EXEC tSQLt.AssertEqualsString @expected, @actual;

  DROP TABLE [edw].[dim_test];


END
