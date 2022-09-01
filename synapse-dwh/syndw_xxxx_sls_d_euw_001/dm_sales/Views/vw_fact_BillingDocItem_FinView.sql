CREATE VIEW [dm_sales].[vw_fact_BillingDocItem_FinView]
    AS

SELECT 
    docBilling.[BillingDocument]
,   docBilling.[BillingDocumentItem]
,   docBilling.[CurrencyType]
,   docBilling.[CurrencyID]
,   docBilling.[Currency]
,   docBilling.[SalesDocumentItemCategoryID]
,   docBilling.[SalesDocumentItemCategory]
,   docBilling.[SalesDocumentItemTypeID]
,   docBilling.[SalesDocumentItemType]
,   docBilling.[ReturnItemProcessingType]
,   docBilling.[BillingDocumentTypeID]
,   docBilling.[BillingDocumentType]
,   docBilling.[BillingDocumentCategoryID]
,   docBilling.[BillingDocumentCategory]
,   docBilling.[SDDocumentCategoryID]
,   docBilling.[SDDocumentCategory]
,   docBilling.[BillingDocumentDate]
,   docBilling.[SalesOrganizationID]
,   docBilling.[SalesOrganization]
,   docBilling.[DistributionChannelID]
,   docBilling.[DistributionChannel]
,   docBilling.[Material]
,   docBilling.[BrandID]
,   docBilling.[Brand]
,   docBilling.[BillingDocumentIsCancelled]
,   docBilling.[CancelledInvoiceEffect]
,   docBilling.[BillingQuantity]  
--,   docBilling.[UnitOfMeasureID]        AS [BillingQuantityUnitID]
--,   docBilling.[UnitOfMeasure]          AS [BillingQuantityUnit]
,   CAST (docBilling.[NetAmount] AS decimal (15,2)) as [NetAmount] 
,   docBilling.[TransactionCurrencyID]
,   CAST (docBilling.[GrossAmount] AS decimal (15,2)) as [GrossAmount] 
,   CAST (docBilling.[TaxAmount] AS decimal (15,2)) as [TaxAmount] 
,   CAST (docBilling.[CostAmount] AS decimal (15,2)) as [CostAmount] 
,   docBilling.[FiscalYear]
,   docBilling.[FiscalPeriod]
,   docBilling.[ProfitCenter]
--,   docBilling.[OriginSDDocument]
--,   docBilling.[OriginSDDocumentItem]
,   docBilling.[ExchangeRateTypeID]
,   docBilling.[ExchangeRateType]
,   docBilling.[SDDocumentCategoryID] AS [ReferenceSDDocumentCategoryID]
,   docBilling.[SDDocumentCategory]   AS [ReferenceSDDocumentCategory]
,   docBilling.[SalesDocumentID]
,   docBilling.[SalesDocumentItemID]
,   docBilling.[SDDocumentCategoryID] AS [SalesSDDocumentCategoryID]
,   docBilling.[SDDocumentCategory]   AS [SalesSDDocumentCategory]
,   docBilling.[HigherLevelItem]
,   docBilling.[SDDocumentReasonID]
,   docBilling.[SDDocumentReason]
,   docBilling.[SalesDistrictID]
,   docBilling.[SalesDistrict]
,   docBilling.[CustomerGroup]
,   docBilling.[SoldToParty]
,   docBilling.[CountryID]
,   docBilling.[Country]
--,   docBilling.[ShipToParty]
,   docBilling.[BillToParty]
,   docBilling.[QuantitySold] 
,   CAST (docBilling.[GrossMargin] AS decimal (15,2)) as [GrossMargin] 
,   docBilling.[ExternalSalesAgentID]
,   docBilling.[ExternalSalesAgent]
,   docBilling.[ProjectID]
,   docBilling.[Project]
,   docBilling.[SalesEmployeeID]
,   docBilling.[SalesEmployee]
,   docBilling.[GlobalParentID]
,   docBilling.[GlobalParent]
,   docBilling.[LocalParentID]
,   docBilling.[LocalParent]
,   docBilling.[SalesOrderTypeID]
,   docBilling.[GlobalParentCalculatedID]
,   docBilling.[GlobalParentCalculated]
,   docBilling.[LocalParentCalculatedID]
,   docBilling.[LocalParentCalculated]
,   docBilling.[SalesOrderType]
,   CAST (docBilling.[FinNetAmountRealProduct] AS decimal (15,2)) as [FinNetAmountRealProduct] 
,   CAST (docBilling.[FinNetAmountFreight] AS decimal (15,2)) as [FinNetAmountFreight] 
,   CAST (docBilling.[FinNetAmountMinQty] AS decimal (15,2))as [FinNetAmountMinQty] 
,   CAST (docBilling.[FinNetAmountEngServ] AS decimal (15,2)) as [FinNetAmountEngServ] 
,   CAST (docBilling.[FinNetAmountMisc] AS decimal (15,2)) as [FinNetAmountMisc] 
,   CAST (docBilling.[FinNetAmountServOther] AS decimal (15,2)) as [FinNetAmountServOther] 
,   CAST (docBilling.[FinNetAmountVerp] AS decimal (15,2)) as [FinNetAmountVerp] 
,   CAST (docBilling.[FinRebateAccrual] AS decimal (15,2)) as [FinRebateAccrual] 
,   CAST (docBilling.[FinReserveCashDiscount] AS decimal (15,2)) as [FinReserveCashDiscount] 
,   CAST (docBilling.[FinSales100] AS decimal (15,2)) as [FinSales100] 
,   CAST (docBilling.[FinNetAmountOtherSales] AS decimal (15,2)) as [FinNetAmountOtherSales] 
,   CAST (docBilling.[FinNetAmountAllowances] AS decimal (15,2)) as [FinNetAmountAllowances] 
,   docBilling.[axbi_DataAreaID]
,   docBilling.[axbi_DataAreaName]
,   docBilling.[axbi_DataAreaGroup]
,   docBilling.[axbi_MaterialID]
,   docBilling.[axbi_CustomerID]
,   docBilling.[MaterialCalculated]
,   docBilling.[SoldToPartyCalculated]
,   docBilling.[InOutID]
,   VT.[ValueTypeID]
,   VT.[ValueType]
,   docBilling.[t_applicationId]
,   docBilling.[t_extractionDtm]
FROM
    [dm_sales].[vw_fact_BillingDocumentItem]  AS docBilling
CROSS JOIN
    [edw].[dim_ValueType] VT
WHERE VT.ValueTypeID= '10'
UNION ALL
SELECT
    docBillingUS.[BillingDocument]
,   docBillingUS.[BillingDocumentItem]
,   docBillingUS.[CurrencyType]
,   docBillingUS.[CurrencyID]
,   NULL AS [Currency]
,   NULL AS [SalesDocumentItemCategoryID]
,   NULL AS [SalesDocumentItemCategory]
,   NULL AS [SalesDocumentItemTypeID]
,   NULL AS [SalesDocumentItemType]
,   NULL AS [ReturnItemProcessingType]
,   dimBDT.[BillingDocumentTypeID]
,   dimBDT.[BillingDocumentType]
,   NULL AS [BillingDocumentCategoryID]
,   NULL AS [BillingDocumentCategory]
,   dimSDDC.[SDDocumentCategoryID] 
,   dimSDDC.[SDDocumentCategory]
,   docBillingUS.[BillingDocumentDate]
,   docBillingUS.[SalesOrganizationID]
,   dimSOrg.SalesOrganization AS [SalesOrganization]
,   NULL AS [DistributionChannelID]
,   NULL AS [DistributionChannel]
,   docBillingUS.[Material]
,   NULL AS [BrandID]
,   NULL AS [Brand]
,   NULL AS [BillingDocumentIsCancelled]
,   'N'  AS [CancelledInvoiceEffect]
,   NULL AS [BillingQuantity]
--,   docBilling.[UnitOfMeasureID]        AS [BillingQuantityUnitID]
--,   docBilling.[UnitOfMeasure]          AS [BillingQuantityUnit]
,   CAST (docBillingUS.[NetAmount] AS decimal (15,2)) as [NetAmount] 
,   docBillingUS.[TransactionCurrencyID]
,   NULL AS [GrossAmount]
,   CAST (docBillingUS.[TaxAmount] AS decimal (15,2)) as [TaxAmount] 
,   CAST (docBillingUS.[CostAmount] AS decimal (15,2)) as [CostAmount] 
,   NULL AS [FiscalYear]
,   NULL AS [FiscalPeriod]
,   NULL AS [ProfitCenter]
--,   docBilling.[OriginSDDocument]
--,   docBilling.[OriginSDDocumentItem]
,   NULL AS [ExchangeRateTypeID]
,   NULL AS [ExchangeRateType]
,   NULL AS [ReferenceSDDocumentCategoryID]
,   NULL AS [ReferenceSDDocumentCategory]
,   docBillingUS.[SalesDocumentID]
,   NULL AS [SalesDocumentItemID]
,   NULL AS [SalesSDDocumentCategoryID]
,   NULL AS [SalesSDDocumentCategory]
,   NULL AS [HigherLevelItem]
,   NULL AS [SDDocumentReasonID]
,   NULL AS [SDDocumentReason]
,   docBillingUS.[SalesDistrictID]
,   docBillingUS.[SalesDistrictID] AS [SalesDistrict]
,   dimCGr.[CustomerGroup]
,   NULL AS [SoldToParty]
,   dimC.[CountryID]
,   dimC.[Country]
--,   docBilling.[ShipToParty]
,   NULL AS [BillToParty]
,   docBillingUS.[QuantitySold]
,   CAST (docBillingUS.[GrossMargin] AS decimal (15,2)) as [GrossMargin] 
,   NULL AS [ExternalSalesAgentID]
,   NULL AS [ExternalSalesAgent]
,   NULL AS [ProjectID]
,   NULL AS [Project]
,   NULL AS [SalesEmployeeID]
,   NULL AS [SalesEmployee]
,   NULL AS [GlobalParentID]
,   NULL AS [GlobalParent]
,   NULL AS [LocalParentID]
,   NULL AS [LocalParent]
,   NULL AS [SalesOrderTypeID]
,   NULL AS [GlobalParentCalculatedID]
,   NULL AS [GlobalParentCalculated]
,   NULL AS [LocalParentCalculatedID]
,   NULL AS [LocalParentCalculated]
,   NULL AS [SalesOrderType]
,   CAST (docBillingUS.[FinNetAmount] AS decimal (15,2)) as [FinNetAmountRealProduct]  
,   CAST (docBillingUS.[FinNetAmountFreight] AS decimal (15,2)) as [FinNetAmountFreight] 
,   CAST (docBillingUS.[FinNetAmountMinQty] AS decimal (15,2))as [FinNetAmountMinQty] 
,   CAST (docBillingUS.[FinNetAmountEngServ] AS decimal (15,2)) as [FinNetAmountEngServ] 
,   CAST (docBillingUS.[FinNetAmountMisc] AS decimal (15,2)) as [FinNetAmountMisc] 
,   CAST (docBillingUS.[FinNetAmountServOther] AS decimal (15,2)) as [FinNetAmountServOther] 
,   CAST (docBillingUS.[FinNetAmountVerp] AS decimal (15,2)) as [FinNetAmountVerp] 
,   CAST (docBillingUS.[FinRebateAccrual] AS decimal (15,2)) as [FinRebateAccrual] 
,   CAST (docBillingUS.[FinReserveCashDiscount] AS decimal (15,2)) as [FinReserveCashDiscount] 
,   CAST (docBillingUS.[FinSales100] AS decimal (15,2)) as [FinSales100] 
,   CAST (docBillingUS.[FinNetAmountOtherSales] AS decimal (15,2)) as [FinNetAmountOtherSales] 
,   CAST (docBillingUS.[FinNetAmountAllowances] AS decimal (15,2)) as [FinNetAmountAllowances] 
,   NULL AS [axbi_DataAreaID]
,   NULL AS [axbi_DataAreaName]
,   NULL AS [axbi_DataAreaGroup]
,   docBillingUS.[axbi_MaterialID]
,   docBillingUS.[axbi_CustomerID]
,   docBillingUS.[MaterialCalculated]
,   docBillingUS.[SoldToPartyCalculated]
,   docBillingUS.[InOutID]
,   VT.[ValueTypeID]
,   VT.[ValueType]
,   docBillingUS.[t_applicationId]
,   docBillingUS.[t_extractionDtm]
FROM
    [edw].[fact_BillingDocumentItem_US]  AS docBillingUS
LEFT JOIN 
    [edw].[dim_BillingDocumentType] dimBDT
    ON
        dimBDT.[BillingDocumentTypeID] = docBillingUS.[BillingDocumentTypeID]        
LEFT JOIN 
    [edw].[dim_SDDocumentCategory] dimSDDC
        ON dimSDDC.[SDDocumentCategoryID] = docBillingUS.[SDDocumentCategoryID]
LEFT JOIN
    [edw].[dim_SalesOrganization_US] dimSOrg
        ON dimSOrg.[SalesOrganizationID] = docBillingUS.[SalesOrganizationID]
LEFT JOIN
    [edw].[dim_CustomerGroup] dimCGr
        ON dimCGr.[CustomerGroup] = docBillingUS.[CustomerGroupID]
LEFT JOIN
    [edw].[dim_Country] dimC
        ON dimC.[CountryID] = docBillingUS.[CountryID]
CROSS JOIN
    [edw].[dim_ValueType] VT
WHERE VT.ValueTypeID = '10'
UNION ALL
SELECT
    CONCAT('BUDGET', docBillingBudget.[sk_fact_Budget]) AS [BillingDocument]
,   '00010' AS [BillingDocumentItem]
,   docBillingBudget.[CurrencyType]
,   dimCr.[CurrencyID]
,   dimCr.[Currency]
,   NULL [SalesDocumentItemCategoryID]
,   NULL [SalesDocumentItemCategory]
,   NULL [SalesDocumentItemTypeID]
,   NULL [SalesDocumentItemType]
,   NULL AS [ReturnItemProcessingType]
,   NULL AS [BillingDocumentTypeID]
,   NULL AS [BillingDocumentType]
,   NULL AS [BillingDocumentCategoryID]
,   NULL AS [BillingDocumentCategory]
,   NULL AS [SDDocumentCategoryID]
,   NULL AS [SDDocumentCategory]
,   docBillingBudget.[AccountingDate] AS [BillingDocumentDate]
,   docBillingBudget.[SalesOrganizationID]
,   dimSOrg.[SalesOrganization] AS [SalesOrganization]
,   NULL AS [DistributionChannelID]
,   NULL AS [DistributionChannel]
,   NULL AS [Material]
,   NULL AS [BrandID]
,   NULL AS [Brand]
,   NULL AS [BillingDocumentIsCancelled]
,   'N'  AS [CancelledInvoiceEffect]
,   NULL AS [BillingQuantity]
--,   NULL AS [BillingQuantityUnitID]
--,   NULL AS [BillingQuantityUnit]
,   NULL AS [NetAmount]
,   NULL AS [TransactionCurrencyID]
,   NULL AS [GrossAmount]
,   NULL AS [TaxAmount]
,   NULL AS [CostAmount]
,   NULL AS [FiscalYear]
,   NULL AS [FiscalPeriod]
,   NULL AS [ProfitCenter]
--,   NULL AS [OriginSDDocument]
--,   NULL AS [OriginSDDocumentItem]
,   NULL AS ExchangeRateTypeID
,   NULL AS ExchangeRateType
,   NULL AS SDDocumentCategoryID
,   NULL AS SDDocumentCategory
,   NULL AS SalesDocumentID
,   NULL AS SalesDocumentItemID
,   NULL AS SDDocumentCategoryID
,   NULL AS SDDocumentCategory
,   NULL AS HigherLevelItem
,   NULL AS SDDocumentReasonID
,   NULL AS SDDocumentReason
,   NULL AS SalesDistrictID
,   NULL AS SalesDistrict
,   NULL AS [CustomerGroup]
,   docBillingBudget.[SoldToParty]
,   NULL as [CountryID]
,   NULL AS [Country]
--,   NULL AS [ShipToParty]
,   NULL AS [BillToParty]
,   NULL AS [QuantitySold]
,   NULL AS [GrossMargin]
,   NULL AS [ExternalSalesAgentID]
,   NULL AS [ExternalSalesAgent]
,   NULL AS [ProjectID]
,   NULL AS [Project]
,   NULL AS [SalesEmployeeID]
,   NULL AS [SalesEmployee]
,   NULL AS [GlobalParentID]
,   NULL AS [GlobalParent]
,   NULL AS [LocalParentID]
,   NULL AS [LocalParent]
,   NULL AS [SalesOrderTypeID]
,   NULL AS [GlobalParentCalculatedID]
,   NULL AS [GlobalParentCalculated]
,   NULL AS [LocalParentCalculatedID]
,   NULL AS [LocalParentCalculated]
,   NULL AS [SalesDocumentType]
,   NULL AS [FinNetAmountRealProduct]
,   NULL AS [FinNetAmountFreight]
,   NULL AS [FinNetAmountMinQty]
,   NULL AS [FinNetAmountEngServ]
,   NULL AS [FinNetAmountMisc]
,   NULL AS [FinNetAmountServOther]
,   NULL AS [FinNetAmountVerp]
,   NULL AS [FinRebateAccrual]
,   NULL AS [FinReserveCashDiscount]
,   CAST (docBillingBudget.[FinSales100] AS decimal (15,2)) as [FinSales100] 
,   NULL AS [FinNetAmountOtherSales]
,   NULL AS [FinNetAmountAllowances]
,   docBillingBudget.[axbi_DataAreaID]
,   docBillingBudget.[axbi_DataAreaName]
,   docBillingBudget.[axbi_DataAreaGroup]
,   docBillingBudget.[axbi_MaterialID]
,   docBillingBudget.[axbi_CustomerID]
,   docBillingBudget.[MaterialCalculated]
,   docBillingBudget.[SoldToPartyCalculated]
,   docBillingBudget.[InOutID]
,   VT.[ValueTypeID]
,   VT.[ValueType]
,   docBillingBudget.[t_applicationId]
,   docBillingBudget.[t_extractionDtm]
FROM
    [edw].[fact_Budget_axbi] docBillingBudget
LEFT JOIN
    [edw].[dim_Currency] dimCr
    ON
        dimCr.[CurrencyID] = docBillingBudget.[CurrencyID]
left join
    [edw].[dim_SalesOrganization] dimSOrg
    on
        dimSOrg.[SalesOrganizationID] = docBillingBudget.[SalesOrganizationID]
CROSS JOIN
    [edw].[dim_ValueType] VT
WHERE VT.ValueTypeID= '20'

UNION ALL
SELECT
    CONCAT('BUDGETUS', docBillingBudget_US.[sk_fact_Budget_US]) AS [BillingDocument]
,   '00010' AS [BillingDocumentItem]
,   docBillingBudget_US.[CurrencyType]
,   dimCr.[CurrencyID]
,   dimCr.[Currency]
,   NULL AS [SalesDocumentItemCategoryID]
,   NULL AS [SalesDocumentItemCategory]
,   NULL AS [SalesDocumentItemTypeID]
,   NULL AS [SalesDocumentItemType]
,   NULL AS [ReturnItemProcessingType]
,   NULL AS [BillingDocumentTypeID]
,   NULL AS [BillingDocumentType]
,   NULL AS [BillingDocumentCategoryID]
,   NULL AS [BillingDocumentCategory]
,   NULL AS [SDDocumentCategoryID]
,   NULL AS [SDDocumentCategory]
,   docBillingBudget_US.[BillingDocumentDate]
,   docBillingBudget_US.[SalesOrganizationID]
,   docBillingBudget_US.[SalesOrgname] AS [SalesOrganization]
,   NULL AS [DistributionChannelID]
,   NULL AS [DistributionChannel]
,   NULL AS [Material]
,   NULL AS [BrandID]
,   NULL AS [Brand]
,   NULL AS [BillingDocumentIsCancelled]
,   'N'  AS [CancelledInvoiceEffect]
,   NULL AS [BillingQuantity]
--,   NULL AS [BillingQuantityUnitID]
--,   NULL AS [BillingQuantityUnit]
,   CAST (docBillingBudget_US.[NetAmount] AS decimal (15,2)) as [NetAmount] 
,   docBillingBudget_US.[TransactionCurrencyID]
,   NULL AS [GrossAmount]
,   NULL AS [TaxAmount]
,   NULL AS [CostAmount]
,   NULL AS [FiscalYear]
,   NULL AS [FiscalPeriod]
,   NULL AS [ProfitCenter]
--,   NULL AS [OriginSDDocument]
--,   NULL AS [OriginSDDocumentItem]
,   NULL AS ExchangeRateTypeID
,   NULL AS ExchangeRateType
,   NULL AS SDDocumentCategoryID
,   NULL AS SDDocumentCategory
,   NULL AS SalesDocumentID
,   NULL AS SalesDocumentItemID
,   NULL AS SDDocumentCategoryID
,   NULL AS SDDocumentCategory
,   NULL AS HigherLevelItem
,   NULL AS SDDocumentReasonID
,   NULL AS SDDocumentReason
,   NULL AS SalesDistrictID
,   NULL AS SalesDistrict
,   NULL AS [CustomerGroup]
,   NULL AS [SoldToParty]
,   NULL as [CountryID]
,   NULL AS [Country]
--,   NULL AS [ShipToParty]
,   NULL AS [BillToParty]
,   NULL AS [QuantitySold]
,   NULL AS [GrossMargin]
,   NULL AS [ExternalSalesAgentID]
,   NULL AS [ExternalSalesAgent]
,   NULL AS [ProjectID]
,   NULL AS [Project]
,   NULL AS [SalesEmployeeID]
,   NULL AS [SalesEmployee]
,   NULL AS [GlobalParentID]
,   NULL AS [GlobalParent]
,   NULL AS [LocalParentID]
,   NULL AS [LocalParent]
,   NULL AS [SalesOrderTypeID]
,   NULL AS [GlobalParentCalculatedID]
,   NULL AS [GlobalParentCalculated]
,   NULL AS [LocalParentCalculatedID]
,   NULL AS [LocalParentCalculated]
,   NULL AS [SalesDocumentType]
,   NULL AS [FinNetAmountRealProduct]
,   NULL AS [FinNetAmountFreight]
,   NULL AS [FinNetAmountMinQty]
,   NULL AS [FinNetAmountEngServ]
,   NULL AS [FinNetAmountMisc]
,   NULL AS [FinNetAmountServOther]
,   NULL AS [FinNetAmountVerp]
,   NULL AS [FinRebateAccrual]
,   NULL AS [FinReserveCashDiscount]
,   CAST (docBillingBudget_US.[FinSales100] AS decimal (15,2)) as [FinSales100] 
,   NULL AS [FinNetAmountOtherSales]
,   NULL AS [FinNetAmountAllowances]
,   NULL AS [axbi_DataAreaID]
,   NULL AS [axbi_DataAreaName]
,   NULL AS [axbi_DataAreaGroup]
,   NULL AS [axbi_MaterialID]
,   NULL AS [axbi_CustomerID]
,   docBillingBudget_US.[MaterialCalculated]
,   NULL AS [SoldToPartyCalculated]
,   'O' AS [InOutID]
,   VT.[ValueTypeID]
,   VT.[ValueType]
,   docBillingBudget_US.[t_applicationId]
,   docBillingBudget_US.[t_extractionDtm]
FROM
    [edw].[fact_Budget_US] docBillingBudget_US
LEFT JOIN
    [edw].[dim_Currency] dimCr
    ON
        dimCr.[CurrencyID] = docBillingBudget_US.[CurrencyID]
CROSS JOIN
    [edw].[dim_ValueType] VT
WHERE VT.ValueTypeID= '20'

/*
SELECT
    docBillingBudget.[BillingDocument]
,   docBillingBudget.[BillingDocumentItem]
,   docBillingBudget.[CurrencyType]
,   dimCr.[CurrencyID]
,   dimCr.[Currency]
,   NULL [SalesDocumentItemCategoryID]
,   NULL [SalesDocumentItemCategory]
,   NULL [SalesDocumentItemTypeID]
,   NULL [SalesDocumentItemType]
,   NULL AS [ReturnItemProcessingType]
,   NULL AS [BillingDocumentTypeID]
,   NULL AS [BillingDocumentType]
,   NULL AS [BillingDocumentCategoryID]
,   NULL AS [BillingDocumentCategory]
,   NULL AS [SDDocumentCategoryID]
,   NULL AS [SDDocumentCategory]
,   docBillingBudget.[BillingDocumentDate]
,   docBillingBudget.[SalesOrganizationID]
,   dimSOrg.[SalesOrganization] AS [SalesOrganization]
,   NULL AS [DistributionChannelID]
,   NULL AS [DistributionChannel]
,   docBillingBudget.[Material]
,   NULL AS [BillingDocumentIsCancelled]
,   NULL AS [BillingQuantity]
--,   NULL AS [BillingQuantityUnitID]
--,   NULL AS [BillingQuantityUnit]
,   NULL AS [NetAmount]
,   NULL AS [TransactionCurrencyID]
,   NULL AS [GrossAmount]
,   NULL AS [TaxAmount]
,   NULL AS [CostAmount]
,   NULL AS [FiscalYear]
,   NULL AS [FiscalPeriod]
,   NULL AS [ProfitCenter]
--,   NULL AS [OriginSDDocument]
--,   NULL AS [OriginSDDocumentItem]
,   NULL AS ExchangeRateTypeID
,   NULL AS ExchangeRateType
,   NULL AS SDDocumentCategoryID
,   NULL AS SDDocumentCategory
,   NULL AS SalesDocumentID
,   NULL AS SalesDocumentItemID
,   NULL AS SDDocumentCategoryID
,   NULL AS SDDocumentCategory
,   NULL AS HigherLevelItem
,   NULL AS SDDocumentReasonID
,   NULL AS SDDocumentReason
,   NULL AS SalesDistrictID
,   NULL AS SalesDistrict
,   docBillingBudget.[SoldToParty]
,   docBillingBudget.[CountryID]
,   NULL AS [Country]
--,   NULL AS [ShipToParty]
,   NULL AS [BillToParty]
,   NULL AS [QuantitySold]
,   NULL AS [GrossMargin]
,   NULL AS [ExternalSalesAgentID]
,   NULL AS [ExternalSalesAgent]
,   NULL AS [ProjectID]
,   NULL AS [Project]
,   NULL AS [SalesEmployeeID]
,   NULL AS [SalesEmployee]
,   NULL AS [GlobalParentID]
,   NULL AS [GlobalParent]
,   NULL AS [LocalParentID]
,   NULL AS [LocalParent]
,   NULL AS [SalesOrderTypeID]
,   NULL AS [GlobalParentCalculatedID]
,   NULL AS [GlobalParentCalculated]
,   NULL AS [LocalParentCalculatedID]
,   NULL AS [LocalParentCalculated]
,   NULL AS [SalesDocumentType]
,   NULL AS [FinNetAmountRealProduct]
,   NULL AS [FinNetAmountFreight]
,   NULL AS [FinNetAmountMinQty]
,   NULL AS [FinNetAmountEngServ]
,   NULL AS [FinNetAmountMisc]
,   NULL AS [FinNetAmountServOther]
,   NULL AS [FinNetAmountVerp]
,   NULL AS [FinRebateAccrual]
,   NULL AS [FinReserveCashDiscount]
,   docBillingBudget.[FinSales100]
,   NULL AS [FinNetAmountOtherSales]
,   NULL AS [FinNetAmountAllowances]
,   docBillingBudget.[axbi_DataAreaID]
,   docBillingBudget.[axbi_DataAreaName]
,   docBillingBudget.[axbi_DataAreaGroup]
,   docBillingBudget.[axbi_MaterialID]
,   docBillingBudget.[axbi_CustomerID]
,   docBillingBudget.[MaterialCalculated]
,   docBillingBudget.[SoldToPartyCalculated]
,   docBillingBudget.[InOutID]
,   VT.[ValueTypeID]
,   VT.[ValueType]
,   docBillingBudget.[t_applicationId]
,   docBillingBudget.[t_extractionDtm]
FROM
    [edw].[fact_BillingBudget] docBillingBudget
LEFT JOIN
    [edw].[dim_Currency] dimCr
    ON
        dimCr.[CurrencyID] = docBillingBudget.[CurrencyID]
left join 
    [edw].[dim_SalesOrganization] dimSOrg 
    on
        dimSOrg.[SalesOrganizationID] = docBillingBudget.[SalesOrganizationID]
CROSS JOIN
    [edw].[dim_ValueType] VT
WHERE VT.ValueTypeID= '20'
*/