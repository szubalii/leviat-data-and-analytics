CREATE TABLE [base_s4h_cax].[I_ProductPlant](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [Product] nvarchar(40) NOT NULL
, [Plant] nvarchar(4) NOT NULL
, [MaintenanceStatusName] nvarchar(15)
, [IsMarkedForDeletion] nvarchar(1)
, [IsInternalBatchManaged] nvarchar(1)
, [ProfileCode] nvarchar(2)
, [ProfileValidityStartDate] date
, [ABCIndicator] nvarchar(1)
, [ProductIsCriticalPrt] nvarchar(1)
, [PurchasingGroup] nvarchar(3)
, [GoodsIssueUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [MRPType] nvarchar(2)
, [MRPResponsible] nvarchar(3)
, [PlannedDeliveryDurationInDays] decimal(3)
, [GoodsReceiptDuration] decimal(3)
, [PeriodType] nvarchar(1)
, [ProcurementType] nvarchar(1)
, [SpecialProcurementType] nvarchar(2)
, [SafetyStockQuantity] decimal(13,3)
, [MinimumLotSizeQuantity] decimal(13,3)
, [MaximumLotSizeQuantity] decimal(13,3)
, [FixedLotSizeQuantity] decimal(13,3)
, [ProductionSupervisor] nvarchar(3)
, [OverDelivToleranceLimit] decimal(3,1)
, [UnderDelivToleranceLimit] decimal(3,1)
, [HasPostToInspectionStock] nvarchar(1)
, [StockInTransferQuantity] decimal(13,3)
, [IsBatchManagementRequired] nvarchar(1)
, [AvailabilityCheckType] nvarchar(2)
, [FiscalYearVariant] nvarchar(2)
, [SourceOfSupplyCategory] nvarchar(1)
, [Commodity] nvarchar(17)
, [CountryOfOrigin] nvarchar(3)
, [RegionOfOrigin] nvarchar(3)
, [ProfitCenter] nvarchar(10)
, [StockInTransitQuantity] decimal(13,3)
, [ProductionInvtryManagedLoc] nvarchar(4)
, [SerialNumberProfile] nvarchar(4)
, [ProductConfiguration] char(18) collate Latin1_General_100_BIN2
, [ProductIsConfigurable] nvarchar(40)
, [ConfigurableProduct] nvarchar(40)
, [IsNegativeStockAllowed] nvarchar(1)
, [ConsumptionReferenceProduct] nvarchar(40)
, [ConsumptionReferencePlant] nvarchar(4)
, [ConsumptionRefUsageEndDate] date
, [ConsumptionQtyMultiplier] decimal(4,2)
, [IsCoProduct] nvarchar(1)
, [StockDeterminationGroup] nvarchar(4)
, [ProductionSchedulingProfile] nvarchar(6)
, [ProductUnitGroup] nvarchar(4)
, [MaterialFreightGroup] nvarchar(8)
, [ProductLogisticsHandlingGroup] nvarchar(4)
, [DistrCntrDistributionProfile] nvarchar(3)
, [ProductCFOPCategory] nvarchar(2)
, [ConsumptionTaxCtrlCode] nvarchar(16)
, [FiscalMonthCurrentPeriod] char(2) collate Latin1_General_100_BIN2
, [FiscalYearCurrentPeriod] char(4) collate Latin1_General_100_BIN2
, [OriglBatchManagementIsRequired] nvarchar(1)
, [OriginalBatchReferenceMaterial] nvarchar(40)
, [GoodsReceiptBlockedStockQty] decimal(13,3)
, [HasConsignmentCtrl] nvarchar(1)
, [ConsignmentControl] nvarchar(1)
, [GoodIssueProcessingDays] decimal(3)
, [IsPurgAcrossPurgGroup] nvarchar(1)
, [ProductIsExciseTaxRelevant] nvarchar(1)
, [IsActiveEntity] nvarchar(1)
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
