CREATE PROCEDURE [tc.edw.sp_materialize_view].[test insertion is successful]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('edw.dim_test') IS NOT NULL DROP TABLE [edw].[dim_test];

  CREATE TABLE [edw].[dim_test](
    [id] INT,
    [field_not_in_view] INT,
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

  EXEC edw.sp_materialize_view
    @SourceSchema,
    @SourceView,
    @DestSchema,
    @DestTable,
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
    [field_not_in_view],
    [t_applicationId],
    [t_jobId],
    [t_jobDtm],
    [t_lastActionCd],
    [t_jobBy]
  )
  VALUES
    (1, NULL, 'test', @t_jobId, @t_jobDtm, @t_lastActionCd, @t_jobBy);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END