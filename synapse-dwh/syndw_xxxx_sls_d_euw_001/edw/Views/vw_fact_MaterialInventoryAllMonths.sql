CREATE VIEW [edw].[vw_fact_MaterialInventoryAllMonths]
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
  , cal.[YearMonth] AS [FirstPostingYearMonth]
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
AllYearMonths AS (
  -- SELECT
  --   YearWeek,
    -- NULL AS YearMonth,
  -- required to get the monthly StockPricePerUnit
  -- If a weeks falls in two months, take the first month
  --   FirstDayOfWeekDate AS ReportingDate,
  --   MIN(FirstDayOfMonthDate) AS FirstDayOfMonthDate
  -- FROM
  --   [edw].[dim_Calendar]
  -- GROUP BY
  --   YearWeek,
  --   FirstDayOfWeekDate

  -- UNION ALL

  SELECT
    -- NULL AS YearWeek,
    CalendarYear,
    YearMonth,
    CalendarMonth,
    NULL AS YearWeek,
    NULL AS CalendarWeek,
    LastDayOfMonthDate,
    -- 1 AS IsMonthly,
    LastDayOfMonthDate AS MaxPostingDate,
  -- required to get the monthly StockPricePerUnit
    -- FirstDayOfMonthDate AS ReportingDate,
    FirstDayOfMonthDate
  FROM
    [edw].[dim_Calendar]
  GROUP BY
    CalendarYear,
    YearMonth,
    CalendarMonth,
    LastDayOfMonthDate,
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
, AllYearWeeks.[CalendarYear]
, AllYearWeeks.[YearMonth]
, AllYearWeeks.[CalendarMonth]
-- , AllYearWeeks.[YearWeek]
-- , AllYearWeeks.[CalendarWeek]
, AllYearWeeks.[MaxPostingDate]
-- , AllYearWeeks.[IsMonthly]
, AllYearWeeks.[FirstDayOfMonthDate]
, fw.[t_applicationId]
, fw.[t_extractionDtm]
FROM
  FirstPostingCal fw
CROSS JOIN
  AllYearMonths
WHERE
  AllYearMonths.YearMonth BETWEEN fw.FirstPostingYearMonth AND
    -- Construct YearMonth based on current date
    CONCAT(YEAR(GETDATE()), DATEPART(week, GETDATE()));
