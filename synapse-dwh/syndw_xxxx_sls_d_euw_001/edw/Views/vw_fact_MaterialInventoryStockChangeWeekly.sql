CREATE VIEW [edw].[vw_fact_MaterialInventoryStockChangeWeekly]
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
-- WITH stock AS (
--   SELECT
--     stockChangeWeekly.[MaterialID]
--   , stockChangeWeekly.[PlantID]
--   , stockChangeWeekly.[StorageLocationID]
--   , stockChangeWeekly.[InventorySpecialStockTypeID]
--   , stockChangeWeekly.[InventoryStockTypeID]
--   , stockChangeWeekly.[StockOwner]
--   , stockChangeWeekly.[CostCenterID]
--   , stockChangeWeekly.[CompanyCodeID]
--   , stockChangeWeekly.[SalesDocumentTypeID]
--   , stockChangeWeekly.[SalesDocumentItemCategoryID]
--   , stockChangeWeekly.[MaterialBaseUnitID]
--   , stockChangeWeekly.[PurchaseOrderTypeID]
--   , stockChangeWeekly.[InventoryValuationTypeID]
--   , stockChangeWeekly.[YearWeek]
--   -- , NULL AS [YearMonth]
--   , stockChangeWeekly.[MatlStkChangeQtyInBaseUnit]
--   , stockChangeWeekly.[MatlCnsmpnQtyInMatlBaseUnit]
--   , stockChangeWeekly.[ConsumptionQtyICPOInStandardValue_EUR]
--   , stockChangeWeekly.[ConsumptionQtyICPOInStandardValue_USD]
--   , stockChangeWeekly.[ConsumptionQtyOBDProStandardValue]
--   , stockChangeWeekly.[ConsumptionQtyOBDProStandardValue_EUR]
--   , stockChangeWeekly.[ConsumptionQtyOBDProStandardValue_USD]
--   , stockChangeWeekly.[ConsumptionQtySOStandardValue]
--   , stockChangeWeekly.[ConsumptionQtySOStandardValue_EUR]
--   , stockChangeWeekly.[ConsumptionQtySOStandardValue_USD]
--   , stockChangeWeekly.[ConsumptionQty]
--   , stockChangeWeekly.[ConsumptionValueByLatestPriceInBaseValue]
--   , stockChangeWeekly.[ConsumptionValueByLatestPrice_EUR]
--   , stockChangeWeekly.[ConsumptionValueByLatestPrice_USD]
--   FROM
--     [edw].[vw_fact_MaterialInventoryReportedStockChangeWeekly] AS stockChangeWeekly

--   UNION ALL

--   SELECT
--     stockChangeMonthly.[MaterialID]
--   , stockChangeMonthly.[PlantID]
--   , stockChangeMonthly.[StorageLocationID]
--   , stockChangeMonthly.[InventorySpecialStockTypeID]
--   , stockChangeMonthly.[InventoryStockTypeID]
--   , stockChangeMonthly.[StockOwner]
--   , stockChangeMonthly.[CostCenterID]
--   , stockChangeMonthly.[CompanyCodeID]
--   , stockChangeMonthly.[SalesDocumentTypeID]
--   , stockChangeMonthly.[SalesDocumentItemCategoryID]
--   , stockChangeMonthly.[MaterialBaseUnitID]
--   , stockChangeMonthly.[PurchaseOrderTypeID]
--   , stockChangeMonthly.[InventoryValuationTypeID]
--   , NULL AS [YearWeek]
--   , stockChangeMonthly.[YearMonth]
--   , stockChangeMonthly.[MatlStkChangeQtyInBaseUnit]
--   , stockChangeMonthly.[MatlCnsmpnQtyInMatlBaseUnit]
--   , stockChangeMonthly.[ConsumptionQtyICPOInStandardValue_EUR]
--   , stockChangeMonthly.[ConsumptionQtyICPOInStandardValue_USD]
--   , stockChangeMonthly.[ConsumptionQtyOBDProStandardValue]
--   , stockChangeMonthly.[ConsumptionQtyOBDProStandardValue_EUR]
--   , stockChangeMonthly.[ConsumptionQtyOBDProStandardValue_USD]
--   , stockChangeMonthly.[ConsumptionQtySOStandardValue]
--   , stockChangeMonthly.[ConsumptionQtySOStandardValue_EUR]
--   , stockChangeMonthly.[ConsumptionQtySOStandardValue_USD]
--   , stockChangeMonthly.[ConsumptionQty]
--   , stockChangeMonthly.[ConsumptionValueByLatestPriceInBaseValue]
--   , stockChangeMonthly.[ConsumptionValueByLatestPrice_EUR]
--   , stockChangeMonthly.[ConsumptionValueByLatestPrice_USD]
--   FROM
--     [edw].[vw_fact_MaterialInventoryReportedStockChangeMonthly] AS stockChangeMonthly
-- )

-- 5. Include the stock changes for the weeks on which they are reported
SELECT
  allWeeks.[MaterialID]
, allWeeks.[PlantID]
, allWeeks.[StorageLocationID]
, allWeeks.[InventorySpecialStockTypeID]
, allWeeks.[InventoryStockTypeID]
, allWeeks.[StockOwner]
, allWeeks.[CostCenterID]
, allWeeks.[CompanyCodeID]
, allWeeks.[SalesDocumentTypeID]
, allWeeks.[SalesDocumentItemCategoryID]
, allWeeks.[MaterialBaseUnitID]
, allWeeks.[PurchaseOrderTypeID]
, allWeeks.[InventoryValuationTypeID]
, allWeeks.[nk_StoragePlantID]
, allWeeks.[sk_ProductSalesOrg]
, allWeeks.[PlantSalesOrgID]
-- , allWeeks.[ReportingDate]
, allWeeks.[FirstDayOfMonthDate]
, allWeeks.[CalendarYear]
, allWeeks.[YearMonth]
, allWeeks.[CalendarMonth]
, allWeeks.[YearWeek]
, allWeeks.[CalendarWeek]
-- , stockChangeWeekly.[WeeklyMatlStkChangeQtyInBaseUnit]
-- , allWeeks.[YearMonth]
, allWeeks.[MaxPostingDate]
, allWeeks.[IsMonthly]
, stock.[MatlCnsmpnQtyInMatlBaseUnit]
, stock.[MatlStkChangeQtyInBaseUnit]
, stock.[ConsumptionQtyICPOInBaseUnit]
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
-- , stockChangeMonthly.[MonthlyMatlStkChangeQtyInBaseUnit]
-- , allWeeks.[IsWeekly]
-- , allWeeks.[IsMonthly]
, allWeeks.[t_applicationId]
, allWeeks.[t_extractionDtm]
FROM
  [edw].[vw_fact_MaterialInventoryAllWeeks] allWeeks
LEFT JOIN
  [edw].[vw_fact_MaterialInventoryReportedStockChangeWeekly] AS stock
  ON
  -- Join on all required fields
  -- Include checks for cases when one or both fields are NULL
    stock.[MaterialID] = allWeeks.[MaterialID]
    AND (
    stock.[PlantID] = allWeeks.[PlantID]
      OR (
        stock.[PlantID] IS NULL
        AND
        allWeeks.[PlantID] IS NULL
      )
    )
    AND (
      stock.[StorageLocationID] = allWeeks.[StorageLocationID]
      OR (
        stock.[StorageLocationID] IS NULL
        AND
        allWeeks.[StorageLocationID] IS NULL
      )
    )
    AND (
      stock.[InventorySpecialStockTypeID] = allWeeks.[InventorySpecialStockTypeID]
      OR (
        stock.[InventorySpecialStockTypeID] IS NULL
        AND
        allWeeks.[InventorySpecialStockTypeID] IS NULL
      )
    )
    AND (
      stock.[InventoryStockTypeID] = allWeeks.[InventoryStockTypeID]
      OR (
        stock.[InventoryStockTypeID] IS NULL
        AND
        allWeeks.[InventoryStockTypeID] IS NULL
      )
    )
    AND (
      stock.[StockOwner] = allWeeks.[StockOwner]
      OR (
        stock.[StockOwner] IS NULL
        AND
        allWeeks.[StockOwner] IS NULL
      )
    )
    AND (
      stock.[CostCenterID] = allWeeks.[CostCenterID]
      OR (
        stock.[CostCenterID] IS NULL
        AND
        allWeeks.[CostCenterID] IS NULL
      )
    )
    AND (
      stock.[CompanyCodeID] = allWeeks.[CompanyCodeID]
      OR (
        stock.[CompanyCodeID] IS NULL
        AND
        allWeeks.[CompanyCodeID] IS NULL
      )
    )
    AND (
      stock.[SalesDocumentTypeID] = allWeeks.[SalesDocumentTypeID]
      OR (
        stock.[SalesDocumentTypeID] IS NULL
        AND
        allWeeks.[SalesDocumentTypeID] IS NULL
      )
    )
    AND (
      stock.[SalesDocumentItemCategoryID] = allWeeks.[SalesDocumentItemCategoryID]
      OR (
        stock.[SalesDocumentItemCategoryID] IS NULL
        AND
        allWeeks.[SalesDocumentItemCategoryID] IS NULL
      )
    )
    AND (
      stock.[MaterialBaseUnitID] = allWeeks.[MaterialBaseUnitID]
      OR (
        stock.[MaterialBaseUnitID] IS NULL
        AND
        allWeeks.[MaterialBaseUnitID] IS NULL
      )
    )
    AND (
      stock.[PurchaseOrderTypeID] = allWeeks.[PurchaseOrderTypeID]
      OR (
        stock.[PurchaseOrderTypeID] IS NULL
        AND
        allWeeks.[PurchaseOrderTypeID] IS NULL
      )
    )
    AND (
      stock.[InventoryValuationTypeID] = allWeeks.[InventoryValuationTypeID]
      OR (
        stock.[InventoryValuationTypeID] IS NULL
        AND
        allWeeks.[InventoryValuationTypeID] IS NULL
      )
    )
    AND (
      stock.[YearWeek] = allWeeks.[YearWeek]
      OR (
        stock.[YearWeek] IS NULL
        -- AND
        -- allWeeks.[YearWeek] IS NULL
      )
    )
    AND (
      stock.[YearMonth] = allWeeks.[YearMonth]
      OR (
        stock.[YearMonth] IS NULL
    --     -- AND
    --     -- allWeeks.[YearMonth] IS NULL
      )
    )
-- WHERE
--   allWeeks.MaterialID = '000000000040000023'
--   AND
--   allWeeks.CompanyCodeID = 'DE35'
--   AND
--   allWeeks.PurchaseOrderTypeID IS NULL
--   AND
--   allWeeks.CostCenterID = ''
-- --   AND
-- --   InventorySpecialStockTypeID = ''
--   AND
--   allWeeks.InventoryStockTypeID = '01'
-- ORDER  BY
--   allWeeks.YearMonth, allWeeks.YearWeek