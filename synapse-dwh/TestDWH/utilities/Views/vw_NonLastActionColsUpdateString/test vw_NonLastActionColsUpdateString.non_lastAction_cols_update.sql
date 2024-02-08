CREATE PROCEDURE [tc.utilities.vw_NonLastActionColsUpdateString].[test vw_NonLastActionColsUpdateString.non_lastAction_cols_update]
AS
BEGIN
  -- Act:
  DECLARE
    @actual NVARCHAR(MAX) = (
      SELECT
        non_lastAction_cols_update
      FROM [utilities].[vw_NonLastActionColsUpdateString]
      WHERE table_name = '_active' and schema_name = 'base_s4h_cax'
    ),
    @expected NVARCHAR(MAX) = 
      '[base_s4h_cax].[_active].[PrimaryKeyField_1] = src.[PrimaryKeyField_1],'
      + CHAR(13) + CHAR(10) +
      '[base_s4h_cax].[_active].[PrimaryKeyField_2] = src.[PrimaryKeyField_2],'
      + CHAR(13) + CHAR(10) +
      '[base_s4h_cax].[_active].[NonPrimaryKeyField_1] = src.[NonPrimaryKeyField_1],'
      + CHAR(13) + CHAR(10) +
      '[base_s4h_cax].[_active].[t_applicationId] = src.[t_applicationId],'
      + CHAR(13) + CHAR(10) +
      '[base_s4h_cax].[_active].[t_jobId] = src.[t_jobId],'
      + CHAR(13) + CHAR(10) +
      '[base_s4h_cax].[_active].[t_jobDtm] = src.[t_jobDtm],'
      + CHAR(13) + CHAR(10) +
      '[base_s4h_cax].[_active].[t_jobBy] = src.[t_jobBy],'
      + CHAR(13) + CHAR(10) +
      '[base_s4h_cax].[_active].[t_extractionDtm] = src.[t_extractionDtm],'
      + CHAR(13) + CHAR(10) +
      '[base_s4h_cax].[_active].[t_filePath] = src.[t_filePath]';

  -- Assert
  EXEC tSQLt.AssertEqualsString @expected, @actual;
END