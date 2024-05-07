CREATE TABLE [base_s4h_cax].[C_MngProdnOrderMfgOrder]
(
  [MANDT] NCHAR(3) NOT NULL --COLLATE Latin1_General_100_BIN2 NOT NULL
, [ManufacturingOrder] NVARCHAR(12) NOT NULL --COLLATE Latin1_General_100_BIN2 NOT NULL
, [ManufacturingOrderCategory] CHAR(2) -- COLLATE Latin1_General_100_BIN2
, [ManufacturingOrderType] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [ManufacturingOrderText] NVARCHAR(40) -- COLLATE Latin1_General_100_BIN2
, [ManufacturingOrderHasLongText] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [ManufacturingOrderImportance] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderIsToBeDeleted] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderHasMultipleItems] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderIsPartOfCollvOrder] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderHierarchyLevel] DECIMAL(2)
, [IsCompletelyDelivered] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderCreationDate] DATE
, [MfgOrderCreationTime] TIME(0)
, [CreatedByUser] NVARCHAR(12) -- COLLATE Latin1_General_100_BIN2
, [LastChangeDate] DATE
, [LastChangeTime] TIME(0)
, [LastChangedByUser] NVARCHAR(12) -- COLLATE Latin1_General_100_BIN2
, [OrderInternalBillOfOperations] CHAR(10) -- COLLATE Latin1_General_100_BIN2
, [ReferenceOrder] NVARCHAR(12) -- COLLATE Latin1_General_100_BIN2
, [LeadingOrder] NVARCHAR(12) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderSuperiorMfgOrder] NVARCHAR(12) -- COLLATE Latin1_General_100_BIN2
, [Currency] NCHAR(5) -- COLLATE Latin1_General_100_BIN2
, [ProductionPlant] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [Material] NVARCHAR(40) -- COLLATE Latin1_General_100_BIN2
, [MRPPlant] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [MRPArea] NVARCHAR(10) -- COLLATE Latin1_General_100_BIN2
, [MRPController] NVARCHAR(3) -- COLLATE Latin1_General_100_BIN2
, [ProductionSupervisor] NVARCHAR(3) -- COLLATE Latin1_General_100_BIN2
, [ProductionSchedulingProfile] NVARCHAR(6) -- COLLATE Latin1_General_100_BIN2
, [ResponsiblePlannerGroup] NVARCHAR(3) -- COLLATE Latin1_General_100_BIN2
, [ProductionVersion] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [PlannedOrder] NVARCHAR(10) -- COLLATE Latin1_General_100_BIN2
, [SalesDocument] NVARCHAR(10) -- COLLATE Latin1_General_100_BIN2
, [SalesDocumentItem] CHAR(6) -- COLLATE Latin1_General_100_BIN2
, [WBSElementInternalID] CHAR(8) -- COLLATE Latin1_General_100_BIN2
, [Reservation] CHAR(10) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderConfirmation] CHAR(10) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderConfirmationCount] CHAR(8) -- COLLATE Latin1_General_100_BIN2
, [CapacityRequirement] CHAR(12) -- COLLATE Latin1_General_100_BIN2
, [InspectionLot] CHAR(12) -- COLLATE Latin1_General_100_BIN2
, [ChangeNumber] NVARCHAR(12) -- COLLATE Latin1_General_100_BIN2
, [BasicSchedulingType] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [ForecastSchedulingType] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [ManufacturingObject] NVARCHAR(22) -- COLLATE Latin1_General_100_BIN2
, [ProductConfiguration] CHAR(18) -- COLLATE Latin1_General_100_BIN2
, [ConditionApplication] NVARCHAR(2) -- COLLATE Latin1_General_100_BIN2
, [BillOfOperationsMaterial] NVARCHAR(40) -- COLLATE Latin1_General_100_BIN2
, [BillOfOperationsType] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [BillOfOperations] NVARCHAR(8) -- COLLATE Latin1_General_100_BIN2
, [BillOfOperationsVariant] NVARCHAR(2) -- COLLATE Latin1_General_100_BIN2
, [BOOInternalVersionCounter] CHAR(8) -- COLLATE Latin1_General_100_BIN2
, [BillOfOperationsUsage] NVARCHAR(3) -- COLLATE Latin1_General_100_BIN2
, [BOOExplosionDate] DATE
, [BOOValidityStartDate] DATE
, [BillOfMaterialCategory] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [BillOfMaterial] NVARCHAR(8) -- COLLATE Latin1_General_100_BIN2
, [BillOfMaterialVariant] NVARCHAR(2) -- COLLATE Latin1_General_100_BIN2
, [BillOfMaterialVariantUsage] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [BOMExplosionDate] DATE
, [BOMValidityStartDate] DATE
, [BusinessArea] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [CompanyCode] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [ControllingArea] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [ProfitCenter] NVARCHAR(10) -- COLLATE Latin1_General_100_BIN2
, [CostCenter] NVARCHAR(10) -- COLLATE Latin1_General_100_BIN2
, [ResponsibleCostCenter] NVARCHAR(10) -- COLLATE Latin1_General_100_BIN2
, [CostElement] NVARCHAR(10) -- COLLATE Latin1_General_100_BIN2
, [CostingSheet] NVARCHAR(6) -- COLLATE Latin1_General_100_BIN2
, [GLAccount] NVARCHAR(10) -- COLLATE Latin1_General_100_BIN2
, [ProductCostCollector] NVARCHAR(12) -- COLLATE Latin1_General_100_BIN2
, [ActualCostsCostingVariant] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [PlannedCostsCostingVariant] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [ControllingObjectClass] NVARCHAR(2) -- COLLATE Latin1_General_100_BIN2
, [FunctionalArea] NVARCHAR(16) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderPlannedStartDate] DATE
, [MfgOrderPlannedStartTime] TIME(0)
, [MfgOrderPlannedEndDate] DATE
, [MfgOrderPlannedEndTime] TIME(0)
, [MfgOrderPlannedReleaseDate] DATE
, [MfgOrderScheduledStartDate] DATE
, [MfgOrderScheduledStartTime] TIME(0)
, [MfgOrderScheduledEndDate] DATE
, [MfgOrderScheduledEndTime] TIME(0)
, [MfgOrderScheduledReleaseDate] DATE
, [MfgOrderActualStartDate] DATE
, [MfgOrderActualStartTime] TIME(0)
, [MfgOrderActualEndDate] DATE
, [MfgOrderActualReleaseDate] DATE
, [MfgOrderConfirmedEndDate] DATE
, [MfgOrderConfirmedEndTime] TIME(0)
, [MfgOrderTotalCommitmentDate] DATE
, [MfgOrderItemActualDeliveryDate] DATE
, [ProductionUnit] NVARCHAR(3) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderPlannedTotalQty] DECIMAL(13,3)
, [MfgOrderPlannedScrapQty] DECIMAL(13,3)
, [MfgOrderConfirmedYieldQty] DECIMAL(13,3)
, [MfgOrderConfirmedScrapQty] DECIMAL(13,3)
, [MfgOrderConfirmedReworkQty] DECIMAL(13,3)
, [ExpectedDeviationQuantity] DECIMAL(13,3)
, [ActualDeliveredQuantity] DECIMAL(13,3)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_C_MngProdnOrderMfgOrder] PRIMARY KEY NONCLUSTERED (
    [MANDT],[ManufacturingOrder]
  ) NOT ENFORCED
)
WITH (
  HEAP
)

