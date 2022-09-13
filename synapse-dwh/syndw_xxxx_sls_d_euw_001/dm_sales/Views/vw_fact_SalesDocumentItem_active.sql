CREATE VIEW [dm_sales].[vw_fact_SalesDocumentItem_active] AS
    SELECT
        [sk_fact_SalesDocumentItem] 
    ,   [nk_fact_SalesDocumentItem]
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
    ,   [ProductSurrogateKey]
    ,   [OriginallyRequestedMaterialID]
    ,   [MaterialSubstitutionReasonID]
    ,   [MaterialGroupID]
    ,   [BrandID]
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
    ,   [t_applicationId]
    ,   [t_extractionDtm]
    ,   [t_lastActionCd]
    FROM
        [edw].[fact_SalesDocumentItem_s4h_active]
        Where [t_lastActionCd] <> 'D'                
    UNION ALL
    SELECT
        [sk_fact_SalesDocumentItem] 
    ,   [nk_fact_SalesDocumentItem]
    ,   [SalesDocument]
    ,   [SalesDocumentItem]
    ,   [CurrencyTypeID]
    ,   [CurrencyType]
    ,   [CurrencyID]
    ,   [ExchangeRate]  as [ExchangeRate]
    ,   [SDDocumentCategoryID]
    ,   [SalesDocumentTypeID]                         --??
    ,   null            as [SalesDocumentItemCategoryID]
    ,   [IsReturnsItemID]
    ,   [CreationDate]
    ,   [CreationTime]
    ,   null            as [LastChangeDate]
    ,   [SalesOrganizationID]            as [SalesOrganizationID]
    ,   null            as [DistributionChannelID]
    ,   null            as [DivisionID]
    ,   null            as [SalesGroupID]
    ,   null            as [SalesOfficeID]
    ,   null            as [InternationalArticleNumberID]
    ,   null            as [BatchID]
    ,   [MaterialID]
    ,   [MaterialID]    as [ProductSurrogateKey]
    ,   null            as [OriginallyRequestedMaterialID]
    ,   null            as [MaterialSubstitutionReasonID]
    ,   null            as [MaterialGroupID]
    ,   [BrandID]
    ,   null            as [AdditionalMaterialGroup2ID]
    ,   null            as [AdditionalMaterialGroup3ID]
    ,   null            as [AdditionalMaterialGroup4ID]
    ,   null            as [AdditionalMaterialGroup5ID]
    ,   [SoldToPartyID]
    ,   null            as [AdditionalCustomerGroup1ID]
    ,   null            as [AdditionalCustomerGroup2ID]
    ,   null            as [AdditionalCustomerGroup3ID]
    ,   null            as [AdditionalCustomerGroup4ID]
    ,   null            as [AdditionalCustomerGroup5ID]
    ,   null            as [ShipToPartyID]
    ,   null            as [PayerPartyID]
    ,   [BillToPartyID]
    ,   null            as [SDDocumentReasonID]
    ,   null            as [SalesDocumentDate]
    ,   [OrderQuantity]
    ,   null            as [OrderQuantityUnitID]
    ,   null            as [TargetQuantity]
    ,   null            as [TargetQuantityUnitID]
    ,   null            as [TargetToBaseQuantityDnmntr]
    ,   null            as [TargetToBaseQuantityNmrtr]
    ,   null            as [OrderToBaseQuantityDnmntr]
    ,   null            as [OrderToBaseQuantityNmrtr]
    ,   null            as [ConfdDelivQtyInOrderQtyUnit]
    ,   null            as [TargetDelivQtyInOrderQtyUnit]
    ,   null            as [ConfdDeliveryQtyInBaseUnit]
    ,   null            as [BaseUnitID]
    ,   null            as [ItemGrossWeight]
    ,   null            as [ItemNetWeight]
    ,   null            as [ItemWeightUnitID]
    ,   null            as [ItemVolume]
    ,   null            as [ItemVolumeUnitID]
    ,   null            as [ServicesRenderedDate]
    ,   [SalesDistrictID]
    ,   [CustomerGroupID]
    ,   null            as [HdrOrderProbabilityInPercentID]
    ,   null            as [ItemOrderProbabilityInPercentID]
    ,   null            as [SalesDocumentRjcnReasonID]
    ,   null            as [PricingDate]
    ,   null            as [ExchangeRateDate]
    ,   null            as [PriceDetnExchangeRate]
    ,   null            as [StatisticalValueControlID]
    ,   [NetAmount]
    ,   null            as [TransactionCurrencyID]
    ,   null            as [SalesOrganizationCurrencyID]
    ,   null            as [NetPriceAmount]
    ,   null            as [NetPriceQuantity]
    ,   null            as [NetPriceQuantityUnitID]
    ,   null            as [TaxAmount]
    ,   [CostAmount]    as [CostAmount]
    ,   [Margin]
    ,   null            as [Subtotal1Amount]
    ,   null            as [Subtotal2Amount]
    ,   null            as [Subtotal3Amount]
    ,   null            as [Subtotal4Amount]
    ,   null            as [Subtotal5Amount]
    ,   null            as [Subtotal6Amount]
    ,   null            as [ShippingPointID]
    ,   null            as [ShippingTypeID]
    ,   null            as [DeliveryPriorityID]
    ,   null            as [InventorySpecialStockTypeID]
    ,   [RequestedDeliveryDate]
    ,   null            as [ShippingConditionID]
    ,   null            as [DeliveryBlockReasonID]
    ,   null            as [PlantID]                  --FSL_DOC.[INVENTSITEID]
    ,   null            as [StorageLocationID]
    ,   null            as [RouteID]
    ,   null            as [IncotermsClassificationID]
    ,   null            as [IncotermsVersionID]
    ,   null            as [IncotermsTransferLocationID]
    ,   null            as [IncotermsLocation1ID]
    ,   null            as [IncotermsLocation2ID]
    ,   null            as [MinDeliveryQtyInBaseUnit]
    ,   null            as [UnlimitedOverdeliveryIsAllowedID]
    ,   null            as [OverdelivTolrtdLmtRatioInPct]
    ,   null            as [UnderdelivTolrtdLmtRatioInPct]
    ,   null            as [PartialDeliveryIsAllowedID]
    ,   null            as [BindingPeriodValidityStartDate]
    ,   null            as [BindingPeriodValidityEndDate]
    ,   null            as [OutlineAgreementTargetAmount]
    ,   null            as [BillingDocumentDate]
    ,   null            as [BillingCompanyCodeID]
    ,   null            as [HeaderBillingBlockReasonID]
    ,   null            as [ItemBillingBlockReasonID]
    ,   null            as [FiscalYearID]
    ,   null            as [FiscalPeriodID]
    ,   null            as [CustomerAccountAssignmentGroupID]
    ,   null            as [ExchangeRateTypeID]
    ,   null            as [CompanyCodeCurrencyID]
    ,   null            as [FiscalYearVariantID]
    ,   null            as [BusinessAreaID]
    ,   null            as [ProfitCenterID]
    ,   null            as [OrderID]
    ,   null            as [ProfitabilitySegmentID]
    ,   null            as [ControllingAreaID]
    ,   null            as [ReferenceSDDocumentID]
    ,   null            as [ReferenceSDDocumentItemID]
    ,   null            as [ReferenceSDDocumentCategoryID]
    ,   null            as [OriginSDDocumentID]
    ,   null            as [OriginSDDocumentItemID]
    ,   null            as [OverallSDProcessStatusID] --FSL_DOC.[SALESSTATUS]
    ,   null            as [OverallTotalDeliveryStatusID]
    ,   null            as [OverallOrdReltdBillgStatusID]
    ,   null            as [TotalCreditCheckStatusID]
    ,   null            as [DeliveryBlockStatusID]
    ,   null            as [BillingBlockStatusID]
    ,   null            as [TotalSDDocReferenceStatusID]
    ,   null            as [SDDocReferenceStatusID]
    ,   null            as [OverallSDDocumentRejectionStsID]
    ,   null            as [SDDocumentRejectionStatusID]
    ,   null            as [OverallTotalSDDocRefStatusID]
    ,   null            as [OverallSDDocReferenceStatusID]
    ,   null            as [ItemGeneralIncompletionStatusID]
    ,   null            as [ItemBillingIncompletionStatusID]
    ,   null            as [PricingIncompletionStatusID]
    ,   null            as [ItemDeliveryIncompletionStatusID]
    ,   [ExternalSalesAgentID]
    ,   null            as [ExternalSalesAgent]
    ,   null            as [GlobalParentID]
    ,   null            as [GlobalParent]
    ,   null            as [LocalParentID]
    ,   null            as [LocalParent]
    ,   [ProjectID]     as [ProjectID]                -- FSL_DOC.[DW_Id_CustomerObject]
    ,   [Project]       as [Project]
    ,   [SalesEmployeeID]
    ,   null            as [SalesEmployee]
    ,   [GlobalParentCalculatedID]
    ,   [GlobalParentCalculated]
    ,   [LocalParentCalculatedID]
    ,   [LocalParentCalculated]
    ,   null            as [SDoc_ControllingObjectID]
    ,   null            as [SDItem_ControllingObjectID]
    ,   null            as [CorrespncExternalReference]
    ,   [InOutID]
    ,   [t_applicationId]            as [t_applicationId]
    ,   [t_extractionDtm]            as [t_extractionDtm]
    ,   [t_lastActionCd]             as [t_lastActionCd]       
    FROM
        [edw].[fact_SalesDocumentItem_axbi]