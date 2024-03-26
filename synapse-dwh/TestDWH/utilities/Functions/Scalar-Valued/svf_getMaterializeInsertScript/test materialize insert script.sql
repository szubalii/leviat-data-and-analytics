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
  GO;

  CREATE VIEW [edw].[vw_test]
  AS
  SELECT
    1 AS [id],
    'test' AS [t_applicationId];
  GO;

  DECLARE
    @DestSchema NVARCHAR(128) = 'edw',
    @DestTable NVARCHAR(128) = 'dim_test',
    @SourceSchema NVARCHAR(128) = 'edw',
    @SourceView NVARCHAR(128) = 'vw_test',
    @t_jobId VARCHAR(36) = '1',
    @t_jobDtm DATETIME = '2024-03-26',
    @t_lastActionCd VARCHAR(1) = 'I',
    @t_jobBy NVARCHAR(128) = 'system_user';

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
  INSERT INTO 
    [edw].[dim_test]([int],'
      + CHAR(13) + CHAR(10) +
      '[t_applicationId],t_jobId,t_jobDtm,t_lastActionCd,t_jobBy) 
  SELECT 
      [int],'
      + CHAR(13) + CHAR(10) +
      '[t_applicationId]
  ,	''1'' AS t_jobId
  ,	''2024-03-26'' AS t_jobDtm
  ,	''I'' AS t_lastActionCd
  ,	''system_user'' AS t_jobBy
  FROM 
    [edw].[vw_test]
END TRY
BEGIN CATCH
  TRUNCATE TABLE [edw].[dim_test];

  INSERT INTO
    [edw].[dim_test]
  SELECT
    *
  FROM
    [tempdb..#edw.dim_test] 
END CATCH';

  -- TODO include where clause where extraction DTm is higher in delta vw than active

  EXEC tSQLt.AssertEqualsString @actual, @expected;

  DROP TABLE [edw].[dim_test];
  DROP VIEW [edw].[vw_test];


END
