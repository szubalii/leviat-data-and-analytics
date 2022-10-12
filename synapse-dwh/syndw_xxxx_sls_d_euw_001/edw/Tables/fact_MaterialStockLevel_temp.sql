CREATE TABLE [edw].[fact_MaterialStockLevel_temp]
(
	[_hash] 		 	NVARCHAR(32) NOT NULL,	
	[ReportingYear] 	[char](4) NOT NULL,
	[ReportingMonth] 	[nvarchar](12) NOT NULL,
	[ReportingDate] 	[date] NULL,
	[MaterialID]		[nvarchar](40) NOT  NULL,
	[PlantID] [nvarchar](5) NULL,
	[StorageLocationID] [nvarchar](10) NULL,
	[InventorySpecialStockTypeID] [nvarchar](1) NULL,
	[InventorySpecialStockTypeName] [nvarchar](20) NULL,
	[InventoryStockTypeID] [nvarchar](2) NULL,
	[InventoryStockTypeName] [nvarchar](60) NULL,
	[StockOwner] [nvarchar](10) NULL,
	[CostCenterID] [nvarchar](10) NULL,
	[CompanyCodeID] [nvarchar](4) NULL,
	[SalesDocumentTypeID] [nvarchar](4) NULL,
	[SalesDocumentType] [nvarchar](20) NULL,
	[SalesDocumentItemCategoryID] [nvarchar](8) NULL,
	[SalesDocumentItemCategory] [nvarchar](120) NULL,
	[MaterialBaseUnitID] [nvarchar](4) NULL,
	[PurchaseOrderTypeID] [nvarchar](4) NULL,
	[PurchaseOrderType] [nvarchar](20) NULL,
	[MatlStkChangeQtyInBaseUnit] [decimal](38, 14) NULL,
	[StockLevelQtyInBaseUnit] [decimal](38, 14) NULL,
	[StockLevelStandardPPU] [decimal](38, 6) NULL,
	[StockLevelStandardPPU_EUR] [decimal](38, 6) NULL,
	[StockLevelStandardPPU_USD] [decimal](38, 6) NULL,
	[PriceControlIndicatorID] [nvarchar](1) NULL,
	[PriceControlIndicator] [nvarchar](25) NULL,
	[nk_dim_ProductValuationPUP] [nvarchar](54) NULL,
	[sk_dim_ProductValuationPUP] [bigint] NULL,
  	[t_applicationId]                           VARCHAR(32),
  	[t_extractionDtm]                           DATETIME,
  	[t_jobId]                                   VARCHAR(36),
  	[t_jobDtm]                                  DATETIME,
  	[t_lastActionCd]                            VARCHAR(1),
  	[t_jobBy]                                   VARCHAR(128),
  	CONSTRAINT [PK_fact_MaterialStockLevel_temp] PRIMARY KEY NONCLUSTERED (
		 [_hash], [ReportingYear], [ReportingMonth] 
  	) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([_hash]), CLUSTERED COLUMNSTORE INDEX )
