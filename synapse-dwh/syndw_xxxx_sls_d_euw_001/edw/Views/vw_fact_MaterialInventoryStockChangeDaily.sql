CREATE VIEW [edw].[vw_fact_MaterialInventoryStockChangeDaily]
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
-- 5. Include the stock changes for the weeks on which they are reported
SELECT
  allDays.[MaterialID]
, allDays.[PlantID]
, allDays.[StorageLocationID]
, allDays.[InventorySpecialStockTypeID]
, allDays.[InventoryStockTypeID]
, allDays.[StockOwner]
, allDays.[CostCenterID]
, allDays.[CompanyCodeID]
, allDays.[SalesDocumentTypeID]
, allDays.[SalesDocumentItemCategoryID]
, allDays.[MaterialBaseUnitID]
, allDays.[PurchaseOrderTypeID]
, allDays.[InventoryValuationTypeID]
, allDays.[nk_StoragePlantID]
, allDays.[sk_ProductSalesOrg]
, allDays.[PlantSalesOrgID]
, allDays.[FirstDayOfMonthDate]
, allDays.[CalendarYear]
, allDays.[YearMonth]
, allDays.[CalendarMonth]
, allDays.[YearWeek]
, allDays.[CalendarWeek]
, allDays.[CalendarDate]
, allDays.[IsMonthly]
, stock.[MatlCnsmpnQtyInMatlBaseUnit]
, stock.[MatlStkChangeQtyInBaseUnit]
, stock.[ConsumptionQtyICPOInBaseUnit]
, stock.[ConsumptionQtyICPOInStandardValue]
, stock.[ConsumptionQtyICPOInStandardValue_EUR]
, stock.[ConsumptionQtyICPOInStandardValue_USD]
, stock.[ConsumptionQtyOBDProStandardValue]
, stock.[ConsumptionQtyOBDProInBaseUnit]
, stock.[ConsumptionQtyOBDProStandardValue_EUR]
, stock.[ConsumptionQtyOBDProStandardValue_USD]
, stock.[ConsumptionQtySOStandardValue]
, stock.[ConsumptionQtySOInBaseUnit]
, stock.[ConsumptionQtySOStandardValue_EUR]
, stock.[ConsumptionQtySOStandardValue_USD]
, stock.[ConsumptionQty]
, stock.[ConsumptionValueByLatestPriceInBaseValue]
, stock.[ConsumptionValueByLatestPrice_EUR]
, stock.[ConsumptionValueByLatestPrice_USD]
, allDays.[t_applicationId]
, allDays.[t_extractionDtm]
FROM
  [edw].[vw_fact_MaterialInventoryAllDays] allDays
LEFT JOIN
  [edw].[vw_fact_MaterialInventoryReportedStockChangeDaily] AS stock
  ON
  -- Join on all required fields
  -- Include checks for cases when one or both fields are NULL
    stock.[MaterialID] = allDays.[MaterialID]
    AND
    stock.[PlantID] = allDays.[PlantID]
    AND 
    stock.[StorageLocationID] = allDays.[StorageLocationID]
    AND
    stock.[InventorySpecialStockTypeID] = allDays.[InventorySpecialStockTypeID]
    AND
    stock.[InventoryStockTypeID] = allDays.[InventoryStockTypeID]
    AND
    stock.[StockOwner] = allDays.[StockOwner]
    AND
    stock.[CostCenterID] = allDays.[CostCenterID]
    AND
    stock.[CompanyCodeID] = allDays.[CompanyCodeID]
    AND
    stock.[MaterialBaseUnitID] = allDays.[MaterialBaseUnitID]
    AND
    stock.[InventoryValuationTypeID] = allDays.[InventoryValuationTypeID]
    AND (
      stock.[HDR_PostingDate] = allDays.[CalendarDate]
      OR
      stock.[HDR_PostingDate] IS NULL
    )
