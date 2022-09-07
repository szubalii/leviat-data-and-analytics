﻿CREATE VIEW [dm_sales].[vw_fact_BillingDocumentItem] AS

WITH original AS (
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
         --, doc.[Division]
         --, dimSO.[SalesOfficeID]
         --, dimSO.[SalesOffice]
         , dimSOrg.[SalesOrganizationID]
         , dimSOrg.[SalesOrganization]
         , dimDCh.[DistributionChannelID]
         , dimDCh.[DistributionChannel]
         , doc.[Material]
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
         , dimCPG.[CustomerPriceGroupID]
         , dimCPG.[CustomerPriceGroup]
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
         , doc.[axbi_ItemNoCalc]
         , doc.[t_applicationId]
         , doc.[t_extractionDtm]
    FROM [edw].[fact_BillingDocumentItem] doc
             left join [edw].[dim_SalesDocumentItemCategory] dimSDIC --1
                       on dimSDIC.[SalesDocumentItemCategoryID] = doc.[SalesDocumentItemCategoryID]
             left join [edw].[dim_SalesDocumentItemType] dimSDIT --2
                       on dimSDIT.[SalesDocumentItemTypeID] = doc.[SalesDocumentItemTypeID]
             left join [edw].[dim_BillingDocumentType] dimBDT --3
                       on dimBDT.[BillingDocumentTypeID] = doc.[BillingDocumentTypeID]
             left join [edw].[dim_BillingDocumentCategory] dimBDC --4
                       on dimBDC.[BillingDocumentCategoryID] = doc.[BillingDocumentCategoryID]
             left join [edw].[dim_SDDocumentCategory] dimSDDC --5
                       on dimSDDC.[SDDocumentCategoryID] = doc.[SDDocumentCategoryID]
             left join [edw].[dim_CustomerPriceGroup] dimCPG
                       on dimCPG.[CustomerPriceGroupID] = doc.[CustomerPriceGroupID] --6
             left join [edw].[dim_Currency] dimCr on dimCr.[CurrencyID] = doc.[CurrencyID] --7
             left join [edw].[dim_SDDocumentCategory] dimRSDDC
                       on dimRSDDC.[SDDocumentCategoryID] = doc.[ReferenceSDDocumentCategoryID]
             left join [edw].[dim_SDDocumentCategory] dimSSDDC
                       on dimSSDDC.[SDDocumentCategoryID] = doc.[SalesSDDocumentCategoryID]
             left join [edw].[dim_SDDocumentReason] dimSDR
                       on dimSDR.[SDDocumentReasonID] = doc.[SDDocumentReasonID] --8
             --left join [edw].[dim_SalesOffice] dimSO
                       --on dimSO.[SalesOfficeID] = doc.[SalesOfficeID]
             left join [edw].[dim_SalesOrganization] dimSOrg 
                       on dimSOrg.[SalesOrganizationID] = doc.[SalesOrganizationID]
             left join [edw].[dim_DistributionChannel] dimDCh
                       on dimDCh.[DistributionChannelID] = doc.[DistributionChannelID]
             left join [edw].[dim_MaterialGroup] dimMG
                       on dimMG.[MaterialGroupID] = doc.[MaterialGroupID]
             left join [edw].[dim_Plant] dimP on dimP.[PlantID] = doc.[PlantID]
             left join [edw].[dim_StorageLocation] dimSL
                       on dimSL.[StorageLocationID] = doc.[StorageLocationID] and dimSL.[Plant] = doc.[PlantID]
             left join [edw].[dim_UnitOfMeasure] dimBQU
                       on dimBQU.[UnitOfMeasureID] = doc.[BillingQuantityUnitID]
             --left join [edw].[dim_PriceListType] dimPT
                       --on dimPT.[PriceListTypeID] = doc.[PriceListTypeID]
             left join [edw].[dim_CustomerAccountAssignmentGroup] dimCAAG
                       on dimCAAG.[CustomerAccountAssignmentGroupID] = doc.[CustomerAccountAssignmentGroupID]
             left join [edw].[dim_ExchangeRateType] dimERT
                       on dimERT.[ExchangeRateTypeID] = doc.[ExchangeRateTypeID]
             left join [edw].[dim_SalesDistrict] dimSD
                       on dimSD.[SalesDistrictID] = doc.[SalesDistrictID]
             left join [edw].[dim_CustomerGroup] dimCGr
                       on dimCGr.[CustomerGroupID] = doc.[CustomerGroupID]
             left join [edw].[dim_Country] dimC
                       on dimC.[CountryID] = doc.[CountryID]
             left join [edw].[dim_SalesDocumentType] dimSDT
                       on dimSDT.[SalesDocumentTypeID] = doc.[SalesOrderTypeID]

            WHERE doc.[CurrencyTypeID] <> '00' -- Transaction Currency
)

SELECT [BillingDocument]
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
      --,[SalesOfficeID]
      --,[SalesOffice]
      ,[SalesOrganizationID]
      ,[SalesOrganization]
      ,[DistributionChannelID]
      ,[DistributionChannel]
      ,[Material]
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
      ,[CustomerPriceGroup]
      --,[PriceListTypeID]
      --,[PriceListType]
      --,[SDPricingProcedure]
      ,[NetAmount]
      ,[TransactionCurrencyID]
      ,[GrossAmount]
      ,[PricingDate]
      ,[TaxAmount]
      ,[CostAmount]
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
      --,[CustomerGroupID]
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
      ,[t_applicationId]
      ,[t_extractionDtm]
  FROM original

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