﻿CREATE TABLE [edw].[dim_ProductPlant](
         [sk_ProductPlant]                NVARCHAR(45)   NOT NULL
    ,    [Product]                        NVARCHAR(40)   NOT NULL
    ,    [Plant]                          NVARCHAR(4)    NOT NULL
    ,    [PurchasingGroup]                NVARCHAR(3)
    ,    [CountryOfOrigin]                NVARCHAR(3)
    ,    [RegionOfOrigin]                 NVARCHAR(3)
    ,    [ProductionInvtryManagedLoc]     NVARCHAR(4)
    ,    [ProfileCode]                    NVARCHAR(2)
    ,    [ProfileValidityStartDate]       DATE
    ,    [AvailabilityCheckType]          NVARCHAR(2)
    ,    [FiscalYearVariant]              NVARCHAR(2)
    ,    [PeriodType]                     NVARCHAR(1)
    ,    [ProfitCenter]                   NVARCHAR(10)
    ,    [Commodity]                      NVARCHAR(17)
    ,    [GoodsReceiptDuration]           DECIMAL(3)
    ,    [MaintenanceStatusName]          NVARCHAR(15)
    ,    [IsMarkedForDeletion]            NVARCHAR(1)
    ,    [MRPType]                        NVARCHAR(2)
    ,    [MRPResponsible]                 NVARCHAR(3)
    ,    [ABCIndicator]                   NVARCHAR(1)
    ,    [MinimumLotSizeQuantity]         DECIMAL(13,3)
    ,    [MaximumLotSizeQuantity]         DECIMAL(13,3)
    ,    [FixedLotSizeQuantity]           DECIMAL(13,3)
    ,    [ConsumptionTaxCtrlCode]         NVARCHAR(16)
    ,    [IsCoProduct]                    NVARCHAR(1)
    ,    [ProductIsConfigurable]          NVARCHAR(40)
    ,    [ConfigurableProduct]            NVARCHAR(40)
    ,    [StockDeterminationGroup]        NVARCHAR(4)
    ,    [StockInTransferQuantity]        DECIMAL(13,3)
    ,    [StockInTransitQuantity]         DECIMAL(13,3)
    ,    [HasPostToInspectionStock]       NVARCHAR(1)
    ,    [IsBatchManagementRequired]      NVARCHAR(1)
    ,    [SerialNumberProfile]            NVARCHAR(4)
    ,    [IsNegativeStockAllowed]         NVARCHAR(1)
    ,    [GoodsReceiptBlockedStockQty]    DECIMAL(13,3)
    ,    [HasConsignmentCtrl]             NVARCHAR(1)
    ,    [FiscalYearCurrentPeriod]        CHAR(4) COLLATE Latin1_General_100_BIN2
    ,    [FiscalMonthCurrentPeriod]       CHAR(2) COLLATE Latin1_General_100_BIN2
    ,    [IsPurgAcrossPurgGroup]          NVARCHAR(1)
    ,    [IsInternalBatchManaged]         NVARCHAR(1)
    ,    [ProductCFOPCategory]            NVARCHAR(2)
    ,    [ProductIsExciseTaxRelevant]     NVARCHAR(1)
    ,    [UnderDelivToleranceLimit]       DECIMAL(3,1)
    ,    [OverDelivToleranceLimit]        DECIMAL(3,1)
    ,    [ProcurementType]                NVARCHAR(1)
    ,    [SpecialProcurementType]         NVARCHAR(2)
    ,    [ProductionSchedulingProfile]    NVARCHAR(6)
    ,    [ProductionSupervisor]           NVARCHAR(3)
    ,    [SafetyStockQuantity]            DECIMAL(13,3)
    ,    [GoodsIssueUnit]                 NVARCHAR(3) COLLATE Latin1_General_100_BIN2
    ,    [SourceOfSupplyCategory]         NVARCHAR(1)
    ,    [ConsumptionReferenceProduct]    NVARCHAR(40)
    ,    [ConsumptionReferencePlant]      NVARCHAR(4)
    ,    [ConsumptionRefUsageEndDate]     DATE
    ,    [ConsumptionQtyMultiplier]       DECIMAL(4,2)
    ,    [ProductUnitGroup]               NVARCHAR(4)
    ,    [DistrCntrDistributionProfile]   NVARCHAR(3)
    ,    [ConsignmentControl]             NVARCHAR(1)
    ,    [GoodIssueProcessingDays]        DECIMAL(3)
    ,    [PlannedDeliveryDurationInDays]  DECIMAL(3)
    ,    [IsActiveEntity]                 NVARCHAR(1)
    ,    [ProductIsCriticalPrt]           NVARCHAR(1)
    ,    [ProductLogisticsHandlingGroup]  NVARCHAR(4)
    ,    [MaterialFreightGroup]           NVARCHAR(8)
    ,    [OriginalBatchReferenceMaterial] NVARCHAR(40)
    ,    [OriglBatchManagementIsRequired] NVARCHAR(1)
    ,    [ProductConfiguration]           CHAR(18) COLLATE Latin1_General_100_BIN2
    ,    [t_applicationId]                VARCHAR(32)
    ,    [t_jobId]                        VARCHAR(36)
    ,    [t_jobDtm]                       DATETIME
    ,    [t_lastActionCd]                 VARCHAR(1)
    ,    [t_jobBy]                        NVARCHAR(128)
    ,    [t_extractionDtm]                DATETIME
    ,    CONSTRAINT [PK_dim_ProductPlant] PRIMARY KEY NONCLUSTERED ([Product],[Plant]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO
