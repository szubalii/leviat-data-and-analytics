CREATE PROCEDURE [tc.utilities.vw_UpdateScriptWhereClause].[test vw_UpdateScriptWhereClause.update_scrpt_where_clause]
AS
BEGIN
  -- Act:
  DECLARE
    @actual NVARCHAR(MAX) = (
      SELECT
        update_scrpt_where_clause
      FROM [utilities].[vw_UpdateScriptWhereClause]
      WHERE table_name = '_active' and schema_name = 'base_s4h_cax'
    ),
    @expected NVARCHAR(MAX) = 
      '[base_s4h_cax].[_active].[PrimaryKeyField_1] = src.[PrimaryKeyField_1]'
      + CHAR(13) + CHAR(10) + ' AND ' + CHAR(13) + CHAR(10) +
      '[base_s4h_cax].[_active].[PrimaryKeyField_2] = src.[PrimaryKeyField_2]';

  -- Assert
  EXEC tSQLt.AssertEqualsString @expected, @actual;
END