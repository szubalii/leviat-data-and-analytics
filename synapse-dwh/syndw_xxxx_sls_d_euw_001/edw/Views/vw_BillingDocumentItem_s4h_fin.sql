CREATE VIEW [edw].[vw_BillingDocumentItem_s4h_fin]
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
        BDI.[nk_fact_BillingDocumentItem]
    ,   BDI.[BillingDocument]
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
    ,   edw.svf_get2PartNaturalKey (BDI.Material,BDI.PlantID) AS [nk_ProductPlant]
    ,   COALESCE(VC.[ProductSurrogateKey],Product.[ProductID]) AS [ProductSurrogateKey]
    ,   BDI.[OriginallyRequestedMaterial]
    ,   BDI.[InternationalArticleNumber]
    ,   BDI.[PricingReferenceMaterial]
    ,   BDI.[LengthInMPer1]
    ,   BDI.[LengthInM]
    ,   BDI.[Batch]
    ,   BDI.[MaterialGroupID]
    ,   BDI.[BrandID]
    ,   BDI.[Brand]
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
    ,   BDI.[ICSalesDocumentID]
    ,   BDI.[ICSalesDocumentItemID]
    ,   BDI.[t_applicationId]
    ,   BDI.[t_extractionDtm]
    FROM 
        [edw].[vw_BillingDocumentItem_s4h] BDI
    LEFT JOIN
        Product
        ON
            BDI.[Material] = Product.[ProductID]
    LEFT JOIN
        [edw].[vw_ProductHierarchyVariantConfigCharacteristic] AS VC
           ON VC.SalesDocument =
            CASE
               WHEN BDI.SalesSDDocumentCategoryID='V'
                   THEN  BDI.ICSalesDocumentID         COLLATE DATABASE_DEFAULT
               ELSE BDI.SalesDocumentID
               END 
        and VC.SalesDocumentItem =
            CASE
               WHEN BDI.SalesSDDocumentCategoryID='V'
                   THEN  BDI.ICSalesDocumentItemID 
               ELSE BDI.SalesDocumentItemID 
               END    
    WHERE BDI.[Material]<>'000000000070000019'
),

CTE_BDIPE_ZF20 AS (
    SELECT 
            BDIPE_ZF20.[BillingDocument]
        ,   BDIPE_ZF20.[BillingDocumentItem]
        ,   BDIPE_ZF20.[PricingProcedureCounter]
        ,   BDIPE_ZF20.[PricingProcedureStep]
        ,   BDIPE_ZF20.[ConditionAmount]
    FROM
        [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] BDIPE_ZF20  
    WHERE 
        BDIPE_ZF20.[ConditionType] = 'ZF20'
        AND
        BDIPE_ZF20.ConditionInactiveReason = ''
),
CTE_BDIPE AS(
    SELECT
        BDIPE.BillingDocument
       ,    BDIPE.BillingDocumentItem
       ,    sum(BDIPE.ConditionAmount) as ConditionAmountFreight
    FROM 
        [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] AS BDIPE
    LEFT JOIN 
        CTE_BDIPE_ZF20 AS BDIPE_ZF20
            ON 
                BDIPE.[BillingDocument] = BDIPE_ZF20.[BillingDocument]
                AND
                BDIPE.[BillingDocumentItem] = BDIPE_ZF20.[BillingDocumentItem]
                AND
                BDIPE.[PricingProcedureCounter] = BDIPE_ZF20.[PricingProcedureCounter]
                AND
                BDIPE.[PricingProcedureStep] = BDIPE_ZF20.[PricingProcedureStep]
    WHERE 
        BDIPE.ConditionInactiveReason = ''
        AND
        (
            (BDIPE_ZF20.[BillingDocument] IS NOT NULL 
            AND
            BDIPE.[ConditionType] IN ('ZF60', 'ZF20', 'ZTMF', 'ZM40')
            )
            OR 
            (
            (BDIPE_ZF20.[BillingDocument] IS NULL OR BDIPE_ZF20.ConditionAmount=0) 
            AND
            BDIPE.[ConditionType] IN ('ZF60', 'ZTMF', 'ZF10', 'ZM40')
            )
        )
    GROUP BY 
        BDIPE.BillingDocument,
        BDIPE.BillingDocumentItem
)
, BDItemZSERAndConditions AS (
    SELECT 
        BDIwithMatType.[BillingDocument]
    ,   BDIwithMatType.[BillingDocumentItem]
    ,   BDIwithMatType.CurrencyTypeID
    ,   CASE
            WHEN
                mbdi.[FinNetAmountColumnName] = 'FinNetAmountFreight'
            THEN NetAmount 
        END AS NetAmountFreight
    ,   CASE
            WHEN
                mbdi.[FinNetAmountColumnName] = 'FinNetAmountMinQty'
            THEN NetAmount 
        END AS NetAmountMinQty
    ,   CASE
            WHEN
                mbdi.[FinNetAmountColumnName] = 'FinNetAmountEngServ'
            THEN NetAmount 
        END AS NetAmountEngServ
    ,   CASE
            WHEN
                mbdi.[FinNetAmountColumnName] = 'FinNetAmountMisc'
            THEN NetAmount 
        END AS NetAmountMisc
    ,   CASE
            WHEN
                [MaterialTypeID] = 'ZSER'
                AND
                mbdi.[ProductID] IS NULL
            THEN NetAmount 
        END AS NetAmountServOther
    ,   CASE
            WHEN
                [MaterialTypeID] = 'ZVER'
            THEN NetAmount 
        END AS NetAmountVerp
    ,   ISNULL(ConditionAmountVerp.ConditionAmount, 0) * BDIwithMatType.ExchangeRate AS ConditionAmountVerp
    ,   ISNULL(ConditionAmountMinQty.ConditionAmount, 0) * BDIwithMatType.ExchangeRate AS ConditionAmountMinQty
    ,   ISNULL(CTE_BDIPE.ConditionAmountFreight, 0) * BDIwithMatType.ExchangeRate AS ConditionAmountFreight
    FROM 
        BDIwithMatType
    LEFT JOIN
        [map_AXBI].[BillingDocumentItem] AS mbdi
        ON
            mbdi.[ProductID] = BDIwithMatType.[Material]

    LEFT JOIN
        [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] AS ConditionAmountVerp
        ON
            BDIwithMatType.[BillingDocument] = ConditionAmountVerp.[BillingDocument]
            AND
            BDIwithMatType.[BillingDocumentItem] = ConditionAmountVerp.[BillingDocumentItem]
            AND
            ConditionAmountVerp.ConditionInactiveReason = ''
            AND
            ConditionAmountVerp.[ConditionType] = 'ZF40'
        
    LEFT JOIN
        [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] AS ConditionAmountMinQty
        ON
            BDIwithMatType.[BillingDocument] = ConditionAmountMinQty.[BillingDocument]
            AND
            BDIwithMatType.[BillingDocumentItem] = ConditionAmountMinQty.[BillingDocumentItem]
            AND
            ConditionAmountMinQty.ConditionInactiveReason = ''
            AND
            ConditionAmountMinQty.[ConditionType] = 'AMIZ'

    LEFT JOIN
        CTE_BDIPE
        ON
            BDIwithMatType.[BillingDocument] = CTE_BDIPE.[BillingDocument]
            AND
            BDIwithMatType.[BillingDocumentItem] = CTE_BDIPE.[BillingDocumentItem]
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
    WHERE
        [MaterialTypeID] = 'ZSER'
        AND
        [Material] NOT IN (
            SELECT
                [ProductID]
            FROM
                [map_AXBI].[BillingDocumentItem]
        )
    GROUP BY
        BillingDocument
    ,   CurrencyTypeID
)
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

BDwithConditionAmountFreight AS (
    SELECT 
            BDI.BillingDocument
        ,   BDI.BillingDocumentItem
        ,   BDI.CurrencyTypeID
        ,   BDI.CurrencyID
        ,   BDI.ExchangeRate
        ,   CTE_BDIPE.ConditionAmountFreight * BDI.ExchangeRate AS ConditionAmountFreight
    FROM             
        BDIwithMatType BDI
    JOIN
        CTE_BDIPE
        ON
            BDI.[BillingDocument] = CTE_BDIPE.[BillingDocument]
            AND
            BDI.[BillingDocumentItem] = CTE_BDIPE.[BillingDocumentItem]
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
    
    WHERE
        BDIPE.ConditionInactiveReason = ''
    GROUP BY 
         BDI.BillingDocument
        ,BDI.BillingDocumentItem
        ,BDI.CurrencyTypeID
        ,BDI.CurrencyID
        ,BDI.ExchangeRate
)
,BDwithConditionAmountVerp AS (
    SELECT 
            BDI.BillingDocument
        ,   BDI.BillingDocumentItem
        ,   BDI.CurrencyTypeID
        ,   BDI.CurrencyID
        ,   BDI.ExchangeRate
        ,   SUM(BDIPE.ConditionAmount * BDI.ExchangeRate) AS ConditionAmountVerp
    FROM             
        BDIwithMatType BDI
    LEFT JOIN
        [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] BDIPE
        ON
            BDI.[BillingDocument] = BDIPE.[BillingDocument]
            AND
            BDI.[BillingDocumentItem] = BDIPE.[BillingDocumentItem]
            AND
            BDIPE.[ConditionType] = 'ZF40'    
    WHERE
        BDIPE.ConditionInactiveReason = ''
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
        BDIwithMatType.[nk_fact_BillingDocumentItem]
    ,   BDIwithMatType.[BillingDocument]
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
    ,   BDIwithMatType.[nk_ProductPlant]
    ,   BDIwithMatType.[ProductSurrogateKey]
    ,   BDIwithMatType.[OriginallyRequestedMaterial]
    ,   BDIwithMatType.[InternationalArticleNumber]
    ,   BDIwithMatType.[PricingReferenceMaterial]
    ,   BDIwithMatType.[LengthInMPer1]
    ,   BDIwithMatType.[LengthInM]
    ,   BDIwithMatType.[Batch]
    ,   BDIwithMatType.[MaterialGroupID]
    ,   BDIwithMatType.[BrandID]
    ,   BDIwithMatType.[Brand]
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
    ,   BDexclZVERandZSER.FinNetAmountSumBD
    ,   ISNULL(BDwithZVER.NetAmountZVER,0) AS NetAmountZVER
    ,   BDwithZSER.NetAmountZSER
    ,   ISNULL(BDwithFreight.NetAmountFreight,0) AS NetAmountFreight
    ,   ISNULL(BDwithMinQty.NetAmountMinQty,0) AS NetAmountMinQty
    ,   BDwithEngServ.NetAmountEngServ
    ,   BDwithMisc.NetAmountMisc
    ,   BDwithServOther.NetAmountServOther
    ,   ISNULL(BDwithConditionAmountFreight.ConditionAmountFreight, 0) AS ConditionAmountFreight
    ,   ISNULL(BDwithConditionAmountMinQty.ConditionAmountMinQty, 0) AS ConditionAmountMinQty
    ,   ISNULL(BDwithConditionAmountVerp.ConditionAmountVerp, 0) AS ConditionAmountVerp
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
    LEFT JOIN
        BDwithConditionAmountVerp
        ON 
            BDIwithMatType.BillingDocument = BDwithConditionAmountVerp.BillingDocument
            AND            
            BDIwithMatType.BillingDocumentItem = BDwithConditionAmountVerp.BillingDocumentItem
            AND
            BDIwithMatType.CurrencyTypeID = BDwithConditionAmountVerp.CurrencyTypeID
            
)
,BDIFinancials AS (
    SELECT 
        [nk_fact_BillingDocumentItem]
    ,   [BillingDocument]
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
    ,   [nk_ProductPlant]
    ,   [ProductSurrogateKey]
    ,   [OriginallyRequestedMaterial]
    ,   [InternationalArticleNumber]
    ,   [PricingReferenceMaterial]
    ,   [LengthInMPer1]
    ,   [LengthInM]
    ,   [Batch]
    ,   [MaterialGroupID]
    ,   [BrandID]
    ,   [Brand]
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
            THEN [NetAmount] - [ConditionAmountFreight] - [ConditionAmountMinQty] - [ConditionAmountVerp]
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
            THEN [NetAmount] / [FinNetAmountSumBD] * NetAmountZVER + [ConditionAmountVerp]
            ELSE NULL
        END AS [FinNetAmountVerp]
    ,   [AccountingDate]
    ,   [MaterialCalculated]
    ,   [SoldToPartyCalculated]
    ,   [InOutID]
    ,   [t_applicationId]
    ,   [t_extractionDtm]
    FROM 
        BDITotals
)
,BDIZZZDUMMY AS (
/*
    Generate additional records for documents that consist of [MaterialTypeID] = 'ZSER' or 'ZVER' only
*/
    SELECT
        edw.svf_getNaturalKey (BDIwithMatType.[BillingDocument]
                              ,STUFF(BDIwithMatType.[BillingDocumentItem], 1, 1, 'Z') + '0'
                              ,BDIwithMatType.[CurrencyTypeID]) AS [nk_fact_BillingDocumentItem]
    ,   BDIwithMatType.[BillingDocument]
    ,   STUFF(BDIwithMatType.[BillingDocumentItem], 1, 1, 'Z') + '0' AS [BillingDocumentItem]
    ,   NULL AS [MaterialTypeID] --MPS 2021/11/04 MaterialTypeID is not used in output but required for UNION
    ,   BDIwithMatType.[CurrencyTypeID]
    ,   BDIwithMatType.[CurrencyType]
    ,   BDIwithMatType.[CurrencyID]
    ,   BDIwithMatType.[ExchangeRate]
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
    ,   edw.svf_get2PartNaturalKey ('ZZZDUMMY02',PlantID) AS [nk_ProductPlant]
    ,   'ZZZDUMMY02' AS [ProductSurrogateKey]
    ,   [OriginallyRequestedMaterial]
    ,   [InternationalArticleNumber]
    ,   [PricingReferenceMaterial]
    ,   [LengthInMPer1]
    ,   [LengthInM]
    ,   [Batch]
    ,   [MaterialGroupID]
    ,   [BrandID]
    ,   [Brand]
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
    ,   ISNULL(BDItemZSERAndConditions.NetAmountFreight - 
                BDItemZSERAndConditions.ConditionAmountMinQty - 
                BDItemZSERAndConditions.ConditionAmountVerp, 
            BDItemZSERAndConditions.ConditionAmountFreight
        ) AS [FinNetAmountFreight]
    ,   ISNULL(BDItemZSERAndConditions.NetAmountMinQty - 
                BDItemZSERAndConditions.ConditionAmountVerp - 
                BDItemZSERAndConditions.ConditionAmountFreight, 
            BDItemZSERAndConditions.ConditionAmountMinQty
        ) AS [FinNetAmountMinQty]
    ,   ISNULL(BDItemZSERAndConditions.NetAmountEngServ  - 
                BDItemZSERAndConditions.ConditionAmountVerp - 
                BDItemZSERAndConditions.ConditionAmountFreight - 
                BDItemZSERAndConditions.ConditionAmountMinQty,
            0
        ) AS [FinNetAmountEngServ]
    ,   ISNULL(BDItemZSERAndConditions.NetAmountMisc - 
                BDItemZSERAndConditions.ConditionAmountVerp - 
                BDItemZSERAndConditions.ConditionAmountFreight - 
                BDItemZSERAndConditions.ConditionAmountMinQty, 
            0
        ) AS [FinNetAmountMisc]
    ,   ISNULL(BDItemZSERAndConditions.NetAmountServOther - 
                BDItemZSERAndConditions.ConditionAmountVerp - 
                BDItemZSERAndConditions.ConditionAmountFreight - 
                BDItemZSERAndConditions.ConditionAmountMinQty, 
            0
        ) AS [FinNetAmountServOther]
    ,   ISNULL(BDItemZSERAndConditions.NetAmountVerp - 
                BDItemZSERAndConditions.ConditionAmountFreight - 
                BDItemZSERAndConditions.ConditionAmountMinQty, 
            BDItemZSERAndConditions.ConditionAmountVerp
        ) AS [FinNetAmountVerp]
    ,   [AccountingDate]
    ,   'ZZZDUMMY02' AS [MaterialCalculated]
    ,   [SoldToPartyCalculated]
    ,   [InOutID]
    ,   [t_applicationId]
    ,   [t_extractionDtm]
    FROM 
        BDIwithMatType
    LEFT JOIN
        BDItemZSERAndConditions
        ON 
            BDIwithMatType.BillingDocument = BDItemZSERAndConditions.BillingDocument
            AND            
            BDIwithMatType.BillingDocumentItem = BDItemZSERAndConditions.BillingDocumentItem
            AND
            BDIwithMatType.CurrencyTypeID = BDItemZSERAndConditions.CurrencyTypeID
    WHERE 
        BDIwithMatType.[BillingDocument] NOT IN (
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
    ,   SUM(BDIPE.ConditionAmount * BDI.ExchangeRate) AS FinRebateAccrual
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
    WHERE
        BDIPE.ConditionInactiveReason = ''
    GROUP BY 
        BDI.BillingDocument
    ,   BDI.BillingDocumentItem
    ,   BDI.CurrencyTypeID
    ,   BDI.CurrencyID
    ,   BDI.ExchangeRate
    ,   BDIPE.ConditionCurrency
)
,BDIFinancialsZZZDUMMYAllKPI AS (
SELECT
    [nk_fact_BillingDocumentItem]
,   [BillingDocument]
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
,   edw.svf_get2PartNaturalKey (Material,PlantID) AS [nk_ProductPlant]
,   [ProductSurrogateKey]
,   [OriginallyRequestedMaterial]
,   [InternationalArticleNumber]
,   [PricingReferenceMaterial]
,   [LengthInMPer1]
,   [LengthInM]
,   [Batch]
,   [MaterialGroupID]
,   [BrandID]
,   [Brand]
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
                    WHERE [PaymentTerms] = BDIFinancialsZZZDUMMYAndOtherSales.[CustomerPaymentTerms]
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
)

SELECT
    BDI_CancellDocs.[nk_fact_BillingDocumentItem]
,   BDI_CancellDocs.[BillingDocument]
,   BDI_CancellDocs.[BillingDocumentItem]
,   BDI_CancellDocs.[CurrencyTypeID]
,   BDI_CancellDocs.[CurrencyType]
,   BDI_CancellDocs.[CurrencyID]
,   BDI_CancellDocs.[ExchangeRate]
,   BDI_CancellDocs.[SalesDocumentItemCategoryID]
,   BDI_CancellDocs.[SalesDocumentItemTypeID]
,   BDI_CancellDocs.[ReturnItemProcessingType]
,   BDI_CancellDocs.[BillingDocumentTypeID]
,   BDI_CancellDocs.[BillingDocumentCategoryID]
,   BDI_CancellDocs.[SDDocumentCategoryID]
,   BDI_CancellDocs.[CreationDate]
,   BDI_CancellDocs.[CreationTime]
,   BDI_CancellDocs.[LastChangeDate]
,   BDI_CancellDocs.[BillingDocumentDate]
,   BDI_CancellDocs.[BillingDocumentIsTemporary]
,   BDI_CancellDocs.[OrganizationDivision]
,   BDI_CancellDocs.[Division]
,   BDI_CancellDocs.[SalesOfficeID]
,   BDI_CancellDocs.[SalesOrganizationID]
,   BDI_CancellDocs.[DistributionChannelID]
,   BDI_CancellDocs.[Material]
,   BDI_CancellDocs.[nk_ProductPlant]
,   BDI_CancellDocs.[ProductSurrogateKey]
,   BDI_CancellDocs.[OriginallyRequestedMaterial]
,   BDI_CancellDocs.[InternationalArticleNumber]
,   BDI_CancellDocs.[PricingReferenceMaterial]
,   BDI_CancellDocs.[LengthInMPer1]
,   BDI_CancellDocs.[LengthInM]
,   BDI_CancellDocs.[Batch]
,   BDI_CancellDocs.[MaterialGroupID]
,   BDI_CancellDocs.[BrandID]
,   BDI_CancellDocs.[Brand]
,   BDI_CancellDocs.[AdditionalMaterialGroup2]
,   BDI_CancellDocs.[AdditionalMaterialGroup3]
,   BDI_CancellDocs.[AdditionalMaterialGroup4]
,   BDI_CancellDocs.[AdditionalMaterialGroup5]
,   BDI_CancellDocs.[MaterialCommissionGroup]
,   BDI_CancellDocs.[PlantID]
,   BDI_CancellDocs.[StorageLocationID]
,   BDI_CancellDocs.[BillingDocumentIsCancelled]
,   BDI_CancellDocs.[CancelledBillingDocument]
,   BDI_CancellDocs.[CancelledInvoiceEffect]
,   BDI_CancellDocs.[BillingDocumentItemText]
,   BDI_CancellDocs.[ServicesRenderedDate]
,   BDI_CancellDocs.[BillingQuantity]
,   BDI_CancellDocs.[BillingQuantityUnitID]
,   BDI_CancellDocs.[BillingQuantityInBaseUnit]
,   BDI_CancellDocs.[BaseUnit]
,   BDI_CancellDocs.[MRPRequiredQuantityInBaseUnit]
,   BDI_CancellDocs.[BillingToBaseQuantityDnmntr]
,   BDI_CancellDocs.[BillingToBaseQuantityNmrtr]
,   BDI_CancellDocs.[ItemGrossWeight]
,   BDI_CancellDocs.[ItemNetWeight]
,   BDI_CancellDocs.[ItemWeightUnit]
,   BDI_CancellDocs.[ItemVolume]
,   BDI_CancellDocs.[ItemVolumeUnit]
,   BDI_CancellDocs.[BillToPartyCountry]
,   BDI_CancellDocs.[BillToPartyRegion]
,   BDI_CancellDocs.[BillingPlanRule]
,   BDI_CancellDocs.[BillingPlan]
,   BDI_CancellDocs.[BillingPlanItem]
,   BDI_CancellDocs.[CustomerPriceGroupID]
,   BDI_CancellDocs.[PriceListTypeID]
,   BDI_CancellDocs.[TaxDepartureCountry]
,   BDI_CancellDocs.[VATRegistration]
,   BDI_CancellDocs.[VATRegistrationCountry]
,   BDI_CancellDocs.[VATRegistrationOrigin]
,   BDI_CancellDocs.[CustomerTaxClassification1]
,   BDI_CancellDocs.[CustomerTaxClassification2]
,   BDI_CancellDocs.[CustomerTaxClassification3]
,   BDI_CancellDocs.[CustomerTaxClassification4]
,   BDI_CancellDocs.[CustomerTaxClassification5]
,   BDI_CancellDocs.[CustomerTaxClassification6]
,   BDI_CancellDocs.[CustomerTaxClassification7]
,   BDI_CancellDocs.[CustomerTaxClassification8]
,   BDI_CancellDocs.[CustomerTaxClassification9]
,   BDI_CancellDocs.[SDPricingProcedure]
,   BDI_CancellDocs.[NetAmount]
,   BDI_CancellDocs.[TransactionCurrencyID]
,   BDI_CancellDocs.[GrossAmount]
,   BDI_CancellDocs.[PricingDate]
,   BDI_CancellDocs.[PriceDetnExchangeRate]
,   BDI_CancellDocs.[PricingScaleQuantityInBaseUnit]
,   BDI_CancellDocs.[TaxAmount]
,   BDI_CancellDocs.[CostAmount]
,   BDI_CancellDocs.[Subtotal1Amount]
,   BDI_CancellDocs.[Subtotal2Amount]
,   BDI_CancellDocs.[Subtotal3Amount]
,   BDI_CancellDocs.[Subtotal4Amount]
,   BDI_CancellDocs.[Subtotal5Amount]
,   BDI_CancellDocs.[Subtotal6Amount]
,   BDI_CancellDocs.[StatisticalValueControl]
,   BDI_CancellDocs.[StatisticsExchangeRate]
,   BDI_CancellDocs.[StatisticsCurrency]
,   BDI_CancellDocs.[SalesOrganizationCurrency]
,   BDI_CancellDocs.[EligibleAmountForCashDiscount]
,   BDI_CancellDocs.[ContractAccount]
,   BDI_CancellDocs.[CustomerPaymentTerms]
,   BDI_CancellDocs.[PaymentMethod]
,   BDI_CancellDocs.[PaymentReference]
,   BDI_CancellDocs.[FixedValueDate]
,   BDI_CancellDocs.[AdditionalValueDays]
,   BDI_CancellDocs.[PayerParty]
,   BDI_CancellDocs.[CompanyCode]
,   BDI_CancellDocs.[FiscalYear]
,   BDI_CancellDocs.[FiscalPeriod]
,   BDI_CancellDocs.[CustomerAccountAssignmentGroupID]
,   BDI_CancellDocs.[BusinessArea]
,   BDI_CancellDocs.[ProfitCenter]
,   BDI_CancellDocs.[OrderID]
,   BDI_CancellDocs.[ControllingArea]
,   BDI_CancellDocs.[ProfitabilitySegment]
,   BDI_CancellDocs.[CostCenter]
,   BDI_CancellDocs.[OriginSDDocument]
,   BDI_CancellDocs.[OriginSDDocumentItem]
,   BDI_CancellDocs.[PriceDetnExchangeRateDate]
,   BDI_CancellDocs.[ExchangeRateTypeID]
,   BDI_CancellDocs.[FiscalYearVariant]
,   BDI_CancellDocs.[CompanyCodeCurrencyID]
,   BDI_CancellDocs.[AccountingExchangeRate]
,   BDI_CancellDocs.[AccountingExchangeRateIsSet]
,   BDI_CancellDocs.[ReferenceSDDocument]
,   BDI_CancellDocs.[ReferenceSDDocumentItem]
,   BDI_CancellDocs.[ReferenceSDDocumentCategoryID]
,   BDI_CancellDocs.[SalesDocumentID]
,   BDI_CancellDocs.[SalesDocumentItemID]
,   BDI_CancellDocs.[SalesSDDocumentCategoryID]
,   BDI_CancellDocs.[HigherLevelItem]
,   BDI_CancellDocs.[BillingDocumentItemInPartSgmt]
,   BDI_CancellDocs.[SalesGroup]
,   BDI_CancellDocs.[AdditionalCustomerGroup1]
,   BDI_CancellDocs.[AdditionalCustomerGroup2]
,   BDI_CancellDocs.[AdditionalCustomerGroup3]
,   BDI_CancellDocs.[AdditionalCustomerGroup4]
,   BDI_CancellDocs.[AdditionalCustomerGroup5]
,   BDI_CancellDocs.[SDDocumentReasonID]
,   BDI_CancellDocs.[ItemIsRelevantForCredit]
,   BDI_CancellDocs.[CreditRelatedPrice]
,   BDI_CancellDocs.[SalesDistrictID]
,   BDI_CancellDocs.[CustomerGroupID]
,   BDI_CancellDocs.[SoldToParty]
,   BDI_CancellDocs.[CountryID]
,   BDI_CancellDocs.[ShipToParty]
,   BDI_CancellDocs.[BillToParty]
,   BDI_CancellDocs.[ShippingPoint]
,   BDI_CancellDocs.[IncotermsVersion]
,   BDI_CancellDocs.[IncotermsClassification]
,   BDI_CancellDocs.[IncotermsTransferLocation]
,   BDI_CancellDocs.[IncotermsLocation1]
,   BDI_CancellDocs.[IncotermsLocation2]
,   BDI_CancellDocs.[ShippingCondition]
,   BDI_CancellDocs.[QuantitySold]
,   BDI_CancellDocs.[GrossMargin]
,   BDI_CancellDocs.[ExternalSalesAgentID]
,   BDI_CancellDocs.[ExternalSalesAgent]
,   BDI_CancellDocs.[ProjectID]
,   BDI_CancellDocs.[Project]
,   BDI_CancellDocs.[SalesEmployeeID]
,   BDI_CancellDocs.[SalesEmployee]
,   BDI_CancellDocs.[GlobalParentID]
,   BDI_CancellDocs.[GlobalParent]
,   BDI_CancellDocs.[GlobalParentCalculatedID]
,   BDI_CancellDocs.[GlobalParentCalculated]
,   BDI_CancellDocs.[LocalParentID]
,   BDI_CancellDocs.[LocalParent]
,   BDI_CancellDocs.[LocalParentCalculatedID]
,   BDI_CancellDocs.[LocalParentCalculated]
,   BDI_CancellDocs.[SalesOrderTypeID]
,   BDI_CancellDocs.[BillToID]
,   BDI_CancellDocs.[BillTo]
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinNetAmountRealProduct]*(-1)
        ELSE BDI_CancellDocs.[FinNetAmountRealProduct]
    END                                                 AS [FinNetAmountRealProduct]  
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinNetAmountFreight]*(-1)
        ELSE BDI_CancellDocs.[FinNetAmountFreight] 
    END                                                 AS [FinNetAmountFreight]
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinNetAmountMinQty]*(-1)
        ELSE BDI_CancellDocs.[FinNetAmountMinQty]
    END                                                 AS [FinNetAmountMinQty]
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinNetAmountEngServ]*(-1)
        ELSE BDI_CancellDocs.[FinNetAmountEngServ]
    END                                                 AS [FinNetAmountEngServ]
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinNetAmountMisc]*(-1)
        ELSE BDI_CancellDocs.[FinNetAmountMisc]
    END                                                 AS [FinNetAmountMisc]
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinNetAmountServOther]*(-1)
        ELSE BDI_CancellDocs.[FinNetAmountServOther]
    END                                                 AS [FinNetAmountServOther]
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinNetAmountVerp]*(-1)
        ELSE BDI_CancellDocs.[FinNetAmountVerp]
    END                                                 AS [FinNetAmountVerp]
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinRebateAccrual]*(-1)
        ELSE BDI_CancellDocs.[FinRebateAccrual]
    END                                                 AS [FinRebateAccrual]
,   BDI_CancellDocs.[PaymentTermCashDiscountPercentageRate]
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinNetAmountOtherSales]*(-1)
        ELSE BDI_CancellDocs.[FinNetAmountOtherSales]
    END                                                 AS [FinNetAmountOtherSales]
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinReserveCashDiscount]*(-1)
        ELSE BDI_CancellDocs.[FinReserveCashDiscount]
    END                                                 AS [FinReserveCashDiscount]
,   CASE
        WHEN BDI_CancellDocs.BillingDocumentTypeID = 'S1'
            THEN BDI_AllKPI.[FinNetAmountAllowances]*(-1)
        ELSE BDI_CancellDocs.[FinNetAmountAllowances]
    END                                                 AS [FinNetAmountAllowances]
,   BDI_CancellDocs.[FinSales100]
,   BDI_CancellDocs.[AccountingDate]
,   BDI_CancellDocs.[MaterialCalculated]
,   BDI_CancellDocs.[SoldToPartyCalculated]
,   BDI_CancellDocs.[InOutID]
,   BDI_CancellDocs.[t_applicationId]
,   BDI_CancellDocs.[t_extractionDtm]
FROM
    BDIFinancialsZZZDUMMYAllKPI BDI_CancellDocs
LEFT JOIN 
    BDIFinancialsZZZDUMMYAllKPI BDI_AllKPI
    ON
        BDI_AllKPI.BillingDocument = BDI_CancellDocs.CancelledBillingDocument
        AND
        BDI_AllKPI.BillingDocumentItem = BDI_CancellDocs.BillingDocumentItem
        AND
        BDI_AllKPI.CurrencyTypeID = BDI_CancellDocs.CurrencyTypeID
        AND
        BDI_AllKPI.Material = BDI_CancellDocs.Material
        AND
        BDI_AllKPI.BillingDocumentTypeID <> 'S1'
        AND
        BDI_CancellDocs.BillingDocumentTypeID = 'S1'