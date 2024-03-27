CREATE VIEW [dm_sales].[vw_fact_BillingDocumentItem] AS

WITH BillDocPrcgElmnt AS (
  SELECT
    BillingDocument,
    BillingDocumentItem,
    CurrencyTypeID,
    ConditionType,
    ConditionAmount,
    CASE WHEN [ConditionType] = 'ZNET' THEN [ConditionAmount] END AS ZNET_NetValue,
    CASE WHEN [ConditionType] = 'REA1' THEN [ConditionAmount] END AS REA1_RebateAccrual,
    CASE WHEN [ConditionType] = 'ZNRV' THEN [ConditionAmount] END AS ZNRV_NetRevenue
  FROM
    [edw].[fact_BillingDocumentItemPrcgElmnt]
)

,
BillDocPrcgElmnt_max_value AS (
  SELECT 
    BillingDocument,
    BillingDocumentItem,
    CurrencyTypeID,
    MAX(ZNET_NetValue) AS ZNET_NetValue,
    MAX(REA1_RebateAccrual) AS REA1_RebateAccrual,
    MAX(ZNRV_NetRevenue) AS ZNRV_NetRevenue
  FROM
    BillDocPrcgElmnt
  GROUP BY
    BillingDocument,
    BillingDocumentItem,
    CurrencyTypeID
)

,
CTE_ConditionTypes AS (
  SELECT
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[CurrencyTypeID]
    ,ConditionType AS ConditionTypeForConditionAmount
    ,ConditionType + '1' AS ConditionTypeForConditionRateValue
    ,SUM(ConditionAmount) AS ConditionAmount
    ,SUM(ConditionRateValue) AS ConditionRateValue
  FROM
    [edw].[fact_BillingDocumentItemPrcgElmnt]
  GROUP BY
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[CurrencyTypeID]
    ,[ConditionType]
)

,
CTE_PVT AS (
  SELECT
    *
  FROM
    CTE_ConditionTypes
  PIVOT  
  (  
    SUM(ConditionAmount)  
    FOR [ConditionTypeForConditionAmount] IN ([ZC10], [ZCF1], [VPRS], [EK02])  
  ) AS PVT_ConditionAmount
  PIVOT  
  (  
    SUM(ConditionRateValue)  
    FOR [ConditionTypeForConditionRateValue] IN ([ZC101], [ZCF11], [VPRS1], [EK021])  
  ) AS PVT_ConditionRateValue
)

,
CTE_PrcgElmnt AS (
  SELECT
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[CurrencyTypeID]
    ,MAX([ZC10])  AS [PrcgElmntZC10ConditionAmount]
    ,MAX([ZCF1])  AS [PrcgElmntZCF1ConditionAmount]
    ,MAX([VPRS])  AS [PrcgElmntVPRSConditionAmount]
    ,MAX([EK02])  AS [PrcgElmntEK02ConditionAmount]
    ,MAX([ZC101]) AS [PrcgElmntZC10ConditionRate]
    ,MAX([ZCF11]) AS [PrcgElmntZCF1ConditionRate]
    ,MAX([VPRS1]) AS [PrcgElmntVPRSConditionRate]
    ,MAX([EK021]) AS [PrcgElmntEK02ConditionRate]
  FROM
    CTE_PVT
  GROUP BY
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[CurrencyTypeID]
)

 ,
 original AS (
  SELECT 
    doc.[sk_fact_BillingDocumentItem]
  , doc.[BillingDocument]
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
  --, doc.[Division]
  , dimSO.[SalesOfficeID]
  , dimSO.[SalesOffice]
  , dimSOrg.[SalesOrganizationID]
  , dimSOrg.[SalesOrganization]
  , dimDCh.[DistributionChannelID]
  , dimDCh.[DistributionChannel]
  , doc.[Material]
  , doc.[nk_ProductPlant]
  , [ProductSurrogateKey]
  --, doc.[OriginallyRequestedMaterial]
  --, doc.[InternationalArticleNumber]
  , dimMG.[MaterialGroupID]
  , dimMG.[MaterialGroup]
  , doc.[BrandID]
  , doc.[Brand]
  , dimP.[PlantID]
  , dimP.[Plant]
  , dimSL.[StorageLocationID]
  , dimSL.[StorageLocation]
  , doc.[BillingDocumentIsCancelled]
  , doc.[CancelledBillingDocument]
  , doc.[CancelledInvoiceEffect]
  --, doc.[ServicesRenderedDate]
  , doc.[BillingQuantity] 
  , doc.[BillingQuantityUnitID]
  , dimBQU.[UnitOfMeasure] as [BillingQuantityUnit]
  --, doc.[ItemGrossWeight]
  --, doc.[ItemNetWeight]
  --, doc.[ItemWeightUnit]
  --, doc.[ItemVolume]
  --, doc.[ItemVolumeUnit]
  --, doc.[BillToPartyCountry]
  --, doc.[BillToPartyRegion]
  , doc.[CustomerPriceGroupID]
  , dimCPG.[CustomerPriceGroup] 
  , doc.[CustomerPriceGroupID_BPSA]
  , dimCPG_BPSA.[CustomerPriceGroup] AS [CustomerPriceGroup_BPSA]
  --, dimPT.[PriceListTypeID]
  --, dimPT.[PriceListType]
  --, doc.[SDPricingProcedure]
  , CAST (doc.[NetAmount] AS decimal (15,2)) as [NetAmount] 
  , doc.[TransactionCurrencyID]
  , CAST (doc.[GrossAmount] AS decimal (15,2)) as [GrossAmount] 
  , doc.[PricingDate]
  , CAST (doc.[TaxAmount] AS decimal (15,2)) as [TaxAmount] 
  , CAST (doc.[CostAmount] AS decimal (15,2)) as [CostAmount] 
  , CAST (doc.[Subtotal1Amount] AS decimal (15,2)) as [Subtotal1Amount] 
  , CAST (doc.[Subtotal2Amount] AS decimal (15,2)) as [Subtotal2Amount] 
  , CAST (doc.[Subtotal3Amount] AS decimal (15,2)) as [Subtotal3Amount] 
  , CAST (doc.[Subtotal4Amount] AS decimal (15,2)) as [Subtotal4Amount] 
  , CAST (doc.[Subtotal5Amount] AS decimal (15,2)) as [Subtotal5Amount] 
  , CAST (doc.[Subtotal6Amount] AS decimal (15,2)) as [Subtotal6Amount] 
  , doc.[SalesOrganizationCurrency] 
  , CAST (doc.[EligibleAmountForCashDiscount] AS decimal (15,2)) as [EligibleAmountForCashDiscount] 
  --, doc.[PaymentMethod]
  --, doc.[PaymentReference]
  --, doc.[PayerParty]
  , doc.[CompanyCode]
  , doc.[FiscalYear]
  , doc.[FiscalPeriod]
  , dimCAAG.[CustomerAccountAssignmentGroupID]
  , dimCAAG.[CustomerAccountAssignmentGroup]
  --, doc.[BusinessArea]
  , doc.[ProfitCenter]
  , doc.[OrderID]
  , doc.[ControllingArea]
  --, doc.[CostCenter]
  --, doc.[OriginSDDocument]
  --, doc.[OriginSDDocumentItem]
  , dimERT.[ExchangeRateTypeID]
  , dimERT.[ExchangeRateType]
  --, doc.[CompanyCodeCurrencyID]
  , doc.[AccountingExchangeRate]
  --, doc.[AccountingExchangeRateIsSet]
  , doc.[ReferenceSDDocument]
  , doc.[ReferenceSDDocumentItem]
  , dimRSDDC.[SDDocumentCategoryID] as [ReferenceSDDocumentCategoryID]
  , dimRSDDC.[SDDocumentCategory]   as [ReferenceSDDocumentCategory]
  , doc.[SalesDocumentID]
  , doc.[SalesDocumentItemID]
  , dimSSDDC.[SDDocumentCategoryID] as [SalesSDDocumentCategoryID]
  , dimSSDDC.[SDDocumentCategory]   as [SalesSDDocumentCategory]
  , doc.[HigherLevelItem]
  --, doc.[BillingDocumentItemInPartSgmt]
  --, doc.[SalesGroup]
  , dimSDR.[SDDocumentReasonID]
  , dimSDR.[SDDocumentReason]
  --, doc.[ItemIsRelevantForCredit]
  , dimSD.[SalesDistrictID]
  , dimSD.[SalesDistrict]
  --, dimCGr.[CustomerGroupID]
  , dimCGr.[CustomerGroup]
  , doc.[SoldToParty]
  , dimC.[CountryID]
  , dimC.[Country]
  --, doc.[ShipToParty]
  , doc.[BillToParty]
  --, doc.[ShippingPoint]
  --, doc.[IncotermsVersion]
  , doc.[QuantitySold]
  , CAST (doc.[GrossMargin] AS decimal (15,2)) as [GrossMargin] 
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
  --, doc.[BillTo]
  , CAST (doc.[FinNetAmountRealProduct] AS decimal (15,2)) as [FinNetAmountRealProduct] 
  , CAST (doc.[FinNetAmountFreight] AS decimal (15,2)) as [FinNetAmountFreight] 
  , CAST (doc.[FinNetAmountMinQty] AS decimal (15,2)) as [FinNetAmountMinQty] 
  , CAST (doc.[FinNetAmountEngServ] AS decimal (15,2)) as [FinNetAmountEngServ] 
  , CAST (doc.[FinNetAmountMisc] AS decimal (15,2)) as [FinNetAmountMisc] 
  , CAST (doc.[FinNetAmountServOther] AS decimal (15,2)) as [FinNetAmountServOther] 
  , CAST (doc.[FinNetAmountVerp] AS decimal (15,2)) as [FinNetAmountVerp] 
  , CAST (doc.[FinRebateAccrual] AS decimal (15,2)) as [FinRebateAccrual] 
  , doc.[PaymentTermCashDiscountPercentageRate]
  , CAST (doc.[FinNetAmountOtherSales] AS decimal (15,2)) as [FinNetAmountOtherSales] 
  , CAST (doc.[FinReserveCashDiscount] AS decimal (15,2)) as [FinReserveCashDiscount] 
  , CAST (doc.[FinNetAmountAllowances] AS decimal (15,2)) as [FinNetAmountAllowances] 
  , CAST (doc.[FinSales100] AS decimal (15,2)) as [FinSales100] 
  , doc.[AccountingDate]
  , doc.[axbi_DataAreaID]                     
  , doc.[axbi_DataAreaName]                   
  , doc.[axbi_DataAreaGroup]                  
  , doc.[axbi_MaterialID]                     
  , doc.[axbi_CustomerID]
  , doc.[MaterialCalculated]
  , doc.[SoldToPartyCalculated]
  , doc.[InOutID]
  , doc.CustomerGroupID
  , doc.[axbi_ItemNoCalc]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentTypeID],
      doc.[SalesDocumentItemCategoryID],
      COALESCE(BDPE.ZNET_NetValue,0)
  ) AS ZNET_NetValue
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentTypeID],
      doc.[SalesDocumentItemCategoryID],
      COALESCE(BDPE.REA1_RebateAccrual,0)
  ) AS REA1_RebateAccrual
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentTypeID],
      doc.[SalesDocumentItemCategoryID],
      COALESCE(BDPE.ZNRV_NetRevenue,0)
  ) AS ZNRV_NetRevenue
  , doc.SDPricingProcedure
  , doc.PriceListTypeID
  , CTE_PrcgElmnt.[PrcgElmntZC10ConditionAmount]
  , CTE_PrcgElmnt.[PrcgElmntZCF1ConditionAmount]
  , [edw].[svf_replaceZero](
      CTE_PrcgElmnt.[PrcgElmntVPRSConditionAmount]
      ,CTE_PrcgElmnt.[PrcgElmntEK02ConditionAmount]
  ) AS [PrcgElmntVPRS/EK02ConditionAmount]
  , CTE_PrcgElmnt.[PrcgElmntZC10ConditionRate]
  , CTE_PrcgElmnt.[PrcgElmntZCF1ConditionRate]
  , [edw].[svf_replaceZero](
      CTE_PrcgElmnt.[PrcgElmntVPRSConditionRate]
      ,CTE_PrcgElmnt.[PrcgElmntEK02ConditionRate]
  ) AS [PrcgElmntVPRS/EK02ConditionRate]
  , doc.[t_applicationId]
  , doc.[t_extractionDtm]
  FROM
    [edw].[fact_BillingDocumentItem] doc
  LEFT JOIN
    [edw].[dim_SalesDocumentItemCategory] dimSDIC --1
    ON
      dimSDIC.[SalesDocumentItemCategoryID] = doc.[SalesDocumentItemCategoryID]
  LEFT JOIN
    [edw].[dim_SalesDocumentItemType] dimSDIT --2
    ON
      dimSDIT.[SalesDocumentItemTypeID] = doc.[SalesDocumentItemTypeID]
  LEFT JOIN
    [edw].[dim_BillingDocumentType] dimBDT --3
    ON
      dimBDT.[BillingDocumentTypeID] = doc.[BillingDocumentTypeID]
  LEFT JOIN
    [edw].[dim_BillingDocumentCategory] dimBDC --4
    ON
      dimBDC.[BillingDocumentCategoryID] = doc.[BillingDocumentCategoryID]
  LEFT JOIN
    [edw].[dim_SDDocumentCategory] dimSDDC --5
    ON
      dimSDDC.[SDDocumentCategoryID] = doc.[SDDocumentCategoryID]
  LEFT JOIN
    [edw].[dim_CustomerPriceGroup] dimCPG
    ON
      dimCPG.[CustomerPriceGroupID] = doc.[CustomerPriceGroupID] --6.1
  LEFT JOIN
    [edw].[dim_CustomerPriceGroup] dimCPG_BPSA
    ON
      dimCPG_BPSA.[CustomerPriceGroupID] = doc.[CustomerPriceGroupID_BPSA] --6.2
  LEFT JOIN
    [edw].[dim_Currency] dimCr
    ON
      dimCr.[CurrencyID] = doc.[CurrencyID] --7
  LEFT JOIN
    [edw].[dim_SDDocumentCategory] dimRSDDC
    ON
      dimRSDDC.[SDDocumentCategoryID] = doc.[ReferenceSDDocumentCategoryID]
  LEFT JOIN
    [edw].[dim_SDDocumentCategory] dimSSDDC
    ON
      dimSSDDC.[SDDocumentCategoryID] = doc.[SalesSDDocumentCategoryID]
  LEFT JOIN
    [edw].[dim_SDDocumentReason] dimSDR
    ON
      dimSDR.[SDDocumentReasonID] = doc.[SDDocumentReasonID] --8
  LEFT JOIN
    [edw].[dim_SalesOffice] dimSO
    ON
      dimSO.[SalesOfficeID] = doc.[SalesOfficeID]
  LEFT JOIN
    [edw].[dim_SalesOrganization] dimSOrg 
    ON
      dimSOrg.[SalesOrganizationID] = doc.[SalesOrganizationID]
  LEFT JOIN
    [edw].[dim_DistributionChannel] dimDCh
    ON
      dimDCh.[DistributionChannelID] = doc.[DistributionChannelID]
  LEFT JOIN
    [edw].[dim_MaterialGroup] dimMG
    ON
      dimMG.[MaterialGroupID] = doc.[MaterialGroupID]
  LEFT JOIN
    [edw].[dim_Plant] dimP
    ON
      dimP.[PlantID] = doc.[PlantID]
  LEFT JOIN
    [edw].[dim_StorageLocation] dimSL
    ON
      dimSL.[StorageLocationID] = doc.[StorageLocationID]
      AND
      dimSL.[Plant] = doc.[PlantID]
  LEFT JOIN
    [edw].[dim_UnitOfMeasure] dimBQU
    ON
      dimBQU.[UnitOfMeasureID] = doc.[BillingQuantityUnitID]
  --LEFT JOIN
    -- [edw].[dim_PriceListType] dimPT
    --on dimPT.[PriceListTypeID] = doc.[PriceListTypeID]
  LEFT JOIN
    [edw].[dim_CustomerAccountAssignmentGroup] dimCAAG
    ON
      dimCAAG.[CustomerAccountAssignmentGroupID] = doc.[CustomerAccountAssignmentGroupID]
  LEFT JOIN
    [edw].[dim_ExchangeRateType] dimERT
    ON
      dimERT.[ExchangeRateTypeID] = doc.[ExchangeRateTypeID]
  LEFT JOIN
    [edw].[dim_SalesDistrict] dimSD
    ON
      dimSD.[SalesDistrictID] = doc.[SalesDistrictID]
  LEFT JOIN
    [edw].[dim_CustomerGroup] dimCGr
    ON
      dimCGr.[CustomerGroupID] = doc.[CustomerGroupID]
  LEFT JOIN
    [edw].[dim_Country] dimC
    ON
      dimC.[CountryID] = doc.[CountryID]
  LEFT JOIN
    [edw].[dim_SalesDocumentType] dimSDT
    ON
      dimSDT.[SalesDocumentTypeID] = doc.[SalesOrderTypeID]
  LEFT JOIN
    BillDocPrcgElmnt_max_value BDPE
    ON
      doc.BillingDocument = BDPE.BillingDocument
      AND 
      doc.BillingDocumentItem = BDPE.BillingDocumentItem
      AND 
      doc.CurrencyTypeID = BDPE.CurrencyTypeID 
  LEFT JOIN
    CTE_PrcgElmnt
    ON
      doc.BillingDocument = CTE_PrcgElmnt.BillingDocument
      AND
      doc.BillingDocumentItem = CTE_PrcgElmnt.BillingDocumentItem
      AND
      doc.CurrencyTypeID = CTE_PrcgElmnt.CurrencyTypeID
            -- LEFT JOIN PrcgElmntCR
            --     ON doc.BillingDocument = PrcgElmntCR.BillingDocument
            --         AND doc.BillingDocumentItem = PrcgElmntCR.BillingDocumentItem
            --         AND doc.CurrencyTypeID = PrcgElmntCR.CurrencyTypeID
  WHERE
    doc.[CurrencyTypeID] <> '00' -- Transaction Currency
)

SELECT 
  [sk_fact_BillingDocumentItem]
,[BillingDocument]
,[BillingDocumentItem]
,[CurrencyType]
,[CurrencyID]
,[Currency]
,[SalesDocumentItemCategoryID]
,[SalesDocumentItemCategory]
,[SalesDocumentItemTypeID]
,[SalesDocumentItemType]
,[ReturnItemProcessingType]
,[BillingDocumentTypeID]
,[BillingDocumentType]
,[BillingDocumentCategoryID]
,[BillingDocumentCategory]
,[SDDocumentCategoryID]
,[SDDocumentCategory]
,[CreationDate]
,[CreationTime]
,[LastChangeDate]
,[BillingDocumentDate]
,[BillingDocumentIsTemporary]
--,[Division]
,[SalesOfficeID]
,[SalesOffice]
,[SalesOrganizationID]
,[SalesOrganization]
,[DistributionChannelID]
,[DistributionChannel]
,[Material]
,[nk_ProductPlant]
,[ProductSurrogateKey]
--,[OriginallyRequestedMaterial]
--,[InternationalArticleNumber]
,[MaterialGroupID]
,[MaterialGroup]
,[BrandID]
,[Brand]
,[PlantID]
,[Plant]
,[StorageLocationID]
,[StorageLocation]
,[BillingDocumentIsCancelled]
,[CancelledBillingDocument]
,[CancelledInvoiceEffect]
--,[ServicesRenderedDate]
,[BillingQuantity]
,[BillingQuantityUnitID]
,[BillingQuantityUnit]
--,[ItemGrossWeight]
--,[ItemNetWeight]
--,[ItemWeightUnit]
--,[ItemVolume]
--,[ItemVolumeUnit]
--,[BillToPartyCountry]
--,[BillToPartyRegion]
,[CustomerPriceGroupID]
,[CustomerPriceGroupID_BPSA]
,[CustomerPriceGroup]
,[CustomerPriceGroup_BPSA]
--,[PriceListTypeID]
--,[PriceListType]
--,[SDPricingProcedure]
,[NetAmount]
,[TransactionCurrencyID]
,[GrossAmount]
,[PricingDate]
,[TaxAmount]
,[CostAmount]
,   NULL AS [ProfitMargin]
,   NULL AS [MarginPercent]
,   NULL AS [FinProfitMargin]
,   NULL AS [FinMarginPercent]
,[Subtotal1Amount]
,[Subtotal2Amount]
,[Subtotal3Amount]
,[Subtotal4Amount]
,[Subtotal5Amount]
,[Subtotal6Amount]
,[SalesOrganizationCurrency]
,[EligibleAmountForCashDiscount]
--,[PaymentMethod]
--,[PaymentReference]
--,[PayerParty]
,[CompanyCode]
,[FiscalYear]
,[FiscalPeriod]
,[CustomerAccountAssignmentGroupID]
,[CustomerAccountAssignmentGroup]
--,[BusinessArea]
,[ProfitCenter]
,[OrderID]
,[ControllingArea]
--,[CostCenter]
--,[OriginSDDocument]
--,[OriginSDDocumentItem]
,[ExchangeRateTypeID]
,[ExchangeRateType]
--,[CompanyCodeCurrencyID]
,[AccountingExchangeRate]
--,[AccountingExchangeRateIsSet]
,[ReferenceSDDocument]
,[ReferenceSDDocumentItem]
,[ReferenceSDDocumentCategoryID]
,[ReferenceSDDocumentCategory]
,[SalesDocumentID]
,[SalesDocumentItemID]
,[SalesSDDocumentCategoryID]
,[SalesSDDocumentCategory]
,[HigherLevelItem]
--,[BillingDocumentItemInPartSgmt]
--,[SalesGroup]
,[SDDocumentReasonID]
,[SDDocumentReason]
--,[ItemIsRelevantForCredit]
,[SalesDistrictID]
,[SalesDistrict]
,[CustomerGroupID]
,[CustomerGroup]
,[SoldToParty]
,[CountryID]
,[Country]
--,[ShipToParty]
,[BillToParty]
--,[ShippingPoint]
--,[IncotermsVersion]
,[QuantitySold]
,[GrossMargin]
,[ExternalSalesAgentID]
,[ExternalSalesAgent]
,[ProjectID]
,[Project]
,[SalesEmployeeID]
,[SalesEmployee]
,[GlobalParentID]
,[GlobalParent]
,[GlobalParentCalculatedID]             
,[GlobalParentCalculated]               
,[LocalParentID]
,[LocalParent]
,[LocalParentCalculatedID]           
,[LocalParentCalculated]             
,[SalesOrderTypeID]
,[SalesOrderType]
--,[BillTo]
,[FinNetAmountRealProduct]
,[FinNetAmountFreight]
,[FinNetAmountMinQty]
,[FinNetAmountEngServ]
,[FinNetAmountMisc]
,[FinNetAmountServOther]
,[FinNetAmountVerp]
,[FinRebateAccrual]
,[PaymentTermCashDiscountPercentageRate]
,[FinNetAmountOtherSales]
,[FinReserveCashDiscount]
,[FinNetAmountAllowances]
,[FinSales100]
,[AccountingDate]
,[axbi_DataAreaID]                     
,[axbi_DataAreaName]                   
,[axbi_DataAreaGroup]                  
,[axbi_MaterialID]                     
,[axbi_CustomerID]
,[MaterialCalculated]
,[SoldToPartyCalculated]
,[InOutID]
,[axbi_ItemNoCalc]
,ZNET_NetValue
,REA1_RebateAccrual
,ZNRV_NetRevenue
,SDPricingProcedure
,PriceListTypeID
,[PrcgElmntZC10ConditionAmount]
,[PrcgElmntZCF1ConditionAmount]
,[PrcgElmntVPRS/EK02ConditionAmount]
,[PrcgElmntZC10ConditionRate]
,[PrcgElmntZCF1ConditionRate]
,[PrcgElmntVPRS/EK02ConditionRate]
,[t_applicationId]
,[t_extractionDtm]
FROM
  original

  -- Add mocked previous year data PY
--   UNION ALL

--   SELECT 
--        [BillingDocument]
--       ,[BillingDocumentItem]
--       ,[CurrencyType]
--       ,[CurrencyID]
--       ,[Currency]
--       ,[SalesDocumentItemCategoryID]
--       ,[SalesDocumentItemCategory]
--       ,[SalesDocumentItemTypeID]
--       ,[SalesDocumentItemType]
--       ,[ReturnItemProcessingType]
--       ,[BillingDocumentTypeID]
--       ,[BillingDocumentType]
--       ,[BillingDocumentCategoryID]
--       ,[BillingDocumentCategory]
--       ,[SDDocumentCategoryID]
--       ,[SDDocumentCategory]
--       ,[CreationDate]
--       ,[CreationTime]
--       ,[LastChangeDate]
--       ,[BillingDocumentDate]
--       ,[BillingDocumentIsTemporary]
--       ,[Division]
--       ,[SalesOfficeID]
--       ,[SalesOffice]
--       ,[SalesOrganizationID]
--       ,[SalesOrganization]
--       ,[DistributionChannelID]
--       ,[DistributionChannel]
--       ,[Material]
--       ,[OriginallyRequestedMaterial]
--       ,[InternationalArticleNumber]
--       ,[MaterialGroupID]
--       ,[MaterialGroup]
--       ,[PlantID]
--       ,[Plant]
--       ,[StorageLocationID]
--       ,[StorageLocation]
--       ,[BillingDocumentIsCancelled]
--       ,[CancelledBillingDocument]
--       ,[ServicesRenderedDate]
--       ,[BillingQuantity]
--       ,[BillingQuantityUnitID]
--       ,[BillingQuantityUnit]
--       ,[ItemGrossWeight]
--       ,[ItemNetWeight]
--       ,[ItemWeightUnit]
--       ,[ItemVolume]
--       ,[ItemVolumeUnit]
--       ,[BillToPartyCountry]
--       ,[BillToPartyRegion]
--       ,[CustomerPriceGroupID]
--       ,[CustomerPriceGroup]
--       ,[PriceListTypeID]
--       ,[PriceListType]
--       ,[SDPricingProcedure]
--       ,NetAmount
--       ,[TransactionCurrencyID]
--       ,[GrossAmount]
--       ,[PricingDate]
--       ,[TaxAmount]
--       ,[CostAmount]
--       ,[Subtotal1Amount]
--       ,[Subtotal2Amount]
--       ,[Subtotal3Amount]
--       ,[Subtotal4Amount]
--       ,[Subtotal5Amount]
--       ,[Subtotal6Amount]
--       ,[SalesOrganizationCurrency]
--       ,[EligibleAmountForCashDiscount]
--       ,[PaymentMethod]
--       ,[PaymentReference]
--       ,[PayerParty]
--       ,[CompanyCode]
--       ,[FiscalYear]
--       ,[FiscalPeriod]
--       ,[CustomerAccountAssignmentGroupID]
--       ,[CustomerAccountAssignmentGroup]
--       ,[BusinessArea]
--       ,[ProfitCenter]
--       ,[OrderID]
--       ,[ControllingArea]
--       ,[CostCenter]
--       ,[OriginSDDocument]
--       ,[OriginSDDocumentItem]
--       ,[ExchangeRateTypeID]
--       ,[ExchangeRateType]
--       ,[CompanyCodeCurrencyID]
--       ,[AccountingExchangeRate]
--       ,[AccountingExchangeRateIsSet]
--       ,[ReferenceSDDocument]
--       ,[ReferenceSDDocumentItem]
--       ,[ReferenceSDDocumentCategoryID]
--       ,[ReferenceSDDocumentCategory]
--       ,[SalesDocumentID]
--       ,[SalesDocumentItemID]
--       ,[SalesSDDocumentCategoryID]
--       ,[SalesSDDocumentCategory]
--       ,[HigherLevelItem]
--       ,[BillingDocumentItemInPartSgmt]
--       ,[SalesGroup]
--       ,[SDDocumentReasonID]
--       ,[SDDocumentReason]
--       ,[ItemIsRelevantForCredit]
--       ,[SalesDistrictID]
--       ,[SalesDistrict]
--       ,[CustomerGroupID]
--       ,[CustomerGroup]
--       ,[SoldToParty]
--       ,[CountryID]
--       ,[Country]
--       ,[ShipToParty]
--       ,[BillToParty]
--       ,[ShippingPoint]
--       ,[IncotermsVersion]
--       ,case
--                when py.[ReturnItemProcessingType] = 'X' then [BillingQuantity] * (-1)
--                else
--                    [BillingQuantity] end                   as QuantitySold
--       ,case
--                when py.[ReturnItemProcessingType] = 'X' then (py.[NetAmount] - py.[CostAmount]) * (-1)
--                else py.[NetAmount] - py.[CostAmount] end as GrossMargin
--       ,[ExternalSalesAgentID]
--       ,[ExternalSalesAgent]
--       ,[ProjectID]
--       ,[Project]
--       ,[SalesEmployeeID]
--       ,[SalesEmployee]
--       ,[GlobalParentID]
--       ,[GlobalParent]
--       ,[LocalParentID]
--       ,[LocalParent]
--       ,[SalesOrderTypeID]
--       ,[SalesOrderType]
--       ,[BillTo]
--       ,[FinNetAmount]
--       ,[FinNetAmountFreight]
--       ,[FinNetAmountMinQty]
--       ,[FinNetAmountEngServ]
--       ,[FinNetAmountMisc]
--       ,[FinNetAmountServOther]
--       ,[FinNetAmountVerp]
--       ,[FinRebateAccrual]
--       ,[PaymentTermCashDiscountPercentageRate]
--       ,[FinNetAmountOtherSales]
--       ,[FinReserveCashDiscount]
--       ,[FinNetAmountAllowances]
--       ,[FinSales100]
--       ,[AccountingDate]
--       ,[t_applicationId]
--   FROM (

--       SELECT 
--            CONCAT([BillingDocument],'PY') as [BillingDocument]
--           ,[BillingDocumentItem]
--           ,[CurrencyType]
--           ,[CurrencyID]
--           ,[Currency]
--           ,[SalesDocumentItemCategoryID]
--           ,[SalesDocumentItemCategory]
--           ,[SalesDocumentItemTypeID]
--           ,[SalesDocumentItemType]
--           ,[ReturnItemProcessingType]
--           ,[BillingDocumentTypeID]
--           ,[BillingDocumentType]
--           ,[BillingDocumentCategoryID]
--           ,[BillingDocumentCategory]
--           ,[SDDocumentCategoryID]
--           ,[SDDocumentCategory]
--           ,DATEADD(year, -1, [CreationDate] ) as [CreationDate]
--           ,[CreationTime]
--           ,case when year([LastChangeDate]) !=  '0001' 
--                 then 
--                     DATEADD(year, -1, [LastChangeDate] ) 
--                 else 
--                     [LastChangeDate]
--                 end as [LastChangeDate]
--           ,DATEADD(year, -1, [BillingDocumentDate] ) as [BillingDocumentDate]
--           ,[BillingDocumentIsTemporary]
--           ,[Division]
--           ,[SalesOfficeID]
--           ,[SalesOffice]
--           ,[SalesOrganizationID]
--           ,[SalesOrganization]
--           ,[DistributionChannelID]
--           ,[DistributionChannel]
--           ,[Material]
--           ,[OriginallyRequestedMaterial]
--           ,[InternationalArticleNumber]
--           ,[MaterialGroupID]
--           ,[MaterialGroup]
--           ,[PlantID]
--           ,[Plant]
--           ,[StorageLocationID]
--           ,[StorageLocation]
--           ,[BillingDocumentIsCancelled]
--           ,[CancelledBillingDocument]
--           ,DATEADD(year, -1, [ServicesRenderedDate] ) as [ServicesRenderedDate]
--           ,[BillingQuantity] + CEILING([BillingQuantity]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5)) as [BillingQuantity]
--           ,[BillingQuantityUnitID]
--           ,[BillingQuantityUnit]
--           ,[ItemGrossWeight]
--           ,[ItemNetWeight]
--           ,[ItemWeightUnit]
--           ,[ItemVolume]
--           ,[ItemVolumeUnit]
--           ,[BillToPartyCountry]
--           ,[BillToPartyRegion]
--           ,[CustomerPriceGroupID]
--           ,[CustomerPriceGroup]
--           ,[PriceListTypeID]
--           ,[PriceListType]
--           ,[SDPricingProcedure]
--           ,ROUND([NetAmount] + [NetAmount] * (RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as NetAmount
--           ,[TransactionCurrencyID]
--           ,ROUND([GrossAmount] + [GrossAmount]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [GrossAmount]
--           ,DATEADD(year, -1, [PricingDate] ) as [PricingDate]
--           ,ROUND([TaxAmount] + [TaxAmount]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [TaxAmount]
--           ,ROUND([CostAmount] + [CostAmount]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [CostAmount]
--           ,[Subtotal1Amount]
--           ,[Subtotal2Amount]
--           ,[Subtotal3Amount]
--           ,[Subtotal4Amount]
--           ,[Subtotal5Amount]
--           ,[Subtotal6Amount]
--           ,[SalesOrganizationCurrency]
--           ,[EligibleAmountForCashDiscount]
--           ,[PaymentMethod]
--           ,[PaymentReference]
--           ,[PayerParty]
--           ,[CompanyCode]
--           ,[FiscalYear]
--           ,[FiscalPeriod]
--           ,[CustomerAccountAssignmentGroupID]
--           ,[CustomerAccountAssignmentGroup]
--           ,[BusinessArea]
--           ,[ProfitCenter]
--           ,[OrderID]
--           ,[ControllingArea]
--           ,[CostCenter]
--           ,[OriginSDDocument]
--           ,[OriginSDDocumentItem]
--           ,[ExchangeRateTypeID]
--           ,[ExchangeRateType]
--           ,[CompanyCodeCurrencyID]
--           ,[AccountingExchangeRate]
--           ,[AccountingExchangeRateIsSet]
--           ,[ReferenceSDDocument]
--           ,[ReferenceSDDocumentItem]
--           ,[ReferenceSDDocumentCategoryID]
--           ,[ReferenceSDDocumentCategory]
--           ,[SalesDocumentID]
--           ,[SalesDocumentItemID]
--           ,[SalesSDDocumentCategoryID]
--           ,[SalesSDDocumentCategory]
--           ,[HigherLevelItem]
--           ,[BillingDocumentItemInPartSgmt]
--           ,[SalesGroup]
--           ,[SDDocumentReasonID]
--           ,[SDDocumentReason]
--           ,[ItemIsRelevantForCredit]
--           ,[SalesDistrictID]
--           ,[SalesDistrict]
--           ,[CustomerGroupID]
--           ,[CustomerGroup]
--           ,[SoldToParty]
--           ,[CountryID]
--           ,[Country]
--           ,[ShipToParty]
--           ,[BillToParty]
--           ,[ShippingPoint]
--           ,[IncotermsVersion]
--           ,[ExternalSalesAgentID]
--           ,[ExternalSalesAgent]
--           ,[ProjectID]
--           ,[Project]
--           ,[SalesEmployeeID]
--           ,[SalesEmployee]
--           ,[GlobalParentID]
--           ,[GlobalParent]
--           ,[LocalParentID]
--           ,[LocalParent]
--           ,[SalesOrderTypeID]
--           ,[SalesOrderType]
--           ,[BillTo]
--           ,ROUND([FinNetAmount] + [FinNetAmount]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinNetAmount]
--         ,ROUND([FinNetAmountFreight] + [FinNetAmountFreight]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinNetAmountFreight]
--         ,ROUND([FinNetAmountMinQty] + [FinNetAmountMinQty]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinNetAmountMinQty]
--         ,ROUND([FinNetAmountEngServ] + [FinNetAmountEngServ]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinNetAmountEngServ]
--         ,ROUND([FinNetAmountMisc] + [FinNetAmountMisc]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinNetAmountMisc]
--         ,ROUND([FinNetAmountServOther] + [FinNetAmountServOther]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinNetAmountServOther]
--         ,ROUND([FinNetAmountVerp] + [FinNetAmountVerp]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinNetAmountVerp]
--         ,ROUND([FinRebateAccrual] + [FinRebateAccrual]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinRebateAccrual]
--         ,[PaymentTermCashDiscountPercentageRate]
--         ,ROUND([FinNetAmountOtherSales] + [FinNetAmountOtherSales]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinNetAmountOtherSales]
--         ,ROUND([FinReserveCashDiscount] + [FinReserveCashDiscount]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinReserveCashDiscount]
--         ,ROUND([FinNetAmountAllowances] + [FinNetAmountAllowances]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinNetAmountAllowances]
--         ,ROUND([FinSales100] + [FinSales100]*(RAND(CHECKSUM(NEWID()))*(.2+.5)-.5),2) as [FinSales100]
--         ,[AccountingDate]
--         ,[t_applicationId]
--       FROM original
--   ) py