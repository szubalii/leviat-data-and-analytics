CREATE TABLE [edw].[fact_OutboundDeliveryItem] (
       [sk_fact_OutboundDeliveryItem] int IDENTITY(1,1) NOT NULL
      ,[nk_fact_OutboundDeliveryItem] nvarchar(45) NOT NULL
      ,[OutboundDelivery] nvarchar(20) NOT NULL
      ,[OutboundDeliveryItem] char(6) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
      ,[DeliveryDocumentItemCategoryID] nvarchar(4)
      ,[SalesDocumentItemTypeID] nvarchar(1)
      ,[CreatedByUserID] nvarchar(12)
      ,[CreationDate] date
      ,[CreationTime] time(0)
      ,[LastChangeDate] date
      ,[DistributionChannelID] nvarchar(2)
      ,[ProductID] nvarchar(40)
      ,[OriginallyRequestedMaterialID] nvarchar(40)
      ,[ProductGroupID] nvarchar(9)
      ,[PlantID] nvarchar(4)
      ,[WarehouseID] nvarchar(3)
      ,[StorageLocationID] nvarchar(4)
      ,[HigherLevelItem] char(6) -- collate Latin1_General_100_BIN2
      ,[ActualDeliveryQuantity] decimal(38,12)
      ,[ActDelQtyTotalForSDI] decimal(38,12)
      ,[DeliveryQuantityUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
      ,[ActualDeliveredQtyInBaseUnit] decimal(13,3)
      ,[BaseUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
      ,[Batch] nvarchar(10)
      ,[BatchClassification] char(18) -- collate Latin1_General_100_BIN2
      ,[BusinessArea] nvarchar(4)
      ,[ChmlCmplncStatusID] nvarchar(1)
      ,[ControllingArea] nvarchar(4)
      ,[CostCenter] nvarchar(10)
      ,[CostInDocumentCurrency] decimal(13,2)
      ,[CreditRelatedPrice] float
      ,[DangerousGoodsStatusID] nvarchar(1)
      ,[DeliveryGroup] char(3) -- collate Latin1_General_100_BIN2
      ,[Division] nvarchar(2)
      ,[FixedShipgProcgDurationInDays] decimal(5,2)
      ,[FunctionalArea] nvarchar(16)
      ,[GoodsMovementType] nvarchar(3)
      ,[InventorySpecialStockType] nvarchar(1)
      ,[IsNotGoodsMovementsRelevant] nvarchar(1)
      ,[ItemGrossWeight] decimal(15,3)
      ,[ItemNetWeight] decimal(15,3)
      ,[WGT001_DataQualityCode]  nvarchar (6)      
      ,[ItemVolume] decimal(15,3)
      ,[ItemVolumeUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
      ,[ItemWeightUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
      ,[LoadingGroup] nvarchar(4)
      ,[NetPriceAmount_LC] decimal(11,2)
      ,[OrderDocument] nvarchar(10)
      ,[OrderID] nvarchar(12)
      ,[OrderItem] char(4) -- collate Latin1_General_100_BIN2
      ,[OriginalDeliveryQuantity] decimal(13,3)
      ,[OriginSDDocument] nvarchar(10)
      ,[OverdelivTolrtdLmtRatioInPct] decimal(3,1)
      ,[PartialDeliveryIsAllowed] nvarchar(1)
      ,[PlanningPlant] nvarchar(4)
      ,[ProductAvailabilityDate] date
      ,[ProfitCenterID] nvarchar(10)
      ,[SalesGroup] nvarchar(3)
      ,[SalesOffice] nvarchar(4)
      ,[SDDocumentItem] char(6) -- collate Latin1_General_100_BIN2
      ,[SubsequentMovementType] nvarchar(3)
      ,[HDR_TotalNetAmount_LC] decimal(15,2)
      ,[VarblShipgProcgDurationInDays] decimal(5,2)
      ,[UnlimitedOverdeliveryIsAllowed] nvarchar(1)
      ,[GLAccountID] nvarchar(10)
      ,[IsCompletelyDelivered] nvarchar(1)
      ,[ReceivingPoint] nvarchar(25)
      ,[ItemIsBillingRelevant] nvarchar(1)
      ,[ReferenceSDDocument] nvarchar(20)
      ,[ReferenceSDDocumentItem] char(24) -- collate Latin1_General_100_BIN2
      ,[ReferenceSDDocumentCategoryID] nvarchar(4)
      ,[SDProcessStatusID] nvarchar(1)
      ,[PickingConfirmationStatusID] nvarchar(1)
      ,[PickingStatusID] nvarchar(1)
      ,[WarehouseActivityStatusID] nvarchar(1)
      ,[PackingStatusID] nvarchar(1)
      ,[GoodsMovementStatusID] nvarchar(1)
      ,[DeliveryRelatedBillingStatusID] nvarchar(1)
      ,[ProofOfDeliveryStatusID] nvarchar(1)
      ,[ItemGeneralIncompletionStatusID] nvarchar(1)
      ,[ItemDeliveryIncompletionStatusID] nvarchar(1)
      ,[ItemPickingIncompletionStatusID] nvarchar(1)
      ,[ItemGdsMvtIncompletionStsID] nvarchar(1)
      ,[ItemPackingIncompletionStatusID] nvarchar(1)
      ,[ItemBillingIncompletionStatusID] nvarchar(1)
      ,[IntercompanyBillingStatusID] nvarchar(1)
      ,[IsReturnsItem] nvarchar(1)
      ,[SL_ConfirmedDeliveryDate] date
      ,[SL_ConfdOrderQtyByMatlAvailCheck] decimal(38,12)
      ,[SL_GoodsIssueDate] date
      ,[SL_ScheduleLine] char(4) -- collate Latin1_General_100_BIN2
      ,[HDR_SalesDistrictID] nvarchar(6)
      ,[HDR_SalesOrganizationID] nvarchar(4)
      ,[HDR_SoldToPartyID] nvarchar(10)
      ,[HDR_ShipToPartyID] nvarchar(10)
      ,[HDR_DeliveryDocumentTypeID] nvarchar(4)
      ,[HDR_CompleteDeliveryIsDefined] nvarchar(1)
      ,[HDR_SupplierID] nvarchar(10)
      ,[HDR_ReceivingPlantID] nvarchar(4)
      ,[HDR_DeletionIndicator] nvarchar(1)
      ,[HDR_DeliveryDate] date
      ,[HDR_CarrierID] nvarchar(10)
      ,[HDR_Carrier] nvarchar(80)
      ,[SDI_CreationDate] date
      ,[SDI_RequestedDeliveryDate] date
      ,[SDI_PricePerPiece_LC] decimal(38,12)
      ,[SDI_PricePerPiece_EUR] decimal(38,12)
      ,[SDI_LocalCurrency] char(5) NULL
      ,[SDI_SalesDocumentTypeID] nvarchar(4)
      ,[SDI_IsReturnsItemID] nvarchar(1)
      ,[SDI_BillToParty] nvarchar(10)
      ,[SDI_ConfdDeliveryQtyInBaseUnit] decimal(15,3)
      ,[SDI_ConfdDelivQtyInOrderQtyUnit] decimal(15,3)
      ,[SDI_CostAmount_LC] decimal(19,6)
      ,[SDI_CostAmount_EUR] decimal(19,6)
      ,[SDI_DeliveryBlockStatusID] nvarchar(1)
      ,[SDI_ExchangeRateDate] date
      ,[SDI_ExchangeRateType] nvarchar(4)
      ,[SDI_NetAmount_LC] decimal(19,6)
      ,[SDI_NetAmount_EUR] decimal(19,6)
      ,[SDI_NetPriceQuantityUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
      ,[SDI_OrderID] nvarchar(12)
      ,[SDI_OrderQuantity] decimal(15,3)
      ,[SDI_OrderQuantityUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
      ,[SDI_OverallTotalDeliveryStatusID] nvarchar(1)
      ,[SDI_PayerParty] nvarchar(10)
      ,[SDI_Route] nvarchar(6)
      ,[SDI_SalesDocumentItemCategory] nvarchar(4)
      ,[SDI_SalesOrganizationCurrency] char(5) -- collate Latin1_General_100_BIN2
      ,[SDI_SDDocumentCategory] nvarchar(4)
      ,[SDI_SDDocumentRejectionStatusID] nvarchar(1)
      ,[SDI_StorageLocationID] nvarchar(4)
      ,[OTS_IsOnTime] bit
      ,[OTS_EarlyDays] int
      ,[OTS_LateDays] int
      ,[OTS_IsEarly] bit
      ,[OTS_IsLate] bit
      ,[RouteIsChangedFlag] char(1)  -- collate Latin1_General_100_BIN2
      ,[NrODIPerSDIAndQtyNot0] int
      ,[NrSLInScope] int
      ,[OTSIF_OnTimeShipInFull] nvarchar(6)
      ,[HDR_PlannedGoodsIssueDate] date
      ,[HDR_ActualGoodsMovementDate] date
      ,[HDR_ShippingPointID] nvarchar(4)
      ,[HDR_OrderCombinationIsAllowed] nvarchar(1)
      ,[HDR_DeliveryPriority] char(2) -- collate Latin1_General_100_BIN2
      ,[HDR_DeliveryBlockReason] nvarchar(2)
      ,[HDR_DeliveryDocumentBySupplier] nvarchar(35)
      ,[HDR_DeliveryIsInPlant] nvarchar(1)
      ,[HDR_OrderID] nvarchar(12)
      ,[HDR_PickingDate] date
      ,[HDR_LoadingDate] date
      ,[HDR_ShippingType] nvarchar(2)
      ,[HDR_ShippingCondition] nvarchar(2)
      ,[HDR_ShipmentBlockReason] nvarchar(2)
      ,[HDR_TransportationPlanningDate] date
      ,[HDR_ProposedDeliveryRoute] nvarchar(6)
      ,[HDR_ActualDeliveryRoute] nvarchar(6)
      ,[HDR_RouteSchedule] nvarchar(10)
      ,[HDR_IncotermsClassification] nvarchar(3)
      ,[HDR_IncotermsTransferLocation] nvarchar(28)
      ,[HDR_TransportationGroup] nvarchar(4)
      ,[HDR_MeansOfTransport] nvarchar(20)
      ,[HDR_MeansOfTransportType] nvarchar(4)
      ,[HDR_ProofOfDeliveryDate] date
      ,[HDR_CustomerGroup] nvarchar(2)
      ,[HDR_TotalBlockStatusID] nvarchar(1)
      ,[HDR_TransportationPlanningStatusID] nvarchar(1)
      ,[HDR_OverallPickingConfStatusID] nvarchar(1)
      ,[HDR_OverallPickingStatusID] nvarchar(1)
      ,[HDR_OverallPackingStatusID] nvarchar(1)
      ,[HDR_OverallGoodsMovementStatusID] nvarchar(1)
      ,[HDR_OverallProofOfDeliveryStatusID] nvarchar(1)
      ,[HDR_IntercompanyBillingType] nvarchar(4)
      ,[HDR_IntercompanyBillingCustomer] nvarchar(10)
      ,[HDR_TotalNetAmount] decimal(15,2)
      ,[HDR_ReferenceDocumentNumber] nvarchar(25)
      ,[HDR_CreatedByUser] nvarchar(12)
      ,[HDR_DocumentDate] date
      ,[HDR_ExternalTransportSystem] nvarchar(5)
      ,[HDR_HdrGeneralIncompletionStatusID] nvarchar(1)
      ,[HDR_HdrGoodsMvtIncompletionStatusID] nvarchar(1)
      ,[HDR_HeaderBillgIncompletionStatusID] nvarchar(1)
      ,[HDR_HeaderBillingBlockReason] nvarchar(2)
      ,[HDR_HeaderDelivIncompletionStatusID] nvarchar(1)
      ,[HDR_HeaderPackingIncompletionSts] nvarchar(1)
      ,[HDR_HeaderPickgIncompletionStatusID] nvarchar(1)
      ,[HDR_IsExportDelivery] nvarchar(1)
      ,[HDR_LastChangeDate] date
      ,[HDR_LastChangedByUser] nvarchar(12)
      ,[HDR_LoadingPoint] nvarchar(2)
      ,[HDR_OverallChmlCmplncStatusID] nvarchar(1)
      ,[HDR_OverallDangerousGoodsStatusID] nvarchar(1)
      ,[HDR_OverallDelivConfStatusID] nvarchar(1)
      ,[HDR_OverallDelivReltdBillgStatusID] nvarchar(1)
      ,[HDR_OverallIntcoBillingStatusID] nvarchar(1)
      ,[HDR_OverallSafetyDataSheetStatusID] nvarchar(1)
      ,[HDR_OverallSDProcessStatusID] nvarchar(1)
      ,[HDR_OverallWarehouseActivityStatusID] nvarchar(1)
      ,[HDR_OvrlItmDelivIncompletionSts] nvarchar(1)
      ,[HDR_OvrlItmGdsMvtIncompletionSts] nvarchar(1)
      ,[HDR_OvrlItmGeneralIncompletionSts] nvarchar(1)
      ,[HDR_OvrlItmPackingIncompletionSts] nvarchar(1)
      ,[HDR_OvrlItmPickingIncompletionSts] nvarchar(1)
      ,[HDR_ShippingGroupNumber] nvarchar(10)
      ,[HDR_TotalNumberOfPackage] char(5) -- collate Latin1_General_100_BIN2
      ,[HDR_TransactionCurrency] char(5) -- collate Latin1_General_100_BIN2
      ,[Currency_EUR] nvarchar(3)
      ,[ActualDeliveryRouteName] nvarchar(40)
      ,[ActualDeliveryRouteDurationInHrs] decimal(11)
      ,[ProposedDeliveryRouteName] nvarchar(40)
      ,[ProposedDeliveryRouteDurationInHrs] decimal(11)
      ,[ActualDeliveryRouteDurationInDays] decimal(11)
      ,[ProposedDeliveryRouteDurationInDays] decimal(11)
      ,[InOutID] NVARCHAR (6) -- collate Latin1_General_100_BIN2
      ,[SDICreationDateIsODICreationDateFlag] char(1) -- collate Latin1_General_100_BIN2
      ,[IF_Total_Group] nvarchar (17)
      ,[IF_Group] nvarchar (17)
      ,[IF_IsInFullFlag] char(1) -- collate Latin1_General_100_BIN2
      ,[IF_IsInFull] bit
      ,[NoActualDeliveredQtyFlag] char(1) -- collate Latin1_General_100_BIN2
      ,[OTS_GoodsIssueDateDiffInDays] int
      ,[OTS_DaysDiff] int
      ,[OTS_GIDateCheckGroup] nvarchar (7)
      ,[OTS_Group] nvarchar (7)
      ,[SDAvailableFlag] char(1) -- collate Latin1_General_100_BIN2
      ,[SDI_ConfQtyEqOrderQtyFlag] char(1) -- collate Latin1_General_100_BIN2
      ,[SLAvailableFlag] char(1) -- collate Latin1_General_100_BIN2
      ,[IF_DataQualityCode] nvarchar (5)
      ,[OTD_DataQualityCode] nvarchar (6)
      ,[OTS_DataQualityCode] nvarchar (6)
      ,[CalculatedDelDate] date
      ,[ActualLeadTime] int
      ,[ALT001_DataQualityCode] nvarchar (6)
      ,[RequestedLeadTime] int
      ,[RLT001_DataQualityCode] nvarchar (6)
      ,[OTD_DaysDiff] int
      ,[OTD_Group]  nvarchar (7)
      ,[OTD_EarlyDays] int
      ,[OTD_IsEarly] bit
      ,[OTD_IsLate] bit
      ,[OTD_IsOnTime] bit
      ,[OTD_LateDays] int
      ,[OTDIF_OnTimeDelInFull] nvarchar(6)
      ,[t_applicationId]       varchar (32)
      ,[t_extractionDtm]       datetime
      ,[t_jobId]               varchar (36)
      ,[t_jobDtm]              datetime
      ,[t_lastActionCd]        varchar(1)
      ,[t_jobBy]               nvarchar(128)
, CONSTRAINT [PK_fact_OutboundDeliveryItem] PRIMARY KEY NONCLUSTERED ([sk_fact_OutboundDeliveryItem]) NOT ENFORCED
)
WITH (
    DISTRIBUTION = HASH ([nk_fact_OutboundDeliveryItem]), CLUSTERED COLUMNSTORE INDEX
)
