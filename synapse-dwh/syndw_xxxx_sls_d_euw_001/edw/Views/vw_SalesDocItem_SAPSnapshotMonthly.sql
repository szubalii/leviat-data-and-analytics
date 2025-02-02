﻿CREATE VIEW [edw].[vw_SalesDocItem_SAPSnapshotMonthly]
    AS 
SELECT
        [sk_fact_SalesDocumentItem] AS [sk_fact_SalesDocItem_SAPSnapshotMonthly]
    ,   [nk_fact_SalesDocumentItem] AS [nk_fact_SalesDocItem_SAPSnapshotMonthly]
    ,   [SalesDocument]
    ,   [SalesDocumentItem]
    ,   [CurrencyTypeID]
    ,   [CurrencyType]
    ,   [CurrencyID]
    ,   [ExchangeRate]
    ,   [SDDocumentCategoryID]
    ,   [SalesDocumentTypeID]
    ,   [SalesDocumentItemCategoryID]
    ,   [IsReturnsItemID]
    ,   [CreationDate]
    ,   [CreationTime]
    ,   [LastChangeDate]
    ,   [SalesOrganizationID]
    ,   [DistributionChannelID]
    ,   [DivisionID]
    ,   [SalesGroupID]
    ,   [SalesOfficeID]
    ,   [InternationalArticleNumberID]
    ,   [BatchID]
    ,   [MaterialID]
    ,   [OriginallyRequestedMaterialID]
    ,   [MaterialSubstitutionReasonID]
    ,   [MaterialGroupID]
    ,   [BrandID]
    ,   [Brand]
    ,   [AdditionalMaterialGroup2ID]
    ,   [AdditionalMaterialGroup3ID]
    ,   [AdditionalMaterialGroup4ID]
    ,   [AdditionalMaterialGroup5ID]
    ,   [SoldToPartyID]
    ,   [AdditionalCustomerGroup1ID]
    ,   [AdditionalCustomerGroup2ID]
    ,   [AdditionalCustomerGroup3ID]
    ,   [AdditionalCustomerGroup4ID]
    ,   [AdditionalCustomerGroup5ID]
    ,   [ShipToPartyID]
    ,   [PayerPartyID]
    ,   [BillToPartyID]
    ,   [SDDocumentReasonID]
    ,   [SalesDocumentDate]
    ,   [OrderQuantity]
    ,   [OrderQuantityUnitID]
    ,   [TargetQuantity]
    ,   [TargetQuantityUnitID]
    ,   [TargetToBaseQuantityDnmntr]
    ,   [TargetToBaseQuantityNmrtr]
    ,   [OrderToBaseQuantityDnmntr]
    ,   [OrderToBaseQuantityNmrtr]
    ,   [ConfdDelivQtyInOrderQtyUnit]
    ,   [TargetDelivQtyInOrderQtyUnit]
    ,   [ConfdDeliveryQtyInBaseUnit]
    ,   [BaseUnitID]
    ,   [ItemGrossWeight]
    ,   [ItemNetWeight]
    ,   [ItemWeightUnitID]
    ,   [ItemVolume]
    ,   [ItemVolumeUnitID]
    ,   [ServicesRenderedDate]
    ,   [SalesDistrictID]
    ,   [CustomerGroupID]
    ,   [HdrOrderProbabilityInPercentID]
    ,   [ItemOrderProbabilityInPercentID]
    ,   [SalesDocumentRjcnReasonID]
    ,   [PricingDate]
    ,   [ExchangeRateDate]
    ,   [PriceDetnExchangeRate]
    ,   [StatisticalValueControlID]
    ,   [NetAmount]
    ,   [TransactionCurrencyID]
    ,   [SalesOrganizationCurrencyID]
    ,   [NetPriceAmount]
    ,   [NetPriceQuantity]
    ,   [NetPriceQuantityUnitID]
    ,   [TaxAmount]
    ,   [CostAmount]
    ,   [Margin]
    ,   [Subtotal1Amount]
    ,   [Subtotal2Amount]
    ,   [Subtotal3Amount]
    ,   [Subtotal4Amount]
    ,   [Subtotal5Amount]
    ,   [Subtotal6Amount]
    ,   [ShippingPointID]
    ,   [ShippingTypeID]
    ,   [DeliveryPriorityID]
    ,   [InventorySpecialStockTypeID]
    ,   [RequestedDeliveryDate]
    ,   [ShippingConditionID]
    ,   [DeliveryBlockReasonID]
    ,   [PlantID]
    ,   [StorageLocationID]
    ,   [RouteID]
    ,   [IncotermsClassificationID]
    ,   [IncotermsVersionID]
    ,   [IncotermsTransferLocationID]
    ,   [IncotermsLocation1ID]
    ,   [IncotermsLocation2ID]
    ,   [MinDeliveryQtyInBaseUnit]
    ,   [UnlimitedOverdeliveryIsAllowedID]
    ,   [OverdelivTolrtdLmtRatioInPct]
    ,   [UnderdelivTolrtdLmtRatioInPct]
    ,   [PartialDeliveryIsAllowedID]
    ,   [BindingPeriodValidityStartDate]
    ,   [BindingPeriodValidityEndDate]
    ,   [OutlineAgreementTargetAmount]
    ,   [BillingDocumentDate]
    ,   [BillingCompanyCodeID]
    ,   [HeaderBillingBlockReasonID]
    ,   [ItemBillingBlockReasonID]
    ,   [FiscalYearID]
    ,   [FiscalPeriodID]
    ,   [CustomerAccountAssignmentGroupID]
    ,   [ExchangeRateTypeID]
    ,   [CompanyCodeCurrencyID]
    ,   [FiscalYearVariantID]
    ,   [BusinessAreaID]
    ,   [ProfitCenterID]
    ,   [OrderID]
    ,   [ProfitabilitySegmentID]
    ,   [ControllingAreaID]
    ,   [ReferenceSDDocumentID]
    ,   [ReferenceSDDocumentItemID]
    ,   [ReferenceSDDocumentCategoryID]
    ,   [OriginSDDocumentID]
    ,   [OriginSDDocumentItemID]
    ,   [OverallSDProcessStatusID]
    ,   [OverallTotalDeliveryStatusID]
    ,   [OverallOrdReltdBillgStatusID]
    ,   [TotalCreditCheckStatusID]
    ,   [DeliveryBlockStatusID]
    ,   [BillingBlockStatusID]
    ,   [TotalSDDocReferenceStatusID]
    ,   [SDDocReferenceStatusID]
    ,   [OverallSDDocumentRejectionStsID]
    ,   [SDDocumentRejectionStatusID]
    ,   [OverallTotalSDDocRefStatusID]
    ,   [OverallSDDocReferenceStatusID]
    ,   [ItemGeneralIncompletionStatusID]
    ,   [ItemBillingIncompletionStatusID]
    ,   [PricingIncompletionStatusID]
    ,   [ItemDeliveryIncompletionStatusID]
    ,   [ExternalSalesAgentID]
    ,   [ExternalSalesAgent]
    ,   [GlobalParentID]
    ,   [GlobalParent]
    ,   [LocalParentID]
    ,   [LocalParent]
    ,   [ProjectID]
    ,   [Project]
    ,   [SalesEmployeeID]
    ,   [SalesEmployee]
    ,   [GlobalParentCalculatedID]
    ,   [GlobalParentCalculated]
    ,   [LocalParentCalculatedID]
    ,   [LocalParentCalculated]
    ,   [SDoc_ControllingObjectID]
    ,   [SDItem_ControllingObjectID]
    ,   [CorrespncExternalReference] 
    ,   [InOutID]
    ,   [OpenDeliveryNetAmount] 
    ,   CONCAT(
            YEAR([t_jobDtm]),
             RIGHT('00'+CONVERT(VARCHAR(2), MONTH([t_jobDtm])), 2)
        ) AS [SnapshotCalMonth]
    ,   [t_jobDtm] AS [SnapshotDate]
    ,   [t_applicationId]
    ,   [t_extractionDtm]
FROM
    [edw].[fact_SalesDocumentItem]
WHERE
    [t_applicationId] LIKE 's4h-ca%'