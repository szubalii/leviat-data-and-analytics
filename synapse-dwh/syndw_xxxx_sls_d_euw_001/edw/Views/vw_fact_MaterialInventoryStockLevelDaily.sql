CREATE VIEW [edw].[vw_fact_MaterialInventoryStockLevelDaily]
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
  , [CalendarDate]
  -- , [YearMonth]
  -- , [IsWeekly]
  , [IsMonthly]
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
      , [MaterialBaseUnitID]
      , [InventoryValuationTypeID]
        ORDER BY CalendarDate
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
      , [MaterialBaseUnitID]
      , [InventoryValuationTypeID]
        ORDER BY CalendarDate
        ROWS BETWEEN 365 PRECEDING AND CURRENT ROW
        )
    AS Rolling365DayConsumptionQty
  , [ConsumptionQtyICPOInBaseUnit]
  , [ConsumptionQtyICPOInStandardValue]
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
    [edw].[vw_fact_MaterialInventoryStockChangeDaily]
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
, StockLevels.[FirstDayOfMonthDate]
, StockLevels.[CalendarYear]
, StockLevels.[YearMonth]
, StockLevels.[CalendarMonth]
, StockLevels.[YearWeek]
, StockLevels.[CalendarWeek]
, StockLevels.[CalendarDate]
, StockLevels.[IsMonthly]
, StockLevels.[MatlCnsmpnQtyInMatlBaseUnit]
, StockLevels.[MatlStkChangeQtyInBaseUnit]
, StockLevels.[StockLevelQtyInBaseUnit]
, StockLevels.[Rolling365DayConsumptionQty]
, StockLevels.[ConsumptionQtyICPOInBaseUnit]
, StockLevels.[ConsumptionQtyICPOInStandardValue]
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
