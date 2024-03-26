CREATE PROCEDURE [tc.edw.sp_materialize_view].[test insertion is successful]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

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

  EXEC edw.sp_materialize_view
    @DestSchema,
    @DestTable,
    @SourceSchema,
    @SourceView,
    @t_jobId,
    @t_jobDtm,
    @t_lastActionCd,
    @t_jobBy;
  
  -- Act: 
  SELECT
    *
  INTO actual
  FROM [edw].[dim_test];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    [id],
    [t_applicationId],
    [t_jobId],
    [t_jobDtm],
    [t_lastActionCd],
    [t_jobBy]
  )
  VALUES
    (1, 'test', @t_jobId, @t_jobDtm, @t_lastActionCd, @t_jobBy);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

  DROP TABLE [edw].[dim_test];
  DROP VIEW [edw].[vw_test];

END