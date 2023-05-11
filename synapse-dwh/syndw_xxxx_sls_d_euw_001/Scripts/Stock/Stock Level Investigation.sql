select top 100 *
from [edw].[fact_MaterialStockLevel]
where MaterialID = 'HALF-0754.060-00006'
and PlantID = '5300A' and StorageLocationID = '5300AA'
order by ReportingYear, ReportingMonth

--  6.647.975 on QAS on 2023-04-17
select count(*) from [edw].[fact_MaterialStockLevel]

--  1.387.842 on QAS on 2023-04-20
select count(*) from [dm_scm].[vw_fact_MaterialStockLevel_Weekly]

select top 100 *
from [edw].[fact_MaterialDocumentItem]
where MaterialID = 'HALF-0754.060-00006'
and PlantID = '5300A' and StorageLocationID = '5300AA'
-- order by ReportingYear, ReportingMonth

-- 12.001.124 on QAS on 2023-04-17
--    301.841 on MPS on 2023-04-17
select count(*) from [edw].[fact_MaterialDocumentItem]

-- 28.175.025 on QAS on 2023-04-17
--         82 on MPS on 2023-04-17
--  1.453.350 on QAS on 2023-04-24
select count(*) from [edw].[vw_MaterialStockLevel_Weekly]
select * from [edw].[vw_MaterialStockLevel_Weekly]

-- Base daily level stock change
select top 100 
  [Material],
  [Plant],
  [StorageLocation],
  [InventorySpecialStockType],
  [InventoryStockType],
  [StockOwner],
  [CostCenter],
  [CompanyCode],
  -- [SalesDocumentTypeID],
  -- [SalesDocumentItemCategoryID],
  [MaterialBaseUnit],
  -- [PurchaseOrderTypeID],
  PostingDate,
  -- SUM(MatlStkChangeQtyInBaseUnit) AS 
  MatlStkChangeQtyInBaseUnit--,
  -- SUM(ConsumptionQty) AS 
  -- ConsumptionQty
from [base_s4h_cax].[I_MaterialDocumentItem]

-- Base weekly level stock change
select top 100 
  [Material],
  [Plant],
  [StorageLocation],
  [InventorySpecialStockType],
  [InventoryStockType],
  [StockOwner],
  [CostCenter],
  [CompanyCode],
  -- [SalesDocumentTypeID],
  -- [SalesDocumentItemCategoryID],
  [MaterialBaseUnit],
  -- [PurchaseOrderTypeID],
  --PostingDate,
  Cal.YearWeek,
  SUM(MatlStkChangeQtyInBaseUnit) AS MatlStkChangeQtyInBaseUnit--,
  -- SUM(ConsumptionQty) AS 
  -- ConsumptionQty
from [base_s4h_cax].[I_MaterialDocumentItem] AS MDI
left join edw.dim_Calendar AS Cal
  on Cal.CalendarDate = MDI.PostingDate
where Material <> ''
group by 
  [Material],
  [Plant],
  [StorageLocation],
  [InventorySpecialStockType],
  [InventoryStockType],
  [StockOwner],
  [CostCenter],
  [CompanyCode],
  -- [SalesDocumentTypeID],
  -- [SalesDocumentItemCategoryID],
  [MaterialBaseUnit],
  -- [PurchaseOrderTypeID],
  --PostingDate,
  Cal.YearWeek
order by [Material],
  [Plant],
  [StorageLocation],
  [InventorySpecialStockType],
  [InventoryStockType],
  [StockOwner],
  [CostCenter],
  [CompanyCode],
  YearWeek

select top 100 *
from edw.dim_Calendar
-- where 
order by CalendarDate

/*
1. Aggregate stock changes on a weekly level
2. Get the first posting date of each hash
3. Get the corresponding year week of the first posting date
4. Add the missing yearWeeks for each hash based on calendar table
5. Get the stock changes for the missing weeks
6. Calculate the stock levels for each combo of yearWeek and hash
*/



DECLARE
  @date DATE = GETDATE(),
  -- @hash CHAR(32) = '822451011BB1F2F049B6E64B60DEE07C'; --few changes
  @hash CHAR(32) = '4DF5CE888E16CA5F3B07CFC872AE52D6'; --lots changes
DECLARE
  @CurrentYearWeek CHAR(6) = CONCAT(YEAR(@date), DATEPART(week, @date));

WITH 

-- 1. Aggregate stock change on weekly level
WeeklyMatlStkChangeQtyInBaseUnit AS (
  SELECT top 100
    _hash
    -- , HDR_PostingDate
    , YearWeek
    , SUM(MatlStkChangeQtyInBaseUnit) AS WeeklyMatlStkChangeQtyInBaseUnit
  FROM
    [edw].[fact_MaterialDocumentItem] AS MDI
  LEFT JOIN
    [edw].[dim_Calendar] AS cal
    ON cal.CalendarDate = MDI.HDR_PostingDate
  WHERE
    _hash = @hash
  GROUP BY
    _hash
    , YearWeek
  -- ORDER BY
  --   YearWeek
)

-- 2. Get the first posting date for each hash
, FirstPostingDate AS (
  select
    _hash,
    MIN(HDR_PostingDate) AS FirstPostingDate
  from [edw].[fact_MaterialDocumentItem] AS MDI
  WHERE
    _hash = @hash
  group by _hash
)

-- 3. Get the YearWeek of the first posting date
, FirstYearWeek AS (
  SELECT
    _hash,
    YearWeek AS FirstYearWeek
  FROM
    FirstPostingDate
  LEFT JOIN
    [edw].[dim_Calendar] AS cal
    ON cal.CalendarDate = FirstPostingDate.FirstPostingDate
)

-- 4. Add the missing yearWeeks for each hash based on calendar table
, YearWeeks AS (
  SELECT
    YearWeek
  FROM
    [edw].[dim_Calendar]
  GROUP BY
    YearWeek
)

, MissingYearWeeks AS (
  SELECT
    _hash,
    YearWeek
  FROM
    FirstYearWeek
  CROSS JOIN
    YearWeeks
  WHERE
    YearWeeks.YearWeek BETWEEN FirstYearWeek AND @CurrentYearWeek
  -- ORDER BY YearWeek
)

-- 5. Get the stock changes for the missing weeks
, StockChanges AS (
  SELECT
    Weeks._hash,
    Weeks.YearWeek,
    WeeklyMatlStkChangeQtyInBaseUnit
  FROM
    MissingYearWeeks AS Weeks
  LEFT JOIN
    WeeklyMatlStkChangeQtyInBaseUnit AS Weekly
    ON
      Weekly._hash = Weeks._hash
      AND
      Weekly.YearWeek = Weeks.YearWeek
  -- ORDER BY
  --   YearWeek
)

-- 6. Calculate the stock levels for each combo of yearWeek and hash
SELECT
  _hash,
  YearWeek,
  WeeklyMatlStkChangeQtyInBaseUnit,
  SUM(WeeklyMatlStkChangeQtyInBaseUnit) OVER (PARTITION BY _hash ORDER BY YearWeek) AS StockLevelQtyInBaseUnit
FROM
  StockChanges

