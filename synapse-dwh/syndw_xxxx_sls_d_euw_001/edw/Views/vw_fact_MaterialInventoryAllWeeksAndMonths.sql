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
  , MIN(HDR_PostingDate) AS FirstPostingDate
  , [t_applicationId]
  FROM
    [edw].[fact_MaterialDocumentItem]
  -- WHERE
  --   t_applicationId LIKE '%s4h%' -- TODO filter on S4H only now
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
  , [t_applicationId]
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
  , cal.[YearWeek] AS [FirstPostingYearWeek]
  , cal.[YearMonth] AS [FirstPostingYearMonth]
  , fp.[t_applicationId]
  FROM
    FirstPostingDate AS fp
  LEFT JOIN
    [edw].[dim_Calendar] AS cal
    ON
      cal.CalendarDate = fp.FirstPostingDate
)
,
AllYearWeeks AS (
  SELECT --top 100
    YearWeek,
    NULL AS YearMonth,
    /*
      Add two helper columns that define in cases of duplicate weeks and months
      respectively which rows to take when retrieving stock levels
    */
    -- CASE
    --   WHEN MAX(YearMonth) OVER(PARTITION BY YearWeek) = YearMonth THEN 1 
    -- END AS IsWeekly,
    -- CASE
    --   WHEN MAX(YearWeek) OVER(PARTITION BY YearMonth) = YearWeek THEN 1 
    -- END AS IsMonthly,
  -- required to get the monthly StockPricePerUnit
  -- If a weeks falls in two months, take the first month
    FirstDayOfWeekDate AS ReportingDate,
    MIN(FirstDayOfMonthDate) AS FirstDayOfMonthDate
  FROM
    [edw].[dim_Calendar]
  GROUP BY
    YearWeek,
    FirstDayOfWeekDate
    -- YearMonth
  --Order by YearWeek, YearMonth
  UNION ALL

  SELECT --top 100
    NULL AS YearWeek,
    YearMonth,
    /*
      Add two helper columns that define in cases of duplicate weeks and months
      respectively which rows to take when retrieving stock levels
    */
    -- CASE
    --   WHEN MAX(YearMonth) OVER(PARTITION BY YearWeek) = YearMonth THEN 1 
    -- END AS IsWeekly,
    -- CASE
    --   WHEN MAX(YearWeek) OVER(PARTITION BY YearMonth) = YearWeek THEN 1 
    -- END AS IsMonthly,
  -- required to get the monthly StockPricePerUnit
  -- If a weeks falls in two months, take the first month
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
, AllYearWeeks.[ReportingDate]
, AllYearWeeks.[YearWeek]
, AllYearWeeks.[YearMonth]
-- , AllYearWeeks.IsWeekly
-- , AllYearWeeks.IsMonthly
, AllYearWeeks.FirstDayOfMonthDate
, fw.[t_applicationId]
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
