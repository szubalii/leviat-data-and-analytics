CREATE VIEW [edw].[vw_MaterialStockLevel_Weekly]
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

-- DECLARE
--   @date DATE = GETDATE(),
--   -- @hash CHAR(32) = '822451011BB1F2F049B6E64B60DEE07C'; --few changes
--   @hash CHAR(32) = '4DF5CE888E16CA5F3B07CFC872AE52D6'; --lots changes
  -- @hash CHAR(32) = 'CF93DC5202665958283CF132C82092A0';
-- DECLARE
--   @CurrentYearWeek CHAR(6) = CONCAT(YEAR(@date), DATEPART(week, @date));

WITH

-- 1. Aggregate stock change on weekly level
MaterialInventoryWeeklyStockChange AS (
  SELECT
      -- MDI.[_hash]
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
  FROM
    [edw].[fact_MaterialDocumentItem] AS MDI
  LEFT JOIN
    [edw].[dim_Calendar] AS cal
    ON cal.CalendarDate = MDI.HDR_PostingDate
  WHERE
    MDI.t_applicationId LIKE '%s4h%' -- TODO filter on S4H only now
    -- and _hash = @hash
  GROUP BY
      -- MDI.[_hash]
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
  -- ORDER BY
  --   YearWeek
)

-- 2. Get the first posting date for each key
, MaterialInventoryFirstPostingDate AS (
  SELECT
      -- [_hash]
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
    , MIN(HDR_PostingDate) AS FirstPostingDate
  FROM
    [edw].[fact_MaterialDocumentItem]
  WHERE
    t_applicationId LIKE '%s4h%' -- TODO filter on S4H only now
  GROUP BY
      -- [_hash]
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
)

-- 3. Get the YearWeek of the first posting date
, MaterialInventoryFirstYearWeek AS (
  SELECT
      -- FirstPostingDate.[_hash]
      MaterialInventoryFirstPostingDate.[MaterialID]
    , MaterialInventoryFirstPostingDate.[PlantID]
    , MaterialInventoryFirstPostingDate.[StorageLocationID]
    , MaterialInventoryFirstPostingDate.[InventorySpecialStockTypeID]
    , MaterialInventoryFirstPostingDate.[InventoryStockTypeID]
    , MaterialInventoryFirstPostingDate.[StockOwner]
    , MaterialInventoryFirstPostingDate.[CostCenterID]
    , MaterialInventoryFirstPostingDate.[CompanyCodeID]
    , MaterialInventoryFirstPostingDate.[SalesDocumentTypeID]
    , MaterialInventoryFirstPostingDate.[SalesDocumentItemCategoryID]
    , MaterialInventoryFirstPostingDate.[MaterialBaseUnitID]
    , MaterialInventoryFirstPostingDate.[PurchaseOrderTypeID]
    , MaterialInventoryFirstPostingDate.[InventoryValuationTypeID]
    , cal.[YearWeek] AS FirstYearWeek
  FROM
    MaterialInventoryFirstPostingDate
  LEFT JOIN
    [edw].[dim_Calendar] AS cal
    ON
      cal.CalendarDate = MaterialInventoryFirstPostingDate.FirstPostingDate
)

-- 4. Add the missing yearWeeks for each hash based on calendar table
, AllYearWeeks AS (
  SELECT --top 100
      YearWeek
    -- required to get the monthly StockPricePerUnit
    -- If a weeks falls in two months, take the first month
    , MIN(FirstDayOfMonthDate) AS FirstDayOfMonthDate
  FROM
    [edw].[dim_Calendar]
  GROUP BY
      YearWeek
)

, MaterialInventoryWeeks AS (
  SELECT
      -- FirstYearWeek.[_hash]
      MaterialInventoryFirstYearWeek.[MaterialID]
    , MaterialInventoryFirstYearWeek.[PlantID]
    , MaterialInventoryFirstYearWeek.[StorageLocationID]
    , MaterialInventoryFirstYearWeek.[InventorySpecialStockTypeID]
    , MaterialInventoryFirstYearWeek.[InventoryStockTypeID]
    , MaterialInventoryFirstYearWeek.[StockOwner]
    , MaterialInventoryFirstYearWeek.[CostCenterID]
    , MaterialInventoryFirstYearWeek.[CompanyCodeID]
    , MaterialInventoryFirstYearWeek.[SalesDocumentTypeID]
    , MaterialInventoryFirstYearWeek.[SalesDocumentItemCategoryID]
    , MaterialInventoryFirstYearWeek.[MaterialBaseUnitID]
    , MaterialInventoryFirstYearWeek.[PurchaseOrderTypeID]
    , MaterialInventoryFirstYearWeek.[InventoryValuationTypeID]
    , AllYearWeeks.YearWeek
    , AllYearWeeks.FirstDayOfMonthDate
  FROM
    MaterialInventoryFirstYearWeek
  CROSS JOIN
    AllYearWeeks
  WHERE
    AllYearWeeks.YearWeek BETWEEN MaterialInventoryFirstYearWeek.FirstYearWeek AND
      -- Construct YearWeek based on current date
      CONCAT(YEAR(GETDATE()), DATEPART(week, GETDATE()))
)

-- 5. Include the stock changes for the weeks on which they are reported
, StockChanges AS (
  SELECT
      -- Weeks.[_hash]
      MaterialInventoryWeeks.[MaterialID]
    , MaterialInventoryWeeks.[PlantID]
    , MaterialInventoryWeeks.[StorageLocationID]
    , MaterialInventoryWeeks.[InventorySpecialStockTypeID]
    , MaterialInventoryWeeks.[InventoryStockTypeID]
    , MaterialInventoryWeeks.[StockOwner]
    , MaterialInventoryWeeks.[CostCenterID]
    , MaterialInventoryWeeks.[CompanyCodeID]
    , MaterialInventoryWeeks.[SalesDocumentTypeID]
    , MaterialInventoryWeeks.[SalesDocumentItemCategoryID]
    , MaterialInventoryWeeks.[MaterialBaseUnitID]
    , MaterialInventoryWeeks.[PurchaseOrderTypeID]
    , MaterialInventoryWeeks.[InventoryValuationTypeID]
    , MaterialInventoryWeeks.[YearWeek]
    , MaterialInventoryWeeks.[FirstDayOfMonthDate]
    , MaterialInventoryWeeklyStockChange.[MatlStkChangeQtyInBaseUnit]
  FROM
    MaterialInventoryWeeks
  LEFT JOIN
    MaterialInventoryWeeklyStockChange
    ON
      -- Weekly._hash = Weeks._hash
      -- Join on all required fields
      -- Include checks for cases when one or both fields are NULL
      MaterialInventoryWeeklyStockChange.[MaterialID] = MaterialInventoryWeeks.[MaterialID]
      AND (
      MaterialInventoryWeeklyStockChange.[PlantID] = MaterialInventoryWeeks.[PlantID]
        OR (
          MaterialInventoryWeeklyStockChange.[PlantID] IS NULL
          AND
          MaterialInventoryWeeks.[PlantID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[StorageLocationID] = MaterialInventoryWeeks.[StorageLocationID]
        OR (
          MaterialInventoryWeeklyStockChange.[StorageLocationID] IS NULL
          AND
          MaterialInventoryWeeks.[StorageLocationID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[InventorySpecialStockTypeID] = MaterialInventoryWeeks.[InventorySpecialStockTypeID]
        OR (
          MaterialInventoryWeeklyStockChange.[InventorySpecialStockTypeID] IS NULL
          AND
          MaterialInventoryWeeks.[InventorySpecialStockTypeID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[InventoryStockTypeID] = MaterialInventoryWeeks.[InventoryStockTypeID]
        OR (
          MaterialInventoryWeeklyStockChange.[InventoryStockTypeID] IS NULL
          AND
          MaterialInventoryWeeks.[InventoryStockTypeID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[StockOwner] = MaterialInventoryWeeks.[StockOwner]
        OR (
          MaterialInventoryWeeklyStockChange.[StockOwner] IS NULL
          AND
          MaterialInventoryWeeks.[StockOwner] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[CostCenterID] = MaterialInventoryWeeks.[CostCenterID]
        OR (
          MaterialInventoryWeeklyStockChange.[CostCenterID] IS NULL
          AND
          MaterialInventoryWeeks.[CostCenterID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[CompanyCodeID] = MaterialInventoryWeeks.[CompanyCodeID]
        OR (
          MaterialInventoryWeeklyStockChange.[CompanyCodeID] IS NULL
          AND
          MaterialInventoryWeeks.[CompanyCodeID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[SalesDocumentTypeID] = MaterialInventoryWeeks.[SalesDocumentTypeID]
        OR (
          MaterialInventoryWeeklyStockChange.[SalesDocumentTypeID] IS NULL
          AND
          MaterialInventoryWeeks.[SalesDocumentTypeID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[SalesDocumentItemCategoryID] = MaterialInventoryWeeks.[SalesDocumentItemCategoryID]
        OR (
          MaterialInventoryWeeklyStockChange.[SalesDocumentItemCategoryID] IS NULL
          AND
          MaterialInventoryWeeks.[SalesDocumentItemCategoryID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[MaterialBaseUnitID] = MaterialInventoryWeeks.[MaterialBaseUnitID]
        OR (
          MaterialInventoryWeeklyStockChange.[MaterialBaseUnitID] IS NULL
          AND
          MaterialInventoryWeeks.[MaterialBaseUnitID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[PurchaseOrderTypeID] = MaterialInventoryWeeks.[PurchaseOrderTypeID]
        OR (
          MaterialInventoryWeeklyStockChange.[PurchaseOrderTypeID] IS NULL
          AND
          MaterialInventoryWeeks.[PurchaseOrderTypeID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[InventoryValuationTypeID] = MaterialInventoryWeeks.[InventoryValuationTypeID]
        OR (
          MaterialInventoryWeeklyStockChange.[InventoryValuationTypeID] IS NULL
          AND
          MaterialInventoryWeeks.[InventoryValuationTypeID] IS NULL
        )
      )
      AND (
        MaterialInventoryWeeklyStockChange.[YearWeek] = MaterialInventoryWeeks.[YearWeek]
        OR (
          MaterialInventoryWeeklyStockChange.[YearWeek] IS NULL
          AND
          MaterialInventoryWeeks.[YearWeek] IS NULL
        )
      )
)

-- 6. Calculate the stock levels for each combo of yearWeek and hash
, StockLevels AS (
  SELECT
      -- [_hash]
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
    , [YearWeek]
    , [FirstDayOfMonthDate]
    , [MatlStkChangeQtyInBaseUnit]
    , SUM(MatlStkChangeQtyInBaseUnit) OVER (
      PARTITION BY
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
      ORDER BY YearWeek
    ) AS StockLevelQtyInBaseUnit
  FROM
    StockChanges
)

-- 7. Calculate the stock value by getting the price per unit
SELECT
-- top 100
    -- StockLevels.[_hash]
    StockLevels.[MaterialID]
  , StockLevels.[PlantID]
  , StockLevels.[StorageLocationID]
  , StockLevels.[InventorySpecialStockTypeID]
  , StockLevels.[InventoryStockTypeID]
  , StockLevels.[StockOwner]
  , StockLevels.[CostCenterID]
  , StockLevels.[CompanyCodeID]
  , StockLevels.[SalesDocumentTypeID]
  , StockLevels.[SalesDocumentItemCategoryID]
  , StockLevels.[MaterialBaseUnitID]
  , StockLevels.[PurchaseOrderTypeID]
  , StockLevels.[InventoryValuationTypeID]
  , StockLevels.[YearWeek]
  , PUP.[StockPricePerUnit]
  , PUP.[StockPricePerUnit_EUR]
  , PUP.[StockPricePerUnit_USD]
  , StockLevels.[MatlStkChangeQtyInBaseUnit]
  , StockLevels.[StockLevelQtyInBaseUnit]
  , StockLevels.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit]     AS StockLevelStandardPPU
  , StockLevels.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_EUR] AS StockLevelStandardPPU_EUR
  , StockLevels.[StockLevelQtyInBaseUnit] * PUP.[StockPricePerUnit_USD] AS StockLevelStandardPPU_USD
FROM
  StockLevels
LEFT OUTER JOIN
  [edw].[dim_ProductValuationPUP] PUP
  ON
    PUP.[ProductID] = StockLevels.[MaterialID] 
    AND
    PUP.[ValuationAreaID] = StockLevels.[PlantID] 
    AND
    PUP.[ValuationTypeID] = StockLevels.[InventoryValuationTypeID] 
    AND
    PUP.[FirstDayOfMonthDate] = StockLevels.[FirstDayOfMonthDate]

  -- WHERE
  --   StockLevels.MaterialID = '000000001000200031'
  --   and
  --   StockLevels.PlantID = 'AT01'
  --   and
  --   StockLevels.StorageLocationID = '1001'
  --   and
  --   StockLevels.PurchaseOrderTypeID is null
  -- ORDER BY
  --   StockLevels.YearWeek
