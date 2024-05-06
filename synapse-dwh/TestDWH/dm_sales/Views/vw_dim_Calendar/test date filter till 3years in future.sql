CREATE PROCEDURE [tc.dm_sales.vw_dim_Calendar].[test date filter till 3years in future]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_Calendar]';

  DECLARE @currentYear INT = YEAR(GETDATE());

  INSERT INTO edw.dim_Calendar (CalendarYear)
  VALUES (@currentYear);
  INSERT INTO edw.dim_Calendar (CalendarYear)
  VALUES (@currentYear+1); 
  INSERT INTO edw.dim_Calendar (CalendarYear)
  VALUES (@currentYear+2);
  INSERT INTO edw.dim_Calendar (CalendarYear)
  VALUES (@currentYear+3);
  INSERT INTO edw.dim_Calendar (CalendarYear)
  VALUES (@currentYear+4);

  -- Act: 
  SELECT [Year]
  INTO actual
  FROM [dm_sales].[vw_dim_Calendar]
  WHERE [Year] >= @currentYear+4

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
