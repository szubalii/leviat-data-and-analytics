CREATE TABLE [base_s4h_cax].[I_OutboundDeliveryItem](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [OutboundDelivery] nvarchar(10) NOT NULL
, [OutboundDeliveryItem] char(6) collate Latin1_General_100_BIN2 NOT NULL
, [DeliveryDocumentItemCategory] nvarchar(4)
, [SalesDocumentItemType] nvarchar(1)
, [CreatedByUser] nvarchar(12)
, [CreationDate] date
, [CreationTime] time(0)
, [LastChangeDate] date
, [DistributionChannel] nvarchar(2)
, [Division] nvarchar(2)
, [SalesGroup] nvarchar(3)
, [SalesOffice] nvarchar(4)
, [DepartmentClassificationByCust] nvarchar(4)
, [Material] nvarchar(40)
, [Product] nvarchar(40)
, [MaterialByCustomer] nvarchar(35)
, [OriginallyRequestedMaterial] nvarchar(40)
, [InternationalArticleNumber] nvarchar(18)
, [Batch] nvarchar(10)
, [BatchClassification] char(18) collate Latin1_General_100_BIN2
, [BatchBySupplier] nvarchar(15)
, [MaterialIsIntBatchManaged] nvarchar(1)
, [MaterialIsBatchManaged] nvarchar(1)
, [MaterialGroup] nvarchar(9)
, [ProductGroup] nvarchar(9)
, [MaterialFreightGroup] nvarchar(8)
, [AdditionalMaterialGroup1] nvarchar(3)
, [AdditionalMaterialGroup2] nvarchar(3)
, [AdditionalMaterialGroup3] nvarchar(3)
, [AdditionalMaterialGroup4] nvarchar(3)
, [AdditionalMaterialGroup5] nvarchar(3)
, [Plant] nvarchar(4)
, [Warehouse] nvarchar(3)
, [StorageLocation] nvarchar(4)
, [StorageBin] nvarchar(10)
, [StorageType] nvarchar(3)
, [InventorySpecialStockType] nvarchar(1)
, [ShelfLifeExpirationDate] date
, [NumberOfSerialNumbers] int
, [ProductConfiguration] char(18) collate Latin1_General_100_BIN2
, [ProductHierarchyNode] nvarchar(18)
, [ManufactureDate] date
, [DeliveryDocumentItemText] nvarchar(40)
, [HigherLevelItem] char(6) collate Latin1_General_100_BIN2
, [HigherLvlItmOfBatSpltItm] char(6) collate Latin1_General_100_BIN2
, [ActualDeliveryQuantity] decimal(13,3)
, [QuantityIsFixed] nvarchar(1)
, [OriginalDeliveryQuantity] decimal(13,3)
, [DeliveryQuantityUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [ActualDeliveredQtyInBaseUnit] decimal(13,3)
, [BaseUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [DeliveryToBaseQuantityDnmntr] decimal(5)
, [DeliveryToBaseQuantityNmrtr] decimal(5)
, [ProductAvailabilityDate] date
, [ProductAvailabilityTime] time(0)
, [DeliveryGroup] char(3) collate Latin1_General_100_BIN2
, [ItemGrossWeight] decimal(15,3)
, [ItemNetWeight] decimal(15,3)
, [ItemWeightUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [ItemVolume] decimal(15,3)
, [ItemVolumeUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [InspectionLot] char(12) collate Latin1_General_100_BIN2
, [InspectionPartialLot] char(6) collate Latin1_General_100_BIN2
, [PartialDeliveryIsAllowed] nvarchar(1)
, [UnlimitedOverdeliveryIsAllowed] nvarchar(1)
, [OverdelivTolrtdLmtRatioInPct] decimal(3,1)
, [UnderdelivTolrtdLmtRatioInPct] decimal(3,1)
, [BOMExplosion] nvarchar(8)
, [WarehouseStagingArea] nvarchar(10)
, [WarehouseStockCategory] nvarchar(1)
, [StockType] nvarchar(1)
, [GLAccount] nvarchar(10)
, [GoodsMovementReasonCode] char(4) collate Latin1_General_100_BIN2
, [SubsequentMovementType] nvarchar(3)
, [IsCompletelyDelivered] nvarchar(1)
, [IsNotGoodsMovementsRelevant] nvarchar(1)
, [PickingControl] nvarchar(1)
, [LoadingGroup] nvarchar(4)
, [GoodsMovementType] nvarchar(3)
, [TransportationGroup] nvarchar(4)
, [ReceivingPoint] nvarchar(25)
, [FixedShipgProcgDurationInDays] decimal(5,2)
, [VarblShipgProcgDurationInDays] decimal(5,2)
, [ProofOfDeliveryRelevanceCode] nvarchar(1)
, [ItemIsBillingRelevant] nvarchar(1)
, [ItemBillingBlockReason] nvarchar(2)
, [BusinessArea] nvarchar(4)
, [ControllingArea] nvarchar(4)
, [ProfitabilitySegment] char(10) collate Latin1_General_100_BIN2
, [ProfitCenter] nvarchar(10)
, [InventoryValuationType] nvarchar(10)
, [IsSeparateValuation] nvarchar(1)
, [ConsumptionPosting] nvarchar(1)
, [OrderID] nvarchar(12)
, [OrderItem] char(4) collate Latin1_General_100_BIN2
, [CostCenter] nvarchar(10)
, [ReferenceSDDocument] nvarchar(10)
, [ReferenceSDDocumentItem] char(6) collate Latin1_General_100_BIN2
, [ReferenceSDDocumentCategory] nvarchar(4)
, [ReferenceDocumentLogicalSystem] nvarchar(10)
, [AdditionalCustomerGroup1] nvarchar(3)
, [AdditionalCustomerGroup2] nvarchar(3)
, [AdditionalCustomerGroup3] nvarchar(3)
, [AdditionalCustomerGroup4] nvarchar(3)
, [AdditionalCustomerGroup5] nvarchar(3)
, [RetailPromotion] nvarchar(10)
, [SDProcessStatus] nvarchar(1)
, [PickingConfirmationStatus] nvarchar(1)
, [PickingStatus] nvarchar(1)
, [WarehouseActivityStatus] nvarchar(1)
, [PackingStatus] nvarchar(1)
, [GoodsMovementStatus] nvarchar(1)
, [DeliveryRelatedBillingStatus] nvarchar(1)
, [ProofOfDeliveryStatus] nvarchar(1)
, [ItemGeneralIncompletionStatus] nvarchar(1)
, [ItemDeliveryIncompletionStatus] nvarchar(1)
, [ItemPickingIncompletionStatus] nvarchar(1)
, [ItemGdsMvtIncompletionSts] nvarchar(1)
, [ItemPackingIncompletionStatus] nvarchar(1)
, [ItemBillingIncompletionStatus] nvarchar(1)
, [IntercompanyBillingStatus] nvarchar(1)
, [ChmlCmplncStatus] nvarchar(1)
, [DangerousGoodsStatus] nvarchar(1)
, [SafetyDataSheetStatus] nvarchar(1)
, [RequirementSegment] nvarchar(40)
, [StockSegment] nvarchar(40)
, [ProductSeasonYear] nvarchar(4)
, [ProductSeason] nvarchar(10)
, [ProductCollection] nvarchar(10)
, [ProductTheme] nvarchar(10)
, [ProductCharacteristic1] nvarchar(18)
, [ProductCharacteristic2] nvarchar(18)
, [ProductCharacteristic3] nvarchar(18)
, [OriginSDDocument] nvarchar(10)
, [SDDocumentItem] char(6) collate Latin1_General_100_BIN2
, [SalesSDDocumentCategory] nvarchar(4)
, [MaterialTypePrimary] nvarchar(4)
, [CostInDocumentCurrency] decimal(13,2)
, [Subtotal1Amount] decimal(13,2)
, [Subtotal2Amount] decimal(13,2)
, [Subtotal3Amount] decimal(13,2)
, [Subtotal4Amount] decimal(13,2)
, [Subtotal5Amount] decimal(13,2)
, [Subtotal6Amount] decimal(13,2)
, [OrderDocument] nvarchar(10)
, [PlanningMaterial] nvarchar(40)
, [PlanningPlant] nvarchar(4)
, [ProductGroupBaseUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [ConversionFactor] float
, [IsReturnsItem] nvarchar(1)
, [ConditionUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [NetPriceAmount] decimal(11,2)
, [TotalNetAmount] decimal(15,2)
, [QtyInPurchaseOrderPriceUnit] decimal(13,3)
, [CreditRelatedPrice] float
, [DeliveryToBaseUnitCnvrsnFctr] float
, [FunctionalArea] nvarchar(16)
, [Reservation] char(10) collate Latin1_General_100_BIN2
, [ReservationItem] char(4) collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_OutboundDeliveryItem] PRIMARY KEY NONCLUSTERED (
    [MANDT], [OutboundDelivery], [OutboundDeliveryItem]
  ) NOT ENFORCED
)
WITH (DISTRIBUTION = HASH ([ReferenceSDDocument]), CLUSTERED COLUMNSTORE INDEX)
