CREATE VIEW [edw].[vw_fact_MaterialInventoryStockLevel]
AS

/*
1. Aggregate stock changes on a weekly level
2. Get the first posting date of each hash
3. Get the corresponding year week of the first posting date
4. Add the missing yearWeeks for each hash based on calendar table
5. Include the stock changes for the reported weeks
6. Calculate the stock levels for each combo of yearWeek and hash
7. Calculate the stock level price per unit
*/

-- 6. Calculate the stock levels for each combo of yearWeek and hash
WITH
StockLevels AS (
  SELECT
      -- [_hash]
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
  , [ReportingDate]
  , [YearWeek]
  , [YearMonth]
  -- , [IsWeekly]
  -- , [IsMonthly]
  , [FirstDayOfMonthDate]
  , [MatlStkChangeQtyInBaseUnit]
  , CASE
      WHEN YearWeek IS NOT NULL
      THEN SUM(MatlStkChangeQtyInBaseUnit) OVER (
        PARTITION BY
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
        , [YearMonth]
          ORDER BY YearWeek
        )
      WHEN YearMonth IS NOT NULL
      THEN SUM(MatlStkChangeQtyInBaseUnit) OVER (
        PARTITION BY
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
        , [YearWeek]
          ORDER BY YearMonth
        ) 
    END AS StockLevelQtyInBaseUnit
  -- , [WeeklyMatlStkChangeQtyInBaseUnit]
  -- , CASE
  --     WHEN YearMonth IS NULL
  --     THEN SUM(WeeklyMatlStkChangeQtyInBaseUnit) OVER (
  --       PARTITION BY
  --         [MaterialID]
  --       , [PlantID]
  --       , [StorageLocationID]
  --       , [InventorySpecialStockTypeID]
  --       , [InventoryStockTypeID]
  --       , [StockOwner]
  --       , [CostCenterID]
  --       , [CompanyCodeID]
  --       , [SalesDocumentTypeID]
  --       , [SalesDocumentItemCategoryID]
  --       , [MaterialBaseUnitID]
  --       , [PurchaseOrderTypeID]
  --       , [InventoryValuationTypeID]
  --         ORDER BY YearWeek
  --       )
  --     END AS WeeklyStockLevelQtyInBaseUnit
  FROM
    [edw].[vw_fact_MaterialInventoryStockChange]
)

-- 7. Calculate the stock value by getting the price per unit
SELECT
  StockLevels.[MaterialID]
, StockLevels.[PlantID]
, StockLevels.[StorageLocationID]
, StockLevels.[InventorySpecialStockTypeID]
, StockLevels.[InventoryStockTypeID]
, StockLevels.[StockOwner]
, StockLevels.[CostCenterID]
, StockLevels.[CompanyCodeID]
, StockLevels.[SalesDocumentTypeID]
, StockLevels.[SalesDocumentItemCategoryID]
, StockLevels.[MaterialBaseUnitID]
, StockLevels.[PurchaseOrderTypeID]
, StockLevels.[InventoryValuationTypeID]
, StockLevels.[ReportingDate]
, StockLevels.[YearWeek]
, StockLevels.[YearMonth]
-- , StockLevels.[IsWeekly]
-- , StockLevels.[IsMonthly]
, PUP.[StockPricePerUnit]
, PUP.[StockPricePerUnit_EUR]
, PUP.[StockPricePerUnit_USD]
, StockLevels.[MatlStkChangeQtyInBaseUnit]
, StockLevels.[StockLevelQtyInBaseUnit]
-- , StockLevels.[MonthlyMatlStkChangeQtyInBaseUnit]
-- , StockLevels.[MonthlyStockLevelQtyInBaseUnit]
, StockLevels.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit] AS StockLevelStandardPPU
, StockLevels.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_EUR] AS StockLevelStandardPPU_EUR
, StockLevels.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_USD] AS StockLevelStandardPPU_USD
-- , StockLevels.[WeeklyStockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit]     AS WeeklyStockLevelStandardPPU
-- , StockLevels.[WeeklyStockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_EUR] AS WeeklyStockLevelStandardPPU_EUR
-- , StockLevels.[WeeklyStockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_USD] AS WeeklyStockLevelStandardPPU_USD
FROM
  StockLevels
LEFT OUTER JOIN
  [edw].[dim_ProductValuationPUP] PUP
  ON
    PUP.[ProductID] = StockLevels.[MaterialID] COLLATE DATABASE_DEFAULT
    AND
    PUP.[ValuationAreaID] = StockLevels.[PlantID] COLLATE DATABASE_DEFAULT
    AND
    PUP.[ValuationTypeID] = StockLevels.[InventoryValuationTypeID] COLLATE DATABASE_DEFAULT
    AND
    PUP.[FirstDayOfMonthDate] = StockLevels.[FirstDayOfMonthDate]
    