CREATE VIEW [edw].[vw_fact_MaterialInventoryAllWeeksAndMonths]
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

-- 4. Add the missing yearWeeks for each hash based on calendar table
WITH
FirstPostingDate AS (
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
  , MIN(HDR_PostingDate) AS FirstPostingDate
  , [t_applicationId]
  , [t_extractionDtm]
  FROM
    [edw].[vw_fact_MaterialDocumentItem_s4h]
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
  , [t_applicationId]
  , [t_extractionDtm]
)
,
FirstPostingCal AS (
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
  , cal.[YearWeek] AS [FirstPostingYearWeek]
  , cal.[YearMonth] AS [FirstPostingYearMonth]
  , fp.[t_applicationId]
  , fp.[t_extractionDtm]
  FROM
    FirstPostingDate AS fp
  LEFT JOIN
    [edw].[dim_Calendar] AS cal
    ON
      cal.CalendarDate = fp.FirstPostingDate
)
,
AllYearWeeks AS (
  SELECT
    YearWeek,
    NULL AS YearMonth,
  -- required to get the monthly StockPricePerUnit
  -- If a weeks falls in two months, take the first month
    FirstDayOfWeekDate AS ReportingDate,
    MIN(FirstDayOfMonthDate) AS FirstDayOfMonthDate
  FROM
    [edw].[dim_Calendar]
  GROUP BY
    YearWeek,
    FirstDayOfWeekDate

  UNION ALL

  SELECT
    NULL AS YearWeek,
    YearMonth,
  -- required to get the monthly StockPricePerUnit
    FirstDayOfMonthDate AS ReportingDate,
    FirstDayOfMonthDate
  FROM
    [edw].[dim_Calendar]
  GROUP BY
    YearMonth,
    FirstDayOfMonthDate
)

SELECT
  fw.[MaterialID]
, fw.[PlantID]
, fw.[StorageLocationID]
, fw.[InventorySpecialStockTypeID]
, fw.[InventoryStockTypeID]
, fw.[StockOwner]
, fw.[CostCenterID]
, fw.[CompanyCodeID]
, fw.[SalesDocumentTypeID]
, fw.[SalesDocumentItemCategoryID]
, fw.[MaterialBaseUnitID]
, fw.[PurchaseOrderTypeID]
, fw.[InventoryValuationTypeID]
, fw.[nk_StoragePlantID]
, fw.[sk_ProductSalesOrg]
, fw.[PlantSalesOrgID]
, AllYearWeeks.[ReportingDate]
, AllYearWeeks.[YearWeek]
, AllYearWeeks.[YearMonth]
, AllYearWeeks.FirstDayOfMonthDate
, fw.[t_applicationId]
, fw.[t_extractionDtm]
FROM
  FirstPostingCal fw
CROSS JOIN
  AllYearWeeks
WHERE
  AllYearWeeks.YearWeek BETWEEN fw.FirstPostingYearWeek AND
    -- Construct YearWeek based on current date
    CONCAT(YEAR(GETDATE()), DATEPART(week, GETDATE()))

  OR

  AllYearWeeks.YearMonth BETWEEN fw.FirstPostingYearMonth AND
    -- Construct YearWeek based on current date
    CONCAT(YEAR(GETDATE()), DATEPART(month, GETDATE()))
