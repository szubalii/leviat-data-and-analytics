CREATE TABLE [edw].[dim_CustomerReturnDeliveryItem] (
-- Customer Returns Delivery Document Item
-- 1:1 as base layer table
[CustomerReturnDelivery] nvarchar(20) NOT NULL
, [CustomerReturnDeliveryItem] char(6) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [DeliveryDocumentItemCategory] nvarchar(8)
, [SalesDocumentItemType] nvarchar(2)
, [HigherLvlItmOfBatSpltItm] char(6) -- collate Latin1_General_100_BIN2
, [CreatedByUser] nvarchar(24)
, [CreationDate] date
, [CreationTime] time(0)
, [LastChangeDate] date
, [DistributionChannel] nvarchar(4)
, [Division] nvarchar(4)
, [SalesGroup] nvarchar(6)
, [SalesOffice] nvarchar(8)
, [DepartmentClassificationByCust] nvarchar(8)
, [Material] nvarchar(80)
, [MaterialByCustomer] nvarchar(70)
, [OriginallyRequestedMaterial] nvarchar(80)
, [InternationalArticleNumber] nvarchar(36)
, [Batch] nvarchar(20)
, [BatchClassification] char(18) -- collate Latin1_General_100_BIN2
, [BatchBySupplier] nvarchar(30)
, [MaterialIsIntBatchManaged] nvarchar(2)
, [MaterialIsBatchManaged] nvarchar(2)
, [MaterialGroup] nvarchar(18)
, [MaterialFreightGroup] nvarchar(16)
, [AdditionalMaterialGroup1] nvarchar(6)
, [AdditionalMaterialGroup2] nvarchar(6)
, [AdditionalMaterialGroup3] nvarchar(6)
, [AdditionalMaterialGroup4] nvarchar(6)
, [AdditionalMaterialGroup5] nvarchar(6)
, [Plant] nvarchar(8)
, [Warehouse] nvarchar(6)
, [StorageLocation] nvarchar(8)
, [StorageBin] nvarchar(20)
, [StorageType] nvarchar(6)
, [InventorySpecialStockType] nvarchar(2)
, [ShelfLifeExpirationDate] date
, [NumberOfSerialNumbers] int
, [ProductConfiguration] char(18) -- collate Latin1_General_100_BIN2
, [ProductHierarchyNode] nvarchar(36)
, [ManufactureDate] date
, [DeliveryDocumentItemText] nvarchar(80)
, [HigherLevelItem] char(6) -- collate Latin1_General_100_BIN2
, [ActualDeliveryQuantity] decimal(13,3)
, [QuantityIsFixed] nvarchar(2)
, [OriginalDeliveryQuantity] decimal(13,3)
, [DeliveryQuantityUnit] nvarchar(6) -- collate Latin1_General_100_BIN2
, [ActualDeliveredQtyInBaseUnit] decimal(13,3)
, [BaseUnit] nvarchar(6) -- collate Latin1_General_100_BIN2
, [DeliveryToBaseQuantityDnmntr] decimal(5)
, [DeliveryToBaseQuantityNmrtr] decimal(5)
, [ProductAvailabilityDate] date
, [ProductAvailabilityTime] time(0)
, [DeliveryGroup] char(3) -- collate Latin1_General_100_BIN2
, [ItemGrossWeight] decimal(15,3)
, [ItemNetWeight] decimal(15,3)
, [ItemWeightUnit] nvarchar(6) -- collate Latin1_General_100_BIN2
, [ItemVolume] decimal(15,3)
, [ItemVolumeUnit] nvarchar(6) -- collate Latin1_General_100_BIN2
, [InspectionLot] char(12) -- collate Latin1_General_100_BIN2
, [InspectionPartialLot] char(6) -- collate Latin1_General_100_BIN2
, [PartialDeliveryIsAllowed] nvarchar(2)
, [UnlimitedOverdeliveryIsAllowed] nvarchar(2)
, [OverdelivTolrtdLmtRatioInPct] decimal(3,1)
, [UnderdelivTolrtdLmtRatioInPct] decimal(3,1)
, [BOMExplosion] nvarchar(16)
, [WarehouseStockCategory] nvarchar(2)
, [IsNotGoodsMovementsRelevant] nvarchar(2)
, [StockType] nvarchar(2)
, [GLAccount] nvarchar(20)
, [GoodsMovementReasonCode] char(4) -- collate Latin1_General_100_BIN2
, [IsCompletelyDelivered] nvarchar(2)
, [PickingControl] nvarchar(2)
, [LoadingGroup] nvarchar(8)
, [GoodsMovementType] nvarchar(6)
, [TransportationGroup] nvarchar(8)
, [ReceivingPoint] nvarchar(50)
, [FixedShipgProcgDurationInDays] decimal(5,2)
, [VarblShipgProcgDurationInDays] decimal(5,2)
, [ProofOfDeliveryRelevanceCode] nvarchar(2)
, [ItemIsBillingRelevant] nvarchar(2)
, [ItemBillingBlockReason] nvarchar(4)
, [BusinessArea] nvarchar(8)
, [ControllingArea] nvarchar(8)
, [ProfitabilitySegment] char(10) -- collate Latin1_General_100_BIN2
, [ProfitCenter] nvarchar(20)
, [InventoryValuationType] nvarchar(20)
, [IsSeparateValuation] nvarchar(2)
, [ConsumptionPosting] nvarchar(2)
, [OrderID] nvarchar(24)
, [OrderItem] char(4) -- collate Latin1_General_100_BIN2
, [CostCenter] nvarchar(20)
, [ReferenceSDDocument] nvarchar(20)
, [ReferenceSDDocumentItem] char(6) -- collate Latin1_General_100_BIN2
, [ReferenceSDDocumentCategory] nvarchar(8)
, [ReferenceDocumentLogicalSystem] nvarchar(20)
, [AdditionalCustomerGroup1] nvarchar(6)
, [AdditionalCustomerGroup2] nvarchar(6)
, [AdditionalCustomerGroup3] nvarchar(6)
, [AdditionalCustomerGroup4] nvarchar(6)
, [AdditionalCustomerGroup5] nvarchar(6)
, [RetailPromotion] nvarchar(20)
, [SDProcessStatus] nvarchar(2)
, [PickingConfirmationStatus] nvarchar(2)
, [PickingStatus] nvarchar(2)
, [PutawayStatus] nvarchar(2)
, [WarehouseActivityStatus] nvarchar(2)
, [PackingStatus] nvarchar(2)
, [GoodsMovementStatus] nvarchar(2)
, [DeliveryRelatedBillingStatus] nvarchar(2)
, [ProofOfDeliveryStatus] nvarchar(2)
, [ItemGeneralIncompletionStatus] nvarchar(2)
, [ItemDeliveryIncompletionStatus] nvarchar(2)
, [ItemPickingIncompletionStatus] nvarchar(2)
, [ItemGdsMvtIncompletionSts] nvarchar(2)
, [ItemPackingIncompletionStatus] nvarchar(2)
, [ItemBillingIncompletionStatus] nvarchar(2)
, [IntercompanyBillingStatus] nvarchar(2)
, [ChmlCmplncStatus] nvarchar(2)
, [DangerousGoodsStatus] nvarchar(2)
, [SafetyDataSheetStatus] nvarchar(2)
, [RequirementSegment] nvarchar(80)
, [StockSegment] nvarchar(80)
, [ProductSeasonYear] nvarchar(8)
, [ProductSeason] nvarchar(20)
, [ProductCollection] nvarchar(20)
, [ProductTheme] nvarchar(20)
, [ProductCharacteristic1] nvarchar(36)
, [ProductCharacteristic2] nvarchar(36)
, [ProductCharacteristic3] nvarchar(36)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
,    CONSTRAINT [PK_dim_CustomerReturnDeliveryItem] PRIMARY KEY NONCLUSTERED ([CustomerReturnDelivery],[CustomerReturnDeliveryItem]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
