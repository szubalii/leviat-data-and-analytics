﻿CREATE VIEW [dm_sales].[vw_fact_OutboundDeliveryItem] AS 
WITH BDIFreight AS (
  SELECT
    BDI_TC.[ReferenceSDDocument]
    ,BDI_TC.[ReferenceSDDocumentItem]
    ,BDI_TC.[CurrencyID]              AS TransactionCurrencyID
    ,SUM(PE.[ConditionAmount])        AS InvoicedFreightValueTransactionCurrency
  FROM
    [edw].[fact_BillingDocumentItem] BDI_TC
  LEFT JOIN
    [edw].[fact_BillingDocumentItemPrcgElmnt] PE
    ON BDI_TC.BillingDocument = PE.BillingDocument
      AND BDI_TC.BillingDocumentItem = PE.BillingDocumentItem
      AND PE.ConditionType in ( 'ZF10', 'ZF20', 'ZF40','ZF60', 'ZTMF')        -- ZF10 - Freight surchage %
  WHERE                                                                       -- ZF20 - Min. Freight charges
    BDI_TC.[CurrencyType] = 'Transaction Currency'                            -- ZF40 - Freight Charge- Pack
                                                                              -- ZF60 - Man. Freight Charges
    --AND BDI_TC.Material='000000000070000011'      -- Freight                     ZTMF - Freight from SAP TM
    AND COALESCE( BDI_TC.BillingDocumentIsCancelled, '') = ''
    AND COALESCE( BDI_TC.CancelledBillingDocument, '') = ''
  GROUP BY
    BDI_TC.[ReferenceSDDocument]
    ,BDI_TC.[ReferenceSDDocumentItem]
    ,BDI_TC.[CurrencyID]
)
, FrtCostDistrItm AS (
  SELECT
    TOI.TranspOrdDocReferenceID
    , TOI.TranspOrdDocReferenceItmID
    , SUM(FCDI.FrtCostDistrItemAmount)           AS FrtCostDistrItemAmount
    , MIN(FCDI.FrtCostDistrItemAmtCrcy)          AS FrtCostDistrItemAmtCrcy     -- the same value for a whole group
  FROM [edw].[vw_TransportationOrderItem] TOI
  INNER JOIN [edw].[vw_FrtCostDistrItm] FCDI
    ON TOI.TransportationOrderItemUUID = FCDI.FrtCostDistrItmRefUUID
  GROUP BY
    TOI.TranspOrdDocReferenceID
    , TOI.TranspOrdDocReferenceItmID
)
, CurrencyConversionRate AS (
  SELECT 
    SourceCurrency
    , TargetCurrency
    , ExchangeRate
  FROM
    [edw].[vw_CurrencyConversionRate]
  WHERE
    CurrencyTypeID<>'00'
    AND NOT (CurrencyTypeID<>'10' AND [SourceCurrency]='EUR')
)
SELECT  
       [sk_fact_OutboundDeliveryItem]
      ,[nk_fact_OutboundDeliveryItem]
      ,[OutboundDelivery]
      ,[OutboundDeliveryItem]
      ,[DeliveryDocumentItemCategoryID]
      ,SalesDocumentItemCategory.[SalesDocumentItemCategory] as [DeliveryDocumentItemCategory]
      ,ODI.[SalesDocumentItemTypeID]
      ,SalesDocumentItemType.[SalesDocumentItemType]
      ,[CreatedByUserID]
      ,[CreationDate]
      ,[CreationTime]
      ,[LastChangeDate]
      ,ODI.[DistributionChannelID]
      ,DistributionChannel.[DistributionChannel]
      ,ODI.[ProductID]
      ,[OriginallyRequestedMaterialID]
      ,[ProductGroupID]
      ,MaterialGroup.[MaterialGroupText] as [ProductGroup]
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
      ,ODI.[ReferenceSDDocument]
      ,ODI.[ReferenceSDDocumentItem]
      ,[ReferenceSDDocumentCategoryID]
      ,SDDocumentCategory.[SDDocumentCategory] as [ReferenceSDDocumentCategory]
      ,ODI.[SDProcessStatusID]
      ,SDProcessStatus.[SDProcessStatus]
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
      ,ODI.[HDR_DeliveryDocumentTypeID]
      ,DeliveryDocumentType.[DeliveryDocumentType] as [HDR_DeliveryDocumentType]
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
      ,FCDI.[FrtCostDistrItemAmount]          AS [CalculatedFreightAmountInCompanyCodeCurrency]
      ,FCDI.[FrtCostDistrItemAmtCrcy]         AS [CalculatedFreightAmountCompanyCodeCurrency]
      ,BDIFreight.[TransactionCurrencyID]     AS [FreightTransactionCurrencyID]
      ,BDIFreight.[InvoicedFreightValueTransactionCurrency]
      ,FCDI.[FrtCostDistrItemAmount] * CCR_FR_LOC.ExchangeRate
                                              AS [CalculatedFreightAmountInLocalCodeCurrency]
      ,BDIFreight.[InvoicedFreightValueTransactionCurrency] * CCR_LOC.ExchangeRate
                                              AS [InvoicedFreightValueLocalCurrency]
      ,FCDI.[FrtCostDistrItemAmount] * CCR_FR_EUR.ExchangeRate
                                              AS [CalculatedFreightAmountInEUR]
      ,BDIFreight.[InvoicedFreightValueTransactionCurrency] * CCR_EUR.ExchangeRate
                                              AS [InvoicedFreightValueEUR]
      ,ODI.[t_extractionDtm]
      ,ODI.[t_applicationId]
FROM [edw].[fact_OutboundDeliveryItem] ODI
LEFT JOIN [edw].[dim_SDDocumentCategory] SDDocumentCategory
  ON ODI.[ReferenceSDDocumentCategoryID] = SDDocumentCategory.[SDDocumentCategoryID]
LEFT JOIN [edw].[dim_MaterialGroup] MaterialGroup
  ON ODI.[ProductGroupID] = MaterialGroup.[MaterialGroupID]
LEFT JOIN [edw].[dim_SalesDocumentItemCategory] SalesDocumentItemCategory
  ON ODI.[DeliveryDocumentItemCategoryID] = SalesDocumentItemCategory.[SalesDocumentItemCategoryID]
LEFT JOIN [edw].[dim_DeliveryDocumentType] DeliveryDocumentType
  ON ODI.[HDR_DeliveryDocumentTypeID] = DeliveryDocumentType.[DeliveryDocumentTypeID]
LEFT JOIN [edw].[dim_SalesDocumentItemType] SalesDocumentItemType
  ON ODI.[SalesDocumentItemTypeID] = SalesDocumentItemType.[SalesDocumentItemTypeID]
LEFT JOIN [edw].[dim_DistributionChannel] DistributionChannel
  ON ODI.[DistributionChannelID] = DistributionChannel.[DistributionChannelID]
LEFT JOIN [edw].[dim_SDProcessStatus] SDProcessStatus
  ON ODI.[SDProcessStatusID] = SDProcessStatus.[SDProcessStatusID]
LEFT JOIN FrtCostDistrItm FCDI
  ON ODI.[OutboundDelivery] = FCDI.[TranspOrdDocReferenceID]             COLLATE DATABASE_DEFAULT
  AND ODI.[OutboundDeliveryItem] = FCDI.[TranspOrdDocReferenceItmID]     COLLATE DATABASE_DEFAULT
LEFT JOIN BDIFreight
  ON ODI.[OutboundDelivery] = BDIFreight.[ReferenceSDDocument]
  AND ODI.[OutboundDeliveryItem] = BDIFreight.[ReferenceSDDocumentItem]
LEFT JOIN CurrencyConversionRate CCR_LOC
  ON BDIFreight.[TransactionCurrencyID] = CCR_LOC.[SourceCurrency]
  AND SDI_LocalCurrency = CCR_LOC.[TargetCurrency]                       COLLATE DATABASE_DEFAULT
LEFT JOIN CurrencyConversionRate CCR_EUR
  ON BDIFreight.TransactionCurrencyID = CCR_EUR.[SourceCurrency]
  AND CCR_EUR.[TargetCurrency] = 'EUR'
LEFT JOIN CurrencyConversionRate CCR_FR_LOC
  ON FCDI.[FrtCostDistrItemAmtCrcy] = CCR_FR_LOC.[SourceCurrency]        COLLATE DATABASE_DEFAULT
  AND SDI_LocalCurrency = CCR_FR_LOC.[TargetCurrency]                    COLLATE DATABASE_DEFAULT
LEFT JOIN CurrencyConversionRate CCR_FR_EUR
  ON FCDI.[FrtCostDistrItemAmtCrcy] = CCR_FR_EUR.[SourceCurrency]        COLLATE DATABASE_DEFAULT
  AND CCR_FR_EUR.[TargetCurrency] = 'EUR'