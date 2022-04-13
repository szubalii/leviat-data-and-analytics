﻿CREATE VIEW [edw].[vw_OutboundDeliveryItem_s4h] AS
WITH
CalculatedDelDate_precalculation AS (
    SELECT
        ODI.[OutboundDelivery]
        ,OD.[ActualGoodsMovementDate] AS [HDR_ActualGoodsMovementDate]
        ,CAST(DimActualRoute.[DurInDays] AS INT) AS [ActualDeliveryRouteDurationInDays]
        ,CAST(CAST(DimActualRoute.[DurInDays] AS INT)%5 AS INT) AS [leftoverdays]
        /* CAST((DimActualRoute.[DurInDays])/5 AS INT)  calculates the number of weeks,
        [DurInDays] defines the duration but only weekdays. Hence the divide by 5 and then multiply by 7 to get the number of weeks */
        ,DATEADD(day, CAST((DimActualRoute.[DurInDays])/5 AS INT)*7, OD.[ActualGoodsMovementDate]) AS [HDR_ActualGoodsMovementDate_upd]
        ,DATEPART(weekday, OD.[ActualGoodsMovementDate]) AS [weekday]
    FROM
        [base_s4h_cax].[I_OutboundDeliveryItem] AS ODI
    LEFT JOIN
        [base_s4h_cax].[I_OutboundDelivery] OD
        ON ODI.[OutboundDelivery] = OD.[OutboundDelivery]
    LEFT JOIN
        [edw].[dim_Route] DimActualRoute
        ON DimActualRoute.[ROUTEID] = OD.[ActualDeliveryRoute]
    WHERE
        OD.[ActualGoodsMovementDate] <> '0001-01-01'
    GROUP BY
        ODI.[OutboundDelivery]
        ,OD.[ActualGoodsMovementDate]
        ,DimActualRoute.[DurInDays]
)
,
CalculatedDelDate_calculation AS (
    SELECT
        [OutboundDelivery]
        /* calculates Delivery Date excluding weekends.
        @@DATEFIRST value is set to Sunday, thus Monday has weekday value of 2, hence we do weekday-1
        Then check if after adding the left over days the new date is in a weekend or not.
        This is why we divide by 6 and then multiply by 2 so we potentially increase by another 2 days to fall over the weekend. */
        ,CAST(DATEADD(day, CAST(((weekday-1+[leftoverdays])/6) AS INT)*2 + [leftoverdays], [HDR_ActualGoodsMovementDate_upd]) AS DATE) AS [CalculatedDelDate]
    FROM
        CalculatedDelDate_precalculation
)
,
SDSLScheduleLine AS (
    SELECT 
        SDSL.[SalesDocument]
        ,SDSL.[SalesDocumentItem]
        ,SDSL.[ScheduleLineOrderQuantity]
        ,SDSL.[ConfirmedDeliveryDate]
        ,SDSL.[ConfdOrderQtyByMatlAvailCheck]
        ,SDSL.[OrderQuantityUnit]
        ,SDSL.[GoodsIssueDate]
        ,SDSL.[DeliveredQtyInOrderQtyUnit]
        ,SDSL.[DeliveredQuantityInBaseUnit]
        ,SDSL.[ScheduleLine]
    FROM
        [base_s4h_cax].[I_SalesDocumentScheduleLine] AS SDSL
    INNER JOIN
        (
            SELECT
                [SalesDocument]
                ,[SalesDocumentItem]
                ,MIN([ConfirmedDeliveryDate]) AS [ConfirmedDeliveryDate]
            FROM
                [base_s4h_cax].[I_SalesDocumentScheduleLine]
            WHERE
                [IsConfirmedDelivSchedLine] = 'X'
            GROUP BY 
                [SalesDocument]
                ,[SalesDocumentItem]
        ) EarliestDeliveryDate
        ON
            SDSL.[SalesDocument] = EarliestDeliveryDate.[SalesDocument]
            AND
            SDSL.[SalesDocumentItem] = EarliestDeliveryDate.[SalesDocumentItem]
            AND
            SDSL.[ConfirmedDeliveryDate] = EarliestDeliveryDate.[ConfirmedDeliveryDate]
)
,
SalesDocumentItem_EUR AS (
    SELECT
        SDI_EUR.[SalesDocument]
        ,SDI_EUR.[SalesDocumentItem]
        ,CASE
            WHEN
                SDI_EUR.[OrderQuantity] > 0 
            THEN
                SDI_EUR.[NetAmount] / SDI_EUR.[OrderQuantity]
         END AS [SDI_PricePerPiece_EUR]
        ,SDI_EUR.[CostAmount] AS [SDI_CostAmount_EUR]
        ,SDI_EUR.[NetAmount] AS [SDI_NetAmount_EUR]
    FROM
        [edw].[fact_SalesDocumentItem] AS SDI_EUR
    WHERE
        [CurrencyTypeID] = 30
        AND
        [t_applicationId] LIKE 's4h-ca%'
),
SalesDocumentItem_LC AS (
    SELECT
        SDI_LC.[SalesDocument]
        ,SDI_LC.[SalesDocumentItem]
        ,CASE
            WHEN SDI_LC.[OrderQuantity] > 0
            THEN SDI_LC.[NetAmount] / SDI_LC.[OrderQuantity]
         END AS [SDI_PricePerPiece_LC]
        ,SDI_LC.[CurrencyID] AS [SDI_LocalCurrency]
        ,SDI_LC.[CostAmount] AS [SDI_CostAmount_LC]
        ,SDI_LC.[NetAmount] AS [SDI_NetAmount_LC]
    FROM
        [edw].[fact_SalesDocumentItem] AS SDI_LC
    WHERE
        [CurrencyTypeID] = 10
        AND
        [t_applicationId] LIKE 's4h-ca%'                  
)
,
SalesDocumentItem_LC_EUR AS (
    SELECT
        SDI.[SalesDocument]
        ,SDI.[SalesDocumentItem]
        ,SDI.[CreationDate] AS [SDI_CreationDate]
        ,SDI.[RequestedDeliveryDate] AS [SDI_RequestedDeliveryDate]
        ,SDI_LC.[SDI_PricePerPiece_LC]
        ,SDI_EUR.[SDI_PricePerPiece_EUR]
        ,SDI_LC.[SDI_LocalCurrency]
        ,SDI.[SalesDocumentTypeID] AS [SDI_SalesDocumentTypeID]
        ,SDI.[IsReturnsItemID] AS [SDI_IsReturnsItemID]
        ,SDI.[BillToPartyID] AS [SDI_BillToParty]
        ,SDI.[ConfdDeliveryQtyInBaseUnit] AS [SDI_ConfdDeliveryQtyInBaseUnit]
        ,SDI.[ConfdDelivQtyInOrderQtyUnit] AS [SDI_ConfdDelivQtyInOrderQtyUnit]
        ,SDI_LC.[SDI_CostAmount_LC]
        ,SDI_EUR.[SDI_CostAmount_EUR]
        ,SDI.[DeliveryBlockStatusID] AS [SDI_DeliveryBlockStatusID]
        ,SDI.[ExchangeRateDate] AS [SDI_ExchangeRateDate]
        ,SDI.[ExchangeRateTypeID] AS [SDI_ExchangeRateType]
        ,SDI_LC.[SDI_NetAmount_LC]
        ,SDI_EUR.[SDI_NetAmount_EUR]
        ,SDI.[NetPriceQuantityUnitID] AS [SDI_NetPriceQuantityUnit]
        ,SDI.[OrderID] AS [SDI_OrderID]
        ,SDI.[OrderQuantity] AS [SDI_OrderQuantity]
        ,SDI.[OrderQuantityUnitID] AS [SDI_OrderQuantityUnit]
        ,SDI.[OverallTotalDeliveryStatusID] AS [SDI_OverallTotalDeliveryStatusID]
        ,SDI.[PayerPartyID] AS [SDI_PayerParty]
        ,SDI.[RouteID] AS [SDI_Route]
        ,SDI.[SalesDocumentItemCategoryID] AS [SDI_SalesDocumentItemCategory]
        ,SDI.[SalesOrganizationCurrencyID] AS [SDI_SalesOrganizationCurrency]
        ,SDI.[SDDocumentCategoryID] AS [SDI_SDDocumentCategory]
        ,SDI.[SDDocumentRejectionStatusID] AS [SDI_SDDocumentRejectionStatusID]
        ,SDI.[StorageLocationID] AS [SDI_StorageLocationID]
    FROM
        [edw].[fact_SalesDocumentItem] AS SDI
    LEFT JOIN
        SalesDocumentItem_EUR SDI_EUR
        ON
            SDI.[SalesDocument] = SDI_EUR.[SalesDocument]
            AND
            SDI.[SalesDocumentItem] = SDI_EUR.[SalesDocumentItem]
    LEFT JOIN
        SalesDocumentItem_LC SDI_LC
        ON
            SDI.[SalesDocument] = SDI_LC.[SalesDocument]
            AND
            SDI.[SalesDocumentItem] = SDI_LC.[SalesDocumentItem]
     WHERE
        [CurrencyTypeID] in (10,30)
        AND
        [t_applicationId] LIKE 's4h-ca%'
    GROUP BY
       SDI.[SalesDocument]
        ,SDI.[SalesDocumentItem]
        ,SDI.[CreationDate]
        ,SDI.[RequestedDeliveryDate]
        ,SDI_LC.[SDI_PricePerPiece_LC]
        ,SDI_EUR.[SDI_PricePerPiece_EUR]
        ,SDI_LC.[SDI_LocalCurrency]
        ,SDI.[SalesDocumentTypeID]
        ,SDI.[IsReturnsItemID]
        ,SDI.[BillToPartyID]
        ,SDI.[ConfdDeliveryQtyInBaseUnit]
        ,SDI.[ConfdDelivQtyInOrderQtyUnit]
        ,SDI_LC.[SDI_CostAmount_LC]
        ,SDI_EUR.[SDI_CostAmount_EUR]
        ,SDI.[DeliveryBlockStatusID]
        ,SDI.[ExchangeRateDate]
        ,SDI.[ExchangeRateTypeID]
        ,SDI_LC.[SDI_NetAmount_LC]
        ,SDI_EUR.[SDI_NetAmount_EUR]
        ,SDI.[NetPriceQuantityUnitID]
        ,SDI.[OrderID]
        ,SDI.[OrderQuantity]
        ,SDI.[OrderQuantityUnitID]
        ,SDI.[OverallTotalDeliveryStatusID]
        ,SDI.[PayerPartyID]
        ,SDI.[RouteID]
        ,SDI.[SalesDocumentItemCategoryID]
        ,SDI.[SalesOrganizationCurrencyID]
        ,SDI.[SDDocumentCategoryID]
        ,SDI.[SDDocumentRejectionStatusID]
        ,SDI.[StorageLocationID]
)
,
ODIPerSDI AS (   
    SELECT
        SDI_ODI_list.SalesDocument
        ,SDI_ODI_list.SalesDocumentItem
        ,COUNT(*) AS [NrODIPerSDIAndQtyNot0]
        ,SUM(SDI_ODI_list.[ActualDeliveryQuantity]) AS [ActDelQtyTotalForSDI]
    FROM (
            SELECT 
                SDI.[SalesDocument]
                ,SDI.[SalesDocumentItem]
                ,ODI.[OutboundDelivery]
                ,ODI.[OutboundDeliveryItem]
                ,ODI.[ActualDeliveryQuantity]
            FROM
                [base_s4h_cax].[I_OutboundDeliveryItem] AS ODI
            INNER JOIN
                SalesDocumentItem_LC_EUR AS SDI
                ON
                    ODI.[ReferenceSDDocument] = SDI.[SalesDocument]
                    AND
                    ODI.[ReferenceSDDocumentItem] = SDI.[SalesDocumentItem]
            WHERE
                (ODI.[ReferenceSDDocument] IS NOT NULL
                OR
                ODI.[ReferenceSDDocument] != '')
            GROUP BY
                SDI.[SalesDocument]
                ,SDI.[SalesDocumentItem]
                ,ODI.[OutboundDelivery]
                ,ODI.[OutboundDeliveryItem]
                ,ODI.[ActualDeliveryQuantity]
        ) SDI_ODI_list
    GROUP BY 
     SDI_ODI_list.[SalesDocument]
    ,SDI_ODI_list.[SalesDocumentItem]
)
,
SDSLPerSDI AS (
    SELECT
        SDI_SDSL_list.[SalesDocument]
        ,SDI_SDSL_list.[SalesDocumentItem]
        ,COUNT(*) AS [NrSLInScope]
    FROM (
            SELECT
                SDI.[SalesDocument]
                ,SDI.[SalesDocumentItem]
                ,SDSL.[ScheduleLine]
            FROM
                [base_s4h_cax].[I_SalesDocumentScheduleLine] AS SDSL
            INNER JOIN
                SalesDocumentItem_LC_EUR AS SDI
                ON
                    SDSL.[SalesDocument] = SDI.[SalesDocument]
                    AND
                    SDSL.[SalesDocumentItem] = SDI.[SalesDocumentItem]
            WHERE
            [IsConfirmedDelivSchedLine] = 'X'
            GROUP BY 
                SDI.[SalesDocument]
                ,SDI.[SalesDocumentItem]
                ,SDSL.[ScheduleLine]
        ) SDI_SDSL_list
    GROUP BY
        SDI_SDSL_list.[SalesDocument]
        ,SDI_SDSL_list.[SalesDocumentItem]
)
,
OutboundDeliveryItem_s4h AS (
    SELECT 
        CONCAT_WS('¦', ODI.[OutboundDelivery] collate SQL_Latin1_General_CP1_CS_AS, ODI.[OutboundDeliveryItem] collate SQL_Latin1_General_CP1_CS_AS) AS [nk_fact_OutboundDeliveryItem]
        ,ODI.[OutboundDelivery]
        ,ODI.[OutboundDeliveryItem]
        ,ODI.[DeliveryDocumentItemCategory] AS [DeliveryDocumentItemCategoryID]
        ,ODI.[SalesDocumentItemType] AS [SalesDocumentItemTypeID]
        ,ODI.[CreatedByUser] AS [CreatedByUserID]
        ,ODI.[CreationDate]
        ,ODI.[CreationTime]
        ,ODI.[LastChangeDate]
        ,ODI.[DistributionChannel] AS [DistributionChannelID]
        ,ODI.[Product] AS [ProductID]
        ,ODI.[OriginallyRequestedMaterial] AS [OriginallyRequestedMaterialID]
        ,ODI.[ProductGroup] AS [ProductGroupID]
        ,ODI.[Plant] AS [PlantID]
        ,ODI.[Warehouse] AS [WarehouseID]
        ,ODI.[StorageLocation] AS [StorageLocationID]
        ,ODI.[HigherLevelItem]
        ,ODI.[ActualDeliveryQuantity]
        ,ODIPerSDI.[ActDelQtyTotalForSDI]
        ,ODI.[DeliveryQuantityUnit]
        ,ODI.[ActualDeliveredQtyInBaseUnit]
        ,ODI.[BaseUnit]
        ,ODI.[Batch]
        ,ODI.[BatchClassification]
        ,ODI.[BusinessArea]
        ,ODI.[ChmlCmplncStatus] AS [ChmlCmplncStatusID]
        ,ODI.[ControllingArea]
        ,ODI.[CostCenter]
        ,ODI.[CostInDocumentCurrency]
        ,ODI.[CreditRelatedPrice]
        ,ODI.[DangerousGoodsStatus] AS [DangerousGoodsStatusID]
        ,ODI.[DeliveryGroup]
        ,ODI.[Division]
        ,ODI.[FixedShipgProcgDurationInDays]
        ,ODI.[FunctionalArea]
        ,ODI.[GoodsMovementType]
        ,ODI.[InventorySpecialStockType]
        ,ODI.[IsNotGoodsMovementsRelevant]
        ,ODI.[ItemGrossWeight]
        ,ODI.[ItemNetWeight]
        ,ODI.[ItemVolume]
        ,ODI.[ItemVolumeUnit]
        ,ODI.[ItemWeightUnit]
        ,ODI.[LoadingGroup]
        ,ODI.[NetPriceAmount] AS [NetPriceAmount_LC]
        ,ODI.[OrderDocument]
        ,ODI.[OrderID]
        ,ODI.[OrderItem]
        ,ODI.[OriginalDeliveryQuantity]
        ,ODI.[OriginSDDocument]
        ,ODI.[OverdelivTolrtdLmtRatioInPct]
        ,ODI.[PartialDeliveryIsAllowed]
        ,ODI.[PlanningPlant]
        ,ODI.[ProductAvailabilityDate]
        ,ODI.[ProfitCenter] AS [ProfitCenterID]
        ,ODI.[SalesGroup]
        ,ODI.[SalesOffice]
        ,ODI.[SDDocumentItem]
        ,ODI.[SubsequentMovementType]
        ,ODI.[TotalNetAmount] AS [TotalNetAmount_LC]
        ,ODI.[VarblShipgProcgDurationInDays]
        ,ODI.[UnlimitedOverdeliveryIsAllowed]
        ,ODI.[GLAccount] AS [GLAccountID]
        ,ODI.[IsCompletelyDelivered]
        ,ODI.[ReceivingPoint]
        ,ODI.[ItemIsBillingRelevant]
        ,ODI.[ReferenceSDDocument]
        ,ODI.[ReferenceSDDocumentItem]
        ,ODI.[ReferenceSDDocumentCategory] AS [ReferenceSDDocumentCategoryID]
        ,ODI.[SDProcessStatus] AS [SDProcessStatusID]
        ,ODI.[PickingConfirmationStatus] AS [PickingConfirmationStatusID]
        ,ODI.[PickingStatus] AS [PickingStatusID]
        ,ODI.[WarehouseActivityStatus] AS [WarehouseActivityStatusID]
        ,ODI.[PackingStatus] AS [PackingStatusID]
        ,ODI.[GoodsMovementStatus] AS [GoodsMovementStatusID]
        ,ODI.[DeliveryRelatedBillingStatus] AS [DeliveryRelatedBillingStatusID]
        ,ODI.[ProofOfDeliveryStatus] AS [ProofOfDeliveryStatusID]
        ,ODI.[ItemGeneralIncompletionStatus] AS [ItemGeneralIncompletionStatusID]
        ,ODI.[ItemDeliveryIncompletionStatus] AS [ItemDeliveryIncompletionStatusID]
        ,ODI.[ItemPickingIncompletionStatus] AS [ItemPickingIncompletionStatusID]
        ,ODI.[ItemGdsMvtIncompletionSts] AS [ItemGdsMvtIncompletionStsID]
        ,ODI.[ItemPackingIncompletionStatus] AS [ItemPackingIncompletionStatusID]
        ,ODI.[ItemBillingIncompletionStatus] AS [ItemBillingIncompletionStatusID]
        ,ODI.[IntercompanyBillingStatus] AS [IntercompanyBillingStatusID]
        ,ODI.[IsReturnsItem] 
        ,SDSL.[ConfirmedDeliveryDate] AS [SL_ConfirmedDeliveryDate]
        ,SDSL.[GoodsIssueDate] AS [SL_GoodsIssueDate]
        ,SDSL.[ScheduleLine] AS [SL_ScheduleLine]
        ,OD.[SalesDistrict] AS [HDR_SalesDistrictID]
        ,OD.[SalesOrganization] AS [HDR_SalesOrganizationID]
        ,OD.[SoldToParty] AS [HDR_SoldToPartyID]
        ,OD.[ShipToParty] AS [HDR_ShipToPartyID]
        ,OD.[DeliveryDocumentType] AS [HDR_DeliveryDocumentTypeID]
        ,OD.[CompleteDeliveryIsDefined] AS [HDR_CompleteDeliveryIsDefined]
        ,OD.[Supplier] AS [HDR_SupplierID]
        ,OD.[ReceivingPlant] AS [HDR_ReceivingPlantID]
        ,OD.[DeletionIndicator] AS [HDR_DeletionIndicator]
        ,OD.[DeliveryDate] AS [HDR_DeliveryDate]
        ,SDI.[SDI_CreationDate]
        ,SDI.[SDI_RequestedDeliveryDate]
        ,SDI.[SDI_PricePerPiece_LC]
        ,SDI.[SDI_PricePerPiece_EUR]
        ,SDI.[SDI_LocalCurrency]
        ,SDI.[SDI_SalesDocumentTypeID]
        ,SDI.[SDI_IsReturnsItemID]
        ,SDI.[SDI_BillToParty]
        ,SDI.[SDI_ConfdDeliveryQtyInBaseUnit]
        ,SDI.[SDI_ConfdDelivQtyInOrderQtyUnit]
        ,SDI.[SDI_CostAmount_LC]
        ,SDI.[SDI_CostAmount_EUR]
        ,SDI.[SDI_DeliveryBlockStatusID]
        ,SDI.[SDI_ExchangeRateDate]
        ,SDI.[SDI_ExchangeRateType]
        ,SDI.[SDI_NetAmount_LC]
        ,SDI.[SDI_NetAmount_EUR]
        ,SDI.[SDI_NetPriceQuantityUnit]
        ,SDI.[SDI_OrderID]
        ,SDI.[SDI_OrderQuantity]
        ,SDI.[SDI_OrderQuantityUnit]
        ,SDI.[SDI_OverallTotalDeliveryStatusID]
        ,SDI.[SDI_PayerParty] 
        ,SDI.[SDI_Route]
        ,SDI.[SDI_SalesDocumentItemCategory]
        ,SDI.[SDI_SalesOrganizationCurrency]
        ,SDI.[SDI_SDDocumentCategory]
        ,SDI.[SDI_SDDocumentRejectionStatusID]
        ,SDI.[SDI_StorageLocationID]
        ,CASE
            WHEN
                OD.[ActualDeliveryRoute] IS NULL
                OR
                OD.[ActualDeliveryRoute] = ''
                OR
                OD.[ProposedDeliveryRoute] IS NULL
                OR
                OD.[ProposedDeliveryRoute] = ''
            THEN NULL
            WHEN OD.[ActualDeliveryRoute] = OD.[ProposedDeliveryRoute]
            THEN 'Y'
            ELSE 'N'
        END AS [RouteIsChangedFlag]
        ,ODIPerSDI.[NrODIPerSDIAndQtyNot0]
        ,SDSLPerSDI.[NrSLInScope]
        ,OD.[PlannedGoodsIssueDate] AS [HDR_PlannedGoodsIssueDate]
        ,OD.[ActualGoodsMovementDate] AS [HDR_ActualGoodsMovementDate]
        ,OD.[ShippingPoint] AS [HDR_ShippingPointID]
        ,OD.[OrderCombinationIsAllowed] AS [HDR_OrderCombinationIsAllowed]
        ,OD.[DeliveryPriority] AS	[HDR_DeliveryPriority]
        ,OD.[DeliveryBlockReason] AS [HDR_DeliveryBlockReason]
        ,OD.[DeliveryDocumentBySupplier] AS [HDR_DeliveryDocumentBySupplier]
        ,OD.[DeliveryIsInPlant] AS [HDR_DeliveryIsInPlant]
        ,OD.[OrderID] AS [HDR_OrderID]
        ,OD.[PickingDate] AS [HDR_PickingDate]
        ,OD.[LoadingDate] AS [HDR_LoadingDate]
        ,OD.[ShippingType] AS [HDR_ShippingType]
        ,OD.[ShippingCondition] AS [HDR_ShippingCondition]
        ,OD.[ShipmentBlockReason] AS [HDR_ShipmentBlockReason]
        ,OD.[TransportationPlanningDate] AS [HDR_TransportationPlanningDate]
        ,OD.[ProposedDeliveryRoute] AS [HDR_ProposedDeliveryRoute]
        ,OD.[ActualDeliveryRoute] AS [HDR_ActualDeliveryRoute]
        ,OD.[RouteSchedule] AS [HDR_RouteSchedule]
        ,OD.[IncotermsClassification] AS [HDR_IncotermsClassification]
        ,OD.[IncotermsTransferLocation] AS [HDR_IncotermsTransferLocation]
        ,OD.[TransportationGroup] AS [HDR_TransportationGroup]
        ,OD.[MeansOfTransport] AS [HDR_MeansOfTransport]
        ,OD.[MeansOfTransportType] AS [HDR_MeansOfTransportType]
        ,OD.[ProofOfDeliveryDate]	AS [HDR_ProofOfDeliveryDate]
        ,OD.[CustomerGroup] AS [HDR_CustomerGroup]
        ,OD.[TotalBlockStatus] AS [HDR_TotalBlockStatusID]
        ,OD.[TransportationPlanningStatus] AS [HDR_TransportationPlanningStatusID]
        ,OD.[OverallPickingConfStatus] AS [HDR_OverallPickingConfStatusID]
        ,OD.[OverallPickingStatus] AS [HDR_OverallPickingStatusID]
        ,OD.[OverallPackingStatus] AS [HDR_OverallPackingStatusID]
        ,OD.[OverallGoodsMovementStatus] AS [HDR_OverallGoodsMovementStatusID]
        ,OD.[OverallProofOfDeliveryStatus] AS [HDR_OverallProofOfDeliveryStatusID]
        ,OD.[IntercompanyBillingType] AS [HDR_IntercompanyBillingType]
        ,OD.[IntercompanyBillingCustomer] AS[HDR_IntercompanyBillingCustomer]
        ,OD.[TotalNetAmount] AS [HDR_TotalNetAmount]
        ,OD.[ReferenceDocumentNumber] AS [HDR_ReferenceDocumentNumber]
        ,OD.[CreatedByUser] AS [HDR_CreatedByUser]
        ,OD.[DocumentDate] AS [HDR_DocumentDate]
        ,OD.[ExternalTransportSystem] AS [HDR_ExternalTransportSystem]
        ,OD.[HdrGeneralIncompletionStatus] AS [HDR_HdrGeneralIncompletionStatusID]
        ,OD.[HdrGoodsMvtIncompletionStatus] AS [HDR_HdrGoodsMvtIncompletionStatusID]
        ,OD.[HeaderBillgIncompletionStatus] AS [HDR_HeaderBillgIncompletionStatusID]
        ,OD.[HeaderBillingBlockReason] AS [HDR_HeaderBillingBlockReason]
        ,OD.[HeaderDelivIncompletionStatus] AS [HDR_HeaderDelivIncompletionStatusID]
        ,OD.[HeaderPackingIncompletionSts] AS [HDR_HeaderPackingIncompletionSts]
        ,OD.[HeaderPickgIncompletionStatus] AS [HDR_HeaderPickgIncompletionStatusID]
        ,OD.[IsExportDelivery] AS [HDR_IsExportDelivery]
        ,OD.[LastChangeDate] AS [HDR_LastChangeDate]
        ,OD.[LastChangedByUser] AS [HDR_LastChangedByUser]
        ,OD.[LoadingPoint] AS [HDR_LoadingPoint]
        ,OD.[OverallChmlCmplncStatus] AS [HDR_OverallChmlCmplncStatusID]
        ,OD.[OverallDangerousGoodsStatus] AS [HDR_OverallDangerousGoodsStatusID]
        ,OD.[OverallDelivConfStatus] AS [HDR_OverallDelivConfStatusID]
        ,OD.[OverallDelivReltdBillgStatus] AS [HDR_OverallDelivReltdBillgStatusID]
        ,OD.[OverallIntcoBillingStatus] AS [HDR_OverallIntcoBillingStatusID]
        ,OD.[OverallSafetyDataSheetStatus] AS [HDR_OverallSafetyDataSheetStatusID]
        ,OD.[OverallSDProcessStatus] AS [HDR_OverallSDProcessStatusID]
        ,OD.[OverallWarehouseActivityStatus] AS [HDR_OverallWarehouseActivityStatusID]
        ,OD.[OvrlItmDelivIncompletionSts] AS [HDR_OvrlItmDelivIncompletionSts]
        ,OD.[OvrlItmGdsMvtIncompletionSts] AS [HDR_OvrlItmGdsMvtIncompletionSts]
        ,OD.[OvrlItmGeneralIncompletionSts] AS [HDR_OvrlItmGeneralIncompletionSts]
        ,OD.[OvrlItmPackingIncompletionSts] AS [HDR_OvrlItmPackingIncompletionSts]
        ,OD.[OvrlItmPickingIncompletionSts] AS [HDR_OvrlItmPickingIncompletionSts]
        ,OD.[ShippingGroupNumber] AS [HDR_ShippingGroupNumber]
        ,OD.[TotalNumberOfPackage] AS [HDR_TotalNumberOfPackage]
        ,OD.[TransactionCurrency] AS [HDR_TransactionCurrency]
        ,'EUR' AS [Currency_EUR]
        ,DimActualRoute.[ROUTE] AS [ActualDeliveryRouteName]
        ,DimActualRoute.[TRAZTD] AS [ActualDeliveryRouteDurationInHrs]
        ,DimProposedRoute.[ROUTE] AS [ProposedDeliveryRouteName]
        ,DimProposedRoute.[TRAZTD] AS [ProposedDeliveryRouteDurationInHrs]
        ,DimActualRoute.[DurInDays] AS [ActualDeliveryRouteDurationInDays]
        ,DimProposedRoute.[DurInDays] AS [ProposedDeliveryRouteDurationInDays]
        ,CASE
            WHEN LEFT(OD.[SoldToParty], 2) = 'IC'
            THEN 'I'
            ELSE 'O'
        END AS [InOutID]
        ,CASE
            WHEN
                SDI.[SDI_CreationDate] IS NULL
                OR
                SDI.[SDI_CreationDate] = '0001-01-01'
                OR
                ODI.[CreationDate] IS NULL
                OR
                ODI.[CreationDate] = '0001-01-01'
        THEN NULL
        ELSE
            CASE
                WHEN SDI.[SDI_CreationDate] = ODI.[CreationDate]
                THEN 'Y'
                ELSE 'N'
            END
        END AS [SDICreationDateIsODICreationDateFlag]
        ,CASE
            WHEN
                SDI.[SDI_OrderQuantity] IS NULL
                OR
                SDI.[SDI_OrderQuantity] = 0
            THEN NULL
            WHEN ODIPerSDI.[ActDelQtyTotalForSDI] = SDI.[SDI_OrderQuantity]
            THEN 'In Full Delivered'
            WHEN ODIPerSDI.[ActDelQtyTotalForSDI] > SDI.[SDI_OrderQuantity]
            THEN 'Over Delivered'
            ELSE 'Under Delivered'
         END AS [IF_Group]
        ,CASE
            WHEN
                ODI.[ActualDeliveryQuantity] IS NULL
                OR
                ODI.[ActualDeliveryQuantity] = 0
                OR
                SDI.[SDI_ConfdDelivQtyInOrderQtyUnit] IS NULL
                OR
                SDI.[SDI_ConfdDelivQtyInOrderQtyUnit] = 0
            THEN NULL
            WHEN ODI.[ActualDeliveryQuantity] = SDI.[SDI_ConfdDelivQtyInOrderQtyUnit]
            THEN 'Y'
            ELSE 'N'
        END AS [IF_IsInFullFlag]
        ,CASE
            WHEN
                ODI.[ActualDeliveryQuantity] IS NULL
                OR
                ODI.[ActualDeliveryQuantity] = 0
            THEN 'Y'
            ELSE 'N'
        END AS [NoActualDeliveredQtyFlag]
        ,CASE
            WHEN
                (OD.[PlannedGoodsIssueDate] IS NULL
                OR
                OD.[PlannedGoodsIssueDate] = '0001-01-01')
            THEN NULL
            WHEN
                (OD.[ActualGoodsMovementDate] IS NULL 
                OR
                OD.[ActualGoodsMovementDate] = '0001-01-01')
                AND
                OD.[PlannedGoodsIssueDate] < CONVERT (DATE, ODI.[t_extractionDtm])
            THEN DATEDIFF(day, OD.[PlannedGoodsIssueDate], CONVERT(DATE,ODI.[t_extractionDtm]))
            ELSE DATEDIFF(day, OD.[PlannedGoodsIssueDate],OD.[ActualGoodsMovementDate])
        END AS [OTS_DaysDiff]
        ,CASE
            WHEN
                OD.[PlannedGoodsIssueDate] IS NULL
                OR
                OD.[PlannedGoodsIssueDate] = '0001-01-01'
                OR
                SDSL.[GoodsIssueDate] IS NULL
                OR
                SDSL.[GoodsIssueDate] = '0001-01-01'
            THEN NULL
            ELSE DATEDIFF(day, SDSL.[GoodsIssueDate], OD.[PlannedGoodsIssueDate])
        END AS [OTS_GoodsIssueDateDiffInDays]
        ,CASE
            WHEN
                OD.[PlannedGoodsIssueDate] IS NULL
                OR
                OD.[PlannedGoodsIssueDate] = '0001-01-01'
                OR
                SDSL.[GoodsIssueDate] IS NULL
                OR
                SDSL.[GoodsIssueDate] = '0001-01-01'
            THEN NULL
            WHEN OD.[PlannedGoodsIssueDate] = SDSL.[GoodsIssueDate]
            THEN 'OnTime'
            WHEN OD.[PlannedGoodsIssueDate] > SDSL.[GoodsIssueDate]
            THEN 'Late'
            ELSE 'Early'
        END AS [OTS_GIDateCheckGroup]
        ,CASE
            WHEN
                (OD.[PlannedGoodsIssueDate] IS NULL
                OR
                OD.[PlannedGoodsIssueDate] = '0001-01-01')
            THEN NULL
            WHEN
                (OD.[ActualGoodsMovementDate] IS NULL
                OR
                OD.[ActualGoodsMovementDate] = '0001-01-01')
                AND 
                OD.[PlannedGoodsIssueDate] < CONVERT (DATE, ODI.[t_extractionDtm])
            THEN 'Late'
            WHEN OD.[ActualGoodsMovementDate] = OD.[PlannedGoodsIssueDate]
            THEN 'OnTime'
            WHEN OD.[ActualGoodsMovementDate] > OD.[PlannedGoodsIssueDate]
            THEN 'Late'
            ELSE 'Early'
        END AS [OTS_Group]
        ,CASE
            WHEN SDI.[SalesDocument] IS NULL
            THEN 'N'
            ELSE 'Y'
        END AS [SDAvailableFlag]
        ,CASE
            WHEN SDI.[SalesDocument] IS NULL
            THEN NULL
            WHEN SDI.[SDI_ConfdDelivQtyInOrderQtyUnit] = SDI.[SDI_OrderQuantity]
            THEN 'Y'
            ELSE 'N'
        END AS [SDI_ConfQtyEqOrderQtyFlag]
        ,CASE
            WHEN SDSL.[ScheduleLine] IS NULL
            THEN 'N'
            ELSE 'Y'
        END AS [SLAvailableFlag]
        ,CASE
            WHEN
                OD.[ActualGoodsMovementDate] IS NULL
                OR
                OD.[ActualGoodsMovementDate] = '0001-01-01'
                OR
                DimActualRoute.[DurInDays] = 0
                OR
                DimActualRoute.[DurInDays] IS NULL
            THEN NULL
            ELSE cdd.[CalculatedDelDate]
        END AS [CalculatedDelDate]
      ,ODI.[t_applicationId]
      ,ODI.[t_extractionDtm]
    FROM
        [base_s4h_cax].[I_OutboundDeliveryItem] AS ODI
    LEFT JOIN
        [base_s4h_cax].[I_OutboundDelivery] AS OD
        ON
            ODI.[OutboundDelivery] = OD.[OutboundDelivery]
    LEFT JOIN
        SDSLScheduleLine AS SDSL
        ON
            ODI.[ReferenceSDDocument] = SDSL.[SalesDocument]
            AND
            ODI.[ReferenceSDDocumentItem] = SDSL.[SalesDocumentItem]
    LEFT JOIN
        [edw].[dim_Route] AS DimActualRoute
        ON
            DimActualRoute.[ROUTEID] = OD.[ActualDeliveryRoute]
    LEFT JOIN
        [edw].[dim_Route] AS DimProposedRoute
        ON
            DimProposedRoute.[ROUTEID] = OD.[ProposedDeliveryRoute]
    LEFT JOIN
        SalesDocumentItem_LC_EUR AS SDI
        ON
            ODI.[ReferenceSDDocument] = SDI.[SalesDocument]
            AND
            ODI.[ReferenceSDDocumentItem] = SDI.[SalesDocumentItem]
    LEFT JOIN
        ODIPerSDI
        ON
            ODI.[ReferenceSDDocument] = ODIPerSDI.[SalesDocument]
            AND
            ODI.[ReferenceSDDocumentItem] = ODIPerSDI.[SalesDocumentItem]
    LEFT JOIN
        SDSLPerSDI
        ON
            ODI.[ReferenceSDDocument] = SDSLPerSDI.[SalesDocument]
            AND
            ODI.[ReferenceSDDocumentItem] = SDSLPerSDI.[SalesDocumentItem]
    LEFT JOIN
        CalculatedDelDate_calculation AS cdd
        ON
            ODI.[OutboundDelivery] = cdd.[OutboundDelivery]
)
,
OutboundDeliveryItem_s4h_calculated AS (
    SELECT
        [nk_fact_OutboundDeliveryItem]
        ,[OutboundDelivery]
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
        ,[TotalNetAmount_LC]
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
        ,CASE
            WHEN [OTS_Group] = 'OnTime'
            THEN 1
            ELSE 0
        END AS [OTS_IsOnTime]
      ,CASE
            WHEN [OTS_Group] = 'Early'
            THEN [OTS_DaysDiff]
            ELSE 0
        END AS [OTS_EarlyDays]
      ,CASE
            WHEN [OTS_Group] = 'Late'
            THEN [OTS_DaysDiff]
            ELSE 0
        END AS [OTS_LateDays]
      ,CASE
            WHEN [OTS_Group] = 'Early'
            THEN 1
            ELSE 0
        END AS [OTS_IsEarly]
      ,CASE
            WHEN [OTS_Group] = 'Late'
            THEN 1
            ELSE 0
        END AS [OTS_IsLate]
        ,[RouteIsChangedFlag]
        ,[NrODIPerSDIAndQtyNot0]
        ,[NrSLInScope]
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
        ,[IF_Group]
        ,[IF_IsInFullFlag]
        ,CASE
            WHEN [IF_IsInFullFlag] = 'Y'
            THEN 1
            ELSE 0
        END AS [IF_IsInFull]
        ,[NoActualDeliveredQtyFlag]
        ,[OTS_DaysDiff]
        ,[OTS_GoodsIssueDateDiffInDays]
        ,[OTS_GIDateCheckGroup]
        ,[OTS_Group]
        ,[SDAvailableFlag]
        ,[SDI_ConfQtyEqOrderQtyFlag]
        ,[SLAvailableFlag]
        ,CASE
            WHEN [SDAvailableFlag] = 'N' 
            THEN 'IF001'
            WHEN
                [ActualDeliveryQuantity] IS NULL 
                OR [ActualDeliveryQuantity] = 0
            THEN 'IF002'
            WHEN
                [SDI_ConfdDelivQtyInOrderQtyUnit] IS NULL
                AND
                [SDI_ConfdDelivQtyInOrderQtyUnit] = 0
            THEN 'IF003'
            ELSE NULL
      END AS [IF_DataQualityCode]
      ,CASE
            WHEN [SDAvailableFlag] = 'N' 
            THEN 'OTD001'
            WHEN [SLAvailableFlag] = 'N' 
            THEN 'OTD002'
            WHEN
                [SLAvailableFlag] = 'N'
                AND
                [NrSLInScope] IS NULL   
            THEN 'OTD003'
            WHEN
                [HDR_ActualDeliveryRoute] = ''
                OR
                [HDR_ActualDeliveryRoute] IS NULL
            THEN 'OTD004'
            WHEN [ActualDeliveryRouteDurationInDays] = 0
            THEN 'OTD005'
            WHEN
                [SDI_StorageLocationID] = ''
                OR
                [SDI_StorageLocationID] IS NULL
            THEN 'OTD006'
            ELSE NULL
      END AS [OTD_DataQualityCode]
      ,CASE
            WHEN [HDR_PlannedGoodsIssueDate] = '0001-01-01'
            THEN 'OTS001'
            WHEN [HDR_ActualGoodsMovementDate] = '0001-01-01'
            THEN 'OTS002'
            ELSE NULL
      END AS [OTS_DataQualityCode]
      ,[CalculatedDelDate]
      ,CASE
            WHEN
                ([SL_ConfirmedDeliveryDate] IS NULL
                OR
                [SL_ConfirmedDeliveryDate]  = '0001-01-01')
            THEN NULL
            WHEN
                ([CalculatedDelDate] IS NULL 
                OR
                [CalculatedDelDate] = '0001-01-01')
                AND
                [SL_ConfirmedDeliveryDate] < CONVERT (DATE, [t_extractionDtm])
            THEN DATEDIFF(day, [SL_ConfirmedDeliveryDate], CONVERT(DATE, [t_extractionDtm]))
            ELSE DATEDIFF(day, [SL_ConfirmedDeliveryDate], [CalculatedDelDate])
      END AS [OTD_DaysDiff]
      ,CASE
            WHEN
                [SL_ConfirmedDeliveryDate] IS NULL
                OR
                [SL_ConfirmedDeliveryDate] = '0001-01-01'
				OR
                [ActualDeliveryRouteDurationInDays] = 0
            THEN NULL
			WHEN
                ([CalculatedDelDate] IS NULL
                OR
                [CalculatedDelDate] = '0001-01-01')
				AND
				[SL_ConfirmedDeliveryDate] < CONVERT (DATE, [t_extractionDtm])
            THEN 'Late'
            WHEN [CalculatedDelDate] = [SL_ConfirmedDeliveryDate]
            THEN 'OnTime'
            WHEN
                [CalculatedDelDate] > [SL_ConfirmedDeliveryDate]
            THEN 'Late'
            ELSE 'Early'
      END AS [OTD_Group]
        ,[t_applicationId]
        ,[t_extractionDtm]
    FROM OutboundDeliveryItem_s4h
)
,
OutboundDeliveryItem_s4h_OTDIF_calculated AS (
SELECT
        [nk_fact_OutboundDeliveryItem]
        ,[OutboundDelivery]
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
        ,[TotalNetAmount_LC]
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
        ,CASE
            WHEN [OTS_Group] IS NULL
            THEN NULL
            WHEN
                [OTS_IsOnTime] = 1 
                AND
                [IF_IsInFull] = 1
            THEN 'OTIF'
            WHEN
                [OTS_IsOnTime] = 1
                AND [IF_IsInFull] = 0
            THEN 'OTNIF'
            WHEN
                [OTS_IsOnTime] = 0
                AND
                [IF_IsInFull] = 1
            THEN 'NOTIF'
            WHEN
                [OTS_IsOnTime] = 0
                AND
                [IF_IsInFull] = 0
            THEN 'NOTNIF'
        END AS [OTSIF_OnTimeShipInFull]
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
        ,[IF_Group]
        ,[IF_IsInFullFlag]
        ,[IF_IsInFull]
        ,[NoActualDeliveredQtyFlag]
        ,[OTS_DaysDiff]
        ,[OTS_GoodsIssueDateDiffInDays]
        ,[OTS_GIDateCheckGroup]
        ,[OTS_Group]
        ,[SDAvailableFlag]
        ,[SDI_ConfQtyEqOrderQtyFlag]
        ,[SLAvailableFlag]
        ,[IF_DataQualityCode]
        ,[OTD_DataQualityCode]
        ,[OTS_DataQualityCode]
        ,[CalculatedDelDate]
        ,[OTD_DaysDiff]
        ,[OTD_Group]
        ,CASE
            WHEN [OTD_Group] = 'Early'
            THEN [OTD_DaysDiff]
            ELSE 0
        END AS [OTD_EarlyDays]
      ,CASE
            WHEN [OTD_Group] = 'Early'
            THEN 1
            ELSE 0
        END AS [OTD_IsEarly]
      ,CASE
            WHEN [OTD_Group] = 'Late'
            THEN 1
            ELSE 0
        END AS [OTD_IsLate]
      ,CASE
            WHEN [OTD_Group] = 'OnTime'
            THEN 1
            ELSE 0
        END AS [OTD_IsOnTime]
      ,CASE
            WHEN [OTD_Group] = 'Late'
            THEN [OTD_DaysDiff]
            ELSE 0
        END AS [OTD_LateDays]
        ,[t_applicationId]
        ,[t_extractionDtm]
    FROM OutboundDeliveryItem_s4h_calculated
)
SELECT
    [nk_fact_OutboundDeliveryItem]
    ,[OutboundDelivery]
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
    ,[TotalNetAmount_LC]
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
    ,[IF_Group]
    ,[IF_IsInFullFlag]
    ,[IF_IsInFull]
    ,[NoActualDeliveredQtyFlag]
    ,[OTS_DaysDiff]
    ,[OTS_GoodsIssueDateDiffInDays]
    ,[OTS_GIDateCheckGroup]
    ,[OTS_Group]
    ,[SDAvailableFlag]
    ,[SDI_ConfQtyEqOrderQtyFlag]
    ,[SLAvailableFlag]
    ,[IF_DataQualityCode]
    ,[OTD_DataQualityCode]
    ,[OTS_DataQualityCode]
    ,[CalculatedDelDate]
    ,[OTD_DaysDiff]
    ,[OTD_Group]
    ,[OTD_EarlyDays]
    ,[OTD_IsEarly]
    ,[OTD_IsLate]
    ,[OTD_IsOnTime]
    ,[OTD_LateDays]
    ,CASE
        WHEN [OTD_Group] IS NULL
        THEN NULL
        WHEN
            [OTD_IsOnTime] = 1
            AND
            [IF_IsInFull] = 1
        THEN 'OTIF'
        WHEN
            [OTD_IsOnTime] = 1
            AND
            [IF_IsInFull] = 0
        THEN 'OTNIF'
        WHEN
            [OTD_IsOnTime] = 0
            AND
            [IF_IsInFull] = 1
        THEN 'NOTIF'
        WHEN
            [OTD_IsOnTime] = 0
            AND
            [IF_IsInFull] = 0
        THEN 'NOTNIF'
    END AS [OTDIF_OnTimeDelInFull]
    ,[t_applicationId]
    ,[t_extractionDtm]
FROM
	OutboundDeliveryItem_s4h_OTDIF_calculated