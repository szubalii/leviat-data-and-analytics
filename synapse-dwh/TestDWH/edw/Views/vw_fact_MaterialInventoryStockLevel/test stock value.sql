CREATE PROCEDURE [tc.edw.vw_fact_MaterialInventoryStockLevel].[test stock value]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_Calendar]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_MaterialDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ProductValuationPUP]';

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
    ('2024-01-14', 202402, 202401, '2024-01-01'),
    ('2024-01-15', 202403, 202401, '2024-01-01'),
    ('2024-01-16', 202403, 202401, '2024-01-01'),
    ('2024-01-17', 202403, 202401, '2024-01-01'),
    ('2024-01-18', 202403, 202401, '2024-01-01'),
    ('2024-01-19', 202403, 202401, '2024-01-01'),
    ('2024-01-20', 202403, 202401, '2024-01-01'),
    ('2024-01-21', 202403, 202401, '2024-01-01'),
    ('2024-01-22', 202404, 202401, '2024-01-01'),
    ('2024-01-23', 202404, 202401, '2024-01-01'),
    ('2024-01-24', 202404, 202401, '2024-01-01'),
    ('2024-01-25', 202404, 202401, '2024-01-01'),
    ('2024-01-26', 202404, 202401, '2024-01-01'),
    ('2024-01-27', 202404, 202401, '2024-01-01'),
    ('2024-01-28', 202404, 202401, '2024-01-01'),
    ('2024-01-29', 202405, 202401, '2024-01-01'),
    ('2024-01-30', 202405, 202401, '2024-01-01'),
    ('2024-01-31', 202405, 202401, '2024-01-01'),
    ('2024-02-01', 202405, 202402, '2024-02-01');

  INSERT INTO edw.fact_MaterialDocumentItem (
    [MaterialID]
  , [PlantID]
  , [InventoryValuationTypeID]
  , [HDR_PostingDate]
  , [MatlStkChangeQtyInBaseUnit]
  , [t_applicationId]
  )
  VALUES
    (1, 1, 1, '2024-01-08',  10, 's4h-cap-100'),
    (1, 1, 1, '2024-01-22',  20, 's4h-cap-100'),
    (1, 1, 1, '2024-01-22', -10, 's4h-cap-100'),
    (1, 1, 1, '2024-01-29',  20, 's4h-cap-100'),
    (1, 1, 1, '2024-02-01',  20, 's4h-cap-100');

  INSERT INTO edw.dim_ProductValuationPUP (
    ProductID,
    ValuationAreaID,
    ValuationTypeID,
    FirstDayOfMonthDate,
    StockPricePerUnit,
    StockPricePerUnit_EUR,
    StockPricePerUnit_USD
  )
  VALUES
    (1, 1, 1, '2024-01-01', 10, 15, 20),
    (1, 1, 1, '2024-02-01', 11, 16, 21);

  -- Act: 
  SELECT
    [MaterialID],
    [PlantID],
    [InventoryValuationTypeID],
    [YearWeek],
    [YearMonth],
    [StockLevelQtyInBaseUnit],
    [StockLevelStandardPPU],
    [StockLevelStandardPPU_EUR],
    [StockLevelStandardPPU_USD]
  INTO actual
  FROM [edw].[vw_fact_MaterialInventoryStockLevel]
  WHERE
    YearWeek <= 202405
    OR
    YearMonth <= 202402

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;
  
  INSERT INTO expected (
    [MaterialID],
    [PlantID],
    [InventoryValuationTypeID],
    [YearWeek],
    [YearMonth],    
    [StockLevelQtyInBaseUnit],
    [StockLevelStandardPPU],
    [StockLevelStandardPPU_EUR],
    [StockLevelStandardPPU_USD]
  )
  VALUES
    (1, 1, 1,   NULL, 202401,   40,  400,  600,  800),
    (1, 1, 1,   NULL, 202402,   60,  660,  960, 1260),
    (1, 1, 1, 202402,   NULL,   10,  100,  150,  200),
    (1, 1, 1, 202403,   NULL,   10,  100,  150,  200),
    (1, 1, 1, 202404,   NULL,   20,  200,  300,  400),
    (1, 1, 1, 202405,   NULL,   60,  600,  900, 1200);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;