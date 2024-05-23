CREATE PROCEDURE [tc.edw.vw_fact_MaterialInventoryReportedStockChangeDaily].[test daily stock change]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_Calendar]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_MaterialDocumentItem]';

  INSERT INTO edw.dim_Calendar (
    CalendarDate,
    YearWeek,
    YearMonth,
    FirstDayOfMonthDate
  )
  VALUES
    ('2024-01-07', 202401, 202401, '2024-01-01'),
    ('2024-01-08', 202402, 202401, '2024-01-01'),
    ('2024-01-09', 202402, 202401, '2024-01-01'),
    ('2024-01-10', 202402, 202401, '2024-01-01'),
    ('2024-01-11', 202402, 202401, '2024-01-01'),
    ('2024-01-12', 202402, 202401, '2024-01-01'),
    ('2024-01-13', 202402, 202401, '2024-01-01'),
    ('2024-01-14', 202402, 202401, '2024-01-01');

  INSERT INTO edw.fact_MaterialDocumentItem (
    [HDR_PostingDate]
  , [MatlStkChangeQtyInBaseUnit]
  , [t_applicationId]
  )
  VALUES
    ('2024-01-08',  10, 's4h-cap-100'),
    ('2024-01-12',  20, 's4h-cap-100'),
    ('2024-01-12', -10, 's4h-cap-100'),
    ('2024-01-13',  20, 's4h-cap-100');

  -- Act: 
  SELECT
    [HDR_PostingDate],
    [MatlStkChangeQtyInBaseUnit]
  INTO actual
  FROM [edw].[vw_fact_MaterialInventoryReportedStockChangeDaily]

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;
  
  INSERT INTO expected (
    [HDR_PostingDate],
    [MatlStkChangeQtyInBaseUnit]
  )
  VALUES
    ('2024-01-08', 10),
    ('2024-01-12', 10),
    ('2024-01-13', 20);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
