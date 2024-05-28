CREATE VIEW [edw].[vw_fact_MaterialInventoryStockLevelWeeklyBasedOnDaily]
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
Weekly AS (
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
  , MAX([CalendarDate]) AS CalendarDate
  -- , [YearMonth]
  -- , [IsWeekly]
  , [IsMonthly]
  , SUM([MatlCnsmpnQtyInMatlBaseUnit]) AS MatlCnsmpnQtyInMatlBaseUnit
  , SUM([MatlStkChangeQtyInBaseUnit]) AS MatlStkChangeQtyInBaseUnit
  -- , SUM([StockLevelQtyInBaseUnit]) AS StockLevelQtyInBaseUnit
  -- , [Rolling365DayConsumptionQty]
  , SUM([ConsumptionQtyICPOInBaseUnit]) AS ConsumptionQtyICPOInBaseUnit
  , SUM([ConsumptionQtyICPOInStandardValue]) AS ConsumptionQtyICPOInStandardValue
  , SUM([ConsumptionQtyICPOInStandardValue_EUR]) AS ConsumptionQtyICPOInStandardValue_EUR
  , SUM([ConsumptionQtyICPOInStandardValue_USD]) AS ConsumptionQtyICPOInStandardValue_USD
  , SUM([ConsumptionQtyOBDProStandardValue]) AS ConsumptionQtyOBDProStandardValue
  , SUM([ConsumptionQtyOBDProInBaseUnit]) AS ConsumptionQtyOBDProInBaseUnit
  , SUM([ConsumptionQtyOBDProStandardValue_EUR]) AS ConsumptionQtyOBDProStandardValue_EUR
  , SUM([ConsumptionQtyOBDProStandardValue_USD]) AS ConsumptionQtyOBDProStandardValue_USD
  , SUM([ConsumptionQtySOStandardValue]) AS ConsumptionQtySOStandardValue
  , SUM([ConsumptionQtySOInBaseUnit]) AS ConsumptionQtySOInBaseUnit
  , SUM([ConsumptionQtySOStandardValue_EUR]) AS ConsumptionQtySOStandardValue_EUR
  , SUM([ConsumptionQtySOStandardValue_USD]) AS ConsumptionQtySOStandardValue_USD
  , SUM([ConsumptionQty]) AS ConsumptionQty
  , SUM([ConsumptionValueByLatestPriceInBaseValue]) AS ConsumptionValueByLatestPriceInBaseValue
  , SUM([ConsumptionValueByLatestPrice_EUR]) AS ConsumptionValueByLatestPrice_EUR
  , SUM([ConsumptionValueByLatestPrice_USD]) AS ConsumptionValueByLatestPrice_USD
  , [t_applicationId]
  , [t_extractionDtm]
  FROM
    [edw].[vw_fact_MaterialInventoryStockLevelDaily]
  GROUP BY
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
  , [IsMonthly]
  -- , [MatlCnsmpnQtyInMatlBaseUnit]
  -- , [MatlStkChangeQtyInBaseUnit]
  -- , [Rolling365DayConsumptionQty]
  , [t_applicationId]
  , [t_extractionDtm]
)

-- Add the Rolling365Day
SELECT
    w.[MaterialID]
  , w.[PlantID]
  , w.[StorageLocationID]
  , w.[InventorySpecialStockTypeID]
  , w.[InventoryStockTypeID]
  , w.[StockOwner]
  , w.[CostCenterID]
  , w.[CompanyCodeID]
  , w.[SalesDocumentTypeID]
  , w.[SalesDocumentItemCategoryID]
  , w.[MaterialBaseUnitID]
  , w.[PurchaseOrderTypeID]
  , w.[InventoryValuationTypeID]
  , w.[nk_StoragePlantID]
  , w.[sk_ProductSalesOrg]
  , w.[PlantSalesOrgID]
  , w.[FirstDayOfMonthDate]
  , w.[CalendarYear]
  , w.[YearMonth]
  , w.[CalendarMonth]
  , w.[YearWeek]
  , w.[CalendarWeek]
  , w.CalendarDate
  -- , [YearMonth]
  -- , [IsWeekly]
  , w.[IsMonthly]
  , w.[MatlCnsmpnQtyInMatlBaseUnit]
  , w.[MatlStkChangeQtyInBaseUnit]
  , d.[StockLevelQtyInBaseUnit]
  , d.[Rolling365DayConsumptionQty]
  , w.ConsumptionQtyICPOInBaseUnit
  , w.ConsumptionQtyICPOInStandardValue
  , w.ConsumptionQtyICPOInStandardValue_EUR
  , w.ConsumptionQtyICPOInStandardValue_USD
  , w.ConsumptionQtyOBDProStandardValue
  , w.ConsumptionQtyOBDProInBaseUnit
  , w.ConsumptionQtyOBDProStandardValue_EUR
  , w.ConsumptionQtyOBDProStandardValue_USD
  , w.ConsumptionQtySOStandardValue
  , w.ConsumptionQtySOInBaseUnit
  , w.ConsumptionQtySOStandardValue_EUR
  , w.ConsumptionQtySOStandardValue_USD
  , w.ConsumptionQty
  , w.ConsumptionValueByLatestPriceInBaseValue
  , w.ConsumptionValueByLatestPrice_EUR
  , w.ConsumptionValueByLatestPrice_USD
  , w.[t_applicationId]
  , w.[t_extractionDtm]
FROM
  Weekly w
LEFT JOIN
  [edw].[vw_fact_MaterialInventoryStockLevelDaily] d
  on
    w.[MaterialID] = d.[MaterialID]
    AND
    w.[PlantID] = d.[PlantID]
    AND
    w.[StorageLocationID] = d.[StorageLocationID]
    AND
    w.[InventorySpecialStockTypeID] = d.[InventorySpecialStockTypeID]
    AND
    w.[InventoryStockTypeID] = d.[InventoryStockTypeID]
    AND
    w.[StockOwner] = d.[StockOwner]
    AND
    w.[CostCenterID] = d.[CostCenterID]
    AND
    w.[CompanyCodeID] = d.[CompanyCodeID]
    AND
    w.[MaterialBaseUnitID] = d.[MaterialBaseUnitID]
    AND
    w.[InventoryValuationTypeID] = d.[InventoryValuationTypeID]
    AND
    w.[CalendarDate] = d.[CalendarDate]

