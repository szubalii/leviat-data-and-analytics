CREATE VIEW [edw].[vw_fact_MaterialInventoryStockLevelMonthly]
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
  , [nk_StoragePlantID]
  , [sk_ProductSalesOrg]
  , [PlantSalesOrgID]
  -- , [ReportingDate]
  , [FirstDayOfMonthDate]
  , [CalendarYear]
  , [YearMonth]
  , [CalendarMonth]
  -- , [YearWeek]
  -- , [YearMonth]
  -- , [IsWeekly]
  -- , [IsMonthly]
  -- , [IsMonthly]
  , [MatlCnsmpnQtyInMatlBaseUnit]
  , [MatlStkChangeQtyInBaseUnit]
  , SUM(MatlStkChangeQtyInBaseUnit) OVER (
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
      -- , [YearWeek]
        ORDER BY YearMonth
      )
    AS StockLevelQtyInBaseUnit
  , SUM(MatlCnsmpnQtyInMatlBaseUnit) OVER (
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
      -- , [YearWeek]
        ORDER BY YearMonth
        ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
      )
    AS Rolling12MonthConsumptionQty
  , [ConsumptionQtyICPOInBaseUnit]
  , [ConsumptionQtyICPOInStandardValue_EUR]
  , [ConsumptionQtyICPOInStandardValue_USD]
  , [ConsumptionQtyOBDProStandardValue]
  , [ConsumptionQtyOBDProInBaseUnit]
  , [ConsumptionQtyOBDProStandardValue_EUR]
  , [ConsumptionQtyOBDProStandardValue_USD]
  , [ConsumptionQtySOStandardValue]
  , [ConsumptionQtySOInBaseUnit]
  , [ConsumptionQtySOStandardValue_EUR]
  , [ConsumptionQtySOStandardValue_USD]
  , [ConsumptionQty]
  , [ConsumptionValueByLatestPriceInBaseValue]
  , [ConsumptionValueByLatestPrice_EUR]
  , [ConsumptionValueByLatestPrice_USD]
  , [t_applicationId]
  , [t_extractionDtm]
  FROM
    [edw].[vw_fact_MaterialInventoryStockChangeMonthly]
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
, StockLevels.[nk_StoragePlantID]
, StockLevels.[sk_ProductSalesOrg]
, StockLevels.[PlantSalesOrgID]
, StockLevels.[ReportingDate]
, StockLevels.[FirstDayOfMonthDate]
-- , StockLevels.[YearWeek]
, StockLevels.[YearMonth]
-- , StockLevels.[IsWeekly]
-- , StockLevels.[IsMonthly]
-- , PUP.[CurrencyID]
-- , PUP.[StockPricePerUnit]
-- , PUP.[StockPricePerUnit_EUR]
-- , PUP.[StockPricePerUnit_USD]
-- , LPUP.[LatestStockPricePerUnit]
-- , LPUP.[LatestStockPricePerUnit_EUR]
-- , LPUP.[LatestStockPricePerUnit_USD]
, StockLevels.[MatlCnsmpnQtyInMatlBaseUnit]
, StockLevels.[MatlStkChangeQtyInBaseUnit]
, StockLevels.[StockLevelQtyInBaseUnit]
-- , StockLevels.[MonthlyMatlStkChangeQtyInBaseUnit]
-- , StockLevels.[MonthlyStockLevelQtyInBaseUnit]
-- , StockLevels.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit] AS StockLevelStandardPPU
-- , StockLevels.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_EUR] AS StockLevelStandardPPU_EUR
-- , StockLevels.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_USD] AS StockLevelStandardPPU_USD
-- , StockLevels.[StockLevelQtyInBaseUnit] * LPUP.[LatestStockPricePerUnit] AS StockLevelStandardLatestPPU
-- , StockLevels.[StockLevelQtyInBaseUnit] * LPUP.[LatestStockPricePerUnit_EUR] AS StockLevelStandardLatestPPU_EUR
-- , StockLevels.[StockLevelQtyInBaseUnit] * LPUP.[LatestStockPricePerUnit_USD] AS StockLevelStandardLatestPPU_USD
, StockLevels.[Rolling12MonthConsumptionQty]
, StockLevels.[ConsumptionQtyICPOInBaseUnit]
, StockLevels.[ConsumptionQtyICPOInStandardValue_EUR]
, StockLevels.[ConsumptionQtyICPOInStandardValue_USD]
, StockLevels.[ConsumptionQtyOBDProStandardValue]
, StockLevels.[ConsumptionQtyOBDProInBaseUnit]
, StockLevels.[ConsumptionQtyOBDProStandardValue_EUR]
, StockLevels.[ConsumptionQtyOBDProStandardValue_USD]
, StockLevels.[ConsumptionQtySOStandardValue]
, StockLevels.[ConsumptionQtySOInBaseUnit]
, StockLevels.[ConsumptionQtySOStandardValue_EUR]
, StockLevels.[ConsumptionQtySOStandardValue_USD]
, StockLevels.[ConsumptionQty]
, StockLevels.[ConsumptionValueByLatestPriceInBaseValue]
, StockLevels.[ConsumptionValueByLatestPrice_EUR]
, StockLevels.[ConsumptionValueByLatestPrice_USD]
, StockLevels.[t_applicationId]
, StockLevels.[t_extractionDtm]
FROM
  StockLevels
-- LEFT OUTER JOIN
--   [edw].[dim_ProductValuationPUP] PUP
--   ON
--     PUP.[ProductID] = StockLevels.[MaterialID] COLLATE DATABASE_DEFAULT
--     AND
--     PUP.[ValuationAreaID] = StockLevels.[PlantID] COLLATE DATABASE_DEFAULT
--     AND
--     PUP.[ValuationTypeID] = StockLevels.[InventoryValuationTypeID] COLLATE DATABASE_DEFAULT
--     AND
--     PUP.[FirstDayOfMonthDate] = StockLevels.[FirstDayOfMonthDate]
-- LEFT OUTER JOIN
--   [edw].[vw_dim_ProductValuationPUP_LatestStockPrice] LPUP
--   ON
--     LPUP.[ProductID] = StockLevels.[MaterialID] COLLATE DATABASE_DEFAULT
--     AND
--     LPUP.[ValuationAreaID] = StockLevels.[PlantID] COLLATE DATABASE_DEFAULT
--     AND
--     LPUP.[ValuationTypeID] = StockLevels.[InventoryValuationTypeID] COLLATE DATABASE_DEFAULT
--     AND
--     LPUP.[FirstDayOfMonthDate] = StockLevels.[FirstDayOfMonthDate]
    