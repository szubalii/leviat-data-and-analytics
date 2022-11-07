CREATE TABLE [edw].[fact_MaterialStockLevel]
(
    [_hash]                         NVARCHAR(32) NOT NULL,	
	[ReportingYear]                 [char](4) NOT NULL,
	[ReportingMonth]                [nvarchar](12) NOT NULL,
	[ReportingDate]                 [date] NOT NULL,
	[MaterialID]                    [nvarchar](40) NOT NULL,
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
	[MatlStkChangeQtyInBaseUnit]    [decimal](38, 14),
	[StockLevelQtyInBaseUnit]       [decimal](38, 14),
    [StockLevelStandardPPU]         [decimal](38, 6),
	[StockLevelStandardPPU_EUR]     [decimal](38, 6),
	[StockLevelStandardPPU_USD]     [decimal](38, 6),
	[PriceControlIndicatorID]       [nvarchar](1),
	[PriceControlIndicator]         [nvarchar](25),
	[nk_dim_ProductValuationPUP]    [nvarchar](54),
	[sk_dim_ProductValuationPUP]    [bigint] NULL,
  	[t_applicationId]                           VARCHAR(32),
  	[t_extractionDtm]                           DATETIME,
  	[t_jobId]                                   VARCHAR(36),
  	[t_jobDtm]                                  DATETIME,
  	[t_lastActionCd]                            VARCHAR(1),
  	[t_jobBy]                                   VARCHAR(128),
  	CONSTRAINT [PK_fact_MaterialStockLevel] PRIMARY KEY NONCLUSTERED (
		 [_hash], [ReportingYear], [ReportingMonth] 
  	) NOT ENFORCED
)
WITH
(
	DISTRIBUTION = HASH ( [_hash] ),
	CLUSTERED COLUMNSTORE INDEX
)