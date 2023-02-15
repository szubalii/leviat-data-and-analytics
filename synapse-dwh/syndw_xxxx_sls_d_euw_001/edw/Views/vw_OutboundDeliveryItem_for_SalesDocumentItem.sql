CREATE VIEW [edw].[vw_OutboundDeliveryItem_for_SalesDocumentItem]
AS
SELECT
    [OutboundDelivery]
    ,[OutboundDeliveryItem]
    ,[DeliveryDocumentItemCategoryID]
    ,[SalesDocumentItemTypeID]
    ,[CreatedByUserID]
    ,[CreationDate]
    ,[CreationTime]
    ,[LastChangeDate]
    ,[DistributionChannelID]
    ,[ProductID]
    ,[OriginallyRequestedMaterialID]
    ,[ProductGroupID]
    ,[PlantID]
    ,[WarehouseID]
    ,[StorageLocationID]
    ,[HigherLevelItem]
    ,[ActualDeliveryQuantity]
    ,[ActDelQtyTotalForSDI]
    ,[DeliveryQuantityUnit]
    ,[ActualDeliveredQtyInBaseUnit]
    ,[BaseUnit]
    ,[Batch]
    ,[BatchClassification]
    ,[BusinessArea]
    ,[ChmlCmplncStatusID]
    ,[ControllingArea]
    ,[CostCenter]
    ,[CostInDocumentCurrency]
    ,[CreditRelatedPrice]
    ,[DangerousGoodsStatusID]
    ,[DeliveryGroup]
    ,[Division]
    ,[FixedShipgProcgDurationInDays]
    ,[FunctionalArea]
    ,[GoodsMovementType]
    ,[InventorySpecialStockType]
    ,[IsNotGoodsMovementsRelevant]
    ,[ItemGrossWeight]
    ,[ItemNetWeight]
    ,[WGT001_DataQualityCode]
    ,[ItemVolume]
    ,[ItemVolumeUnit]
    ,[ItemWeightUnit]
    ,[LoadingGroup]
    ,[NetPriceAmount_LC]
    ,[OrderDocument]
    ,[OrderID]
    ,[OrderItem]
    ,[OriginalDeliveryQuantity]
    ,[OriginSDDocument]
    ,[OverdelivTolrtdLmtRatioInPct]
    ,[PartialDeliveryIsAllowed]
    ,[PlanningPlant]
    ,[ProductAvailabilityDate]
    ,[ProfitCenterID]
    ,[SalesGroup]
    ,[SalesOffice]
    ,[SDDocumentItem]
    ,[SubsequentMovementType]
    ,[HDR_TotalNetAmount_LC]
    ,[VarblShipgProcgDurationInDays]
    ,[UnlimitedOverdeliveryIsAllowed]
    ,[GLAccountID]
    ,[IsCompletelyDelivered]
    ,[ReceivingPoint]
    ,[ItemIsBillingRelevant]
    ,[ReferenceSDDocument]
    ,[ReferenceSDDocumentItem]
    ,[ReferenceSDDocumentCategoryID]
    ,[SDProcessStatusID]
    ,[PickingConfirmationStatusID]
    ,[PickingStatusID]
    ,[WarehouseActivityStatusID]
    ,[PackingStatusID]
    ,[GoodsMovementStatusID]
    ,[DeliveryRelatedBillingStatusID]
    ,[ProofOfDeliveryStatusID]
    ,[ItemGeneralIncompletionStatusID]
    ,[ItemDeliveryIncompletionStatusID]
    ,[ItemPickingIncompletionStatusID]
    ,[ItemGdsMvtIncompletionStsID]
    ,[ItemPackingIncompletionStatusID]
    ,[ItemBillingIncompletionStatusID]
    ,[IntercompanyBillingStatusID]
    ,[IsReturnsItem]
    ,[SL_ConfirmedDeliveryDate]
    ,[SL_ConfdOrderQtyByMatlAvailCheck]
    ,[SL_GoodsIssueDate]
    ,[SL_ScheduleLine]
    ,[HDR_SalesDistrictID]
    ,[HDR_SalesOrganizationID]
    ,[HDR_SoldToPartyID]
    ,[HDR_ShipToPartyID]
    ,[HDR_DeliveryDocumentTypeID]
    ,[HDR_CompleteDeliveryIsDefined]
    ,[HDR_SupplierID]
    ,[HDR_ReceivingPlantID]
    ,[HDR_DeletionIndicator]
    ,[HDR_DeliveryDate]
    ,[HDR_CarrierID]
    ,[HDR_Carrier]
    ,[SDI_CreationDate]
    ,[SDI_RequestedDeliveryDate]
    ,[SDI_PricePerPiece_LC]
    ,[SDI_PricePerPiece_EUR]
    ,[SDI_LocalCurrency]
    ,[SDI_SalesDocumentTypeID]
    ,[SDI_IsReturnsItemID]
    ,[SDI_BillToParty]
    ,[SDI_ConfdDeliveryQtyInBaseUnit]
    ,[SDI_ConfdDelivQtyInOrderQtyUnit]
    ,[SDI_CostAmount_LC]
    ,[SDI_CostAmount_EUR]
    ,[SDI_DeliveryBlockStatusID]
    ,[SDI_ExchangeRateDate]
    ,[SDI_ExchangeRateType]
    ,[SDI_NetAmount_LC]
    ,[SDI_NetAmount_EUR]
    ,[SDI_NetPriceQuantityUnit]
    ,[SDI_OrderID]
    ,[SDI_OrderQuantity]
    ,[SDI_OrderQuantityUnit]
    ,[SDI_OverallTotalDeliveryStatusID]
    ,[SDI_PayerParty]
    ,[SDI_Route]
    ,[SDI_SalesDocumentItemCategory]
    ,[SDI_SalesOrganizationCurrency]
    ,[SDI_SDDocumentCategory]
    ,[SDI_SDDocumentRejectionStatusID]
    ,[SDI_StorageLocationID]
    ,[OTS_IsOnTime]
    ,[OTS_EarlyDays]
    ,[OTS_LateDays]
    ,[OTS_IsEarly]
    ,[OTS_IsLate]
    ,[RouteIsChangedFlag]
    ,[NrODIPerSDIAndQtyNot0]
    ,[NrSLInScope]
    ,[OTSIF_OnTimeShipInFull]
    ,[HDR_PlannedGoodsIssueDate]
    ,[HDR_ActualGoodsMovementDate]
    ,[HDR_ShippingPointID]
    ,[HDR_OrderCombinationIsAllowed]
    ,[HDR_DeliveryPriority]
    ,[HDR_DeliveryBlockReason]
    ,[HDR_DeliveryDocumentBySupplier]
    ,[HDR_DeliveryIsInPlant]
    ,[HDR_OrderID]
    ,[HDR_PickingDate]
    ,[HDR_LoadingDate]
    ,[HDR_ShippingType]
    ,[HDR_ShippingCondition]
    ,[HDR_ShipmentBlockReason]
    ,[HDR_TransportationPlanningDate]
    ,[HDR_ProposedDeliveryRoute]
    ,[HDR_ActualDeliveryRoute]
    ,[HDR_RouteSchedule]
    ,[HDR_IncotermsClassification]
    ,[HDR_IncotermsTransferLocation]
    ,[HDR_TransportationGroup]
    ,[HDR_MeansOfTransport]
    ,[HDR_MeansOfTransportType]
    ,[HDR_ProofOfDeliveryDate]
    ,[HDR_CustomerGroup]
    ,[HDR_TotalBlockStatusID]
    ,[HDR_TransportationPlanningStatusID]
    ,[HDR_OverallPickingConfStatusID]
    ,[HDR_OverallPickingStatusID]
    ,[HDR_OverallPackingStatusID]
    ,[HDR_OverallGoodsMovementStatusID]
    ,[HDR_OverallProofOfDeliveryStatusID]
    ,[HDR_IntercompanyBillingType]
    ,[HDR_IntercompanyBillingCustomer]
    ,[HDR_TotalNetAmount]
    ,[HDR_ReferenceDocumentNumber]
    ,[HDR_CreatedByUser]
    ,[HDR_DocumentDate]
    ,[HDR_ExternalTransportSystem]
    ,[HDR_HdrGeneralIncompletionStatusID]
    ,[HDR_HdrGoodsMvtIncompletionStatusID]
    ,[HDR_HeaderBillgIncompletionStatusID]
    ,[HDR_HeaderBillingBlockReason]
    ,[HDR_HeaderDelivIncompletionStatusID]
    ,[HDR_HeaderPackingIncompletionSts]
    ,[HDR_HeaderPickgIncompletionStatusID]
    ,[HDR_IsExportDelivery]
    ,[HDR_LastChangeDate]
    ,[HDR_LastChangedByUser]
    ,[HDR_LoadingPoint]
    ,[HDR_OverallChmlCmplncStatusID]
    ,[HDR_OverallDangerousGoodsStatusID]
    ,[HDR_OverallDelivConfStatusID]
    ,[HDR_OverallDelivReltdBillgStatusID]
    ,[HDR_OverallIntcoBillingStatusID]
    ,[HDR_OverallSafetyDataSheetStatusID]
    ,[HDR_OverallSDProcessStatusID]
    ,[HDR_OverallWarehouseActivityStatusID]
    ,[HDR_OvrlItmDelivIncompletionSts]
    ,[HDR_OvrlItmGdsMvtIncompletionSts]
    ,[HDR_OvrlItmGeneralIncompletionSts]
    ,[HDR_OvrlItmPackingIncompletionSts]
    ,[HDR_OvrlItmPickingIncompletionSts]
    ,[HDR_ShippingGroupNumber]
    ,[HDR_TotalNumberOfPackage]
    ,[HDR_TransactionCurrency]
    ,[Currency_EUR]
    ,[ActualDeliveryRouteName]
    ,[ActualDeliveryRouteDurationInHrs]
    ,[ProposedDeliveryRouteName]
    ,[ProposedDeliveryRouteDurationInHrs]
    ,[ActualDeliveryRouteDurationInDays]
    ,[ProposedDeliveryRouteDurationInDays]
    ,[InOutID]
    ,[SDICreationDateIsODICreationDateFlag]
    ,[IF_Total_Group]
    ,[IF_Group]
    ,[IF_IsInFullFlag]
    ,[IF_IsInFull]
    ,[NoActualDeliveredQtyFlag]
    ,[OTS_GoodsIssueDateDiffInDays]
    ,[OTS_DaysDiff]
    ,[OTS_GIDateCheckGroup]
    ,[OTS_Group]
    ,[SDAvailableFlag]
    ,[SDI_ConfQtyEqOrderQtyFlag]
    ,[SLAvailableFlag]
    ,[IF_DataQualityCode]
    ,[OTD_DataQualityCode]
    ,[OTS_DataQualityCode]
    ,[CalculatedDelDate]
    ,[ActualLeadTime]
    ,[ALT001_DataQualityCode]
    ,[RequestedLeadTime]
    ,[RLT001_DataQualityCode]
    ,[OTD_DaysDiff]
    ,[OTD_Group]
    ,[OTD_EarlyDays]
    ,[OTD_IsEarly]
    ,[OTD_IsLate]
    ,[OTD_IsOnTime]
    ,[OTD_LateDays]
    ,[OTDIF_OnTimeDelInFull]
FROM [edw].[fact_OutboundDeliveryItem]