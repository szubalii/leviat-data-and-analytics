﻿CREATE VIEW [dm_sales].[vw_fact_BillingDocumentItem_active] AS

WITH s4h_axbi_join AS(
    SELECT
            [BillingDocument]
        ,   [BillingDocumentItem]
        ,   [CurrencyTypeID]
        ,   [CurrencyType]
        ,   [CurrencyID]
        ,   [ExchangeRate]
        ,   NULL                      AS [SalesDocumentItemCategoryID]
        ,   NULL                      AS [SalesDocumentItemTypeID]
        ,   [ReturnItemProcessingType]
        ,   NULL                      AS [BillingDocumentTypeID]
        ,   NULL                      AS [BillingDocumentCategoryID]
        ,   [SDDocumentCategoryID]
        ,   NULL                      AS [CreationDate]
        ,   NULL                      AS [CreationTime]
        ,   NULL                      AS [LastChangeDate]
        ,   [BillingDocumentDate]
        ,   NULL                      AS [BillingDocumentIsTemporary]
        ,   NULL                      AS [OrganizationDivision]
        ,   NULL                      AS [Division]
        ,   NULL                      AS [SalesOfficeID]
        ,   [SalesOrganizationID]
        ,   [DistributionChannelID]
        ,   [Material]
        ,   [Material]                AS [ProductSurrogateKey]
        ,   NULL                      AS [OriginallyRequestedMaterial]
        ,   NULL                      AS [InternationalArticleNumber]
        ,   NULL                      AS [PricingReferenceMaterial]
        ,   [LengthInMPer1]
        ,   [LengthInM]
        ,   NULL                      AS [Batch]
        ,   NULL                      AS [MaterialGroupID]
        ,   [BrandID]
        ,   NULL                      AS [AdditionalMaterialGroup2]
        ,   NULL                      AS [AdditionalMaterialGroup3]
        ,   NULL                      AS [AdditionalMaterialGroup4]
        ,   NULL                      AS [AdditionalMaterialGroup5]
        ,   NULL                      AS [MaterialCommissionGroup]
        ,   [PlantID]
        ,   NULL                      AS [StorageLocationID]
        ,   NULL                      AS [BillingDocumentIsCancelled]
        ,   NULL                      AS [CancelledBillingDocument]
        ,   [CancelledInvoiceEffect]
        ,   NULL                      AS [BillingDocumentItemText]
        ,   NULL                      AS [ServicesRenderedDate]
        ,   [BillingQuantity]
        ,   [BillingQuantityUnitID]
        ,   NULL                      AS [BillingQuantityInBaseUnit]
        ,   NULL                      AS [BaseUnit]
        ,   NULL                      AS [MRPRequiredQuantityInBaseUnit]
        ,   NULL                      AS [BillingToBaseQuantityDnmntr]
        ,   NULL                      AS [BillingToBaseQuantityNmrtr]
        ,   NULL                      AS [ItemGrossWeight]
        ,   NULL                      AS [ItemNetWeight]
        ,   NULL                      AS [ItemWeightUnit]
        ,   NULL                      AS [ItemVolume]
        ,   NULL                      AS [ItemVolumeUnit]
        ,   NULL                      AS [BillToPartyCountry]
        ,   NULL                      AS [BillToPartyRegion]
        ,   NULL                      AS [BillingPlanRule]
        ,   NULL                      AS [BillingPlan]
        ,   NULL                      AS [BillingPlanItem]
        ,   NULL                      AS [CustomerPriceGroupID]
        ,   NULL                      AS [PriceListTypeID]
        ,   NULL                      AS [TaxDepartureCountry]
        ,   NULL                      AS [VATRegistration]
        ,   NULL                      AS [VATRegistrationCountry]
        ,   NULL                      AS [VATRegistrationOrigin]
        ,   NULL                      AS [CustomerTaxClassification1]
        ,   NULL                      AS [CustomerTaxClassification2]
        ,   NULL                      AS [CustomerTaxClassification3]
        ,   NULL                      AS [CustomerTaxClassification4]
        ,   NULL                      AS [CustomerTaxClassification5]
        ,   NULL                      AS [CustomerTaxClassification6]
        ,   NULL                      AS [CustomerTaxClassification7]
        ,   NULL                      AS [CustomerTaxClassification8]
        ,   NULL                      AS [CustomerTaxClassification9]
        ,   NULL                      AS [SDPricingProcedure]
        ,   [NetAmount]
        ,   NULL                      AS [TransactionCurrencyID]
        ,   NULL                      AS [GrossAmount]
        ,   NULL                      AS [PricingDate]
        ,   NULL                      AS [PriceDetnExchangeRate]
        ,   NULL                      AS [PricingScaleQuantityInBaseUnit]
        ,   NULL                      AS [TaxAmount]
        ,   [CostAmount]
        ,   [ProfitMargin]
        ,   [MarginPercent]
        ,   NULL                      AS [Subtotal1Amount]
        ,   NULL                      AS [Subtotal2Amount]
        ,   NULL                      AS [Subtotal3Amount]
        ,   NULL                      AS [Subtotal4Amount]
        ,   NULL                      AS [Subtotal5Amount]
        ,   NULL                      AS [Subtotal6Amount]
        ,   NULL                      AS [StatisticalValueControl]
        ,   NULL                      AS [StatisticsExchangeRate]
        ,   NULL                      AS [StatisticsCurrency]
        ,   NULL                      AS [SalesOrganizationCurrency]
        ,   NULL                      AS [EligibleAmountForCashDiscount]
        ,   NULL                      AS [ContractAccount]
        ,   NULL                      AS [CustomerPaymentTerms]
        ,   NULL                      AS [PaymentMethod]
        ,   NULL                      AS [PaymentReference]
        ,   NULL                      AS [FixedValueDate]
        ,   NULL                      AS [AdditionalValueDays]
        ,   NULL                      AS [PayerParty]
        ,   NULL                      AS [CompanyCode]
        ,   NULL                      AS [FiscalYear]
        ,   NULL                      AS [FiscalPeriod]
        ,   NULL                      AS [CustomerAccountAssignmentGroupID]
        ,   NULL                      AS [BusinessArea]
        ,   NULL                      AS [ProfitCenter]
        ,   NULL                      AS [OrderID]
        ,   NULL                      AS [ControllingArea]
        ,   NULL                      AS [ProfitabilitySegment]
        ,   NULL                      AS [CostCenter]
        ,   NULL                      AS [OriginSDDocument]
        ,   NULL                      AS [OriginSDDocumentItem]
        ,   NULL                      AS [PriceDetnExchangeRateDate]
        ,   NULL                      AS [ExchangeRateTypeID]
        ,   NULL                      AS [FiscalYearVariant]
        ,   NULL                      AS [CompanyCodeCurrencyID]
        ,   NULL                      AS [AccountingExchangeRate]
        ,   NULL                      AS [AccountingExchangeRateIsSet]
        ,   NULL                      AS [ReferenceSDDocument]
        ,   NULL                      AS [ReferenceSDDocumentItem]
        ,   NULL                      AS [ReferenceSDDocumentCategoryID]
        ,   [SalesDocumentID]         as [SalesDocumentID]
        ,   NULL                      AS [SalesDocumentItemID]
        ,   NULL                      AS [SalesSDDocumentCategoryID]
        ,   NULL                      AS [HigherLevelItem]
        ,   NULL                      AS [BillingDocumentItemInPartSgmt]
        ,   NULL                      AS [SalesGroup]
        ,   NULL                      AS [AdditionalCustomerGroup1]
        ,   NULL                      AS [AdditionalCustomerGroup2]
        ,   NULL                      AS [AdditionalCustomerGroup3]
        ,   NULL                      AS [AdditionalCustomerGroup4]
        ,   NULL                      AS [AdditionalCustomerGroup5]
        ,   NULL                      AS [SDDocumentReasonID]
        ,   NULL                      AS [ItemIsRelevantForCredit]
        ,   NULL                      AS [CreditRelatedPrice]
        ,   [SalesDistrictID]
        ,   [CustomerGroupID]
        ,   [SoldToParty]
        ,   [CountryID]               AS [CountryID]
        ,   NULL                      AS [ShipToParty]
        ,   NULL                      AS [BillToParty]
        ,   NULL                      AS [ShippingPoint]
        ,   NULL                      AS [IncotermsVersion]
        ,   NULL                      AS [IncotermsClassification]
        ,   NULL                      AS [IncotermsTransferLocation]
        ,   NULL                      AS [IncotermsLocation1]
        ,   NULL                      AS [IncotermsLocation2]
        ,   NULL                      AS [ShippingCondition]
        ,   [QuantitySold]
        ,   NULL                      AS [GrossMargin]
        ,   [ExternalSalesAgentID]
        ,   NULL                      AS [ExternalSalesAgent]
        ,   [ProjectID]
        ,   [Project]
        ,   [SalesEmployeeID]
        ,   NULL                      AS [SalesEmployee]
        ,   [GlobalParentID]
        ,   NULL                      AS [GlobalParent]
        ,   [GlobalParentCalculatedID]
        ,   [GlobalParentCalculated]
        ,   NULL                      AS [LocalParentID]
        ,   NULL                      AS [LocalParent]
        ,   [LocalParentCalculatedID]
        ,   [LocalParentCalculated]
        ,   [SalesOrderTypeID]
        ,   NULL                      AS [BillToID]
        ,   NULL                      AS [BillTo]
        ,   [FinNetAmountRealProduct] as [FinNetAmountRealProduct]
        ,   NULL                      AS [FinNetAmountFreight]
        ,   NULL                      AS [FinNetAmountMinQty]
        ,   NULL                      AS [FinNetAmountEngServ]
        ,   NULL                      AS [FinNetAmountMisc]
        ,   NULL                      AS [FinNetAmountServOther]
        ,   NULL                      AS [FinNetAmountVerp]
        ,   NULL                      AS [FinRebateAccrual]
        ,   NULL                      AS [PaymentTermCashDiscountPercentageRate]
        ,   [FinNetAmountOtherSales]  as [FinNetAmountOtherSales]
        ,   NULL                      AS [FinReserveCashDiscount]
        ,   [FinNetAmountAllowances]  as [FinNetAmountAllowances]
        ,   [FinSales100]             AS [FinSales100]
        ,   [AccountingDate]
        ,   [axbi_DataAreaID]
        ,   [axbi_DataAreaName]
        ,   [axbi_DataAreaGroup]
        ,   [axbi_MaterialID]
        ,   [axbi_CustomerID]
        ,   [MaterialCalculated]
        ,   [SoldToPartyCalculated]
        ,   [InOutID]
        ,   [axbi_ItemNoCalc]
        ,   [t_applicationId]
        ,   [t_extractionDtm]
        ,   [t_lastActionCd]   
    FROM [edw].[fact_BillingDocumentItem_axbi]
    UNION ALL
    SELECT
            [BillingDocument]
        ,   [BillingDocumentItem]
        ,   [CurrencyTypeID]
        ,   [CurrencyType]
        ,   [CurrencyID]
        ,   [ExchangeRate]
        ,   [SalesDocumentItemCategoryID]   -- new
        ,   [SalesDocumentItemTypeID]       --new
        ,   [ReturnItemProcessingType]
        ,   [BillingDocumentTypeID]
        ,   [BillingDocumentCategoryID]     -- new
        ,   [SDDocumentCategoryID]          -- new
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
        ,   [Batch]
        ,   [LengthInMPer1]
        ,   [LengthInM]
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
        ,   [CustomerPriceGroupID]          --new
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
        ,   [TransactionCurrencyID]         -- new
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
        ,   [CompanyCodeCurrencyID]         --new
        ,   [AccountingExchangeRate]
        ,   [AccountingExchangeRateIsSet]
        ,   [ReferenceSDDocument]
        ,   [ReferenceSDDocumentItem]
        ,   [ReferenceSDDocumentCategoryID] --new
        ,   [SalesDocumentID]
        ,   [SalesDocumentItemID]
        ,   [SalesSDDocumentCategoryID]     --new
        ,   [HigherLevelItem]
        ,   [BillingDocumentItemInPartSgmt]
        ,   [SalesGroup]
        ,   [AdditionalCustomerGroup1]
        ,   [AdditionalCustomerGroup2]
        ,   [AdditionalCustomerGroup3]
        ,   [AdditionalCustomerGroup4]
        ,   [AdditionalCustomerGroup5]
        ,   [SDDocumentReasonID]            -- new
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
        ,   [FinNetAmountRealProduct]
        ,   [FinNetAmountFreight]
        ,   [FinNetAmountMinQty]
        ,   [FinNetAmountEngServ]
        ,   [FinNetAmountMisc]
        ,   [FinNetAmountServOther]
        ,   [FinNetAmountVerp]
        ,   [FinRebateAccrual]
        ,   [PaymentTermCashDiscountPercentageRate]
        ,   [FinNetAmountOtherSales]
        ,   [FinReserveCashDiscount]
        ,   [FinNetAmountAllowances]
        ,   [FinSales100]
        ,   [AccountingDate]
        ,   NULL                    AS [axbi_DataAreaID]
        ,   NULL                    AS [axbi_DataAreaName]
        ,   NULL                    AS [axbi_DataAreaGroup]
        ,   NULL                    AS [axbi_MaterialID]
        ,   NULL                    AS [axbi_CustomerID]
        ,   [MaterialCalculated]
        ,   [SoldToPartyCalculated]
        ,   [InOutID]
        ,   NULL                    AS [axbi_ItemNoCalc]
        ,   [t_applicationId]
        ,   [t_extractionDtm]
        ,   [t_lastActionCd]   
        FROM
            [edw].[fact_BillingDocumentItem_s4h_active]       
        Where [t_lastActionCd] <> 'D'        
),
original AS (
    SELECT doc.[BillingDocument]
         , doc.[BillingDocumentItem]
         , doc.[CurrencyType]
         , dimCr.[CurrencyID]
         , dimCr.[Currency]
         , dimSDIC.[SalesDocumentItemCategoryID]
         , dimSDIC.[SalesDocumentItemCategory]
         , dimSDIT.[SalesDocumentItemTypeID]
         , dimSDIT.[SalesDocumentItemType]
         , doc.[ReturnItemProcessingType]
         , dimBDT.[BillingDocumentTypeID]
         , dimBDT.[BillingDocumentType]
         , dimBDC.[BillingDocumentCategoryID]
         , dimBDC.[BillingDocumentCategory]
         , dimSDDC.[SDDocumentCategoryID]
         , dimSDDC.[SDDocumentCategory]
         , doc.[CreationDate]
         , doc.[CreationTime]
         , doc.[LastChangeDate]
         , doc.[BillingDocumentDate]
         , doc.[BillingDocumentIsTemporary]
         , dimSOrg.[SalesOrganizationID]
         , dimSOrg.[SalesOrganization]
         , dimDCh.[DistributionChannelID]
         , dimDCh.[DistributionChannel]
         , doc.[Material]
         , doc.[ProductSurrogateKey]
         , dimMG.[MaterialGroupID]
         , dimMG.[MaterialGroup]
         , doc.[BrandID]
         , dimP.[PlantID]
         , dimP.[Plant]
         , dimSL.[StorageLocationID]
         , dimSL.[StorageLocation]
         , doc.[BillingDocumentIsCancelled]
         , doc.[CancelledBillingDocument]
         , doc.[CancelledInvoiceEffect]
         , doc.[BillingQuantity]
         , dimCPG.[CustomerPriceGroupID]
         , dimCPG.[CustomerPriceGroup]
         , doc.[NetAmount]
         , doc.[TransactionCurrencyID]
         , doc.[GrossAmount]
         , doc.[PricingDate]
         , doc.[TaxAmount]
         , doc.[CostAmount]
         , doc.[ProfitMargin]
         , doc.[MarginPercent]
         , doc.[Subtotal1Amount]
         , doc.[Subtotal2Amount]
         , doc.[Subtotal3Amount]
         , doc.[Subtotal4Amount]
         , doc.[Subtotal5Amount]
         , doc.[Subtotal6Amount]
         , doc.[SalesOrganizationCurrency]
         , doc.[EligibleAmountForCashDiscount]
         , doc.[CompanyCode]
         , doc.[FiscalYear]
         , doc.[FiscalPeriod]
         , dimCAAG.[CustomerAccountAssignmentGroupID]
         , dimCAAG.[CustomerAccountAssignmentGroup]
         , doc.[ProfitCenter]
         , doc.[OrderID]
         , doc.[ControllingArea]
         , dimERT.[ExchangeRateTypeID]
         , dimERT.[ExchangeRateType]
         , doc.[AccountingExchangeRate]
         , doc.[ReferenceSDDocument]
         , doc.[ReferenceSDDocumentItem]
         , dimRSDDC.[SDDocumentCategoryID] as [ReferenceSDDocumentCategoryID]
         , dimRSDDC.[SDDocumentCategory]   as [ReferenceSDDocumentCategory]
         , doc.[SalesDocumentID]
         , doc.[SalesDocumentItemID]
         , dimSSDDC.[SDDocumentCategoryID] as [SalesSDDocumentCategoryID]
         , dimSSDDC.[SDDocumentCategory]   as [SalesSDDocumentCategory]
         , doc.[HigherLevelItem]
         , dimSDR.[SDDocumentReasonID]
         , dimSDR.[SDDocumentReason]
         , dimSD.[SalesDistrictID]
         , dimSD.[SalesDistrict]
         , dimCGr.[CustomerGroup]
         , doc.[SoldToParty]
         , dimC.[CountryID]
         , dimC.[Country]
         , doc.[BillToParty]
         , doc.[QuantitySold]
         , doc.[GrossMargin]
         , doc.[ExternalSalesAgentID]
         , doc.[ExternalSalesAgent]
         , doc.[ProjectID]
         , doc.[Project]
         , doc.[SalesEmployeeID]
         , doc.[SalesEmployee]
         , doc.[GlobalParentID]
         , doc.[GlobalParent]
         , doc.[GlobalParentCalculatedID]             
         , doc.[GlobalParentCalculated]               
         , doc.[LocalParentID]
         , doc.[LocalParent]
         , doc.[LocalParentCalculatedID]           
         , doc.[LocalParentCalculated]  
         , doc.[SalesOrderTypeID]
         , dimSDT.[SalesDocumentType] as SalesOrderType
         , doc.[FinNetAmountRealProduct]
         , doc.[FinNetAmountFreight]
         , doc.[FinNetAmountMinQty]
         , doc.[FinNetAmountEngServ]
         , doc.[FinNetAmountMisc]
         , doc.[FinNetAmountServOther]
         , doc.[FinNetAmountVerp]
         , doc.[FinRebateAccrual]
         , doc.[PaymentTermCashDiscountPercentageRate]
         , doc.[FinNetAmountOtherSales]
         , doc.[FinReserveCashDiscount]
         , doc.[FinNetAmountAllowances]
         , doc.[FinSales100]
         , doc.[AccountingDate]
         , doc.[axbi_DataAreaID]                     
         , doc.[axbi_DataAreaName]                   
         , doc.[axbi_DataAreaGroup]                  
         , doc.[axbi_MaterialID]                     
         , doc.[axbi_CustomerID]
         , doc.[MaterialCalculated]
         , doc.[SoldToPartyCalculated]
         , doc.[InOutID]
         , doc.[axbi_ItemNoCalc]
         , doc.[t_applicationId]
         , doc.[t_extractionDtm]
         , doc.[t_lastActionCd]          
    FROM s4h_axbi_join doc
    left join 
        [edw].[dim_SalesDocumentItemCategory] dimSDIC --1
        on 
            dimSDIC.[SalesDocumentItemCategoryID] = doc.[SalesDocumentItemCategoryID]
    left join 
        [edw].[dim_SalesDocumentItemType] dimSDIT --2
        on 
            dimSDIT.[SalesDocumentItemTypeID] = doc.[SalesDocumentItemTypeID]
    left join 
        [edw].[dim_BillingDocumentType] dimBDT --3
        on 
            dimBDT.[BillingDocumentTypeID] = doc.[BillingDocumentTypeID]
    left join 
        [edw].[dim_BillingDocumentCategory] dimBDC --4
        on 
            dimBDC.[BillingDocumentCategoryID] = doc.[BillingDocumentCategoryID]
    left join 
        [edw].[dim_SDDocumentCategory] dimSDDC --5
        on 
            dimSDDC.[SDDocumentCategoryID] = doc.[SDDocumentCategoryID]
    left join 
        [edw].[dim_CustomerPriceGroup] dimCPG
        on 
            dimCPG.[CustomerPriceGroupID] = doc.[CustomerPriceGroupID] --6
    left join 
        [edw].[dim_Currency] dimCr 
        on 
            dimCr.[CurrencyID] = doc.[CurrencyID] --7
    left join 
        [edw].[dim_SDDocumentCategory] dimRSDDC
        on 
            dimRSDDC.[SDDocumentCategoryID] = doc.[ReferenceSDDocumentCategoryID]
    left join 
        [edw].[dim_SDDocumentCategory] dimSSDDC
        on 
            dimSSDDC.[SDDocumentCategoryID] = doc.[SalesSDDocumentCategoryID]
    left join 
        [edw].[dim_SDDocumentReason] dimSDR
        on 
            dimSDR.[SDDocumentReasonID] = doc.[SDDocumentReasonID] --8
    left join 
        [edw].[dim_SalesOrganization] dimSOrg 
        on 
            dimSOrg.[SalesOrganizationID] = doc.[SalesOrganizationID]
    left join 
        [edw].[dim_DistributionChannel] dimDCh
        on 
            dimDCh.[DistributionChannelID] = doc.[DistributionChannelID]
    left join 
        [edw].[dim_MaterialGroup] dimMG
        on 
            dimMG.[MaterialGroupID] = doc.[MaterialGroupID]
    left join 
        [edw].[dim_Plant] dimP 
        on 
            dimP.[PlantID] = doc.[PlantID]
    left join 
        [edw].[dim_StorageLocation] dimSL
        on 
            dimSL.[StorageLocationID] = doc.[StorageLocationID] 
            and 
            dimSL.[Plant] = doc.[PlantID]
    left join 
        [edw].[dim_CustomerAccountAssignmentGroup] dimCAAG
        on 
            dimCAAG.[CustomerAccountAssignmentGroupID] = doc.[CustomerAccountAssignmentGroupID]
    left join 
        [edw].[dim_ExchangeRateType] dimERT
        on 
            dimERT.[ExchangeRateTypeID] = doc.[ExchangeRateTypeID]
    left join 
        [edw].[dim_SalesDistrict] dimSD
        on 
            dimSD.[SalesDistrictID] = doc.[SalesDistrictID]
    left join 
        [edw].[dim_CustomerGroup] dimCGr
        on 
            dimCGr.[CustomerGroupID] = doc.[CustomerGroupID]
    left join 
        [edw].[dim_Country] dimC
        on 
            dimC.[CountryID] = doc.[CountryID]
    left join 
        [edw].[dim_SalesDocumentType] dimSDT
        on 
            dimSDT.[SalesDocumentTypeID] = doc.[SalesOrderTypeID]
    WHERE doc.[CurrencyTypeID] <> '00' -- Transaction Currency
)

SELECT  
        [BillingDocument]
      , [BillingDocumentItem]
      , [CurrencyType]
      , [CurrencyID]
      , [Currency]
      , [SalesDocumentItemCategoryID]
      , [SalesDocumentItemCategory]
      , [SalesDocumentItemTypeID]
      , [SalesDocumentItemType]
      , [ReturnItemProcessingType]
      , [BillingDocumentTypeID]
      , [BillingDocumentType]
      , [BillingDocumentCategoryID]
      , [BillingDocumentCategory]
      , [SDDocumentCategoryID]
      , [SDDocumentCategory]
      , [CreationDate]
      , [CreationTime]
      , [LastChangeDate]
      , [BillingDocumentDate]
      , [BillingDocumentIsTemporary]
      , [SalesOrganizationID]
      , [SalesOrganization]
      , [DistributionChannelID]
      , [DistributionChannel]
      , [Material]
      , [ProductSurrogateKey]
      , [MaterialGroupID]
      , [MaterialGroup]
      , [BrandID]
      , [PlantID]
      , [Plant]
      , [StorageLocationID]
      , [StorageLocation]
      , [BillingDocumentIsCancelled]
      , [CancelledBillingDocument]
      , [CancelledInvoiceEffect]
      , [BillingQuantity]
      , [CustomerPriceGroupID]
      , [CustomerPriceGroup]
      , [NetAmount]
      , [TransactionCurrencyID]
      , [GrossAmount]
      , [PricingDate]
      , [TaxAmount]
      , [CostAmount]
      , [ProfitMargin]
      , [MarginPercent]
      , [Subtotal1Amount]
      , [Subtotal2Amount]
      , [Subtotal3Amount]
      , [Subtotal4Amount]
      , [Subtotal5Amount]
      , [Subtotal6Amount]
      , [SalesOrganizationCurrency]
      , [EligibleAmountForCashDiscount]
      , [CompanyCode]
      , [FiscalYear]
      , [FiscalPeriod]
      , [CustomerAccountAssignmentGroupID]
      , [CustomerAccountAssignmentGroup]
      , [ProfitCenter]
      , [OrderID]
      , [ControllingArea]
      , [ExchangeRateTypeID]
      , [ExchangeRateType]
      , [AccountingExchangeRate]
      , [ReferenceSDDocument]
      , [ReferenceSDDocumentItem]
      , [ReferenceSDDocumentCategoryID]
      , [ReferenceSDDocumentCategory]
      , [SalesDocumentID]
      , [SalesDocumentItemID]
      , [SalesSDDocumentCategoryID]
      , [SalesSDDocumentCategory]
      , [HigherLevelItem]
      , [SDDocumentReasonID]
      , [SDDocumentReason]
      , [SalesDistrictID]
      , [SalesDistrict]
      , [CustomerGroup]
      , [SoldToParty]
      , [CountryID]
      , [Country]
      , [BillToParty]
      , [QuantitySold]
      , [GrossMargin]
      , [ExternalSalesAgentID]
      , [ExternalSalesAgent]
      , [ProjectID]
      , [Project]
      , [SalesEmployeeID]
      , [SalesEmployee]
      , [GlobalParentID]
      , [GlobalParent]
      , [GlobalParentCalculatedID]             
      , [GlobalParentCalculated]               
      , [LocalParentID]
      , [LocalParent]
      , [LocalParentCalculatedID]           
      , [LocalParentCalculated]             
      , [SalesOrderTypeID]
      , [SalesOrderType]
      , [FinNetAmountRealProduct]
      , [FinNetAmountFreight]
      , [FinNetAmountMinQty]
      , [FinNetAmountEngServ]
      , [FinNetAmountMisc]
      , [FinNetAmountServOther]
      , [FinNetAmountVerp]
      , [FinRebateAccrual]
      , [PaymentTermCashDiscountPercentageRate]
      , [FinNetAmountOtherSales]
      , [FinReserveCashDiscount]
      , [FinNetAmountAllowances]
      , [FinSales100]
      , [AccountingDate]
      , [axbi_DataAreaID]                     
      , [axbi_DataAreaName]                   
      , [axbi_DataAreaGroup]                  
      , [axbi_MaterialID]                     
      , [axbi_CustomerID]
      , [MaterialCalculated]
      , [SoldToPartyCalculated]
      , [InOutID]
      , [axbi_ItemNoCalc]
      , [t_applicationId]
      , [t_extractionDtm]
      , [t_lastActionCd]   
  FROM original	