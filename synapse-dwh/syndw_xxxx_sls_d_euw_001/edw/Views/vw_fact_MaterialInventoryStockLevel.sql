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
_union AS (
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
  , 'Week' AS [DatePart]
  , [nk_StoragePlantID]
  , [sk_ProductSalesOrg]
  , [PlantSalesOrgID]
  , [ReportingDate]
  , [FirstDayOfMonthDate]
  , [YearWeek]
  , NULL AS [YearMonth]
  -- , [IsWeekly]
  -- , [IsMonthly]
  , [MatlCnsmpnQtyInMatlBaseUnit]
  , [MatlStkChangeQtyInBaseUnit]
  , [StockLevelQtyInBaseUnit]
  , [Rolling12MonthConsumptionQty]
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
    [edw].[vw_fact_MaterialInventoryStockLevelWeekly]

  UNION ALL

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
  , 'Month' AS [DatePart]
  , [nk_StoragePlantID]
  , [sk_ProductSalesOrg]
  , [PlantSalesOrgID]
  , [ReportingDate]
  , [FirstDayOfMonthDate]
  , NULL AS [YearWeek]
  , [YearMonth]
  -- , [IsWeekly]
  -- , [IsMonthly]
  , [MatlCnsmpnQtyInMatlBaseUnit]
  , [MatlStkChangeQtyInBaseUnit]
  , [StockLevelQtyInBaseUnit]
  , [Rolling12MonthConsumptionQty]
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
    [edw].[vw_fact_MaterialInventoryStockLevelMonthly]
)

-- 7. Calculate the stock value by getting the price per unit
SELECT
  _union.[MaterialID]
, _union.[PlantID]
, _union.[StorageLocationID]
, _union.[InventorySpecialStockTypeID]
, _union.[InventoryStockTypeID]
, _union.[StockOwner]
, _union.[CostCenterID]
, _union.[CompanyCodeID]
, _union.[SalesDocumentTypeID]
, _union.[SalesDocumentItemCategoryID]
, _union.[MaterialBaseUnitID]
, _union.[PurchaseOrderTypeID]
, _union.[InventoryValuationTypeID]
, _union.[DatePart]
, _union.[nk_StoragePlantID]
, _union.[sk_ProductSalesOrg]
, _union.[PlantSalesOrgID]
, _union.[ReportingDate]
, _union.[YearWeek]
, _union.[YearMonth]
-- , _union.[IsWeekly]
-- , _union.[IsMonthly]
, PUP.[CurrencyID]
, PUP.[StockPricePerUnit]
, PUP.[StockPricePerUnit_EUR]
, PUP.[StockPricePerUnit_USD]
, LPUP.[LatestStockPricePerUnit]
, LPUP.[LatestStockPricePerUnit_EUR]
, LPUP.[LatestStockPricePerUnit_USD]
, _union.[MatlCnsmpnQtyInMatlBaseUnit]
, _union.[MatlStkChangeQtyInBaseUnit]
, _union.[StockLevelQtyInBaseUnit]
-- , _union.[MonthlyMatlStkChangeQtyInBaseUnit]
-- , _union.[MonthlyStockLevelQtyInBaseUnit]
, _union.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit] AS StockLevelStandardPPU
, _union.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_EUR] AS StockLevelStandardPPU_EUR
, _union.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_USD] AS StockLevelStandardPPU_USD
, _union.[StockLevelQtyInBaseUnit] * LPUP.[LatestStockPricePerUnit] AS StockLevelStandardLatestPPU
, _union.[StockLevelQtyInBaseUnit] * LPUP.[LatestStockPricePerUnit_EUR] AS StockLevelStandardLatestPPU_EUR
, _union.[StockLevelQtyInBaseUnit] * LPUP.[LatestStockPricePerUnit_USD] AS StockLevelStandardLatestPPU_USD
, _union.[Rolling12MonthConsumptionQty]
, _union.[ConsumptionQtyICPOInStandardValue_EUR]
, _union.[ConsumptionQtyICPOInStandardValue_USD]
, _union.[ConsumptionQtyOBDProStandardValue]
, _union.[ConsumptionQtyOBDProStandardValue_EUR]
, _union.[ConsumptionQtyOBDProStandardValue_USD]
, _union.[ConsumptionQtySOStandardValue]
, _union.[ConsumptionQtySOStandardValue_EUR]
, _union.[ConsumptionQtySOStandardValue_USD]
, _union.[ConsumptionQty]
, _union.[ConsumptionValueByLatestPriceInBaseValue]
, _union.[ConsumptionValueByLatestPrice_EUR]
, _union.[ConsumptionValueByLatestPrice_USD]
, _union.[t_applicationId]
, _union.[t_extractionDtm]
FROM
  _union
LEFT OUTER JOIN
  [edw].[dim_ProductValuationPUP] PUP
  ON
    PUP.[ProductID] = _union.[MaterialID] /*COLLATE DATABASE_DEFAULT*/
    AND
    PUP.[ValuationAreaID] = _union.[PlantID] /*COLLATE DATABASE_DEFAULT*/
    AND
    PUP.[ValuationTypeID] = _union.[InventoryValuationTypeID] /*COLLATE DATABASE_DEFAULT*/
    AND
    PUP.[FirstDayOfMonthDate] = _union.[FirstDayOfMonthDate]
LEFT OUTER JOIN
  [edw].[vw_dim_ProductValuationPUP_LatestStockPrice] LPUP
  ON
    LPUP.[ProductID] = _union.[MaterialID] /*COLLATE DATABASE_DEFAULT*/
    AND
    LPUP.[ValuationAreaID] = _union.[PlantID] /*COLLATE DATABASE_DEFAULT*/
    AND
    LPUP.[ValuationTypeID] = _union.[InventoryValuationTypeID] /*COLLATE DATABASE_DEFAULT*/
    AND
    LPUP.[FirstDayOfMonthDate] = _union.[FirstDayOfMonthDate]
    