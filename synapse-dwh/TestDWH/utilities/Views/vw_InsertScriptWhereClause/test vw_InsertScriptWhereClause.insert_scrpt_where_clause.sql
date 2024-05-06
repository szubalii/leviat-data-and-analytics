CREATE PROCEDURE [tc.utilities.vw_InsertScriptWhereClause].[test vw_InsertScriptWhereClause.insert_scrpt_where_clause]
AS
BEGIN

  -- Act:
  DECLARE
    @actual NVARCHAR(MAX) = (
      SELECT
        insert_scrpt_where_clause
      FROM [utilities].[vw_InsertScriptWhereClause]
      WHERE table_name = '_active' and schema_name = 'base_s4h_cax'
    ),
    @expected NVARCHAR(MAX) = 
      'target.[PrimaryKeyField_1] = src.[PrimaryKeyField_1]'
      + CHAR(13) + CHAR(10) + ' AND ' + CHAR(13) + CHAR(10) +
      'target.[PrimaryKeyField_2] = src.[PrimaryKeyField_2]';

  -- Assert
  EXEC tSQLt.AssertEqualsString @expected, @actual;
END