CREATE VIEW [edw].[vw_fact_MaterialInventoryStockLevelWeekly]
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
  , [YearWeek]
  , [CalendarWeek]
  -- , [YearMonth]
  -- , [IsWeekly]
  -- , [IsMonthly]
  , [MaxPostingDate]
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
      -- , [YearMonth]
        ORDER BY YearMonth, YearWeek
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
      -- , [YearMonth]
        ORDER BY YearMonth, YearWeek
        ROWS BETWEEN 51 PRECEDING AND CURRENT ROW
        )
    AS Rolling12MonthConsumptionQty
  , [ConsumptionQtyICPOInStandardValue_EUR]
  , [ConsumptionQtyICPOInStandardValue_USD]
  , [ConsumptionQtyOBDProStandardValue]
  , [ConsumptionQtyOBDProStandardValue_EUR]
  , [ConsumptionQtyOBDProStandardValue_USD]
  , [ConsumptionQtySOStandardValue]
  , [ConsumptionQtySOStandardValue_EUR]
  , [ConsumptionQtySOStandardValue_USD]
  , [ConsumptionQty]
  , [ConsumptionValueByLatestPriceInBaseValue]
  , [ConsumptionValueByLatestPrice_EUR]
  , [ConsumptionValueByLatestPrice_USD]
  , [t_applicationId]
  , [t_extractionDtm]
  FROM
    [edw].[vw_fact_MaterialInventoryStockChangeWeekly]
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
-- , StockLevels.[ReportingDate]
, StockLevels.[FirstDayOfMonthDate]
, StockLevels.[CalendarYear]
, StockLevels.[YearMonth]
, StockLevels.[CalendarMonth]
, StockLevels.[YearWeek]
, StockLevels.[CalendarWeek]
, StockLevels.[MaxPostingDate]
-- , StockLevels.[YearMonth]
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
, StockLevels.[ConsumptionQtyICPOInStandardValue_EUR]
, StockLevels.[ConsumptionQtyICPOInStandardValue_USD]
, StockLevels.[ConsumptionQtyOBDProStandardValue]
, StockLevels.[ConsumptionQtyOBDProStandardValue_EUR]
, StockLevels.[ConsumptionQtyOBDProStandardValue_USD]
, StockLevels.[ConsumptionQtySOStandardValue]
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
    