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

-- 7. Calculate the stock value by getting the price per unit
SELECT
  sl.[MaterialID]
, sl.[PlantID]
, sl.[StorageLocationID]
, sl.[InventorySpecialStockTypeID]
, sl.[InventoryStockTypeID]
, sl.[StockOwner]
, sl.[CostCenterID]
, sl.[CompanyCodeID]
, sl.[SalesDocumentTypeID]
, sl.[SalesDocumentItemCategoryID]
, sl.[MaterialBaseUnitID]
, sl.[PurchaseOrderTypeID]
, sl.[InventoryValuationTypeID]
-- , sl.[DatePart]
, sl.[nk_StoragePlantID]
, sl.[sk_ProductSalesOrg]
, sl.[PlantSalesOrgID]
-- , sl.[ReportingDate]
, sl.[CalendarYear]
, sl.[YearMonth]
, sl.[CalendarMonth]
, sl.[YearWeek]
, sl.[CalendarWeek]
, sl.[CalendarDate] AS MaxPostingDate
-- , sl.[IsWeekly]
, sl.[IsMonthly]
, PUP.[CurrencyID]
, PUP.[StockPricePerUnit]
, PUP.[StockPricePerUnit_EUR]
, PUP.[StockPricePerUnit_USD]
, LPUP.[LatestStockPricePerUnit]
, LPUP.[LatestStockPricePerUnit_EUR]
, LPUP.[LatestStockPricePerUnit_USD]
, sl.[MatlCnsmpnQtyInMatlBaseUnit]
, sl.[MatlStkChangeQtyInBaseUnit]
, sl.[StockLevelQtyInBaseUnit]
-- , sl.[MonthlyMatlStkChangeQtyInBaseUnit]
-- , sl.[MonthlyStockLevelQtyInBaseUnit]
, sl.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit] AS StockLevelStandardPPU
, sl.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_EUR] AS StockLevelStandardPPU_EUR
, sl.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_USD] AS StockLevelStandardPPU_USD
, sl.[StockLevelQtyInBaseUnit] * LPUP.[LatestStockPricePerUnit] AS StockLevelStandardLatestPPU
, sl.[StockLevelQtyInBaseUnit] * LPUP.[LatestStockPricePerUnit_EUR] AS StockLevelStandardLatestPPU_EUR
, sl.[StockLevelQtyInBaseUnit] * LPUP.[LatestStockPricePerUnit_USD] AS StockLevelStandardLatestPPU_USD
, sl.[Rolling365DayConsumptionQty]
, sl.[ConsumptionQtyICPOInBaseUnit]
, sl.[ConsumptionQtyICPOInStandardValue]
, sl.[ConsumptionQtyICPOInStandardValue_EUR]
, sl.[ConsumptionQtyICPOInStandardValue_USD]
, sl.[ConsumptionQtyOBDProStandardValue]
, sl.[ConsumptionQtyOBDProInBaseUnit]
, sl.[ConsumptionQtyOBDProStandardValue_EUR]
, sl.[ConsumptionQtyOBDProStandardValue_USD]
, sl.[ConsumptionQtySOStandardValue]
, sl.[ConsumptionQtySOInBaseUnit]
, sl.[ConsumptionQtySOStandardValue_EUR]
, sl.[ConsumptionQtySOStandardValue_USD]
, sl.[ConsumptionQty]
, sl.[ConsumptionValueByLatestPriceInBaseValue]
, sl.[ConsumptionValueByLatestPrice_EUR]
, sl.[ConsumptionValueByLatestPrice_USD]
, sl.[t_applicationId]
, sl.[t_extractionDtm]
FROM
  [edw].[vw_fact_MaterialInventoryStockLevelWeeklyBasedOnDaily] sl
LEFT OUTER JOIN
  [edw].[dim_ProductValuationPUP] PUP
  ON
    PUP.[ProductID] = sl.[MaterialID] /*COLLATE DATABASE_DEFAULT*/
    AND
    PUP.[ValuationAreaID] = sl.[PlantID] /*COLLATE DATABASE_DEFAULT*/
    AND
    PUP.[ValuationTypeID] = sl.[InventoryValuationTypeID] /*COLLATE DATABASE_DEFAULT*/
    AND
    PUP.[FirstDayOfMonthDate] = sl.[FirstDayOfMonthDate]
LEFT OUTER JOIN
  [edw].[vw_dim_ProductValuationPUP_LatestStockPrice] LPUP
  ON
    LPUP.[ProductID] = sl.[MaterialID] /*COLLATE DATABASE_DEFAULT*/
    AND
    LPUP.[ValuationAreaID] = sl.[PlantID] /*COLLATE DATABASE_DEFAULT*/
    AND
    LPUP.[ValuationTypeID] = sl.[InventoryValuationTypeID] /*COLLATE DATABASE_DEFAULT*/
    AND
    LPUP.[FirstDayOfMonthDate] = sl.[FirstDayOfMonthDate]
    