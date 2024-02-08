CREATE PROCEDURE [tc.utilities.vw_PrimaryKeyFields].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Act:
  SELECT
    column_id,
    col_name
  INTO actual
  FROM [utilities].[vw_PrimaryKeyFields]
  WHERE OBJECT_NAME(object_id) = 'active'

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    [column_id],
    [col_name]
  )
  VALUES
    (1, 'PrimaryKeyField_1'),
    (2, 'PrimaryKeyField_2');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
