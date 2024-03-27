CREATE PROCEDURE [tc.utilities.vw_MaterializeColumnList].[test vw_MaterializeColumnList.non_t_job_col_names]
AS
BEGIN

  CREATE TABLE [edw].[dim_table] (
    [id] INT,
    [t_applicationId] VARCHAR(32),
    [t_jobId] VARCHAR(36),
    [t_jobDtm] DATETIME,
    [t_lastActionCd] VARCHAR(1),
    [t_jobBy] NVARCHAR(128)
  )

  -- Act:
  DECLARE
    @actual NVARCHAR(MAX) = (
      SELECT
        non_t_job_col_names
      FROM [utilities].[vw_MaterializeColumnList]
      WHERE table_name = 'dim_table' and schema_name = 'edw'
    ),
    @expected NVARCHAR(MAX) =
      '[id],'
      + CHAR(13) + CHAR(10) +
      '[t_applicationId]';

  -- Assert
  EXEC tSQLt.AssertEqualsString @expected, @actual;

  DROP TABLE [edw].[dim_table];
END