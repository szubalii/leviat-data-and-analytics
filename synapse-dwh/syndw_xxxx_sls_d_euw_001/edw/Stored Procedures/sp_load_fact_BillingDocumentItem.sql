CREATE PROC [edw].[sp_load_fact_BillingDocumentItem]
    @t_jobId        [varchar](36),
    @t_jobDtm       [datetime],
    @t_lastActionCd [varchar](1),
    @t_jobBy [nvarchar](20)
AS
BEGIN

    DECLARE @isS4HViewNotEmpty   BIT = 0;
    DECLARE @isAXBIViewNotEmpty  BIT = 0;
    DECLARE @errmessage NVARCHAR(2048);

    BEGIN TRY
	    IF OBJECT_ID('[edw].[fact_BillingDocumentItem_tmp]') IS NOT NULL
		    DROP TABLE [edw].[fact_BillingDocumentItem_tmp];

        CREATE TABLE [edw].[fact_BillingDocumentItem_tmp]
        WITH
        (
            DISTRIBUTION = HASH (BillingDocument),
            CLUSTERED COLUMNSTORE INDEX
        )
        as select * from  [edw].[fact_BillingDocumentItem] WHERE 1=0;

	    SELECT TOP 1 @isS4HViewNotEmpty = 1 FROM [edw].[vw_BillingDocumentItem_s4h_fin];

        IF (@isS4HViewNotEmpty = 0)
            begin
                SET @errmessage = 'Temporary view [edw].[vw_BillingDocumentItem_s4h_fin] was not filled with data from S4H.';
                THROW 50001, @errmessage, 1;
            end;

        INSERT INTO [edw].[fact_BillingDocumentItem_tmp](
            [nk_fact_BillingDocumentItem]
        ,   [BillingDocument]
        ,   [BillingDocumentItem]
        ,   [CurrencyTypeID]
        ,   [CurrencyType]
        ,   [CurrencyID]
        ,   [ExchangeRate]
        ,   [SalesDocumentItemCategoryID] -- new
        ,   [SalesDocumentItemTypeID] --new
        ,   [ReturnItemProcessingType]
        ,   [BillingDocumentTypeID]
        ,   [BillingDocumentCategoryID] -- new
        ,   [SDDocumentCategoryID] -- new
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
        ,   [CustomerPriceGroupID] --new
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
        ,   [TransactionCurrencyID] -- new
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
        ,   [CompanyCodeCurrencyID] --new
        ,   [AccountingExchangeRate]
        ,   [AccountingExchangeRateIsSet]
        ,   [ReferenceSDDocument]
        ,   [ReferenceSDDocumentItem]
        ,   [ReferenceSDDocumentCategoryID] --new
        ,   [SalesDocumentID]
        ,   [SalesDocumentItemID]
        ,   [SalesSDDocumentCategoryID] --new
        ,   [HigherLevelItem]
        ,   [BillingDocumentItemInPartSgmt]
        ,   [SalesGroup]
        ,   [AdditionalCustomerGroup1]
        ,   [AdditionalCustomerGroup2]
        ,   [AdditionalCustomerGroup3]
        ,   [AdditionalCustomerGroup4]
        ,   [AdditionalCustomerGroup5]
        ,   [SDDocumentReasonID] -- new
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
        ,   [MaterialCalculated]
        ,   [SoldToPartyCalculated]
        ,   [InOutID]
        ,   [axbi_ItemNoCalc]
        ,   [t_applicationId]
        ,   [t_extractionDtm]
        ,   [t_jobId]
        ,   [t_jobDtm]
        ,   [t_lastActionCd]
        ,   [t_jobBy]
        )
        SELECT
            [nk_fact_BillingDocumentItem]
        ,   [BillingDocument]
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
        ,   [MaterialCalculated]
        ,   [SoldToPartyCalculated]
        ,   [InOutID]
        ,   NULL            AS [axbi_ItemNoCalc]
        ,   [t_applicationId]
        ,   [t_extractionDtm]
        ,   @t_jobId        AS t_jobId
        ,   @t_jobDtm       AS t_jobDtm
        ,   @t_lastActionCd AS t_lastActionCd
        ,   @t_jobBy        AS t_jobBy
        FROM
            [edw].[vw_BillingDocumentItem_s4h_fin]

	    SELECT TOP 1 @isAXBIViewNotEmpty = 1 FROM [edw].[vw_BillingDocumentItem_axbi];

        IF (@isAXBIViewNotEmpty = 0)
            begin
                SET @errmessage = 'Temporary view [edw].[vw_BillingDocumentItem_axbi] was not filled with data from AXBI.';
                THROW 50001, @errmessage, 1;
            end;

        INSERT INTO [edw].[fact_BillingDocumentItem_tmp](
            [nk_fact_BillingDocumentItem]
        ,   [BillingDocument]
        ,   [BillingDocumentItem]
        ,   [CurrencyTypeID]
        ,   [CurrencyType]
        ,   [CurrencyID]
        ,   [ExchangeRate]
        ,   [SalesDocumentItemCategoryID] -- new
        ,   [SalesDocumentItemTypeID] --new
        ,   [ReturnItemProcessingType]
        ,   [BillingDocumentTypeID]
        ,   [BillingDocumentCategoryID] -- new
        ,   [SDDocumentCategoryID] -- new
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
        ,   [CustomerPriceGroupID] --new
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
        ,   [TransactionCurrencyID] -- new
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
        ,   [CompanyCodeCurrencyID] --new
        ,   [AccountingExchangeRate]
        ,   [AccountingExchangeRateIsSet]
        ,   [ReferenceSDDocument]
        ,   [ReferenceSDDocumentItem]
        ,   [ReferenceSDDocumentCategoryID] --new
        ,   [SalesDocumentID]
        ,   [SalesDocumentItemID]
        ,   [SalesSDDocumentCategoryID] --new
        ,   [HigherLevelItem]
        ,   [BillingDocumentItemInPartSgmt]
        ,   [SalesGroup]
        ,   [AdditionalCustomerGroup1]
        ,   [AdditionalCustomerGroup2]
        ,   [AdditionalCustomerGroup3]
        ,   [AdditionalCustomerGroup4]
        ,   [AdditionalCustomerGroup5]
        ,   [SDDocumentReasonID] -- new
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
        ,   [t_jobId]
        ,   [t_jobDtm]
        ,   [t_lastActionCd]
        ,   [t_jobBy]
        )
        SELECT
            [nk_fact_BillingDocumentItem]
        ,   [BillingDocument]
        ,   [BillingDocumentItem]
        ,   [CurrencyTypeID]
        ,   [CurrencyType]
        ,   [CurrencyID]
        ,   [ExchangeRate]
        ,   NULL AS [SalesDocumentItemCategoryID]
        ,   NULL AS [SalesDocumentItemTypeID]
        ,   [ReturnItemProcessingType]
        ,   NULL AS [BillingDocumentTypeID]
        ,   NULL AS [BillingDocumentCategoryID]
        ,   [SDDocumentCategoryID]
        ,   NULL AS [CreationDate]
        ,   NULL AS [CreationTime]
        ,   NULL AS [LastChangeDate]
        ,   [BillingDocumentDate]
        ,   NULL AS [BillingDocumentIsTemporary]
        ,   NULL AS [OrganizationDivision]
        ,   NULL AS [Division]
        ,   [SalesOfficeID]
        ,   [SalesOrganizationID]
        ,   [DistributionChannelID]
        ,   [Material]
        ,   [Material] AS [ProductSurrogateKey]
        ,   NULL AS [OriginallyRequestedMaterial]
        ,   NULL AS [InternationalArticleNumber]
        ,   NULL AS [PricingReferenceMaterial]
        ,   [LengthInMPer1]
        ,   [LengthInM]
        ,   NULL AS [Batch]
        ,   NULL AS [MaterialGroupID]
        ,   [BrandID]
        ,   [Brand]
        ,   NULL AS [AdditionalMaterialGroup2]
        ,   NULL AS [AdditionalMaterialGroup3]
        ,   NULL AS [AdditionalMaterialGroup4]
        ,   NULL AS [AdditionalMaterialGroup5]
        ,   NULL AS [MaterialCommissionGroup]
        ,   [PlantID]
        ,   NULL AS [StorageLocationID]
        ,   NULL AS [BillingDocumentIsCancelled]
        ,   NULL AS [CancelledBillingDocument]
        ,   'N'  AS [CancelledInvoiceEffect]
        ,   NULL AS [BillingDocumentItemText]
        ,   NULL AS [ServicesRenderedDate]
        ,   [BillingQuantity]
        ,   [BillingQuantityUnitID]
        ,   NULL AS [BillingQuantityInBaseUnit]
        ,   NULL AS [BaseUnit]
        ,   NULL AS [MRPRequiredQuantityInBaseUnit]
        ,   NULL AS [BillingToBaseQuantityDnmntr]
        ,   NULL AS [BillingToBaseQuantityNmrtr]
        ,   NULL AS [ItemGrossWeight]
        ,   NULL AS [ItemNetWeight]
        ,   NULL AS [ItemWeightUnit]
        ,   NULL AS [ItemVolume]
        ,   NULL AS [ItemVolumeUnit]
        ,   NULL AS [BillToPartyCountry]
        ,   NULL AS [BillToPartyRegion]
        ,   NULL AS [BillingPlanRule]
        ,   NULL AS [BillingPlan]
        ,   NULL AS [BillingPlanItem]
        ,   NULL AS [CustomerPriceGroupID]
        ,   NULL AS [PriceListTypeID]
        ,   NULL AS [TaxDepartureCountry]
        ,   NULL AS [VATRegistration]
        ,   NULL AS [VATRegistrationCountry]
        ,   NULL AS [VATRegistrationOrigin]
        ,   NULL AS [CustomerTaxClassification1]
        ,   NULL AS [CustomerTaxClassification2]
        ,   NULL AS [CustomerTaxClassification3]
        ,   NULL AS [CustomerTaxClassification4]
        ,   NULL AS [CustomerTaxClassification5]
        ,   NULL AS [CustomerTaxClassification6]
        ,   NULL AS [CustomerTaxClassification7]
        ,   NULL AS [CustomerTaxClassification8]
        ,   NULL AS [CustomerTaxClassification9]
        ,   NULL AS [SDPricingProcedure]
        ,   [NetAmount]
        ,   NULL AS [TransactionCurrencyID]
        ,   NULL AS [GrossAmount]
        ,   NULL AS [PricingDate]
        ,   NULL AS [PriceDetnExchangeRate]
        ,   NULL AS [PricingScaleQuantityInBaseUnit]
        ,   NULL AS [TaxAmount]
        ,   [CostAmount]
        ,   NULL AS [Subtotal1Amount]
        ,   NULL AS [Subtotal2Amount]
        ,   NULL AS [Subtotal3Amount]
        ,   NULL AS [Subtotal4Amount]
        ,   NULL AS [Subtotal5Amount]
        ,   NULL AS [Subtotal6Amount]
        ,   NULL AS [StatisticalValueControl]
        ,   NULL AS [StatisticsExchangeRate]
        ,   NULL AS [StatisticsCurrency]
        ,   NULL AS [SalesOrganizationCurrency]
        ,   NULL AS [EligibleAmountForCashDiscount]
        ,   NULL AS [ContractAccount]
        ,   NULL AS [CustomerPaymentTerms]
        ,   NULL AS [PaymentMethod]
        ,   NULL AS [PaymentReference]
        ,   NULL AS [FixedValueDate]
        ,   NULL AS [AdditionalValueDays]
        ,   NULL AS [PayerParty]
        ,   NULL AS [CompanyCode]
        ,   NULL AS [FiscalYear]
        ,   NULL AS [FiscalPeriod]
        ,   NULL AS [CustomerAccountAssignmentGroupID]
        ,   NULL AS [BusinessArea]
        ,   NULL AS [ProfitCenter]
        ,   NULL AS [OrderID]
        ,   NULL AS [ControllingArea]
        ,   NULL AS [ProfitabilitySegment]
        ,   NULL AS [CostCenter]
        ,   NULL AS [OriginSDDocument]
        ,   NULL AS [OriginSDDocumentItem]
        ,   NULL AS [PriceDetnExchangeRateDate]
        ,   NULL AS [ExchangeRateTypeID]
        ,   NULL AS [FiscalYearVariant]
        ,   NULL AS [CompanyCodeCurrencyID]
        ,   NULL AS [AccountingExchangeRate]
        ,   NULL AS [AccountingExchangeRateIsSet]
        ,   NULL AS [ReferenceSDDocument]
        ,   NULL AS [ReferenceSDDocumentItem]
        ,   NULL AS [ReferenceSDDocumentCategoryID]
        ,   [SalesDocumentID]        as [SalesDocumentID]
        ,   NULL AS [SalesDocumentItemID]
        ,   NULL AS [SalesSDDocumentCategoryID]
        ,   NULL AS [HigherLevelItem]
        ,   NULL AS [BillingDocumentItemInPartSgmt]
        ,   NULL AS [SalesGroup]
        ,   NULL AS [AdditionalCustomerGroup1]
        ,   NULL AS [AdditionalCustomerGroup2]
        ,   NULL AS [AdditionalCustomerGroup3]
        ,   NULL AS [AdditionalCustomerGroup4]
        ,   NULL AS [AdditionalCustomerGroup5]
        ,   NULL AS [SDDocumentReasonID]
        ,   NULL AS [ItemIsRelevantForCredit]
        ,   NULL AS [CreditRelatedPrice]
        ,   [SalesDistrictID]
        ,   [CustomerGroupID]
        ,   [SoldToParty]
        ,   [CountryID]      AS [CountryID]
        ,   NULL AS [ShipToParty]
        ,   NULL AS [BillToParty]
        ,   NULL AS [ShippingPoint]
        ,   NULL AS [IncotermsVersion]
        ,   NULL AS [IncotermsClassification]
        ,   NULL AS [IncotermsTransferLocation]
        ,   NULL AS [IncotermsLocation1]
        ,   NULL AS [IncotermsLocation2]
        ,   NULL AS [ShippingCondition]
        ,   [QuantitySold]
        ,   NULL AS [GrossMargin]
        ,   [ExternalSalesAgentID]
        ,   NULL AS [ExternalSalesAgent]
        ,   [ProjectID]
        ,   [Project]
        ,   [SalesEmployeeID]
        ,   NULL AS [SalesEmployee]
        ,   [GlobalParentID]
        ,   NULL AS [GlobalParent]
        ,   [GlobalParentCalculatedID]
        ,   [GlobalParentCalculated]
        ,   NULL AS [LocalParentID]
        ,   NULL AS [LocalParent]
        ,   [LocalParentCalculatedID]
        ,   [LocalParentCalculated]
        ,   [SalesOrderTypeID]
        ,   NULL AS [BillToID]
        ,   NULL AS [BillTo]
        ,   [FinNetAmountRealProduct] as [FinNetAmountRealProduct]
        ,   NULL AS [FinNetAmountFreight]
        ,   NULL AS [FinNetAmountMinQty]
        ,   NULL AS [FinNetAmountEngServ]
        ,   NULL AS [FinNetAmountMisc]
        ,   [FinNetAmountServOther] AS [FinNetAmountServOther]
        ,   NULL AS [FinNetAmountVerp]
        ,   NULL AS [FinRebateAccrual]
        ,   NULL AS [PaymentTermCashDiscountPercentageRate]
        ,   [FinNetAmountOtherSales] as [FinNetAmountOtherSales]
        ,   NULL AS [FinReserveCashDiscount]
        ,   [FinNetAmountAllowances] as [FinNetAmountAllowances]
        ,   [FinSales100]    AS [FinSales100]
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
        ,   @t_jobId         AS t_jobId
        ,   @t_jobDtm        AS t_jobDtm
        ,   @t_lastActionCd  AS t_lastActionCd
        ,   @t_jobBy         AS t_jobBy
        FROM
            [edw].[vw_BillingDocumentItem_axbi];

        RENAME OBJECT [edw].[fact_BillingDocumentItem] TO [fact_BillingDocumentItem_old];
        RENAME OBJECT [edw].[fact_BillingDocumentItem_tmp] TO [fact_BillingDocumentItem];
        DROP TABLE [edw].[fact_BillingDocumentItem_old];

    END TRY
    BEGIN CATCH
        SET @errmessage = 'Internal error in ' + ERROR_PROCEDURE() + '. ' +  ERROR_MESSAGE();
		THROW 50001, @errmessage, 1;
    END CATCH

END
GO