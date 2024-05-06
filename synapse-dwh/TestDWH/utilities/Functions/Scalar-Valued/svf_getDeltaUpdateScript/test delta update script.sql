CREATE PROCEDURE [tc.utilities.svf_getDeltaUpdateScript].[test delta update script]
AS
BEGIN

  DECLARE
    @schema_name NVARCHAR(128) = 'base_s4h_cax',
    @delta_table_name NVARCHAR(128) = '_delta',
    @active_table_name NVARCHAR(128) = '_active',
    @delta_view_name NVARCHAR(128) = 'vw__delta';

  DECLARE
    @non_lastAction_cols_update NVARCHAR(MAX) = (
      SELECT
        non_lastAction_cols_update
      FROM
        utilities.vw_NonLastActionColsUpdateString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    ),
    @update_scrpt_where_clause NVARCHAR(MAX) = (
      SELECT
        update_scrpt_where_clause
      FROM
        utilities.vw_UpdateScriptWhereClause
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    ),
    @system_user NVARCHAR(100) = 'TEST_SYSTEM_USER',
    @date_time_string NVARCHAR(23) = '2024-03-01T12:00:00.000'

  DECLARE
    @actual NVARCHAR(MAX) = [utilities].[svf_getDeltaUpdateScript](
      @schema_name,
      @active_table_name,
      @delta_view_name,
      @non_lastAction_cols_update,
      @update_scrpt_where_clause,
      @system_user,
      @date_time_string
    ),
    @expected NVARCHAR(MAX) = N'
UPDATE
  [base_s4h_cax].[_active] 
SET
  [base_s4h_cax].[_active].[PrimaryKeyField_1] = src.[PrimaryKeyField_1],'
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
  '[base_s4h_cax].[_active].[t_filePath] = src.[t_filePath],
  [base_s4h_cax].[_active].[t_lastActionBy] = ''TEST_SYSTEM_USER'',
  [base_s4h_cax].[_active].[t_lastActionCd] = (
    CASE
      WHEN src.[ODQ_CHANGEMODE] = ''U'' AND src.[ODQ_ENTITYCNTR] =  1 THEN ''U''
      WHEN src.[ODQ_CHANGEMODE] = ''D'' AND src.[ODQ_ENTITYCNTR] = -1 THEN ''D''
      WHEN src.[ODQ_CHANGEMODE] = '''' AND src.[ODQ_ENTITYCNTR] =  0 THEN ''U''
      WHEN src.[ODQ_CHANGEMODE] = ''C'' AND src.[ODQ_ENTITYCNTR] = 1 THEN ''U''
    END
  ),
  [base_s4h_cax].[_active].[t_lastActionDtm] = ''2024-03-01T12:00:00.000'' 
FROM
  [base_s4h_cax].[vw__delta] as src 
WHERE
  [base_s4h_cax].[_active].[PrimaryKeyField_1] = src.[PrimaryKeyField_1]'
  + CHAR(13) + CHAR(10) + ' AND ' + CHAR(13) + CHAR(10) +
  '[base_s4h_cax].[_active].[PrimaryKeyField_2] = src.[PrimaryKeyField_2]'
  + CHAR(13) + CHAR(10) + ' AND ' + CHAR(13) + CHAR(10) +
  '[base_s4h_cax].[_active].[t_extractionDtm] < src.[t_extractionDtm]';

  -- TODO include where clause where extraction DTm is higher in delta vw than active

  EXEC tSQLt.AssertEqualsString @actual, @expected;

END