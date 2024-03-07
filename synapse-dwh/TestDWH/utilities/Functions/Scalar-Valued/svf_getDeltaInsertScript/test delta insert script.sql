CREATE PROCEDURE [tc.utilities.svf_getDeltaInsertScript].[test delta insert script]
AS
BEGIN

  DECLARE
    @schema_name NVARCHAR(128) = 'base_s4h_cax',
    @delta_table_name NVARCHAR(128) = '_delta',
    @active_table_name NVARCHAR(128) = '_active',
    @delta_view_name NVARCHAR(128) = 'vw__delta';

  DECLARE
    @col_names NVARCHAR(MAX) = (
      SELECT
        col_names
      FROM
        utilities.vw_ColNamesString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    ),
    @primary_key_fields NVARCHAR(MAX) = (
      SELECT
        primary_key_col_names
      FROM
        utilities.vw_PrimaryKeyColNamesString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    ),
    @non_lastAction_col_names NVARCHAR(MAX) = (
      SELECT
        non_lastAction_col_names
      FROM
        utilities.vw_NonLastActionColNamesString
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    ),
    @insert_scrpt_where_clause NVARCHAR(MAX) = (
      SELECT
        insert_scrpt_where_clause
      FROM
        utilities.vw_InsertScriptWhereClause
      WHERE
        table_name = @active_table_name
        AND
        schema_name = @schema_name
    ),
    @system_user NVARCHAR(100) = 'TEST_SYSTEM_USER',
    @date_time_string NVARCHAR(23) = '2024-03-01T12:00:00.000'

  DECLARE
    @actual NVARCHAR(MAX) = [utilities].[svf_getDeltaInsertScript](
      @schema_name,
      @active_table_name,
      @delta_view_name,
      @col_names,
      @non_lastAction_col_names,
      @primary_key_fields,
      @insert_scrpt_where_clause,
      @system_user,
      @date_time_string
    ),
    @expected NVARCHAR(MAX) = N'
INSERT INTO
  [base_s4h_cax].[_active] ([PrimaryKeyField_1],'
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
'[t_lastActionDtm]
)
SELECT
  [PrimaryKeyField_1],'
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
'[t_filePath],
  ''TEST_SYSTEM_USER'' AS [t_lastActionBy],
  CASE
    WHEN src.[ODQ_CHANGEMODE] = ''''  AND src.[ODQ_ENTITYCNTR] = 0
      THEN ''I''
    WHEN src.[ODQ_CHANGEMODE] = ''U'' AND src.[ODQ_ENTITYCNTR] = 1
      THEN ''I''
    WHEN src.[ODQ_CHANGEMODE] = ''D'' AND src.[ODQ_ENTITYCNTR] = -1
      THEN ''D''
    WHEN src.[ODQ_CHANGEMODE] = ''C'' AND src.[ODQ_ENTITYCNTR] = 1
      THEN ''I''
  END AS [t_lastActionCd],
  ''2024-03-01T12:00:00.000'' AS [t_lastActionDtm] 
FROM
  [base_s4h_cax].[vw__delta] AS src 
WHERE NOT EXISTS (
  SELECT
    [PrimaryKeyField_1],'
+ CHAR(13) + CHAR(10) +
'[PrimaryKeyField_2]
  FROM
    [base_s4h_cax].[_active] target 
  WHERE
    target.[PrimaryKeyField_1] = src.[PrimaryKeyField_1]'
+ CHAR(13) + CHAR(10) + ' AND ' + CHAR(13) + CHAR(10) +
'target.[PrimaryKeyField_2] = src.[PrimaryKeyField_2]
)';

  EXEC tSQLt.AssertEqualsString @actual, @expected;

END