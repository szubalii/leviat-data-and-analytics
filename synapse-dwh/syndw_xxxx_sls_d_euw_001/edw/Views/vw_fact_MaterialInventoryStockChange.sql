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
, allWeeks.[YearWeek]
, stockChangeWeekly.[WeeklyMatlStkChangeQtyInBaseUnit]
, allWeeks.[YearMonth]
, stockChangeMonthly.[MonthlyMatlStkChangeQtyInBaseUnit]
-- , allWeeks.[IsWeekly]
-- , allWeeks.[IsMonthly]
, allWeeks.[FirstDayOfMonthDate]
FROM
  [edw].[vw_fact_MaterialInventoryAllWeeksAndMonths] allWeeks
LEFT JOIN
  [edw].[vw_fact_MaterialInventoryReportedStockChangeWeekly] stockChangeWeekly
  ON
  -- Weekly._hash = Weeks._hash
  -- Join on all required fields
  -- Include checks for cases when one or both fields are NULL
    stockChangeWeekly.[MaterialID] = allWeeks.[MaterialID]
    AND (
    stockChangeWeekly.[PlantID] = allWeeks.[PlantID]
      OR (
        stockChangeWeekly.[PlantID] IS NULL
        AND
        allWeeks.[PlantID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[StorageLocationID] = allWeeks.[StorageLocationID]
      OR (
        stockChangeWeekly.[StorageLocationID] IS NULL
        AND
        allWeeks.[StorageLocationID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[InventorySpecialStockTypeID] = allWeeks.[InventorySpecialStockTypeID]
      OR (
        stockChangeWeekly.[InventorySpecialStockTypeID] IS NULL
        AND
        allWeeks.[InventorySpecialStockTypeID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[InventoryStockTypeID] = allWeeks.[InventoryStockTypeID]
      OR (
        stockChangeWeekly.[InventoryStockTypeID] IS NULL
        AND
        allWeeks.[InventoryStockTypeID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[StockOwner] = allWeeks.[StockOwner]
      OR (
        stockChangeWeekly.[StockOwner] IS NULL
        AND
        allWeeks.[StockOwner] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[CostCenterID] = allWeeks.[CostCenterID]
      OR (
        stockChangeWeekly.[CostCenterID] IS NULL
        AND
        allWeeks.[CostCenterID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[CompanyCodeID] = allWeeks.[CompanyCodeID]
      OR (
        stockChangeWeekly.[CompanyCodeID] IS NULL
        AND
        allWeeks.[CompanyCodeID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[SalesDocumentTypeID] = allWeeks.[SalesDocumentTypeID]
      OR (
        stockChangeWeekly.[SalesDocumentTypeID] IS NULL
        AND
        allWeeks.[SalesDocumentTypeID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[SalesDocumentItemCategoryID] = allWeeks.[SalesDocumentItemCategoryID]
      OR (
        stockChangeWeekly.[SalesDocumentItemCategoryID] IS NULL
        AND
        allWeeks.[SalesDocumentItemCategoryID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[MaterialBaseUnitID] = allWeeks.[MaterialBaseUnitID]
      OR (
        stockChangeWeekly.[MaterialBaseUnitID] IS NULL
        AND
        allWeeks.[MaterialBaseUnitID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[PurchaseOrderTypeID] = allWeeks.[PurchaseOrderTypeID]
      OR (
        stockChangeWeekly.[PurchaseOrderTypeID] IS NULL
        AND
        allWeeks.[PurchaseOrderTypeID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[InventoryValuationTypeID] = allWeeks.[InventoryValuationTypeID]
      OR (
        stockChangeWeekly.[InventoryValuationTypeID] IS NULL
        AND
        allWeeks.[InventoryValuationTypeID] IS NULL
      )
    )
    AND (
      stockChangeWeekly.[YearWeek] = allWeeks.[YearWeek]
      -- OR (
      --   stockChangeWeekly.[YearWeek] IS NULL
      --   AND
      --   allWeeks.[YearWeek] IS NULL
      -- )
    )
    -- AND
    -- allWeeks.IsWeekly = 1

LEFT JOIN
  [edw].[vw_fact_MaterialInventoryReportedStockChangeMonthly] stockChangeMonthly
  ON
  -- Weekly._hash = Weeks._hash
  -- Join on all required fields
  -- Include checks for cases when one or both fields are NULL
    stockChangeMonthly.[MaterialID] = allWeeks.[MaterialID]
    AND (
    stockChangeMonthly.[PlantID] = allWeeks.[PlantID]
      OR (
        stockChangeMonthly.[PlantID] IS NULL
        AND
        allWeeks.[PlantID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[StorageLocationID] = allWeeks.[StorageLocationID]
      OR (
        stockChangeMonthly.[StorageLocationID] IS NULL
        AND
        allWeeks.[StorageLocationID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[InventorySpecialStockTypeID] = allWeeks.[InventorySpecialStockTypeID]
      OR (
        stockChangeMonthly.[InventorySpecialStockTypeID] IS NULL
        AND
        allWeeks.[InventorySpecialStockTypeID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[InventoryStockTypeID] = allWeeks.[InventoryStockTypeID]
      OR (
        stockChangeMonthly.[InventoryStockTypeID] IS NULL
        AND
        allWeeks.[InventoryStockTypeID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[StockOwner] = allWeeks.[StockOwner]
      OR (
        stockChangeMonthly.[StockOwner] IS NULL
        AND
        allWeeks.[StockOwner] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[CostCenterID] = allWeeks.[CostCenterID]
      OR (
        stockChangeMonthly.[CostCenterID] IS NULL
        AND
        allWeeks.[CostCenterID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[CompanyCodeID] = allWeeks.[CompanyCodeID]
      OR (
        stockChangeMonthly.[CompanyCodeID] IS NULL
        AND
        allWeeks.[CompanyCodeID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[SalesDocumentTypeID] = allWeeks.[SalesDocumentTypeID]
      OR (
        stockChangeMonthly.[SalesDocumentTypeID] IS NULL
        AND
        allWeeks.[SalesDocumentTypeID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[SalesDocumentItemCategoryID] = allWeeks.[SalesDocumentItemCategoryID]
      OR (
        stockChangeMonthly.[SalesDocumentItemCategoryID] IS NULL
        AND
        allWeeks.[SalesDocumentItemCategoryID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[MaterialBaseUnitID] = allWeeks.[MaterialBaseUnitID]
      OR (
        stockChangeMonthly.[MaterialBaseUnitID] IS NULL
        AND
        allWeeks.[MaterialBaseUnitID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[PurchaseOrderTypeID] = allWeeks.[PurchaseOrderTypeID]
      OR (
        stockChangeMonthly.[PurchaseOrderTypeID] IS NULL
        AND
        allWeeks.[PurchaseOrderTypeID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[InventoryValuationTypeID] = allWeeks.[InventoryValuationTypeID]
      OR (
        stockChangeMonthly.[InventoryValuationTypeID] IS NULL
        AND
        allWeeks.[InventoryValuationTypeID] IS NULL
      )
    )
    AND (
      stockChangeMonthly.[YearMonth] = allWeeks.[YearMonth]
      -- OR (
      --   stockChangeMonthly.[YearMonth] IS NULL
      --   AND
      --   allWeeks.[YearMonth] IS NULL
      -- )
    )
    -- AND
    -- allWeeks.IsMonthly = 1