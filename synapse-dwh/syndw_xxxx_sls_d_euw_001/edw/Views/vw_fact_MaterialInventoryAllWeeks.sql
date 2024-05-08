CREATE VIEW [edw].[vw_fact_MaterialInventoryAllWeeks]
AS
WITH
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
  , cal.[CalendarYear] AS [FirstPostingYear]
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
  -- WHERE
  --   fp.MaterialID = '000000007000001725'
  --   AND
  --   InventorySpecialStockTypeID = ''
  --   AND
  --   InventoryStockTypeID = '01'
  --   AND
  --   CostCenterID = ''
  --   AND
  --   SalesDocumentTypeID is NULL
  --   AND
  --   SalesDocumentItemCategoryID IS NULL
)
,
AllYearWeeks AS (
  SELECT --top 100
    [CalendarYear],
    YearMonth,
    CalendarMonth,
    YearWeek,
    CalendarWeek,
    LastDayOfMonthDate,
    -- 0 AS IsMonthly,
    -- CASE
    --   WHEN CalendarDate = LastDayOfMonthDate THEN 1 ELSE 0
    -- END AS IsMonthly,
    -- FirstDayOfWeekDate AS ReportingDate,
    MAX(CalendarDate) AS MaxPostingDate,
  -- If a weeks falls in two months, take the first month
  -- as that is required to get the monthly StockPricePerUnit
    MIN(FirstDayOfMonthDate) AS FirstDayOfMonthDate
  FROM
    [edw].[dim_Calendar]
  -- WHERE
  --   YearMonth = '202402' OR YearMonth = '202401'
  GROUP BY
    [CalendarYear],
    YearMonth,
    CalendarMonth,
    YearWeek,
    CalendarWeek,
    LastDayOfMonthDate
)
,

IsMonthly AS (
  SELECT
    [CalendarYear],
    YearMonth,
    CalendarMonth,
    YearWeek,
    CalendarWeek,
    -- LastDayOfMonthDate,
    CASE
      WHEN MaxPostingDate = LastDayOfMonthDate THEN 1 ELSE 0
    END AS IsMonthly,
  -- required to get the monthly StockPricePerUnit
  -- If a weeks falls in two months, take the first month
    -- FirstDayOfWeekDate AS ReportingDate,
    MaxPostingDate,
    FirstDayOfMonthDate
  FROM
    AllYearWeeks
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
, IsMonthly.[CalendarYear]
, IsMonthly.[YearMonth]
, IsMonthly.[CalendarMonth]
, IsMonthly.[YearWeek]
, IsMonthly.[CalendarWeek]
, IsMonthly.[MaxPostingDate]
, IsMonthly.[IsMonthly]
, IsMonthly.[FirstDayOfMonthDate]
, fw.[t_applicationId]
, fw.[t_extractionDtm]
FROM
  FirstPostingCal fw
CROSS JOIN
  IsMonthly
WHERE
  IsMonthly.YearWeek BETWEEN fw.FirstPostingYearWeek AND
    -- Construct YearWeek based on current date
    CONCAT(YEAR(GETDATE()), DATEPART(week, GETDATE()))
-- order by YearMonth, YearWeek