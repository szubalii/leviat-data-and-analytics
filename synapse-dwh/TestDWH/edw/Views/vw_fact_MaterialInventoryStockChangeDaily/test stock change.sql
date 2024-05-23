CREATE PROCEDURE [tc.edw.vw_fact_MaterialInventoryStockChangeDaily].[test stock change]
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
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-11',  20, 's4h-cap-100'),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-11', -10, 's4h-cap-100'),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-12',  20, 's4h-cap-100'),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-13',  20, 's4h-cap-100');

  -- Act: 
  SELECT
    [MaterialID],
    [CalendarDate],
    [MatlStkChangeQtyInBaseUnit]
  INTO actual
  FROM [edw].[vw_fact_MaterialInventoryStockChangeDaily]

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;
  
  INSERT INTO expected (
    [MaterialID],
    [CalendarDate],
    [MatlStkChangeQtyInBaseUnit]
  )
  VALUES
    (1, '2024-01-08',   10),
    (1, '2024-01-09', NULL),
    (1, '2024-01-10', NULL),
    (1, '2024-01-11',   10),
    (1, '2024-01-12',   20),
    (1, '2024-01-13',   20),
    (1, '2024-01-14', NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
