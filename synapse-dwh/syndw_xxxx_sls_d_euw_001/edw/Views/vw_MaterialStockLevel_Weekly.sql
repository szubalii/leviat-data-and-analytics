CREATE VIEW [edw].[vw_MaterialStockLevel_Weekly]
AS  

/*
1. Aggregate stock changes on a weekly level
2. Get the first posting date of each hash
3. Get the corresponding year week of the first posting date
4. Add the missing yearWeeks for each hash based on calendar table
5. Get the stock changes for the missing weeks
6. Calculate the stock levels for each combo of yearWeek and hash
*/

-- DECLARE
--   @date DATE = GETDATE(),
--   -- @hash CHAR(32) = '822451011BB1F2F049B6E64B60DEE07C'; --few changes
--   @hash CHAR(32) = '4DF5CE888E16CA5F3B07CFC872AE52D6'; --lots changes
-- DECLARE
--   @CurrentYearWeek CHAR(6) = CONCAT(YEAR(@date), DATEPART(week, @date));

WITH 

-- 1. Aggregate stock change on weekly level
WeeklyMatlStkChangeQtyInBaseUnit AS (
  SELECT
    _hash
    , YearWeek
    , SUM(MatlStkChangeQtyInBaseUnit) AS WeeklyMatlStkChangeQtyInBaseUnit
  FROM
    [edw].[fact_MaterialDocumentItem] AS MDI
  LEFT JOIN
    [edw].[dim_Calendar] AS cal
    ON cal.CalendarDate = MDI.HDR_PostingDate
  -- WHERE
  --   _hash = @hash
  GROUP BY
    _hash
    , YearWeek
  -- ORDER BY
  --   YearWeek
)

-- 2. Get the first posting date for each hash
, FirstPostingDate AS (
  SELECT
    _hash,
    MIN(HDR_PostingDate) AS FirstPostingDate
  FROM
    [edw].[fact_MaterialDocumentItem] AS MDI
  -- WHERE
  --   _hash = @hash
  GROUP BY _hash
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
    YearWeeks.YearWeek BETWEEN 
      FirstYearWeek 
      AND 
      -- Construct YearWeek based on current date
      CONCAT(YEAR(GETDATE()), DATEPART(week, GETDATE())) 
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
  SUM(WeeklyMatlStkChangeQtyInBaseUnit) OVER (
    PARTITION BY _hash 
    ORDER BY YearWeek
  ) AS StockLevelQtyInBaseUnit
FROM
  StockChanges