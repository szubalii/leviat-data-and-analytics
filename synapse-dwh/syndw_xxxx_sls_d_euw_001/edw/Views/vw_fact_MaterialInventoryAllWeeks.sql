CREATE VIEW [edw].[vw_fact_MaterialInventoryAllWeeks]
AS WITH
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
  , cal.[Year] AS [FirstPostingYear]
  , cal.[YearMonth] AS [FirstPostingYearMonth]
  , cal.[YearWeek] AS [FirstPostingYearWeek]
  , fp.[t_applicationId]
  , fp.[t_extractionDtm]
  FROM
    edw.vw_fact_MaterialInventoryFirstPostingDate AS fp
  LEFT JOIN
    [edw].[dim_Calendar] AS cal
    ON
      cal.CalendarDate = fp.FirstPostingDate
)
,
AllYearWeeks AS (
  SELECT
    Year,
    YearMonth,
    CalendarMonth,
    YearWeek,
    CalendarWeek,
  -- required to get the monthly StockPricePerUnit
  -- If a weeks falls in two months, take the first month
    -- FirstDayOfWeekDate AS ReportingDate,
    MIN(FirstDayOfMonthDate) AS FirstDayOfMonthDate
  FROM
    [edw].[dim_Calendar]
  GROUP BY
    Year,
    YearMonth,
    CalendarMonth,
    YearWeek,
    CalendarWeek--,
    -- FirstDayOfWeekDate

  -- UNION ALL

  -- SELECT
  --   NULL AS YearWeek,
  --   YearMonth,
  -- -- required to get the monthly StockPricePerUnit
  --   FirstDayOfMonthDate AS ReportingDate,
  --   FirstDayOfMonthDate
  -- FROM
  --   [edw].[dim_Calendar]
  -- GROUP BY
  --   YearMonth,
  --   FirstDayOfMonthDate
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
, AllYearWeeks.[Year]
, AllYearWeeks.[YearMonth]
, AllYearWeeks.[CalendarMonth]
, AllYearWeeks.[YearWeek]
, AllYearWeeks.[CalendarWeek]
-- , AllYearWeeks.[YearMonth]
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
    CONCAT(YEAR(GETDATE()), DATEPART(week, GETDATE()));
