CREATE PROCEDURE [tc.utilities.vw_PrimaryKeyColNamesString].[test vw_PrimaryKeyColNamesString.primary_key_col_names]
AS
BEGIN
  -- Act:
  DECLARE
    @actual NVARCHAR(MAX) = (
      SELECT
        primary_key_col_names
      FROM [utilities].[vw_PrimaryKeyColNamesString]
      WHERE table_name = '_active' and schema_name = 'base_s4h_cax'
    ),
    @expected NVARCHAR(MAX) = 
      '[PrimaryKeyField_1],'
      + CHAR(13) + CHAR(10) +
      '[PrimaryKeyField_2]';

  -- Assert
  EXEC tSQLt.AssertEqualsString @expected, @actual;
END