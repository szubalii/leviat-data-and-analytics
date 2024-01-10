CREATE PROCEDURE [tc.dm_sales.vw_dim_Calendar].[test date filter from 2021]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_Calendar]';

  INSERT INTO edw.dim_Calendar (CalendarYear)
  VALUES (2020), (2021);

  -- Act: 
  SELECT [Year]
  INTO actual
  FROM [dm_sales].[vw_dim_Calendar]

  -- Assert:
  SELECT TOP 0 * INTO expected FROM actual;

  INSERT INTO expected([Year])
  VALUES (2021)

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
