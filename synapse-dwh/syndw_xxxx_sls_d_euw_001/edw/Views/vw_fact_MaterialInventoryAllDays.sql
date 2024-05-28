CREATE VIEW [edw].[vw_fact_MaterialInventoryAllDays]
AS
WITH
AllDays AS (
  SELECT 
    [CalendarYear],
    YearMonth,
    CalendarMonth,
    YearWeek,
    CalendarWeek,
    CalendarDate,
    LastDayOfMonthDate,
  -- If a weeks falls in two months, take the first month
  -- as that is required to get the monthly StockPricePerUnit
    FirstDayOfMonthDate
  FROM
    [edw].[dim_Calendar]
  WHERE
    CalendarYear >= 2018 -- TODO check if correct
    AND
    CalendarYear <= YEAR(GETDATE())
)

-- Select all days between the first posting date and current date
SELECT
  fp.[MaterialID]
, fp.[PlantID]
, fp.[StorageLocationID]
, fp.[InventorySpecialStockTypeID]
, fp.[InventoryStockTypeID]
, fp.[StockOwner]
, fp.[CostCenterID]
, fp.[CompanyCodeID]
, fp.[SalesDocumentTypeID]
, fp.[SalesDocumentItemCategoryID]
, fp.[MaterialBaseUnitID]
, fp.[PurchaseOrderTypeID]
, fp.[InventoryValuationTypeID]
, fp.[nk_StoragePlantID]
, fp.[sk_ProductSalesOrg]
, fp.[PlantSalesOrgID]
, AllDays.[CalendarYear]
, AllDays.[YearMonth]
, AllDays.[CalendarMonth]
, AllDays.[YearWeek]
, AllDays.[CalendarWeek]
, AllDays.[CalendarDate]
, NULL AS [IsMonthly]
, AllDays.[FirstDayOfMonthDate]
, fp.[t_applicationId]
, fp.[t_extractionDtm]
FROM
  edw.vw_fact_MaterialInventoryFirstPostingDate fp
CROSS JOIN
  AllDays
WHERE
  AllDays.CalendarDate BETWEEN fp.FirstPostingDate AND GETDATE()
