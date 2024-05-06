-- Write your own SQL object definition here, and it'll be included in your package.
EXEC tSQLt.NewTestClass 'FailTest';
GO

CREATE PROCEDURE [FailTest].[test failure]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table

  -- Act: 
  SELECT [test]
  INTO actual
  FROM ( SELECT 1 AS [test] ) a

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO
