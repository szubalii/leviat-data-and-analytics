CREATE PROCEDURE [tc.dm_sales.vw_dim_Calendar].[test date filter out before 2021]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_Calendar]';

  INSERT INTO edw.dim_Calendar (CalendarYear)
  VALUES (2020);

  -- Act: 
  SELECT [Year]
  INTO actual
  FROM [dm_sales].[vw_dim_Calendar]
  WHERE [Year] < 2021

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
