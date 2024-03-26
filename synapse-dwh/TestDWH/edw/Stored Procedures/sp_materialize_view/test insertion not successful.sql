CREATE PROCEDURE [tc.edw.sp_materialize_view].[test insertion not successful]
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

  INSERT INTO [edw].[dim_test]
  VALUES (0, 'test', 'jobId', '2024-03-20', 'I', 'mpors');

  DECLARE
    @DestSchema NVARCHAR(128) = 'edw',
    @DestTable NVARCHAR(128) = 'dim_test',
    @SourceSchema NVARCHAR(128) = 'edw',
    @SourceView NVARCHAR(128) = 'vw_TestFailMaterialize',
    @t_jobId VARCHAR(36) = '1',
    @t_jobDtm DATETIME = '2024-03-26',
    @t_lastActionCd VARCHAR(1) = 'I',
    @t_jobBy NVARCHAR(128) = 'system_user';

  -- EXEC tSQLt.ExpectException @Message = 'Failed to materialize data from [edw].[vw_TestFailMaterialize] into [edw].[dim_test]', @ExpectedErrorNumber = 50001, @ExpectedState = 1;

  BEGIN TRY
    EXEC edw.sp_materialize_view
      @SourceSchema,
      @SourceView,
      @DestSchema,
      @DestTable,
      @t_jobId,
      @t_jobDtm,
      @t_lastActionCd,
      @t_jobBy;
  END TRY
  BEGIN CATCH
  
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
      (0, 'test', 'jobId', '2024-03-20', 'I', 'mpors');

    EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

    DROP TABLE [edw].[dim_test];
  END CATCH

END

-- drop table  edw.dim_test

-- select * from edw.dim_test
-- select * from #edw_dim_test


-- IF OBJECT_ID('tempdb..#edw_dim_test') IS NOT NULL
--   DROP TABLE [#edw_dim_test];

-- SELECT *
-- INTO [#edw_dim_test]
-- FROM [edw].[dim_test];

-- TRUNCATE TABLE [edw].[dim_test]

-- DECLARE @Columns NVARCHAR(MAX) = (
--       SELECT
--         non_t_job_col_names
--       FROM
--         utilities.vw_MaterializeColumnList
--       WHERE
--         table_name = 'dim_test'
--         AND
--         schema_name = 'edw'
--     );

-- select @Columns

-- BEGIN TRY
--   INSERT INTO [edw].[dim_test](
--     [id],
--     [t_applicationId],t_jobId,t_jobDtm,t_lastActionCd,t_jobBy
--   )
--   SELECT
--     [id],
--     [t_applicationId]
--   ,	'1' AS t_jobId
--   ,	'2024-03-26 00:00:00.000' AS t_jobDtm
--   ,	'I' AS t_lastActionCd
--   ,	'system_user' AS t_jobBy
--   FROM [edw].[vw_TestFailMaterialize];
-- END TRY
-- BEGIN CATCH
--   TRUNCATE TABLE [edw].[dim_test];

--   INSERT INTO [edw].[dim_test]
--   SELECT *
--   FROM [#edw_dim_test];
-- END CATCH;

-- select OBJECT_ID('edw.vw_SalesOffice', 'V')


-- SELECT 1 
-- FROM sys.views
-- JOIN sys.[schemas]
--   ON sys.views.schema_id = sys.[schemas].schema_id
-- WHERE 
--   sys.[schemas].name = 'edw'
--   AND
--   sys.views.name = 'vw_TestMaterialize'
--   AND
--   sys.views.type = 'v'