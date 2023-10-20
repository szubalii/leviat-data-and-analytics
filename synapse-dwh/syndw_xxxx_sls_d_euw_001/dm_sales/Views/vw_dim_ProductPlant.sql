CREATE VIEW [dm_sales].[vw_dim_ProductPlant] AS
SELECT
        [nk_ProductPlant]
    ,   [Product]
    ,   PP.[Plant]
    ,   PP.[PurchasingGroup]
    ,   [CountryOfOrigin]
    ,   [RegionOfOrigin]
    ,   [ProductionInvtryManagedLoc]
    ,   [ProfileCode]
    ,   [ProfileValidityStartDate]
    ,   [AvailabilityCheckType]
    ,   [FiscalYearVariant]
    ,   [PeriodType]
    ,   PP.[ProfitCenter]
    ,   [Commodity]
    ,   [GoodsReceiptDuration]
    ,   [MaintenanceStatusName]
    ,   [IsMarkedForDeletion]
    ,   [MRPType]
    ,   [MRPResponsible]
    ,   [ABCIndicator]
    ,   [MinimumLotSizeQuantity]
    ,   [MaximumLotSizeQuantity]
    ,   [FixedLotSizeQuantity]
    ,   [ConsumptionTaxCtrlCode]
    ,   [IsCoProduct]
    ,   [ProductIsConfigurable]
    ,   [ConfigurableProduct]
    ,   [StockDeterminationGroup]
    ,   [StockInTransferQuantity]
    ,   [StockInTransitQuantity]
    ,   [HasPostToInspectionStock]
    ,   [IsBatchManagementRequired]
    ,   [SerialNumberProfile]
    ,   [IsNegativeStockAllowed]
    ,   [GoodsReceiptBlockedStockQty]
    ,   [HasConsignmentCtrl]
    ,   [FiscalYearCurrentPeriod]
    ,   [FiscalMonthCurrentPeriod]
    ,   [IsPurgAcrossPurgGroup]
    ,   [IsInternalBatchManaged]
    ,   [ProductCFOPCategory]
    ,   [ProductIsExciseTaxRelevant]
    ,   [UnderDelivToleranceLimit]
    ,   [OverDelivToleranceLimit]
    ,   [ProcurementType]
    ,   [SpecialProcurementType]
    ,   [ProductionSchedulingProfile]
    ,   [ProductionSupervisor]
    ,   [SafetyStockQuantity]
    ,   [GoodsIssueUnit]
    ,   [SourceOfSupplyCategory]
    ,   [ConsumptionReferenceProduct]
    ,   [ConsumptionReferencePlant]
    ,   [ConsumptionRefUsageEndDate]
    ,   [ConsumptionQtyMultiplier]
    ,   [ProductUnitGroup]
    ,   [DistrCntrDistributionProfile]
    ,   [ConsignmentControl]
    ,   [GoodIssueProcessingDays]
    ,   [PlannedDeliveryDurationInDays]
    ,   [IsActiveEntity]
    ,   [ProductIsCriticalPrt]
    ,   [ProductLogisticsHandlingGroup]
    ,   [MaterialFreightGroup]
    ,   [OriginalBatchReferenceMaterial]
    ,   [OriglBatchManagementIsRequired]
    ,   [ProductConfiguration]
    ,   [MRPControllerName] AS [MRPController]
    ,   NSDM.[MINBE] AS [Re-Order Point]
    ,   NSDM.[BSTRF] AS [Rounding Value]
    ,   NSDM.[STRGR] AS [PlanningStrategyGroup]
    ,   PSGT.[PlanningStrategyGroupName]
    ,   PP.[t_applicationId]
    ,   PP.[t_extractionDtm]
FROM
    [edw].[dim_ProductPlant] PP
LEFT JOIN
    [base_s4h_cax].[I_MRPController] MRPC
    ON
        PP.[Plant]=MRPC.[Plant]
        AND
        PP.[MRPResponsible] = MRPC.[MRPController]
LEFT JOIN
    [base_s4h_cax].[NSDM_V_MARC] NSDM
    ON 
        PP.[Product] = NSDM.[MATNR] COLLATE SQL_Latin1_General_CP1_CS_AS
        AND
        PP.[Plant] = NSDM.[WERKS] COLLATE SQL_Latin1_General_CP1_CS_AS
LEFT JOIN
    [base_s4h_cax].[I_PlanningStrategyGroupText] PSGT
    ON 
        NSDM.STRGR = PSGT.PlanningStrategyGroup COLLATE DATABASE_DEFAULT