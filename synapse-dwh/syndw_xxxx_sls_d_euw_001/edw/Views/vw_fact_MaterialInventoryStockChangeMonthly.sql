CREATE VIEW [edw].[vw_fact_MaterialInventoryStockChangeMonthly]
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
  allMonths.[MaterialID]
, allMonths.[PlantID]
, allMonths.[StorageLocationID]
, allMonths.[InventorySpecialStockTypeID]
, allMonths.[InventoryStockTypeID]
, allMonths.[StockOwner]
, allMonths.[CostCenterID]
, allMonths.[CompanyCodeID]
, allMonths.[SalesDocumentTypeID]
, allMonths.[SalesDocumentItemCategoryID]
, allMonths.[MaterialBaseUnitID]
, allMonths.[PurchaseOrderTypeID]
, allMonths.[InventoryValuationTypeID]
, allMonths.[nk_StoragePlantID]
, allMonths.[sk_ProductSalesOrg]
, allMonths.[PlantSalesOrgID]
-- , allMonths.[ReportingDate]
, allMonths.[FirstDayOfMonthDate]
, allWeeks.[CalendarYear]
, allWeeks.[YearMonth]
, allWeeks.[CalendarMonth]
-- , allMonths.[YearWeek]
-- , stockChangeWeekly.[WeeklyMatlStkChangeQtyInBaseUnit]
, allMonths.[YearMonth]
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
-- , allMonths.[IsWeekly]
-- , allMonths.[IsMonthly]
, allMonths.[t_applicationId]
, allMonths.[t_extractionDtm]
FROM
  [edw].[vw_fact_MaterialInventoryAllMonths] allMonths
LEFT JOIN
  [edw].[vw_fact_MaterialInventoryReportedStockChangeMonthly] AS stock
  ON
  -- Join on all required fields
  -- Include checks for cases when one or both fields are NULL
    stock.[MaterialID] = allMonths.[MaterialID]
    AND (
    stock.[PlantID] = allMonths.[PlantID]
      OR (
        stock.[PlantID] IS NULL
        AND
        allMonths.[PlantID] IS NULL
      )
    )
    AND (
      stock.[StorageLocationID] = allMonths.[StorageLocationID]
      OR (
        stock.[StorageLocationID] IS NULL
        AND
        allMonths.[StorageLocationID] IS NULL
      )
    )
    AND (
      stock.[InventorySpecialStockTypeID] = allMonths.[InventorySpecialStockTypeID]
      OR (
        stock.[InventorySpecialStockTypeID] IS NULL
        AND
        allMonths.[InventorySpecialStockTypeID] IS NULL
      )
    )
    AND (
      stock.[InventoryStockTypeID] = allMonths.[InventoryStockTypeID]
      OR (
        stock.[InventoryStockTypeID] IS NULL
        AND
        allMonths.[InventoryStockTypeID] IS NULL
      )
    )
    AND (
      stock.[StockOwner] = allMonths.[StockOwner]
      OR (
        stock.[StockOwner] IS NULL
        AND
        allMonths.[StockOwner] IS NULL
      )
    )
    AND (
      stock.[CostCenterID] = allMonths.[CostCenterID]
      OR (
        stock.[CostCenterID] IS NULL
        AND
        allMonths.[CostCenterID] IS NULL
      )
    )
    AND (
      stock.[CompanyCodeID] = allMonths.[CompanyCodeID]
      OR (
        stock.[CompanyCodeID] IS NULL
        AND
        allMonths.[CompanyCodeID] IS NULL
      )
    )
    AND (
      stock.[SalesDocumentTypeID] = allMonths.[SalesDocumentTypeID]
      OR (
        stock.[SalesDocumentTypeID] IS NULL
        AND
        allMonths.[SalesDocumentTypeID] IS NULL
      )
    )
    AND (
      stock.[SalesDocumentItemCategoryID] = allMonths.[SalesDocumentItemCategoryID]
      OR (
        stock.[SalesDocumentItemCategoryID] IS NULL
        AND
        allMonths.[SalesDocumentItemCategoryID] IS NULL
      )
    )
    AND (
      stock.[MaterialBaseUnitID] = allMonths.[MaterialBaseUnitID]
      OR (
        stock.[MaterialBaseUnitID] IS NULL
        AND
        allMonths.[MaterialBaseUnitID] IS NULL
      )
    )
    AND (
      stock.[PurchaseOrderTypeID] = allMonths.[PurchaseOrderTypeID]
      OR (
        stock.[PurchaseOrderTypeID] IS NULL
        AND
        allMonths.[PurchaseOrderTypeID] IS NULL
      )
    )
    AND (
      stock.[InventoryValuationTypeID] = allMonths.[InventoryValuationTypeID]
      OR (
        stock.[InventoryValuationTypeID] IS NULL
        AND
        allMonths.[InventoryValuationTypeID] IS NULL
      )
    )
    -- AND (
    --   stock.[YearWeek] = allMonths.[YearWeek]
    --   OR (
    --     stock.[YearWeek] IS NULL
    --     AND
    --     allMonths.[YearWeek] IS NULL
    --   )
    -- )
    AND (
      stock.[YearMonth] = allMonths.[YearMonth]
      OR (
        stock.[YearMonth] IS NULL
        -- AND
        -- allMonths.[YearMonth] IS NULL
      )
    )
