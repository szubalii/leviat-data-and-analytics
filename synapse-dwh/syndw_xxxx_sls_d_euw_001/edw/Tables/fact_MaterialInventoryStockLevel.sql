CREATE TABLE [edw].[fact_MaterialInventoryStockLevel]
(
  [MaterialID]                    [nvarchar](40),
  [PlantID]                       [nvarchar](8),
  [StorageLocationID]             [nvarchar](10),
  [InventorySpecialStockTypeID]   [nvarchar](1),
  [InventoryStockTypeID]          [nvarchar](2),
  [StockOwner]                    [nvarchar](10),
  [CostCenterID]                  [nvarchar](10),
  [CompanyCodeID]                 [nvarchar](4),
  [SalesDocumentTypeID]           [nvarchar](4),
  [SalesDocumentItemCategoryID]   [nvarchar](8),
  [MaterialBaseUnitID]            [nvarchar](3),
  [PurchaseOrderTypeID]           [nvarchar](4),
  [InventoryValuationTypeID]      [nvarchar](10),
  [DatePart]                      [nvarchar](5),
  [nk_StoragePlantID]             [nvarchar](41),
  [sk_ProductSalesOrg]            INT,
  [PlantSalesOrgID]               [nvarchar](4),
  [ReportingDate]                 DATE,
  [YearWeek]                      [nvarchar](6),
  [YearMonth]                     [nvarchar](6),
  [CurrencyID]                    [nvarchar](5),
  [StockPricePerUnit]             DECIMAL(38, 6),
  [StockPricePerUnit_EUR]         DECIMAL(38, 6),
  [StockPricePerUnit_USD]         DECIMAL(38, 6),
  [LatestStockPricePerUnit]       DECIMAL(38, 6),
  [LatestStockPricePerUnit_EUR]   DECIMAL(38, 6),
  [LatestStockPricePerUnit_USD]   DECIMAL(38, 6),
  [MatlCnsmpnQtyInMatlBaseUnit]   DECIMAL(31, 14),
  [MatlStkChangeQtyInBaseUnit]    [decimal](38, 14),
  [StockLevelQtyInBaseUnit]       [decimal](38, 14),
  [StockLevelStandardPPU]         [decimal](38, 6),
  [StockLevelStandardPPU_EUR]     [decimal](38, 6),
  [StockLevelStandardPPU_USD]     [decimal](38, 6),
  [StockLevelStandardLatestPPU]     [decimal](38, 6),
  [StockLevelStandardLatestPPU_EUR] [decimal](38, 6),
  [StockLevelStandardLatestPPU_USD] [decimal](38, 6),
  [Rolling12MonthConsumptionQty]  [decimal](38, 14),
  [ConsumptionQtyICPOInStandardValue_EUR]    DECIMAL(38, 6),
  [ConsumptionQtyICPOInStandardValue_USD]    DECIMAL(38, 6),
  [ConsumptionQtyOBDProStandardValue]        DECIMAL(38, 6),
  [ConsumptionQtyOBDProStandardValue_EUR]    DECIMAL(38, 6),
  [ConsumptionQtyOBDProStandardValue_USD]    DECIMAL(38, 6),
  [ConsumptionQtySOStandardValue]            DECIMAL(38, 6),
  [ConsumptionQtySOStandardValue_EUR]        DECIMAL(38, 6),
  [ConsumptionQtySOStandardValue_USD]        DECIMAL(38, 6),
  [ConsumptionQty]                           DECIMAL(38, 6),
  [ConsumptionValueByLatestPriceInBaseValue] DECIMAL(38, 6),
  [ConsumptionValueByLatestPrice_EUR]        DECIMAL(38, 6),
  [ConsumptionValueByLatestPrice_USD]        DECIMAL(38, 6),
  [t_applicationId]               VARCHAR(32),
  [t_extractionDtm]               DATETIME,
  [t_jobId]                       VARCHAR(36),
  [t_jobDtm]                      DATETIME,
  [t_lastActionCd]                VARCHAR(1),
  [t_jobBy]                       VARCHAR(128)--,
  -- The primary key of this table can be regarded as the combination of the following fields
  -- The primary key has been commented out as some of these fields can have NULL VALUES
  -- CONSTRAINT [PK_fact_MaterialStockLevel] PRIMARY KEY NONCLUSTERED (
  --   [MaterialID]
  -- , [PlantID]
  -- , [StorageLocationID]
  -- , [InventorySpecialStockTypeID]
  -- , [InventoryStockTypeID]
  -- , [StockOwner]
  -- , [CostCenterID]
  -- , [CompanyCodeID]
  -- , [SalesDocumentTypeID]
  -- , [SalesDocumentItemCategoryID]
  -- , [MaterialBaseUnitID]
  -- , [PurchaseOrderTypeID]
  -- , [InventoryValuationTypeID]
  -- , [DatePart]
  -- ) NOT ENFORCED
)
WITH
(
  DISTRIBUTION = HASH ( [MaterialID] ),
  CLUSTERED INDEX ( [MaterialID] )
)
