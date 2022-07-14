CREATE TABLE [base_s4h_cax].[I_MfgOrderWithStatus]
(
  [MANDT] nchar(3) collate Latin1_General_100_BIN2 NOT NULL
, [ManufacturingOrder] nvarchar(12) collate Latin1_General_100_BIN2 NOT NULL
, [ManufacturingOrderCategory] char(2) collate Latin1_General_100_BIN2
, [ManufacturingOrderType] nvarchar(4) collate Latin1_General_100_BIN2
, [ManufacturingOrderText] nvarchar(40) collate Latin1_General_100_BIN2
, [ManufacturingOrderHasLongText] nvarchar(1) collate Latin1_General_100_BIN2
, [LongTextLanguageCode] nchar(1) collate  Latin1_General_100_BIN2
, [ManufacturingOrderImportance] nvarchar(1) collate Latin1_General_100_BIN2
, [MfgOrderIsToBeDeleted] nvarchar(1) collate Latin1_General_100_BIN2
, [MfgOrderHasMultipleItems] nvarchar(1) collate Latin1_General_100_BIN2
, [MfgOrderIsPartOfCollvOrder] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsCreated] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsReleased] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsPrinted] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsConfirmed] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsPartiallyConfirmed] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsDelivered] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsDeleted] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsPreCosted] nvarchar(1) collate Latin1_General_100_BIN2
, [SettlementRuleIsCreated] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsPartiallyReleased] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsLocked] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsTechnicallyCompleted] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsClosed] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsPartiallyDelivered] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsMarkedForDeletion] nvarchar(1) collate Latin1_General_100_BIN2
, [SettlementRuleIsCrtedManually] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsScheduled] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderHasGeneratedOperations] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsToBeHandledInBatches] nvarchar(1) collate Latin1_General_100_BIN2
, [MaterialAvailyIsNotChecked] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderIsShopFloorOrder] nvarchar(1) collate Latin1_General_100_BIN2
, [MfgOrderCreationDate] date
, [MfgOrderCreationTime] time(0)
, [CreatedByUser] nvarchar(12) collate Latin1_General_100_BIN2
, [LastChangeDate] date
, [LastChangeTime] time(0)
, [LastChangedByUser] nvarchar(12) collate Latin1_General_100_BIN2
, [Material] nvarchar(40) collate Latin1_General_100_BIN2
, [StorageLocation] nvarchar(4) collate Latin1_General_100_BIN2
, [Batch] nvarchar(10) collate Latin1_General_100_BIN2
, [GoodsRecipientName] nvarchar(12) collate Latin1_General_100_BIN2
, [UnloadingPointName] nvarchar(25) collate Latin1_General_100_BIN2
, [InventoryUsabilityCode] nvarchar(1) collate Latin1_General_100_BIN2
, [MaterialGoodsReceiptDuration] decimal(3)
, [QuantityDistributionKey] nvarchar(4) collate Latin1_General_100_BIN2
, [StockSegment] nvarchar(40) collate Latin1_General_100_BIN2
, [OrderInternalBillOfOperations] char(10) collate Latin1_General_100_BIN2
, [SuperiorOrder] nvarchar(12) collate Latin1_General_100_BIN2
, [ReferenceOrder] nvarchar(12) collate Latin1_General_100_BIN2
, [LeadingOrder] nvarchar(12) collate Latin1_General_100_BIN2
, [Currency] nchar(5) collate Latin1_General_100_BIN2
, [ProductionPlant] nvarchar(4) collate Latin1_General_100_BIN2
, [MRPPlant] nvarchar(4) collate Latin1_General_100_BIN2
, [MRPArea] nvarchar(10) collate Latin1_General_100_BIN2
, [MRPController] nvarchar(3) collate Latin1_General_100_BIN2
, [ProductionSupervisor] nvarchar(3) collate Latin1_General_100_BIN2
, [ResponsiblePlannerGroup] nvarchar(3) collate Latin1_General_100_BIN2
, [ProductionSchedulingProfile] nvarchar(6) collate Latin1_General_100_BIN2
, [ProductionVersion] nvarchar(4) collate Latin1_General_100_BIN2
, [PlannedOrder] nvarchar(10) collate Latin1_General_100_BIN2
, [SalesOrder] nvarchar(10) collate Latin1_General_100_BIN2
, [SalesOrderItem] char(6) collate Latin1_General_100_BIN2
, [WBSElementInternalID] char(8) collate Latin1_General_100_BIN2
, [Reservation] char(10) collate Latin1_General_100_BIN2
, [MfgOrderConfirmation] char(10) collate Latin1_General_100_BIN2
, [NumberOfMfgOrderConfirmations] char(8) collate Latin1_General_100_BIN2
, [CapacityRequirement] char(12) collate Latin1_General_100_BIN2
, [InspectionLot] char(12) collate Latin1_General_100_BIN2
, [ChangeNumber] nvarchar(12) collate Latin1_General_100_BIN2
, [BasicSchedulingType] nvarchar(1) collate Latin1_General_100_BIN2
, [ForecastSchedulingType] nvarchar(1) collate Latin1_General_100_BIN2
, [ManufacturingObject] nvarchar(22) collate Latin1_General_100_BIN2
, [ProductConfiguration] char(18) collate Latin1_General_100_BIN2
, [EffectivityParameterVariant] nvarchar(12) collate Latin1_General_100_BIN2
, [ConditionApplication] nvarchar(2) collate Latin1_General_100_BIN2
, [CapacityActiveVersion] char(2) collate Latin1_General_100_BIN2
, [CapacityRqmtHasNotToBeCreated] nvarchar(1) collate Latin1_General_100_BIN2
, [OrderSequenceNumber] char(14) collate Latin1_General_100_BIN2
, [BillOfOperationsMaterial] nvarchar(40) collate Latin1_General_100_BIN2
, [BillOfOperationsType] nvarchar(1) collate Latin1_General_100_BIN2
, [BillOfOperations] nvarchar(8) collate Latin1_General_100_BIN2
, [BillOfOperationsVariant] nvarchar(2) collate Latin1_General_100_BIN2
, [BOOInternalVersionCounter] char(8) collate Latin1_General_100_BIN2
, [BillOfOperationsUsage] nvarchar(3) collate Latin1_General_100_BIN2
, [BillOfOperationsVersion] nvarchar(4) collate Latin1_General_100_BIN2
, [BOOExplosionDate] date
, [BOOValidityStartDate] date
, [BillOfMaterialCategory] nvarchar(1) collate Latin1_General_100_BIN2
, [BillOfMaterial] nvarchar(8) collate Latin1_General_100_BIN2
, [BillOfMaterialVariant] nvarchar(2) collate Latin1_General_100_BIN2
, [BillOfMaterialVariantUsage] nvarchar(1) collate Latin1_General_100_BIN2
, [BillOfMaterialVersion] nvarchar(4) collate Latin1_General_100_BIN2
, [BOMExplosionDate] date
, [BOMValidityStartDate] date
, [BusinessArea] nvarchar(4) collate Latin1_General_100_BIN2
, [CompanyCode] nvarchar(4) collate Latin1_General_100_BIN2
, [ControllingArea] nvarchar(4) collate Latin1_General_100_BIN2
, [ProfitCenter] nvarchar(10) collate Latin1_General_100_BIN2
, [CostCenter] nvarchar(10) collate Latin1_General_100_BIN2
, [ResponsibleCostCenter] nvarchar(10) collate Latin1_General_100_BIN2
, [CostElement] nvarchar(10) collate Latin1_General_100_BIN2
, [CostingSheet] nvarchar(6) collate Latin1_General_100_BIN2
, [GLAccount] nvarchar(10) collate Latin1_General_100_BIN2
, [ProductCostCollector] nvarchar(12) collate Latin1_General_100_BIN2
, [ActualCostsCostingVariant] nvarchar(4) collate Latin1_General_100_BIN2
, [PlannedCostsCostingVariant] nvarchar(4) collate Latin1_General_100_BIN2
, [ControllingObjectClass] nvarchar(2) collate Latin1_General_100_BIN2
, [FunctionalArea] nvarchar(16) collate Latin1_General_100_BIN2
, [MfgOrderPlannedStartDate] date
, [MfgOrderPlannedStartTime] time(0)
, [MfgOrderPlannedEndDate] date
, [MfgOrderPlannedEndTime] time(0)
, [MfgOrderPlannedReleaseDate] date
, [MfgOrderScheduledStartDate] date
, [MfgOrderScheduledStartTime] time(0)
, [MfgOrderScheduledEndDate] date
, [MfgOrderScheduledEndTime] time(0)
, [MfgOrderScheduledReleaseDate] date
, [MfgOrderActualStartDate] date
, [MfgOrderActualStartTime] time(0)
, [MfgOrderActualEndDate] date
, [MfgOrderActualReleaseDate] date
, [MfgOrderConfirmedEndDate] date
, [MfgOrderConfirmedEndTime] time(0)
, [MfgOrderTotalCommitmentDate] date
, [ProductionUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [MfgOrderPlannedTotalQty] decimal(13,3)
, [MfgOrderPlannedScrapQty] decimal(13,3)
, [MfgOrderConfirmedYieldQty] decimal(13,3)
, [MfgOrderConfirmedScrapQty] decimal(13,3)
, [MfgOrderConfirmedReworkQty] decimal(13,3)
, [ExpectedDeviationQuantity] decimal(13,3)
, [ActualDeliveredQuantity] decimal(13,3)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_lastDtm]             DATETIME
, [t_lastActionBy]        VARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_MfgOrderWithStatus] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ManufacturingOrder]
  ) NOT ENFORCED
)
WITH (
  HEAP
)

