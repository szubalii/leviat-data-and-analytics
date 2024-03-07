CREATE PROCEDURE [tc.utilities.vw_NonLastActionColNamesString].[test vw_NonLastActionColNamesString.non_lastAction_col_names]
AS
BEGIN

  -- Act:
  DECLARE
    @actual NVARCHAR(MAX) = (
      SELECT
        non_lastAction_col_names
      FROM [utilities].[vw_NonLastActionColNamesString]
      WHERE table_name = '_active' and schema_name = 'base_s4h_cax'
    ),
    @expected NVARCHAR(MAX) = 
      '[PrimaryKeyField_1],'
      + CHAR(13) + CHAR(10) +
      '[PrimaryKeyField_2],'
      + CHAR(13) + CHAR(10) +
      '[NonPrimaryKeyField_1],'
      + CHAR(13) + CHAR(10) +
      '[t_applicationId],'
      + CHAR(13) + CHAR(10) +
      '[t_jobId],'
      + CHAR(13) + CHAR(10) +
      '[t_jobDtm],'
      + CHAR(13) + CHAR(10) +
      '[t_jobBy],'
      + CHAR(13) + CHAR(10) +
      '[t_extractionDtm],'
      + CHAR(13) + CHAR(10) +
      '[t_filePath]';

  -- Assert
  EXEC tSQLt.AssertEqualsString @expected, @actual;
END