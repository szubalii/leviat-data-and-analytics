CREATE PROCEDURE [tc.edw.vw_fact_MaterialInventoryStockLevel].[test stock level]
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
    ('2024-01-14', 2024, 202402, 202401, '2024-01-01'),
    ('2024-01-15', 2024, 202403, 202401, '2024-01-01'),
    ('2024-01-16', 2024, 202403, 202401, '2024-01-01'),
    ('2024-01-17', 2024, 202403, 202401, '2024-01-01'),
    ('2024-01-18', 2024, 202403, 202401, '2024-01-01'),
    ('2024-01-19', 2024, 202403, 202401, '2024-01-01'),
    ('2024-01-20', 2024, 202403, 202401, '2024-01-01'),
    ('2024-01-21', 2024, 202403, 202401, '2024-01-01'),
    ('2024-01-22', 2024, 202404, 202401, '2024-01-01'),
    ('2024-01-23', 2024, 202404, 202401, '2024-01-01'),
    ('2024-01-24', 2024, 202404, 202401, '2024-01-01'),
    ('2024-01-25', 2024, 202404, 202401, '2024-01-01'),
    ('2024-01-26', 2024, 202404, 202401, '2024-01-01'),
    ('2024-01-27', 2024, 202404, 202401, '2024-01-01'),
    ('2024-01-28', 2024, 202404, 202401, '2024-01-01'),
    ('2024-01-29', 2024, 202405, 202401, '2024-01-01'),
    ('2024-01-30', 2024, 202405, 202401, '2024-01-01'),
    ('2024-01-31', 2024, 202405, 202401, '2024-01-01'),
    ('2024-02-01', 2024, 202405, 202402, '2024-02-01');

  INSERT INTO edw.fact_MaterialDocumentItem (
    [MaterialID]
  , [PlantID]
  , [StorageLocationID]
  , [InventorySpecialStockTypeID]
  , [InventoryStockTypeID]
  , [StockOwner]
  , [CostCenterID]
  , [CompanyCodeID]
  , [MaterialBaseUnitID]
  , [InventoryValuationTypeID]
  , [HDR_PostingDate]
  , [MatlStkChangeQtyInBaseUnit]
  , [t_applicationId]
  )
  VALUES
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-08',  10, 's4h-cap-100'),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-22',  20, 's4h-cap-100'),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-22', -10, 's4h-cap-100'),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-29',  20, 's4h-cap-100'),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-02-01',  20, 's4h-cap-100');

  -- Act: 
  SELECT
    [MaterialID],
    [YearMonth],
    [YearWeek],
    [StockLevelQtyInBaseUnit]
  INTO actual
  FROM [edw].[vw_fact_MaterialInventoryStockLevel]

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;
  
  INSERT INTO expected (
    [MaterialID],
    [YearMonth],
    [YearWeek],
    [StockLevelQtyInBaseUnit]
  )
  VALUES
    (1, 202401, 202402, 10),
    (1, 202401, 202403, 10),
    (1, 202401, 202404, 20),
    (1, 202401, 202405, 40),
    (1, 202402, 202405, 60);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
