CREATE VIEW [edw].[vw_fact_MaterialInventoryStockChange]
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
WITH _union AS (
  SELECT
    stockChangeWeekly.[MaterialID]
  , stockChangeWeekly.[PlantID]
  , stockChangeWeekly.[StorageLocationID]
  , stockChangeWeekly.[InventorySpecialStockTypeID]
  , stockChangeWeekly.[InventoryStockTypeID]
  , stockChangeWeekly.[StockOwner]
  , stockChangeWeekly.[CostCenterID]
  , stockChangeWeekly.[CompanyCodeID]
  , stockChangeWeekly.[SalesDocumentTypeID]
  , stockChangeWeekly.[SalesDocumentItemCategoryID]
  , stockChangeWeekly.[MaterialBaseUnitID]
  , stockChangeWeekly.[PurchaseOrderTypeID]
  , stockChangeWeekly.[InventoryValuationTypeID]
  , stockChangeWeekly.[YearWeek]
  , NULL AS [YearMonth]
  , stockChangeWeekly.[MatlStkChangeQtyInBaseUnit]
  , stockChangeWeekly.[ConsumptionQtyICPOInStandardValue_EUR]
  , stockChangeWeekly.[ConsumptionQtyICPOInStandardValue_USD]
  , stockChangeWeekly.[ConsumptionQtyOBDProStandardValue]
  , stockChangeWeekly.[ConsumptionQtyOBDProStandardValue_EUR]
  , stockChangeWeekly.[ConsumptionQtyOBDProStandardValue_USD]
  , stockChangeWeekly.[ConsumptionQtySOStandardValue]
  , stockChangeWeekly.[ConsumptionQtySOStandardValue_EUR]
  , stockChangeWeekly.[ConsumptionQtySOStandardValue_USD]
  , stockChangeWeekly.[ConsumptionQty]
  , stockChangeWeekly.[ConsumptionValueByLatestPriceInBaseValue]
  , stockChangeWeekly.[ConsumptionValueByLatestPrice_EUR]
  , stockChangeWeekly.[ConsumptionValueByLatestPrice_USD]
  FROM
    [edw].[vw_fact_MaterialInventoryReportedStockChangeWeekly] AS stockChangeWeekly

  UNION ALL

  SELECT
    stockChangeMonthly.[MaterialID]
  , stockChangeMonthly.[PlantID]
  , stockChangeMonthly.[StorageLocationID]
  , stockChangeMonthly.[InventorySpecialStockTypeID]
  , stockChangeMonthly.[InventoryStockTypeID]
  , stockChangeMonthly.[StockOwner]
  , stockChangeMonthly.[CostCenterID]
  , stockChangeMonthly.[CompanyCodeID]
  , stockChangeMonthly.[SalesDocumentTypeID]
  , stockChangeMonthly.[SalesDocumentItemCategoryID]
  , stockChangeMonthly.[MaterialBaseUnitID]
  , stockChangeMonthly.[PurchaseOrderTypeID]
  , stockChangeMonthly.[InventoryValuationTypeID]
  , NULL AS [YearWeek]
  , stockChangeMonthly.[YearMonth]
  , stockChangeMonthly.[MatlStkChangeQtyInBaseUnit]
  , stockChangeMonthly.[ConsumptionQtyICPOInStandardValue_EUR]
  , stockChangeMonthly.[ConsumptionQtyICPOInStandardValue_USD]
  , stockChangeMonthly.[ConsumptionQtyOBDProStandardValue]
  , stockChangeMonthly.[ConsumptionQtyOBDProStandardValue_EUR]
  , stockChangeMonthly.[ConsumptionQtyOBDProStandardValue_USD]
  , stockChangeMonthly.[ConsumptionQtySOStandardValue]
  , stockChangeMonthly.[ConsumptionQtySOStandardValue_EUR]
  , stockChangeMonthly.[ConsumptionQtySOStandardValue_USD]
  , stockChangeMonthly.[ConsumptionQty]
  , stockChangeMonthly.[ConsumptionValueByLatestPriceInBaseValue]
  , stockChangeMonthly.[ConsumptionValueByLatestPrice_EUR]
  , stockChangeMonthly.[ConsumptionValueByLatestPrice_USD]
  FROM
    [edw].[vw_fact_MaterialInventoryReportedStockChangeMonthly] AS stockChangeMonthly
)

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
, allWeeks.[ReportingDate]
, allWeeks.[FirstDayOfMonthDate]
, allWeeks.[YearWeek]
-- , stockChangeWeekly.[WeeklyMatlStkChangeQtyInBaseUnit]
, allWeeks.[YearMonth]
, _union.[MatlStkChangeQtyInBaseUnit]
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
-- , stockChangeMonthly.[MonthlyMatlStkChangeQtyInBaseUnit]
-- , allWeeks.[IsWeekly]
-- , allWeeks.[IsMonthly]
FROM
  [edw].[vw_fact_MaterialInventoryAllWeeksAndMonths] allWeeks
LEFT JOIN
  _union
  ON
  -- Weekly._hash = Weeks._hash
  -- Join on all required fields
  -- Include checks for cases when one or both fields are NULL
    _union.[MaterialID] = allWeeks.[MaterialID]
    AND (
    _union.[PlantID] = allWeeks.[PlantID]
      OR (
        _union.[PlantID] IS NULL
        AND
        allWeeks.[PlantID] IS NULL
      )
    )
    AND (
      _union.[StorageLocationID] = allWeeks.[StorageLocationID]
      OR (
        _union.[StorageLocationID] IS NULL
        AND
        allWeeks.[StorageLocationID] IS NULL
      )
    )
    AND (
      _union.[InventorySpecialStockTypeID] = allWeeks.[InventorySpecialStockTypeID]
      OR (
        _union.[InventorySpecialStockTypeID] IS NULL
        AND
        allWeeks.[InventorySpecialStockTypeID] IS NULL
      )
    )
    AND (
      _union.[InventoryStockTypeID] = allWeeks.[InventoryStockTypeID]
      OR (
        _union.[InventoryStockTypeID] IS NULL
        AND
        allWeeks.[InventoryStockTypeID] IS NULL
      )
    )
    AND (
      _union.[StockOwner] = allWeeks.[StockOwner]
      OR (
        _union.[StockOwner] IS NULL
        AND
        allWeeks.[StockOwner] IS NULL
      )
    )
    AND (
      _union.[CostCenterID] = allWeeks.[CostCenterID]
      OR (
        _union.[CostCenterID] IS NULL
        AND
        allWeeks.[CostCenterID] IS NULL
      )
    )
    AND (
      _union.[CompanyCodeID] = allWeeks.[CompanyCodeID]
      OR (
        _union.[CompanyCodeID] IS NULL
        AND
        allWeeks.[CompanyCodeID] IS NULL
      )
    )
    AND (
      _union.[SalesDocumentTypeID] = allWeeks.[SalesDocumentTypeID]
      OR (
        _union.[SalesDocumentTypeID] IS NULL
        AND
        allWeeks.[SalesDocumentTypeID] IS NULL
      )
    )
    AND (
      _union.[SalesDocumentItemCategoryID] = allWeeks.[SalesDocumentItemCategoryID]
      OR (
        _union.[SalesDocumentItemCategoryID] IS NULL
        AND
        allWeeks.[SalesDocumentItemCategoryID] IS NULL
      )
    )
    AND (
      _union.[MaterialBaseUnitID] = allWeeks.[MaterialBaseUnitID]
      OR (
        _union.[MaterialBaseUnitID] IS NULL
        AND
        allWeeks.[MaterialBaseUnitID] IS NULL
      )
    )
    AND (
      _union.[PurchaseOrderTypeID] = allWeeks.[PurchaseOrderTypeID]
      OR (
        _union.[PurchaseOrderTypeID] IS NULL
        AND
        allWeeks.[PurchaseOrderTypeID] IS NULL
      )
    )
    AND (
      _union.[InventoryValuationTypeID] = allWeeks.[InventoryValuationTypeID]
      OR (
        _union.[InventoryValuationTypeID] IS NULL
        AND
        allWeeks.[InventoryValuationTypeID] IS NULL
      )
    )
    AND (
      _union.[YearWeek] = allWeeks.[YearWeek]
      OR (
        _union.[YearWeek] IS NULL
        AND
        allWeeks.[YearWeek] IS NULL
      )
    )
    AND (
      _union.[YearMonth] = allWeeks.[YearMonth]
      OR (
        _union.[YearMonth] IS NULL
        AND
        allWeeks.[YearMonth] IS NULL
      )
    )
      -- OR (
      --   stockChangeWeekly.[YearWeek] IS NULL
      --   AND
      --   allWeeks.[YearWeek] IS NULL
      -- )
    -- AND
    -- allWeeks.IsWeekly = 1

-- LEFT JOIN
--   [edw].[vw_fact_MaterialInventoryReportedStockChangeMonthly] stockChangeMonthly
--   ON
--   -- Weekly._hash = Weeks._hash
--   -- Join on all required fields
--   -- Include checks for cases when one or both fields are NULL
--     stockChangeMonthly.[MaterialID] = allWeeks.[MaterialID]
--     AND (
--     stockChangeMonthly.[PlantID] = allWeeks.[PlantID]
--       OR (
--         stockChangeMonthly.[PlantID] IS NULL
--         AND
--         allWeeks.[PlantID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[StorageLocationID] = allWeeks.[StorageLocationID]
--       OR (
--         stockChangeMonthly.[StorageLocationID] IS NULL
--         AND
--         allWeeks.[StorageLocationID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[InventorySpecialStockTypeID] = allWeeks.[InventorySpecialStockTypeID]
--       OR (
--         stockChangeMonthly.[InventorySpecialStockTypeID] IS NULL
--         AND
--         allWeeks.[InventorySpecialStockTypeID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[InventoryStockTypeID] = allWeeks.[InventoryStockTypeID]
--       OR (
--         stockChangeMonthly.[InventoryStockTypeID] IS NULL
--         AND
--         allWeeks.[InventoryStockTypeID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[StockOwner] = allWeeks.[StockOwner]
--       OR (
--         stockChangeMonthly.[StockOwner] IS NULL
--         AND
--         allWeeks.[StockOwner] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[CostCenterID] = allWeeks.[CostCenterID]
--       OR (
--         stockChangeMonthly.[CostCenterID] IS NULL
--         AND
--         allWeeks.[CostCenterID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[CompanyCodeID] = allWeeks.[CompanyCodeID]
--       OR (
--         stockChangeMonthly.[CompanyCodeID] IS NULL
--         AND
--         allWeeks.[CompanyCodeID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[SalesDocumentTypeID] = allWeeks.[SalesDocumentTypeID]
--       OR (
--         stockChangeMonthly.[SalesDocumentTypeID] IS NULL
--         AND
--         allWeeks.[SalesDocumentTypeID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[SalesDocumentItemCategoryID] = allWeeks.[SalesDocumentItemCategoryID]
--       OR (
--         stockChangeMonthly.[SalesDocumentItemCategoryID] IS NULL
--         AND
--         allWeeks.[SalesDocumentItemCategoryID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[MaterialBaseUnitID] = allWeeks.[MaterialBaseUnitID]
--       OR (
--         stockChangeMonthly.[MaterialBaseUnitID] IS NULL
--         AND
--         allWeeks.[MaterialBaseUnitID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[PurchaseOrderTypeID] = allWeeks.[PurchaseOrderTypeID]
--       OR (
--         stockChangeMonthly.[PurchaseOrderTypeID] IS NULL
--         AND
--         allWeeks.[PurchaseOrderTypeID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[InventoryValuationTypeID] = allWeeks.[InventoryValuationTypeID]
--       OR (
--         stockChangeMonthly.[InventoryValuationTypeID] IS NULL
--         AND
--         allWeeks.[InventoryValuationTypeID] IS NULL
--       )
--     )
--     AND (
--       stockChangeMonthly.[YearMonth] = allWeeks.[YearMonth]
--       -- OR (
--       --   stockChangeMonthly.[YearMonth] IS NULL
--       --   AND
--       --   allWeeks.[YearMonth] IS NULL
--       -- )
--     )
--     -- AND
--     -- allWeeks.IsMonthly = 1