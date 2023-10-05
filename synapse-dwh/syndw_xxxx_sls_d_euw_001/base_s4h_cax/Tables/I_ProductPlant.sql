CREATE TABLE [base_s4h_cax].[I_ProductPlant](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Product] nvarchar(40) NOT NULL
, [Plant] nvarchar(4) NOT NULL
, [PurchasingGroup] nvarchar(3)
, [CountryOfOrigin] nvarchar(3)
, [RegionOfOrigin] nvarchar(3)
, [ProductionInvtryManagedLoc] nvarchar(4)
, [ProfileCode] nvarchar(2)
, [ProfileValidityStartDate] date
, [AvailabilityCheckType] nvarchar(2)
, [FiscalYearVariant] nvarchar(2)
, [PeriodType] nvarchar(1)
, [ProfitCenter] nvarchar(10)
, [Commodity] nvarchar(17)
, [GoodsReceiptDuration] decimal(3)
, [MaintenanceStatusName] nvarchar(15)
, [IsMarkedForDeletion] nvarchar(1)
, [MRPType] nvarchar(2)
, [MRPResponsible] nvarchar(3)
, [ABCIndicator] nvarchar(1)
, [MinimumLotSizeQuantity] decimal(13,3)
, [MaximumLotSizeQuantity] decimal(13,3)
, [FixedLotSizeQuantity] decimal(13,3)
, [ConsumptionTaxCtrlCode] nvarchar(16)
, [IsCoProduct] nvarchar(1)
, [ProductIsConfigurable] nvarchar(40)
, [ConfigurableProduct] nvarchar(40)
, [StockDeterminationGroup] nvarchar(4)
, [StockInTransferQuantity] decimal(13,3)
, [StockInTransitQuantity] decimal(13,3)
, [HasPostToInspectionStock] nvarchar(1)
, [IsBatchManagementRequired] nvarchar(1)
, [SerialNumberProfile] nvarchar(4)
, [IsNegativeStockAllowed] nvarchar(1)
, [GoodsReceiptBlockedStockQty] decimal(13,3)
, [HasConsignmentCtrl] nvarchar(1)
, [FiscalYearCurrentPeriod] char(4) -- collate Latin1_General_100_BIN2
, [FiscalMonthCurrentPeriod] char(2) -- collate Latin1_General_100_BIN2
, [IsPurgAcrossPurgGroup] nvarchar(1)
, [IsInternalBatchManaged] nvarchar(1)
, [ProductCFOPCategory] nvarchar(2)
, [ProductIsExciseTaxRelevant] nvarchar(1)
, [UnderDelivToleranceLimit] decimal(3,1)
, [OverDelivToleranceLimit] decimal(3,1)
, [ProcurementType] nvarchar(1)
, [SpecialProcurementType] nvarchar(2)
, [ProductionSchedulingProfile] nvarchar(6)
, [ProductionSupervisor] nvarchar(3)
, [SafetyStockQuantity] decimal(13,3)
, [GoodsIssueUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [SourceOfSupplyCategory] nvarchar(1)
, [ConsumptionReferenceProduct] nvarchar(40)
, [ConsumptionReferencePlant] nvarchar(4)
, [ConsumptionRefUsageEndDate] date
, [ConsumptionQtyMultiplier] decimal(4,2)
, [ProductUnitGroup] nvarchar(4)
, [DistrCntrDistributionProfile] nvarchar(3)
, [ConsignmentControl] nvarchar(1)
, [GoodIssueProcessingDays] decimal(3)
, [PlannedDeliveryDurationInDays] decimal(3)
, [IsActiveEntity] nvarchar(1)
, [ProductIsCriticalPrt] nvarchar(1)
, [ProductLogisticsHandlingGroup] nvarchar(4)
, [MaterialFreightGroup] nvarchar(8)
, [OriginalBatchReferenceMaterial] nvarchar(40)
, [OriglBatchManagementIsRequired] nvarchar(1)
, [ProductConfiguration] char(18) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ProductPlant] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Product], [Plant]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
