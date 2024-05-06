CREATE PROCEDURE [tc.utilities.vw_ColNamesString].[test vw_ColNamesString.col_names]
AS
BEGIN

  -- Act:
  DECLARE
    @actual NVARCHAR(MAX) = (
      SELECT
        col_names
      FROM [utilities].[vw_ColNamesString]
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
      '[t_filePath],'
      + CHAR(13) + CHAR(10) +
      '[t_lastActionBy],'
      + CHAR(13) + CHAR(10) +
      '[t_lastActionCd],'
      + CHAR(13) + CHAR(10) +
      '[t_lastActionDtm]';

  -- Assert
  EXEC tSQLt.AssertEqualsString @expected, @actual;
END