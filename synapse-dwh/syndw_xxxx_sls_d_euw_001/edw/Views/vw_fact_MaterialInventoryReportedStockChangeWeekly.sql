CREATE VIEW [edw].[vw_fact_MaterialInventoryReportedStockChangeWeekly]
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


-- 1. Aggregate stock change on weekly and monthly level
SELECT
  MDI.[MaterialID]
, MDI.[PlantID]
, MDI.[StorageLocationID]
, MDI.[InventorySpecialStockTypeID]
, MDI.[InventoryStockTypeID]
, MDI.[StockOwner]
, MDI.[CostCenterID]
, MDI.[CompanyCodeID]
, MDI.[SalesDocumentTypeID]
, MDI.[SalesDocumentItemCategoryID]
, MDI.[MaterialBaseUnitID]
, MDI.[PurchaseOrderTypeID]
, MDI.[InventoryValuationTypeID]
, cal.[YearWeek]
, SUM(MDI.MatlStkChangeQtyInBaseUnit) AS MatlStkChangeQtyInBaseUnit
, SUM(MDI.ConsumptionQtyICPOInStandardValue_EUR) AS ConsumptionQtyICPOInStandardValue_EUR
, SUM(MDI.ConsumptionQtyICPOInStandardValue_USD) AS ConsumptionQtyICPOInStandardValue_USD
, SUM(MDI.ConsumptionQtyOBDProStandardValue) AS ConsumptionQtyOBDProStandardValue
, SUM(MDI.ConsumptionQtyOBDProStandardValue_EUR) AS ConsumptionQtyOBDProStandardValue_EUR
, SUM(MDI.ConsumptionQtyOBDProStandardValue_USD) AS ConsumptionQtyOBDProStandardValue_USD
, SUM(MDI.ConsumptionQtySOStandardValue) AS ConsumptionQtySOStandardValue
, SUM(MDI.ConsumptionQtySOStandardValue_EUR) AS ConsumptionQtySOStandardValue_EUR
, SUM(MDI.ConsumptionQtySOStandardValue_USD) AS ConsumptionQtySOStandardValue_USD
, SUM(MDI.ConsumptionQty) AS ConsumptionQty
, SUM(MDI.ConsumptionValueByLatestPriceInBaseValue) AS ConsumptionValueByLatestPriceInBaseValue
, SUM(MDI.ConsumptionValueByLatestPrice_EUR) AS ConsumptionValueByLatestPrice_EUR
, SUM(MDI.ConsumptionValueByLatestPrice_USD) AS ConsumptionValueByLatestPrice_USD
, MDI.[t_applicationId]
FROM
  [edw].[fact_MaterialDocumentItem] AS MDI
LEFT JOIN
  [edw].[dim_Calendar] AS cal
  ON
    cal.CalendarDate = MDI.HDR_PostingDate
-- WHERE
--   MDI.t_applicationId LIKE '%s4h%' -- TODO filter on S4H only now
GROUP BY
  MDI.[MaterialID]
, MDI.[PlantID]
, MDI.[StorageLocationID]
, MDI.[InventorySpecialStockTypeID]
, MDI.[InventoryStockTypeID]
, MDI.[StockOwner]
, MDI.[CostCenterID]
, MDI.[CompanyCodeID]
, MDI.[SalesDocumentTypeID]
, MDI.[SalesDocumentItemCategoryID]
, MDI.[MaterialBaseUnitID]
, MDI.[PurchaseOrderTypeID]
, MDI.[InventoryValuationTypeID]
, cal.[YearWeek]
, MDI.[t_applicationId]
