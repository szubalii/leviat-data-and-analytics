CREATE PROCEDURE [tc.utilities.vw_MaterializeColumnList].[test vw_MaterializeColumnList.non_t_job_col_names]
AS
BEGIN

  -- Act:
  DECLARE
    @actual NVARCHAR(MAX) = (
      SELECT
        non_t_job_col_names
      FROM [utilities].[vw_MaterializeColumnList]
      WHERE view_name = 'vw_materialize_test' and schema_name = 'edw'
    ),
    @expected NVARCHAR(MAX) =
      '[id],'
      + CHAR(13) + CHAR(10) +
      '[t_applicationId]';

  -- Assert
  EXEC tSQLt.AssertEqualsString @expected, @actual;
END