CREATE PROCEDURE [tc.edw.vw_fact_MaterialInventoryAllDays].[test missing days]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_Calendar]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_MaterialDocumentItem]';

  INSERT INTO edw.dim_Calendar (
    CalendarDate,
    CalendarYear,
    YearWeek,
    YearMonth,
    FirstDayOfMonthDate
  )
  VALUES
    ('2024-01-07', 2024, 202401, 202401, '2024-01-01'),
    ('2024-01-08', 2024, 202402, 202401, '2024-01-01'),
    ('2024-01-09', 2024, 202402, 202401, '2024-01-01'),
    ('2024-01-10', 2024, 202402, 202401, '2024-01-01'),
    ('2024-01-11', 2024, 202402, 202401, '2024-01-01'),
    ('2024-01-12', 2024, 202402, 202401, '2024-01-01'),
    ('2024-01-13', 2024, 202402, 202401, '2024-01-01'),
    ('2024-01-14', 2024, 202402, 202401, '2024-01-01');

  INSERT INTO edw.fact_MaterialDocumentItem (
    [HDR_PostingDate],
    [t_applicationId]
  )
  VALUES
    ('2024-01-08', 's4h-cap-100'),
    ('2024-01-12', 's4h-cap-100');

  -- Act: 
  SELECT
    [CalendarDate]
  INTO actual
  FROM [edw].[vw_fact_MaterialInventoryAllDays]

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;
  
  INSERT INTO expected (
    [CalendarDate]
  )
  VALUES
    ('2024-01-08'),
    ('2024-01-09'),
    ('2024-01-10'),
    ('2024-01-11'),
    ('2024-01-12'),
    ('2024-01-13'),
    ('2024-01-14');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
