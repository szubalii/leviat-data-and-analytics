CREATE PROCEDURE [tc.edw.vw_fact_MaterialInventoryReportedStockChangeWeekly].[test weekly stock change]
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
  , [StorageLocationID]
  , [InventorySpecialStockTypeID]
  , [InventoryStockTypeID]
  , [StockOwner]
  , [CostCenterID]
  , [CompanyCodeID]
  , [SalesDocumentTypeID]
  , [SalesDocumentItemCategoryID]
  , [MaterialBaseUnitID]
  , [PurchaseOrderTypeID]
  , [InventoryValuationTypeID]
  , [HDR_PostingDate]
  , [MatlStkChangeQtyInBaseUnit]
  , [t_applicationId]
  )
  VALUES
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-08', 1, 10),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-22', 1, 20),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-22', 1, -10),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-01-29', 1, 20);

  -- Act: 
  SELECT
    [MaterialID],
    [PlantID],
    [StorageLocationID],
    [InventorySpecialStockTypeID],
    [InventoryStockTypeID],
    [StockOwner],
    [CostCenterID],
    [CompanyCodeID],
    [SalesDocumentTypeID],
    [SalesDocumentItemCategoryID],
    [MaterialBaseUnitID],
    [PurchaseOrderTypeID],
    [InventoryValuationTypeID],
    [YearWeek],
    [WeeklyMatlStkChangeQtyInBaseUnit]
  INTO actual
  FROM [edw].[vw_fact_MaterialInventoryReportedStockChangeWeekly]
  WHERE YearWeek <= 202405

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;
  
  INSERT INTO expected (
    [MaterialID],
    [PlantID],
    [StorageLocationID],
    [InventorySpecialStockTypeID],
    [InventoryStockTypeID],
    [StockOwner],
    [CostCenterID],
    [CompanyCodeID],
    [SalesDocumentTypeID],
    [SalesDocumentItemCategoryID],
    [MaterialBaseUnitID],
    [PurchaseOrderTypeID],
    [InventoryValuationTypeID],
    [YearWeek],
    [WeeklyMatlStkChangeQtyInBaseUnit]
  )
  VALUES
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 202402, 10),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 202404, 10),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 202405, 20);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
