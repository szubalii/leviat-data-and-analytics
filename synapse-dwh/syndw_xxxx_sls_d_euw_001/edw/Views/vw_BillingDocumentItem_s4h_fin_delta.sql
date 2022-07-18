CREATE VIEW [edw].[vw_BillingDocumentItem_s4h_fin_delta]
AS
WITH Product AS (
    SELECT 
        [ProductID]
        ,[MaterialTypeID]
    FROM
        [edw].[dim_Product]
    GROUP BY
        [ProductID]
        ,[MaterialTypeID]
)
,
BDIwithMatType AS (
    SELECT 
        BDI.[BillingDocument]
    ,   BDI.[BillingDocumentItem]
    ,   Product.[MaterialTypeID]
    ,   BDI.[CurrencyTypeID]
    ,   BDI.[CurrencyType]
    ,   BDI.[CurrencyID]
    ,   BDI.[ExchangeRate]
    ,   BDI.[SalesDocumentItemCategoryID]
    ,   BDI.[SalesDocumentItemTypeID]
    ,   BDI.[ReturnItemProcessingType]
    ,   BDI.[BillingDocumentTypeID]
    ,   BDI.[BillingDocumentCategoryID]
    ,   BDI.[SDDocumentCategoryID]
    ,   BDI.[CreationDate]
    ,   BDI.[CreationTime]
    ,   BDI.[LastChangeDate]
    ,   BDI.[BillingDocumentDate]
    ,   BDI.[BillingDocumentIsTemporary]
    ,   BDI.[OrganizationDivision]
    ,   BDI.[Division]
    ,   BDI.[SalesOfficeID]
    ,   BDI.[SalesOrganizationID]
    ,   BDI.[DistributionChannelID]
    ,   BDI.[Material]
    ,   COALESCE(VC.[ProductSurrogateKey],Product.[ProductID]) AS [ProductSurrogateKey]
    ,   BDI.[OriginallyRequestedMaterial]
    ,   BDI.[InternationalArticleNumber]
    ,   BDI.[PricingReferenceMaterial]
    ,   BDI.[LengthInMPer1]
    ,   BDI.[LengthInM]
    ,   BDI.[Batch]
    ,   BDI.[MaterialGroupID]
    ,   BDI.[BrandID]
    ,   BDI.[AdditionalMaterialGroup2]
    ,   BDI.[AdditionalMaterialGroup3]
    ,   BDI.[AdditionalMaterialGroup4]
    ,   BDI.[AdditionalMaterialGroup5]
    ,   BDI.[MaterialCommissionGroup]
    ,   BDI.[PlantID]
    ,   BDI.[StorageLocationID]
    ,   BDI.[BillingDocumentIsCancelled]
    ,   BDI.[CancelledBillingDocument]
    ,   BDI.[CancelledInvoiceEffect]
    ,   BDI.[BillingDocumentItemText]
    ,   BDI.[ServicesRenderedDate]
    ,   BDI.[BillingQuantity]
    ,   BDI.[BillingQuantityUnitID]
    ,   BDI.[BillingQuantityInBaseUnit]
    ,   BDI.[BaseUnit]
    ,   BDI.[MRPRequiredQuantityInBaseUnit]
    ,   BDI.[BillingToBaseQuantityDnmntr]
    ,   BDI.[BillingToBaseQuantityNmrtr]
    ,   BDI.[ItemGrossWeight]
    ,   BDI.[ItemNetWeight]
    ,   BDI.[ItemWeightUnit]
    ,   BDI.[ItemVolume]
    ,   BDI.[ItemVolumeUnit]
    ,   BDI.[BillToPartyCountry]
    ,   BDI.[BillToPartyRegion]
    ,   BDI.[BillingPlanRule]
    ,   BDI.[BillingPlan]
    ,   BDI.[BillingPlanItem]
    ,   BDI.[CustomerPriceGroupID]
    ,   BDI.[PriceListTypeID]
    ,   BDI.[TaxDepartureCountry]
    ,   BDI.[VATRegistration]
    ,   BDI.[VATRegistrationCountry]
    ,   BDI.[VATRegistrationOrigin]
    ,   BDI.[CustomerTaxClassification1]
    ,   BDI.[CustomerTaxClassification2]
    ,   BDI.[CustomerTaxClassification3]
    ,   BDI.[CustomerTaxClassification4]
    ,   BDI.[CustomerTaxClassification5]
    ,   BDI.[CustomerTaxClassification6]
    ,   BDI.[CustomerTaxClassification7]
    ,   BDI.[CustomerTaxClassification8]
    ,   BDI.[CustomerTaxClassification9]
    ,   BDI.[SDPricingProcedure]
    ,   BDI.[NetAmount]
    ,   BDI.[TransactionCurrencyID]
    ,   BDI.[GrossAmount]
    ,   BDI.[PricingDate]
    ,   BDI.[PriceDetnExchangeRate]
    ,   BDI.[PricingScaleQuantityInBaseUnit]
    ,   BDI.[TaxAmount]
    ,   BDI.[CostAmount]
    ,   BDI.[ProfitMargin]
    ,   BDI.[MarginPercent]
    ,   BDI.[Subtotal1Amount]
    ,   BDI.[Subtotal2Amount]
    ,   BDI.[Subtotal3Amount]
    ,   BDI.[Subtotal4Amount]
    ,   BDI.[Subtotal5Amount]
    ,   BDI.[Subtotal6Amount]
    ,   BDI.[StatisticalValueControl]
    ,   BDI.[StatisticsExchangeRate]
    ,   BDI.[StatisticsCurrency]
    ,   BDI.[SalesOrganizationCurrency]
    ,   BDI.[EligibleAmountForCashDiscount]
    ,   BDI.[ContractAccount]
    ,   BDI.[CustomerPaymentTerms]
    ,   BDI.[PaymentMethod]
    ,   BDI.[PaymentReference]
    ,   BDI.[FixedValueDate]
    ,   BDI.[AdditionalValueDays]
    ,   BDI.[PayerParty]
    ,   BDI.[CompanyCode]
    ,   BDI.[FiscalYear]
    ,   BDI.[FiscalPeriod]
    ,   BDI.[CustomerAccountAssignmentGroupID]
    ,   BDI.[BusinessArea]
    ,   BDI.[ProfitCenter]
    ,   BDI.[OrderID]
    ,   BDI.[ControllingArea]
    ,   BDI.[ProfitabilitySegment]
    ,   BDI.[CostCenter]
    ,   BDI.[OriginSDDocument]
    ,   BDI.[OriginSDDocumentItem]
    ,   BDI.[PriceDetnExchangeRateDate]
    ,   BDI.[ExchangeRateTypeID]
    ,   BDI.[FiscalYearVariant]
    ,   BDI.[CompanyCodeCurrencyID]
    ,   BDI.[AccountingExchangeRate]
    ,   BDI.[AccountingExchangeRateIsSet]
    ,   BDI.[ReferenceSDDocument]
    ,   BDI.[ReferenceSDDocumentItem]
    ,   BDI.[ReferenceSDDocumentCategoryID]
    ,   BDI.[SalesDocumentID]
    ,   BDI.[SalesDocumentItemID]
    ,   BDI.[SalesSDDocumentCategoryID]
    ,   BDI.[HigherLevelItem]
    ,   BDI.[BillingDocumentItemInPartSgmt]
    ,   BDI.[SalesGroup]
    ,   BDI.[AdditionalCustomerGroup1]
    ,   BDI.[AdditionalCustomerGroup2]
    ,   BDI.[AdditionalCustomerGroup3]
    ,   BDI.[AdditionalCustomerGroup4]
    ,   BDI.[AdditionalCustomerGroup5]
    ,   BDI.[SDDocumentReasonID]
    ,   BDI.[ItemIsRelevantForCredit]
    ,   BDI.[CreditRelatedPrice]
    ,   BDI.[SalesDistrictID]
    ,   BDI.[CustomerGroupID]
    ,   BDI.[SoldToParty]
    ,   BDI.[CountryID]
    ,   BDI.[ShipToParty]
    ,   BDI.[BillToParty]
    ,   BDI.[ShippingPoint]
    ,   BDI.[IncotermsVersion]
    ,   BDI.[IncotermsClassification]
    ,   BDI.[IncotermsTransferLocation]
    ,   BDI.[IncotermsLocation1]
    ,   BDI.[IncotermsLocation2]
    ,   BDI.[ShippingCondition]
    ,   BDI.[QuantitySold]
    ,   BDI.[GrossMargin]
    ,   BDI.[ExternalSalesAgentID]
    ,   BDI.[ExternalSalesAgent]
    ,   BDI.[ProjectID]
    ,   BDI.[Project]
    ,   BDI.[SalesEmployeeID]
    ,   BDI.[SalesEmployee]
    ,   BDI.[GlobalParentID]
    ,   BDI.[GlobalParent]
    ,   BDI.[GlobalParentCalculatedID]
    ,   BDI.[GlobalParentCalculated]
    ,   BDI.[LocalParentID]
    ,   BDI.[LocalParent]
    ,   BDI.[LocalParentCalculatedID]
    ,   BDI.[LocalParentCalculated]
    ,   BDI.[SalesOrderTypeID]
    ,   BDI.[BillToID]
    ,   BDI.[BillTo]
    ,   BDI.[AccountingDate]
    ,   BDI.[MaterialCalculated]
    ,   BDI.[SoldToPartyCalculated]
    ,   BDI.[InOutID]
    ,   BDI.[t_applicationId]
    ,   BDI.[t_extractionDtm]
    ,   BDI.[t_lastActionBy]
    ,   BDI.[t_lastActionCd]
    ,   BDI.[t_lastActionDtm]
    ,   BDI.[t_filePath] 
    FROM 
        [edw].[vw_BillingDocumentItem_s4h_delta] BDI
    LEFT JOIN
        Product
        ON
            BDI.[Material] = Product.[ProductID]
    LEFT JOIN
        [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active] AS VC
        ON
            BDI.[OriginSDDocument] = VC.[SalesDocument]
            AND
            BDI.[OriginSDDocumentItem] = VC.[SalesDocumentItem]    
    WHERE BDI.[Material]<>'000000000070000019'
)
,
BDwithFreight AS (
    SELECT 
        [BillingDocument]
    ,   CurrencyTypeID
    ,   SUM(NetAmount) AS NetAmountFreight
    FROM 
        BDIwithMatType
    INNER JOIN
        [map_AXBI].[BillingDocumentItem] mbdi
        ON
            mbdi.[ProductID] = BDIwithMatType.[Material]
            AND
            mbdi.[FinNetAmountColumnName] = 'FinNetAmountFreight'
    WHERE 
        [MaterialTypeID] = 'ZSER'
    GROUP BY 
        BillingDocument
    ,   CurrencyTypeID
)
,BDwithMinQty AS (
    SELECT 
        [BillingDocument]
    ,   CurrencyTypeID
    ,   SUM(NetAmount) AS NetAmountMinQty
    FROM 
        BDIwithMatType
    INNER JOIN
        [map_AXBI].[BillingDocumentItem] mbdi
        ON
            mbdi.[ProductID] = BDIwithMatType.[Material]
            AND
            mbdi.[FinNetAmountColumnName] = 'FinNetAmountMinQty'
    WHERE 
        [MaterialTypeID] = 'ZSER'
    GROUP BY
        BillingDocument
    ,   CurrencyTypeID
)
,BDwithEngServ AS (
    SELECT 
        [BillingDocument]
    ,   CurrencyTypeID
    ,   SUM(NetAmount) AS NetAmountEngServ
    FROM 
        BDIwithMatType
    INNER JOIN
        [map_AXBI].[BillingDocumentItem] mbdi
        ON
            mbdi.[ProductID] = BDIwithMatType.[Material]
            AND
            mbdi.[FinNetAmountColumnName] = 'FinNetAmountEngServ'
    WHERE 
        [MaterialTypeID] = 'ZSER'
    GROUP BY
        BillingDocument
    ,   CurrencyTypeID
)
,BDwithMisc AS (
    SELECT 
        [BillingDocument]
    ,   CurrencyTypeID
    ,   SUM(NetAmount) AS NetAmountMisc
    FROM 
        BDIwithMatType
    INNER JOIN
        [map_AXBI].[BillingDocumentItem] mbdi
        ON
            mbdi.[ProductID] = BDIwithMatType.[Material]
            AND
            mbdi.[FinNetAmountColumnName] = 'FinNetAmountMisc'
    WHERE 
        [MaterialTypeID] = 'ZSER'
    GROUP BY
        BillingDocument
    ,   CurrencyTypeID
)
,BDwithServOther AS (
    SELECT 
        [BillingDocument]
    ,   CurrencyTypeID
    ,   SUM(NetAmount) AS NetAmountServOther
    FROM 
        BDIwithMatType
    INNER JOIN
        [map_AXBI].[BillingDocumentItem] mbdi
        ON
            mbdi.[ProductID] IS NULL
    WHERE
        [MaterialTypeID] = 'ZSER'
    GROUP BY
        BillingDocument
    ,   CurrencyTypeID
)
-- ,BDwithVerp AS (
--     SELECT 
--         [BillingDocument]
--     ,   CurrencyTypeID
--     ,   SUM(NetAmount) AS NetAmountVerp
--     FROM 
--         BDIwithMatType
--     WHERE 
--         [MaterialTypeID] = 'ZVER'
--     GROUP BY
--         BillingDocument
--     ,   CurrencyTypeID
-- )
,BDwithZVER AS (
    SELECT 
        [BillingDocument]
    ,   CurrencyTypeID
    ,   SUM(NetAmount) AS NetAmountZVER
    FROM 
        BDIwithMatType
    WHERE 
        [MaterialTypeID] = 'ZVER'
    GROUP BY
        BillingDocument
    ,   CurrencyTypeID
)
,BDwithZSER AS (
    SELECT 
        [BillingDocument]
    ,   CurrencyTypeID
    ,   SUM(NetAmount) AS NetAmountZSER
    FROM 
        BDIwithMatType
    WHERE 
        [MaterialTypeID] = 'ZSER'
    GROUP BY
        BillingDocument
    ,   CurrencyTypeID
)
,BDexclZVERandZSER AS (
    SELECT 
        [BillingDocument]
    ,   CurrencyTypeID
    ,   SUM(NetAmount) AS FinNetAmountSumBD
    FROM  
        BDIwithMatType
    WHERE 
        [MaterialTypeID] NOT IN ('ZSER', 'ZVER')
    GROUP BY
        BillingDocument
    ,   CurrencyTypeID
),
BDIPE_ZF20 as (
    SELECT
            BDIPE_ZF20.[BillingDocument]
        ,   BDIPE_ZF20.[BillingDocumentItem]
        ,   BDIPE_ZF20.[ConditionAmount]
    FROM
        [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] BDIPE_ZF20  
    WHERE
        BDIPE_ZF20.[ConditionType] = 'ZF20'
),
BDwithConditionAmountFreight AS (
    SELECT 
            BDI.BillingDocument
        ,   BDI.BillingDocumentItem
        ,   BDI.CurrencyTypeID
        ,   BDI.CurrencyID
        ,   BDI.ExchangeRate
        ,   SUM(BDIPE.ConditionAmount * BDI.ExchangeRate) AS ConditionAmountFreight
    FROM             
        BDIwithMatType BDI
    LEFT JOIN
        [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] BDIPE
        ON
            BDI.[BillingDocument] = BDIPE.[BillingDocument]
            AND
            BDI.[BillingDocumentItem] = BDIPE.[BillingDocumentItem]
    LEFT JOiN
        BDIPE_ZF20
        ON 
            BDI.[BillingDocument] = BDIPE_ZF20.[BillingDocument]
            AND
            BDI.[BillingDocumentItem] = BDIPE_ZF20.[BillingDocumentItem]
    WHERE
        (
            (BDIPE_ZF20.[BillingDocument] IS NOT NULL AND  BDIPE.[ConditionType] IN ('ZF60', 'ZF20', 'ZTMF', 'ZM40'))
            OR 
            (ISNULL(BDIPE_ZF20.[BillingDocument], 0) = 0 AND BDIPE.[ConditionType] IN ('ZF60', 'ZTMF', 'ZF10', 'ZM40'))
        )
    GROUP BY 
         BDI.BillingDocument
        ,BDI.BillingDocumentItem
        ,BDI.CurrencyTypeID
        ,BDI.CurrencyID
        ,BDI.ExchangeRate
)
,BDwithConditionAmountMinQty AS (
    SELECT 
            BDI.BillingDocument
        ,   BDI.BillingDocumentItem
        ,   BDI.CurrencyTypeID
        ,   BDI.CurrencyID
        ,   BDI.ExchangeRate
        ,   SUM(BDIPE.ConditionAmount * BDI.ExchangeRate) AS ConditionAmountMinQty
    FROM             
        BDIwithMatType BDI
    LEFT JOIN
        [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] BDIPE
        ON
            BDI.[BillingDocument] = BDIPE.[BillingDocument]
            AND
            BDI.[BillingDocumentItem] = BDIPE.[BillingDocumentItem]
            AND
            BDIPE.[ConditionType] = 'AMIZ'
    GROUP BY 
         BDI.BillingDocument
        ,BDI.BillingDocumentItem
        ,BDI.CurrencyTypeID
        ,BDI.CurrencyID
        ,BDI.ExchangeRate
)
,BDITotals AS (
    /*

     */
    SELECT 
        BDIwithMatType.[BillingDocument]
    ,   BDIwithMatType.[BillingDocumentItem]
    ,   BDIwithMatType.[MaterialTypeID]
    ,   BDIwithMatType.[CurrencyTypeID]
    ,   BDIwithMatType.[CurrencyType]
    ,   BDIwithMatType.[CurrencyID]
    ,   BDIwithMatType.[ExchangeRate]
    ,   BDIwithMatType.[SalesDocumentItemCategoryID]
    ,   BDIwithMatType.[SalesDocumentItemTypeID]
    ,   BDIwithMatType.[ReturnItemProcessingType]
    ,   BDIwithMatType.[BillingDocumentTypeID]
    ,   BDIwithMatType.[BillingDocumentCategoryID]
    ,   BDIwithMatType.[SDDocumentCategoryID]
    ,   BDIwithMatType.[CreationDate]
    ,   BDIwithMatType.[CreationTime]
    ,   BDIwithMatType.[LastChangeDate]
    ,   BDIwithMatType.[BillingDocumentDate]
    ,   BDIwithMatType.[BillingDocumentIsTemporary]
    ,   BDIwithMatType.[OrganizationDivision]
    ,   BDIwithMatType.[Division]
    ,   BDIwithMatType.[SalesOfficeID]
    ,   BDIwithMatType.[SalesOrganizationID]
    ,   BDIwithMatType.[DistributionChannelID]
    ,   BDIwithMatType.[Material]
    ,   BDIwithMatType.[ProductSurrogateKey]
    ,   BDIwithMatType.[OriginallyRequestedMaterial]
    ,   BDIwithMatType.[InternationalArticleNumber]
    ,   BDIwithMatType.[PricingReferenceMaterial]
    ,   BDIwithMatType.[LengthInMPer1]
    ,   BDIwithMatType.[LengthInM]
    ,   BDIwithMatType.[Batch]
    ,   BDIwithMatType.[MaterialGroupID]
    ,   BDIwithMatType.[BrandID]    
    ,   BDIwithMatType.[AdditionalMaterialGroup2]
    ,   BDIwithMatType.[AdditionalMaterialGroup3]
    ,   BDIwithMatType.[AdditionalMaterialGroup4]
    ,   BDIwithMatType.[AdditionalMaterialGroup5]
    ,   BDIwithMatType.[MaterialCommissionGroup]
    ,   BDIwithMatType.[PlantID]
    ,   BDIwithMatType.[StorageLocationID]
    ,   BDIwithMatType.[BillingDocumentIsCancelled]
    ,   BDIwithMatType.[CancelledBillingDocument]
    ,   BDIwithMatType.[CancelledInvoiceEffect]
    ,   BDIwithMatType.[BillingDocumentItemText]
    ,   BDIwithMatType.[ServicesRenderedDate]
    ,   BDIwithMatType.[BillingQuantity]
    ,   BDIwithMatType.[BillingQuantityUnitID]
    ,   BDIwithMatType.[BillingQuantityInBaseUnit]
    ,   BDIwithMatType.[BaseUnit]
    ,   BDIwithMatType.[MRPRequiredQuantityInBaseUnit]
    ,   BDIwithMatType.[BillingToBaseQuantityDnmntr]
    ,   BDIwithMatType.[BillingToBaseQuantityNmrtr]
    ,   BDIwithMatType.[ItemGrossWeight]
    ,   BDIwithMatType.[ItemNetWeight]
    ,   BDIwithMatType.[ItemWeightUnit]
    ,   BDIwithMatType.[ItemVolume]
    ,   BDIwithMatType.[ItemVolumeUnit]
    ,   BDIwithMatType.[BillToPartyCountry]
    ,   BDIwithMatType.[BillToPartyRegion]
    ,   BDIwithMatType.[BillingPlanRule]
    ,   BDIwithMatType.[BillingPlan]
    ,   BDIwithMatType.[BillingPlanItem]
    ,   BDIwithMatType.[CustomerPriceGroupID]
    ,   BDIwithMatType.[PriceListTypeID]
    ,   BDIwithMatType.[TaxDepartureCountry]
    ,   BDIwithMatType.[VATRegistration]
    ,   BDIwithMatType.[VATRegistrationCountry]
    ,   BDIwithMatType.[VATRegistrationOrigin]
    ,   BDIwithMatType.[CustomerTaxClassification1]
    ,   BDIwithMatType.[CustomerTaxClassification2]
    ,   BDIwithMatType.[CustomerTaxClassification3]
    ,   BDIwithMatType.[CustomerTaxClassification4]
    ,   BDIwithMatType.[CustomerTaxClassification5]
    ,   BDIwithMatType.[CustomerTaxClassification6]
    ,   BDIwithMatType.[CustomerTaxClassification7]
    ,   BDIwithMatType.[CustomerTaxClassification8]
    ,   BDIwithMatType.[CustomerTaxClassification9]
    ,   BDIwithMatType.[SDPricingProcedure]
    ,   BDIwithMatType.[NetAmount]
    ,   BDIwithMatType.[TransactionCurrencyID]
    ,   BDIwithMatType.[GrossAmount]
    ,   BDIwithMatType.[PricingDate]
    ,   BDIwithMatType.[PriceDetnExchangeRate]
    ,   BDIwithMatType.[PricingScaleQuantityInBaseUnit]
    ,   BDIwithMatType.[TaxAmount]
    ,   BDIwithMatType.[CostAmount]
    ,   BDIwithMatType.[ProfitMargin]
    ,   BDIwithMatType.[MarginPercent]
    ,   BDIwithMatType.[Subtotal1Amount]
    ,   BDIwithMatType.[Subtotal2Amount]
    ,   BDIwithMatType.[Subtotal3Amount]
    ,   BDIwithMatType.[Subtotal4Amount]
    ,   BDIwithMatType.[Subtotal5Amount]
    ,   BDIwithMatType.[Subtotal6Amount]
    ,   BDIwithMatType.[StatisticalValueControl]
    ,   BDIwithMatType.[StatisticsExchangeRate]
    ,   BDIwithMatType.[StatisticsCurrency]
    ,   BDIwithMatType.[SalesOrganizationCurrency]
    ,   BDIwithMatType.[EligibleAmountForCashDiscount]
    ,   BDIwithMatType.[ContractAccount]
    ,   BDIwithMatType.[CustomerPaymentTerms]
    ,   BDIwithMatType.[PaymentMethod]
    ,   BDIwithMatType.[PaymentReference]
    ,   BDIwithMatType.[FixedValueDate]
    ,   BDIwithMatType.[AdditionalValueDays]
    ,   BDIwithMatType.[PayerParty]
    ,   BDIwithMatType.[CompanyCode]
    ,   BDIwithMatType.[FiscalYear]
    ,   BDIwithMatType.[FiscalPeriod]
    ,   BDIwithMatType.[CustomerAccountAssignmentGroupID]
    ,   BDIwithMatType.[BusinessArea]
    ,   BDIwithMatType.[ProfitCenter]
    ,   BDIwithMatType.[OrderID]
    ,   BDIwithMatType.[ControllingArea]
    ,   BDIwithMatType.[ProfitabilitySegment]
    ,   BDIwithMatType.[CostCenter]
    ,   BDIwithMatType.[OriginSDDocument]
    ,   BDIwithMatType.[OriginSDDocumentItem]
    ,   BDIwithMatType.[PriceDetnExchangeRateDate]
    ,   BDIwithMatType.[ExchangeRateTypeID]
    ,   BDIwithMatType.[FiscalYearVariant]
    ,   BDIwithMatType.[CompanyCodeCurrencyID]
    ,   BDIwithMatType.[AccountingExchangeRate]
    ,   BDIwithMatType.[AccountingExchangeRateIsSet]
    ,   BDIwithMatType.[ReferenceSDDocument]
    ,   BDIwithMatType.[ReferenceSDDocumentItem]
    ,   BDIwithMatType.[ReferenceSDDocumentCategoryID]
    ,   BDIwithMatType.[SalesDocumentID]
    ,   BDIwithMatType.[SalesDocumentItemID]
    ,   BDIwithMatType.[SalesSDDocumentCategoryID]
    ,   BDIwithMatType.[HigherLevelItem]
    ,   BDIwithMatType.[BillingDocumentItemInPartSgmt]
    ,   BDIwithMatType.[SalesGroup]
    ,   BDIwithMatType.[AdditionalCustomerGroup1]
    ,   BDIwithMatType.[AdditionalCustomerGroup2]
    ,   BDIwithMatType.[AdditionalCustomerGroup3]
    ,   BDIwithMatType.[AdditionalCustomerGroup4]
    ,   BDIwithMatType.[AdditionalCustomerGroup5]
    ,   BDIwithMatType.[SDDocumentReasonID]
    ,   BDIwithMatType.[ItemIsRelevantForCredit]
    ,   BDIwithMatType.[CreditRelatedPrice]
    ,   BDIwithMatType.[SalesDistrictID]
    ,   BDIwithMatType.[CustomerGroupID]
    ,   BDIwithMatType.[SoldToParty]
    ,   BDIwithMatType.[CountryID]
    ,   BDIwithMatType.[ShipToParty]
    ,   BDIwithMatType.[BillToParty]
    ,   BDIwithMatType.[ShippingPoint]
    ,   BDIwithMatType.[IncotermsVersion]
    ,   BDIwithMatType.[IncotermsClassification]
    ,   BDIwithMatType.[IncotermsTransferLocation]
    ,   BDIwithMatType.[IncotermsLocation1]
    ,   BDIwithMatType.[IncotermsLocation2]
    ,   BDIwithMatType.[ShippingCondition]
    ,   BDIwithMatType.[QuantitySold]
    ,   BDIwithMatType.[GrossMargin]
    ,   BDIwithMatType.[ExternalSalesAgentID]
    ,   BDIwithMatType.[ExternalSalesAgent]
    ,   BDIwithMatType.[ProjectID]
    ,   BDIwithMatType.[Project]
    ,   BDIwithMatType.[SalesEmployeeID]
    ,   BDIwithMatType.[SalesEmployee]
    ,   BDIwithMatType.[GlobalParentID]
    ,   BDIwithMatType.[GlobalParent]
    ,   BDIwithMatType.[GlobalParentCalculatedID]
    ,   BDIwithMatType.[GlobalParentCalculated]
    ,   BDIwithMatType.[LocalParentID]
    ,   BDIwithMatType.[LocalParent]
    ,   BDIwithMatType.[LocalParentCalculatedID]
    ,   BDIwithMatType.[LocalParentCalculated]
    ,   BDIwithMatType.[SalesOrderTypeID]
    ,   BDIwithMatType.[BillToID]
    ,   BDIwithMatType.[BillTo]
    ,   BDIwithMatType.[AccountingDate]
    ,   BDIwithMatType.[MaterialCalculated]
    ,   BDIwithMatType.[SoldToPartyCalculated]
    ,   BDIwithMatType.[InOutID]
    ,   BDIwithMatType.[t_applicationId]
    ,   BDIwithMatType.[t_extractionDtm]
    ,   BDIwithMatType.[t_lastActionBy]
    ,   BDIwithMatType.[t_lastActionCd]
    ,   BDIwithMatType.[t_lastActionDtm]
    ,   BDIwithMatType.[t_filePath]          
    ,   BDexclZVERandZSER.FinNetAmountSumBD
    ,   BDwithZVER.NetAmountZVER
    ,   BDwithZSER.NetAmountZSER
    ,   ISNULL(BDwithFreight.NetAmountFreight,0) AS NetAmountFreight
    ,   ISNULL(BDwithMinQty.NetAmountMinQty,0) AS NetAmountMinQty
    ,   BDwithEngServ.NetAmountEngServ
    ,   BDwithMisc.NetAmountMisc
    ,   BDwithServOther.NetAmountServOther
    ,   BDwithConditionAmountFreight.ConditionAmountFreight
    ,   BDwithConditionAmountMinQty.ConditionAmountMinQty
--  ,   BDwithZVER.NetAmountZVER -- MPS 2021/11/04: removed as NetAmountZVER same as NetAmountVerp
    FROM 
        BDIwithMatType
    LEFT JOIN
        BDwithFreight
        ON
            BDIwithMatType.BillingDocument = BDwithFreight.BillingDocument
            AND
            BDIwithMatType.CurrencyTypeID = BDwithFreight.CurrencyTypeID
    LEFT JOIN
        BDwithMinQty
        ON
            BDIwithMatType.BillingDocument = BDwithMinQty.BillingDocument
            AND
            BDIwithMatType.CurrencyTypeID = BDwithMinQty.CurrencyTypeID
    LEFT JOIN
        BDwithEngServ
        ON
            BDIwithMatType.BillingDocument = BDwithEngServ.BillingDocument
            AND
            BDIwithMatType.CurrencyTypeID = BDwithEngServ.CurrencyTypeID
    LEFT JOIN
        BDwithMisc
        ON
            BDIwithMatType.BillingDocument = BDwithMisc.BillingDocument
            AND
            BDIwithMatType.CurrencyTypeID = BDwithMisc.CurrencyTypeID
    LEFT JOIN
        BDwithServOther
        ON
            BDIwithMatType.BillingDocument = BDwithServOther.BillingDocument
            AND
            BDIwithMatType.CurrencyTypeID = BDwithServOther.CurrencyTypeID
    -- LEFT JOIN
    --     BDwithVerp
    --     ON
    --         BDIwithMatType.BillingDocument = BDwithVerp.BillingDocument
    --         AND
    --         BDIwithMatType.CurrencyTypeID = BDwithVerp.CurrencyTypeID
    LEFT JOIN
        BDwithZVER
        ON
            BDIwithMatType.BillingDocument = BDwithZVER.BillingDocument
            AND
            BDIwithMatType.CurrencyTypeID = BDwithZVER.CurrencyTypeID
    LEFT JOIN
        BDwithZSER
        ON
            BDIwithMatType.BillingDocument = BDwithZSER.BillingDocument
            AND
            BDIwithMatType.CurrencyTypeID = BDwithZSER.CurrencyTypeID
    LEFT JOIN
        BDexclZVERandZSER
        ON
            BDIwithMatType.BillingDocument = BDexclZVERandZSER.BillingDocument
            AND
            BDIwithMatType.CurrencyTypeID = BDexclZVERandZSER.CurrencyTypeID
    LEFT JOIN
        BDwithConditionAmountFreight
        ON 
            BDIwithMatType.BillingDocument = BDwithConditionAmountFreight.BillingDocument
            AND            
            BDIwithMatType.BillingDocumentItem = BDwithConditionAmountFreight.BillingDocumentItem
            AND
            BDIwithMatType.CurrencyTypeID = BDwithConditionAmountFreight.CurrencyTypeID
    LEFT JOIN
        BDwithConditionAmountMinQty
        ON 
            BDIwithMatType.BillingDocument = BDwithConditionAmountMinQty.BillingDocument
            AND            
            BDIwithMatType.BillingDocumentItem = BDwithConditionAmountMinQty.BillingDocumentItem
            AND
            BDIwithMatType.CurrencyTypeID = BDwithConditionAmountMinQty.CurrencyTypeID
)
,BDIFinancials AS (
    SELECT 
        [BillingDocument]
    ,   [BillingDocumentItem]
    ,   [MaterialTypeID]
    ,   [CurrencyTypeID]
    ,   [CurrencyType]
    ,   [CurrencyID]
    ,   [ExchangeRate]
    ,   [SalesDocumentItemCategoryID]
    ,   [SalesDocumentItemTypeID]
    ,   [ReturnItemProcessingType]
    ,   [BillingDocumentTypeID]
    ,   [BillingDocumentCategoryID]
    ,   [SDDocumentCategoryID]
    ,   [CreationDate]
    ,   [CreationTime]
    ,   [LastChangeDate]
    ,   [BillingDocumentDate]
    ,   [BillingDocumentIsTemporary]
    ,   [OrganizationDivision]
    ,   [Division]
    ,   [SalesOfficeID]
    ,   [SalesOrganizationID]
    ,   [DistributionChannelID]
    ,   [Material]
    ,   [ProductSurrogateKey]
    ,   [OriginallyRequestedMaterial]
    ,   [InternationalArticleNumber]
    ,   [PricingReferenceMaterial]
    ,   [LengthInMPer1]
    ,   [LengthInM]
    ,   [Batch]
    ,   [MaterialGroupID]
    ,   [BrandID]    
    ,   [AdditionalMaterialGroup2]
    ,   [AdditionalMaterialGroup3]
    ,   [AdditionalMaterialGroup4]
    ,   [AdditionalMaterialGroup5]
    ,   [MaterialCommissionGroup]
    ,   [PlantID]
    ,   [StorageLocationID]
    ,   [BillingDocumentIsCancelled]
    ,   [CancelledBillingDocument]
    ,   [CancelledInvoiceEffect]
    ,   [BillingDocumentItemText]
    ,   [ServicesRenderedDate]
    ,   [BillingQuantity]
    ,   [BillingQuantityUnitID]
    ,   [BillingQuantityInBaseUnit]
    ,   [BaseUnit]
    ,   [MRPRequiredQuantityInBaseUnit]
    ,   [BillingToBaseQuantityDnmntr]
    ,   [BillingToBaseQuantityNmrtr]
    ,   [ItemGrossWeight]
    ,   [ItemNetWeight]
    ,   [ItemWeightUnit]
    ,   [ItemVolume]
    ,   [ItemVolumeUnit]
    ,   [BillToPartyCountry]
    ,   [BillToPartyRegion]
    ,   [BillingPlanRule]
    ,   [BillingPlan]
    ,   [BillingPlanItem]
    ,   [CustomerPriceGroupID]
    ,   [PriceListTypeID]
    ,   [TaxDepartureCountry]
    ,   [VATRegistration]
    ,   [VATRegistrationCountry]
    ,   [VATRegistrationOrigin]
    ,   [CustomerTaxClassification1]
    ,   [CustomerTaxClassification2]
    ,   [CustomerTaxClassification3]
    ,   [CustomerTaxClassification4]
    ,   [CustomerTaxClassification5]
    ,   [CustomerTaxClassification6]
    ,   [CustomerTaxClassification7]
    ,   [CustomerTaxClassification8]
    ,   [CustomerTaxClassification9]
    ,   [SDPricingProcedure]
    ,   [NetAmount]
    ,   [TransactionCurrencyID]
    ,   [GrossAmount]
    ,   [PricingDate]
    ,   [PriceDetnExchangeRate]
    ,   [PricingScaleQuantityInBaseUnit]
    ,   [TaxAmount]
    ,   [CostAmount]
    ,   [ProfitMargin]
    ,   [MarginPercent]
    ,   [Subtotal1Amount]
    ,   [Subtotal2Amount]
    ,   [Subtotal3Amount]
    ,   [Subtotal4Amount]
    ,   [Subtotal5Amount]
    ,   [Subtotal6Amount]
    ,   [StatisticalValueControl]
    ,   [StatisticsExchangeRate]
    ,   [StatisticsCurrency]
    ,   [SalesOrganizationCurrency]
    ,   [EligibleAmountForCashDiscount]
    ,   [ContractAccount]
    ,   [CustomerPaymentTerms]
    ,   [PaymentMethod]
    ,   [PaymentReference]
    ,   [FixedValueDate]
    ,   [AdditionalValueDays]
    ,   [PayerParty]
    ,   [CompanyCode]
    ,   [FiscalYear]
    ,   [FiscalPeriod]
    ,   [CustomerAccountAssignmentGroupID]
    ,   [BusinessArea]
    ,   [ProfitCenter]
    ,   [OrderID]
    ,   [ControllingArea]
    ,   [ProfitabilitySegment]
    ,   [CostCenter]
    ,   [OriginSDDocument]
    ,   [OriginSDDocumentItem]
    ,   [PriceDetnExchangeRateDate]
    ,   [ExchangeRateTypeID]
    ,   [FiscalYearVariant]
    ,   [CompanyCodeCurrencyID]
    ,   [AccountingExchangeRate]
    ,   [AccountingExchangeRateIsSet]
    ,   [ReferenceSDDocument]
    ,   [ReferenceSDDocumentItem]
    ,   [ReferenceSDDocumentCategoryID]
    ,   [SalesDocumentID]
    ,   [SalesDocumentItemID]
    ,   [SalesSDDocumentCategoryID]
    ,   [HigherLevelItem]
    ,   [BillingDocumentItemInPartSgmt]
    ,   [SalesGroup]
    ,   [AdditionalCustomerGroup1]
    ,   [AdditionalCustomerGroup2]
    ,   [AdditionalCustomerGroup3]
    ,   [AdditionalCustomerGroup4]
    ,   [AdditionalCustomerGroup5]
    ,   [SDDocumentReasonID]
    ,   [ItemIsRelevantForCredit]
    ,   [CreditRelatedPrice]
    ,   [SalesDistrictID]
    ,   [CustomerGroupID]
    ,   [SoldToParty]
    ,   [CountryID]
    ,   [ShipToParty]
    ,   [BillToParty]
    ,   [ShippingPoint]
    ,   [IncotermsVersion]
    ,   [IncotermsClassification]
    ,   [IncotermsTransferLocation]
    ,   [IncotermsLocation1]
    ,   [IncotermsLocation2]
    ,   [ShippingCondition]
    ,   [QuantitySold]
    ,   [GrossMargin]
    ,   [ExternalSalesAgentID]
    ,   [ExternalSalesAgent]
    ,   [ProjectID]
    ,   [Project]
    ,   [SalesEmployeeID]
    ,   [SalesEmployee]
    ,   [GlobalParentID]
    ,   [GlobalParent]
    ,   [GlobalParentCalculatedID]
    ,   [GlobalParentCalculated]
    ,   [LocalParentID]
    ,   [LocalParent]
    ,   [LocalParentCalculatedID]
    ,   [LocalParentCalculated]
    ,   [SalesOrderTypeID]
    ,   [BillToID]
    ,   [BillTo]
    ,   CASE
            WHEN [MaterialTypeID] NOT IN ('ZSER', 'ZVER')
            THEN [NetAmount] - [ConditionAmountFreight] - [ConditionAmountMinQty]
            ELSE NULL
        END AS [FinNetAmountRealProduct]
    ,   CASE
            WHEN
                [FinNetAmountSumBD] != 0
                AND
                [MaterialTypeID] NOT IN ('ZVER', 'ZSER')
            THEN 
                ([NetAmount] / [FinNetAmountSumBD] * NetAmountFreight) + [ConditionAmountFreight]
            ELSE NULL
        END AS [FinNetAmountFreight]
    ,   CASE
            WHEN
                [FinNetAmountSumBD] != 0
                AND
                [MaterialTypeID] NOT IN ('ZVER', 'ZSER')
            THEN 
                ([NetAmount] / [FinNetAmountSumBD] * NetAmountMinQty) + [ConditionAmountMinQty]
            ELSE 
                NULL
        END AS [FinNetAmountMinQty]
    ,   CASE
            WHEN
                [FinNetAmountSumBD] != 0
                AND
                [MaterialTypeID] NOT IN ('ZVER', 'ZSER')
            THEN
                [NetAmount] / [FinNetAmountSumBD] * NetAmountEngServ
            ELSE
                NULL
        END AS [FinNetAmountEngServ]
    ,   CASE
            WHEN
                [FinNetAmountSumBD] != 0
                AND
                [MaterialTypeID] NOT IN ('ZVER', 'ZSER')
            THEN
                [NetAmount] / [FinNetAmountSumBD] * NetAmountMisc
            ELSE
                NULL
        END AS [FinNetAmountMisc]
    ,   CASE
            WHEN
                [FinNetAmountSumBD] != 0
                AND
                [MaterialTypeID] NOT IN ('ZVER', 'ZSER')
            THEN 
                [NetAmount] / [FinNetAmountSumBD] * NetAmountServOther
            ELSE
                NULL
        END AS [FinNetAmountServOther]
    ,   CASE
            WHEN [FinNetAmountSumBD] != 0
            THEN [NetAmount] / [FinNetAmountSumBD] * NetAmountZVER
            ELSE NULL
        END AS [FinNetAmountVerp]
    ,   [AccountingDate]
    ,   [MaterialCalculated]
    ,   [SoldToPartyCalculated]
    ,   [InOutID]
    ,   [t_applicationId]
    ,   [t_extractionDtm]
    ,   [t_lastActionBy]
    ,   [t_lastActionCd]
    ,   [t_lastActionDtm]
    ,   [t_filePath]      
    
    FROM 
        BDITotals
)
,BDIZZZDUMMY AS (
/*
    Generate additional records for documents that consist of [MaterialTypeID] = 'ZSER' or 'ZVER' only
*/
    SELECT 
        [BillingDocument]
    ,   STUFF([BillingDocumentItem], 1, 1, 'Z') + '0' AS [BillingDocumentItem]
    ,   NULL AS [MaterialTypeID] --MPS 2021/11/04 MaterialTypeID is not used in output but required for UNION
    ,   [CurrencyTypeID]
    ,   [CurrencyType]
    ,   [CurrencyID]
    ,   [ExchangeRate]
    ,   [SalesDocumentItemCategoryID]
    ,   [SalesDocumentItemTypeID]
    ,   [ReturnItemProcessingType]
    ,   [BillingDocumentTypeID]
    ,   [BillingDocumentCategoryID]
    ,   [SDDocumentCategoryID]
    ,   [CreationDate]
    ,   [CreationTime]
    ,   [LastChangeDate]
    ,   [BillingDocumentDate]
    ,   [BillingDocumentIsTemporary]
    ,   [OrganizationDivision]
    ,   [Division]
    ,   [SalesOfficeID]
    ,   [SalesOrganizationID]
    ,   [DistributionChannelID]
    ,   'ZZZDUMMY02' AS [Material]
    ,   'ZZZDUMMY02' AS [ProductSurrogateKey]
    ,   [OriginallyRequestedMaterial]
    ,   [InternationalArticleNumber]
    ,   [PricingReferenceMaterial]
    ,   [LengthInMPer1]
    ,   [LengthInM]
    ,   [Batch]
    ,   [MaterialGroupID]
    ,   [BrandID]
    ,   [AdditionalMaterialGroup2]
    ,   [AdditionalMaterialGroup3]
    ,   [AdditionalMaterialGroup4]
    ,   [AdditionalMaterialGroup5]
    ,   [MaterialCommissionGroup]
    ,   [PlantID]
    ,   [StorageLocationID]
    ,   [BillingDocumentIsCancelled]
    ,   [CancelledBillingDocument]
    ,   [CancelledInvoiceEffect]
    ,   [BillingDocumentItemText]
    ,   [ServicesRenderedDate]
    ,   [BillingQuantity]
    ,   [BillingQuantityUnitID]
    ,   [BillingQuantityInBaseUnit]
    ,   [BaseUnit]
    ,   [MRPRequiredQuantityInBaseUnit]
    ,   [BillingToBaseQuantityDnmntr]
    ,   [BillingToBaseQuantityNmrtr]
    ,   [ItemGrossWeight]
    ,   [ItemNetWeight]
    ,   [ItemWeightUnit]
    ,   [ItemVolume]
    ,   [ItemVolumeUnit]
    ,   [BillToPartyCountry]
    ,   [BillToPartyRegion]
    ,   [BillingPlanRule]
    ,   [BillingPlan]
    ,   [BillingPlanItem]
    ,   [CustomerPriceGroupID]
    ,   [PriceListTypeID]
    ,   [TaxDepartureCountry]
    ,   [VATRegistration]
    ,   [VATRegistrationCountry]
    ,   [VATRegistrationOrigin]
    ,   [CustomerTaxClassification1]
    ,   [CustomerTaxClassification2]
    ,   [CustomerTaxClassification3]
    ,   [CustomerTaxClassification4]
    ,   [CustomerTaxClassification5]
    ,   [CustomerTaxClassification6]
    ,   [CustomerTaxClassification7]
    ,   [CustomerTaxClassification8]
    ,   [CustomerTaxClassification9]
    ,   [SDPricingProcedure]
    ,   NULL AS [NetAmount]
    ,   [TransactionCurrencyID]
    ,   [GrossAmount]
    ,   [PricingDate]
    ,   [PriceDetnExchangeRate]
    ,   [PricingScaleQuantityInBaseUnit]
    ,   [TaxAmount]
    ,   [CostAmount]
    ,   [ProfitMargin]
    ,   [MarginPercent]
    ,   [Subtotal1Amount]
    ,   [Subtotal2Amount]
    ,   [Subtotal3Amount]
    ,   [Subtotal4Amount]
    ,   [Subtotal5Amount]
    ,   [Subtotal6Amount]
    ,   [StatisticalValueControl]
    ,   [StatisticsExchangeRate]
    ,   [StatisticsCurrency]
    ,   [SalesOrganizationCurrency]
    ,   [EligibleAmountForCashDiscount]
    ,   [ContractAccount]
    ,   [CustomerPaymentTerms]
    ,   [PaymentMethod]
    ,   [PaymentReference]
    ,   [FixedValueDate]
    ,   [AdditionalValueDays]
    ,   [PayerParty]
    ,   [CompanyCode]
    ,   [FiscalYear]
    ,   [FiscalPeriod]
    ,   [CustomerAccountAssignmentGroupID]
    ,   [BusinessArea]
    ,   [ProfitCenter]
    ,   [OrderID]
    ,   [ControllingArea]
    ,   [ProfitabilitySegment]
    ,   [CostCenter]
    ,   [OriginSDDocument]
    ,   [OriginSDDocumentItem]
    ,   [PriceDetnExchangeRateDate]
    ,   [ExchangeRateTypeID]
    ,   [FiscalYearVariant]
    ,   [CompanyCodeCurrencyID]
    ,   [AccountingExchangeRate]
    ,   [AccountingExchangeRateIsSet]
    ,   [ReferenceSDDocument]
    ,   [ReferenceSDDocumentItem]
    ,   [ReferenceSDDocumentCategoryID]
    ,   [SalesDocumentID]
    ,   [SalesDocumentItemID]
    ,   [SalesSDDocumentCategoryID]
    ,   [HigherLevelItem]
    ,   [BillingDocumentItemInPartSgmt]
    ,   [SalesGroup]
    ,   [AdditionalCustomerGroup1]
    ,   [AdditionalCustomerGroup2]
    ,   [AdditionalCustomerGroup3]
    ,   [AdditionalCustomerGroup4]
    ,   [AdditionalCustomerGroup5]
    ,   [SDDocumentReasonID]
    ,   [ItemIsRelevantForCredit]
    ,   [CreditRelatedPrice]
    ,   [SalesDistrictID]
    ,   [CustomerGroupID]
    ,   [SoldToParty]
    ,   [CountryID]
    ,   [ShipToParty]
    ,   [BillToParty]
    ,   [ShippingPoint]
    ,   [IncotermsVersion]
    ,   [IncotermsClassification]
    ,   [IncotermsTransferLocation]
    ,   [IncotermsLocation1]
    ,   [IncotermsLocation2]
    ,   [ShippingCondition]
    ,   [QuantitySold]
    ,   [GrossMargin]
    ,   [ExternalSalesAgentID]
    ,   [ExternalSalesAgent]
    ,   [ProjectID]
    ,   [Project]
    ,   [SalesEmployeeID]
    ,   [SalesEmployee]
    ,   [GlobalParentID]
    ,   [GlobalParent]
    ,   [GlobalParentCalculatedID]
    ,   [GlobalParentCalculated]
    ,   [LocalParentID]
    ,   [LocalParent]
    ,   [LocalParentCalculatedID]
    ,   [LocalParentCalculated]
    ,   [SalesOrderTypeID]
    ,   [BillToID]
    ,   [BillTo]
    ,   NULL AS [FinNetAmountRealProduct]
    ,   NULL AS [FinNetAmountFreight]
    ,   NULL AS [FinNetAmountMinQty]
    ,   NULL AS [FinNetAmountEngServ]
    ,   NULL AS [FinNetAmountMisc]
    ,   CASE
            WHEN
                MaterialTypeID = 'ZSER'
            THEN
                NetAmount
        END AS [FinNetAmountServOther]
    ,   CASE
            WHEN
                MaterialTypeID = 'ZVER'
            THEN
                NetAmount
        END AS [FinNetAmountVerp]
    ,   [AccountingDate]
    ,   'ZZZDUMMY02' AS [MaterialCalculated]
    ,   [SoldToPartyCalculated]
    ,   [InOutID]
    ,   [t_applicationId]
    ,   [t_extractionDtm]
    ,   [t_lastActionBy]
    ,   [t_lastActionCd]
    ,   [t_lastActionDtm]
    ,   [t_filePath]      
    FROM 
        BDIwithMatType
    WHERE 
        [BillingDocument] NOT IN (
            SELECT
                [BillingDocument]
            FROM 
                BDexclZVERandZSER
        )
)
,BDIFinancialsZZZDUMMY AS (
    SELECT *
    FROM BDIFinancials

    UNION ALL 

    SELECT *
    FROM BDIZZZDUMMY
)
,BDIFinancialsZZZDUMMYAndOtherSales AS (
    /*
     calculate the FinNetAmountOtherSales
     */
    SELECT 
        BDIFinancialsZZZDUMMY.*
    ,   (
            COALESCE([FinNetAmountEngServ], 0) +
            COALESCE([FinNetAmountFreight], 0) +
            COALESCE([FinNetAmountMinQty], 0) +
            COALESCE([FinNetAmountMisc], 0) +
            COALESCE([FinNetAmountServOther], 0) +
            COALESCE([FinNetAmountVerp], 0)
        ) AS FinNetAmountOtherSales
    FROM 
        BDIFinancialsZZZDUMMY
)
,FinRebateAccrual AS (
    SELECT 
        BDI.BillingDocument
    ,   BDI.BillingDocumentItem
    ,   BDI.CurrencyTypeID
    ,   BDI.CurrencyID
    ,   BDI.ExchangeRate
    ,   SUM(BDIPE.ConditionAmount) AS ConditionAmount -- ???
    ,   BDIPE.ConditionCurrency
    ,   CASE
            WHEN
                BDIPE.ConditionCurrency <> '' -- TODO (2021/08/19), ConditionCurrency is always empty string ('')
                AND
                BDIPE.ConditionCurrency <> BDI.CurrencyID
            THEN
                SUM(BDIPE.ConditionAmount) * BDI.ExchangeRate
            ELSE
                SUM(BDIPE.ConditionAmount)
        END AS FinRebateAccrual
    FROM 
        BDIwithMatType BDI
    LEFT JOIN
        [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] BDIPE
        ON
            BDI.[BillingDocument] = BDIPE.[BillingDocument]
            AND
            BDI.[BillingDocumentItem] = BDIPE.[BillingDocumentItem]
            AND
            BDIPE.[ConditionType] = 'REA1'
    GROUP BY 
        BDI.BillingDocument
    ,   BDI.BillingDocumentItem
    ,   BDI.CurrencyTypeID
    ,   BDI.CurrencyID
    ,   BDI.ExchangeRate
    ,   BDIPE.ConditionCurrency
)

SELECT
    [BillingDocument]
,   [BillingDocumentItem]
,   [CurrencyTypeID]
,   [CurrencyType]
,   [CurrencyID]
,   [ExchangeRate]
,   [SalesDocumentItemCategoryID]
,   [SalesDocumentItemTypeID]
,   [ReturnItemProcessingType]
,   [BillingDocumentTypeID]
,   [BillingDocumentCategoryID]
,   [SDDocumentCategoryID]
,   [CreationDate]
,   [CreationTime]
,   [LastChangeDate]
,   [BillingDocumentDate]
,   [BillingDocumentIsTemporary]
,   [OrganizationDivision]
,   [Division]
,   [SalesOfficeID]
,   [SalesOrganizationID]
,   [DistributionChannelID]
,   [Material]
,   [ProductSurrogateKey]
,   [OriginallyRequestedMaterial]
,   [InternationalArticleNumber]
,   [PricingReferenceMaterial]
,   [LengthInMPer1]
,   [LengthInM]
,   [Batch]
,   [MaterialGroupID]
,   [BrandID]
,   [AdditionalMaterialGroup2]
,   [AdditionalMaterialGroup3]
,   [AdditionalMaterialGroup4]
,   [AdditionalMaterialGroup5]
,   [MaterialCommissionGroup]
,   [PlantID]
,   [StorageLocationID]
,   [BillingDocumentIsCancelled]
,   [CancelledBillingDocument]
,   [CancelledInvoiceEffect]
,   [BillingDocumentItemText]
,   [ServicesRenderedDate]
,   [BillingQuantity]
,   [BillingQuantityUnitID]
,   [BillingQuantityInBaseUnit]
,   [BaseUnit]
,   [MRPRequiredQuantityInBaseUnit]
,   [BillingToBaseQuantityDnmntr]
,   [BillingToBaseQuantityNmrtr]
,   [ItemGrossWeight]
,   [ItemNetWeight]
,   [ItemWeightUnit]
,   [ItemVolume]
,   [ItemVolumeUnit]
,   [BillToPartyCountry]
,   [BillToPartyRegion]
,   [BillingPlanRule]
,   [BillingPlan]
,   [BillingPlanItem]
,   [CustomerPriceGroupID]
,   [PriceListTypeID]
,   [TaxDepartureCountry]
,   [VATRegistration]
,   [VATRegistrationCountry]
,   [VATRegistrationOrigin]
,   [CustomerTaxClassification1]
,   [CustomerTaxClassification2]
,   [CustomerTaxClassification3]
,   [CustomerTaxClassification4]
,   [CustomerTaxClassification5]
,   [CustomerTaxClassification6]
,   [CustomerTaxClassification7]
,   [CustomerTaxClassification8]
,   [CustomerTaxClassification9]
,   [SDPricingProcedure]
,   [NetAmount]
,   [TransactionCurrencyID]
,   [GrossAmount]
,   [PricingDate]
,   [PriceDetnExchangeRate]
,   [PricingScaleQuantityInBaseUnit]
,   [TaxAmount]
,   [CostAmount]
,   [ProfitMargin]
,   [MarginPercent]
,   [Subtotal1Amount]
,   [Subtotal2Amount]
,   [Subtotal3Amount]
,   [Subtotal4Amount]
,   [Subtotal5Amount]
,   [Subtotal6Amount]
,   [StatisticalValueControl]
,   [StatisticsExchangeRate]
,   [StatisticsCurrency]
,   [SalesOrganizationCurrency]
,   [EligibleAmountForCashDiscount]
,   [ContractAccount]
,   [CustomerPaymentTerms]
,   [PaymentMethod]
,   [PaymentReference]
,   [FixedValueDate]
,   [AdditionalValueDays]
,   [PayerParty]
,   [CompanyCode]
,   [FiscalYear]
,   [FiscalPeriod]
,   [CustomerAccountAssignmentGroupID]
,   [BusinessArea]
,   [ProfitCenter]
,   [OrderID]
,   [ControllingArea]
,   [ProfitabilitySegment]
,   [CostCenter]
,   [OriginSDDocument]
,   [OriginSDDocumentItem]
,   [PriceDetnExchangeRateDate]
,   [ExchangeRateTypeID]
,   [FiscalYearVariant]
,   [CompanyCodeCurrencyID]
,   [AccountingExchangeRate]
,   [AccountingExchangeRateIsSet]
,   [ReferenceSDDocument]
,   [ReferenceSDDocumentItem]
,   [ReferenceSDDocumentCategoryID]
,   [SalesDocumentID]
,   [SalesDocumentItemID]
,   [SalesSDDocumentCategoryID]
,   [HigherLevelItem]
,   [BillingDocumentItemInPartSgmt]
,   [SalesGroup]
,   [AdditionalCustomerGroup1]
,   [AdditionalCustomerGroup2]
,   [AdditionalCustomerGroup3]
,   [AdditionalCustomerGroup4]
,   [AdditionalCustomerGroup5]
,   [SDDocumentReasonID]
,   [ItemIsRelevantForCredit]
,   [CreditRelatedPrice]
,   [SalesDistrictID]
,   [CustomerGroupID]
,   [SoldToParty]
,   [CountryID]
,   [ShipToParty]
,   [BillToParty]
,   [ShippingPoint]
,   [IncotermsVersion]
,   [IncotermsClassification]
,   [IncotermsTransferLocation]
,   [IncotermsLocation1]
,   [IncotermsLocation2]
,   [ShippingCondition]
,   [QuantitySold]
,   [GrossMargin]
,   [ExternalSalesAgentID]
,   [ExternalSalesAgent]
,   [ProjectID]
,   [Project]
,   [SalesEmployeeID]
,   [SalesEmployee]
,   [GlobalParentID]
,   [GlobalParent]
,   [GlobalParentCalculatedID]
,   [GlobalParentCalculated]
,   [LocalParentID]
,   [LocalParent]
,   [LocalParentCalculatedID]
,   [LocalParentCalculated]
,   [SalesOrderTypeID]
,   [BillToID]
,   [BillTo]
,   COALESCE([FinNetAmountRealProduct], 0)               as [FinNetAmountRealProduct]
,   COALESCE([FinNetAmountFreight], 0)                   as [FinNetAmountFreight]
,   COALESCE([FinNetAmountMinQty], 0)                    as [FinNetAmountMinQty]
,   COALESCE([FinNetAmountEngServ], 0)                   as [FinNetAmountEngServ]
,   COALESCE([FinNetAmountMisc], 0)                      as [FinNetAmountMisc]
,   COALESCE([FinNetAmountServOther], 0)                 as [FinNetAmountServOther]
,   COALESCE([FinNetAmountVerp], 0)                      as [FinNetAmountVerp]
,   COALESCE([FinRebateAccrual], 0)                      as [FinRebateAccrual]
,   COALESCE([PaymentTermCashDiscountPercentageRate], 0) as [PaymentTermCashDiscountPercentageRate]
,   COALESCE([FinNetAmountOtherSales], 0)                as [FinNetAmountOtherSales]
,   COALESCE([FinReserveCashDiscount], 0)                as [FinReserveCashDiscount]
,   COALESCE([FinNetAmountAllowances], 0)                as [FinNetAmountAllowances]
,   (
        COALESCE(subQ_FinNetAmountAllowances.[FinNetAmountRealProduct], 0) +
        COALESCE(FinNetAmountOtherSales, 0) +
        COALESCE(FinNetAmountAllowances, 0)
    ) AS FinSales100
,   [AccountingDate]
,   [MaterialCalculated]
,   [SoldToPartyCalculated]
,   [InOutID]
,   [t_applicationId]
,   [t_extractionDtm]
,   [t_lastActionBy]
,   [t_lastActionCd]
,   [t_lastActionDtm]
,   [t_filePath]      

FROM (
    SELECT
        subQ_FinReserveCashDiscount.*
    ,   (
            COALESCE([FinReserveCashDiscount], 0) +
            COALESCE([FinRebateAccrual], 0)
        ) AS FinNetAmountAllowances
    FROM (
        SELECT
            subQ_FinNetAmountOtherSales.*
        ,   (
                COALESCE(subQ_FinNetAmountOtherSales.[FinNetAmountRealProduct], 0) +
                COALESCE(subQ_FinNetAmountOtherSales.[FinNetAmountOtherSales], 0)
            ) * COALESCE([PaymentTermCashDiscountPercentageRate], 0) *.01 *(-1) AS [FinReserveCashDiscount]
        FROM (
            /*
             Calculate for the concatenated data the values of the fields in PaymentTermCashDiscountPercentageRate and FinRebateAccrual
             */
            SELECT
                BDIFinancialsZZZDUMMYAndOtherSales.*
            ,   [PaymentTermCashDiscountPercentageRate] = (
                    SELECT TOP (1) [CashDiscount1Percent]
                    FROM [base_s4h_cax].[I_PaymentTermsConditions]
                    WHERE [PaymentTerms] COLLATE Latin1_General_100_BIN2 = BDIFinancialsZZZDUMMYAndOtherSales.[CustomerPaymentTerms]
                    ORDER BY PaymentTermsValidityMonthDay
                )
            ,   FinRebateAccrual.FinRebateAccrual
            FROM 
                BDIFinancialsZZZDUMMYAndOtherSales
            LEFT JOIN
                FinRebateAccrual
            ON
                BDIFinancialsZZZDUMMYAndOtherSales.BillingDocument = FinRebateAccrual.BillingDocument
                AND
                BDIFinancialsZZZDUMMYAndOtherSales.CurrencyTypeID = FinRebateAccrual.CurrencyTypeID
                AND
                BDIFinancialsZZZDUMMYAndOtherSales.BillingDocumentItem = FinRebateAccrual.BillingDocumentItem

        ) subQ_FinNetAmountOtherSales
    ) subQ_FinReserveCashDiscount
) subQ_FinNetAmountAllowances