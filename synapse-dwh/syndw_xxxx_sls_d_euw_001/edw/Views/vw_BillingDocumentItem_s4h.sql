CREATE VIEW [edw].[vw_BillingDocumentItem_s4h]
AS
WITH 
BillingDocumentItemBase AS (
  SELECT 
    doc.[BillingDocument]                           AS [BillingDocument]
  , doc.[BillingDocumentItem]
  , doc.[SalesDocumentItemCategory]                 AS [SalesDocumentItemCategoryID]
  , doc.[SalesDocumentItemType]                     AS [SalesDocumentItemTypeID]
  , doc.[ReturnItemProcessingType]
  , doc.[BillingDocumentType]                       AS [BillingDocumentTypeID]
  , doc.[BillingDocumentCategory]                   AS [BillingDocumentCategoryID]
  , doc.[SDDocumentCategory]                        AS [SDDocumentCategoryID]
  , doc.[CreationDate]
  , doc.[CreationTime]
  , doc.[LastChangeDate]
  , doc.[BillingDocumentDate]
  , doc.[BillingDocumentIsTemporary]
  , doc.[OrganizationDivision]
  , doc.[Division]
  , doc.[SalesOffice]                               AS [SalesOfficeID]
  , doc.[SalesOrganization]                         AS [SalesOrganizationID]
  , doc.[DistributionChannel]                       AS [DistributionChannelID]
  , doc.[Material]
  , doc.[OriginallyRequestedMaterial]
  , doc.[InternationalArticleNumber]
  , doc.[PricingReferenceMaterial]
  , NULL                                            AS [LengthInMPer1]
  , NULL                                            AS [LengthInM]
  , doc.[Batch]
  , doc.[MaterialGroup]                             AS [MaterialGroupID]
  , DimBrand.[BrandID]                              AS [BrandID]
  , DimBrand.[Brand]                                AS [Brand]
  , doc.[AdditionalMaterialGroup2]
  , doc.[AdditionalMaterialGroup3]
  , doc.[AdditionalMaterialGroup4]
  , doc.[AdditionalMaterialGroup5]
  , doc.[MaterialCommissionGroup]
  , doc.[Plant]                                     AS [PlantID]
  , doc.[StorageLocation]                           AS [StorageLocationID]
  , doc.[BillingDocumentIsCancelled]
  , doc.[CancelledBillingDocument]
  , CASE
        WHEN
            doc.[BillingDocumentIsCancelled] = 'X' 
            OR
            doc.[CancelledBillingDocument]<>''
        THEN 'Y'
        ELSE 'N' 
    END                                             AS [CancelledInvoiceEffect]
  , doc.[BillingDocumentItemText]
  , doc.[ServicesRenderedDate]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[BillingQuantity]
  )                                                 AS [BillingQuantity]
  , doc.[BillingQuantityUnit]                       AS [BillingQuantityUnitID]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[BillingQuantityInBaseUnit]
  )                                                 AS [BillingQuantityInBaseUnit]  
  , doc.[BaseUnit]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[MRPRequiredQuantityInBaseUnit]
  )                                                 AS [MRPRequiredQuantityInBaseUnit]
  , doc.[BillingToBaseQuantityDnmntr]
  , doc.[BillingToBaseQuantityNmrtr]
  , doc.[ItemGrossWeight]
  , doc.[ItemNetWeight]
  , doc.[ItemWeightUnit]
  , doc.[ItemVolume]
  , doc.[ItemVolumeUnit]
  , doc.[BillToPartyCountry]
  , doc.[BillToPartyRegion]
  , doc.[BillingPlanRule]
  , doc.[BillingPlan]
  , doc.[BillingPlanItem]
  , doc.[CustomerPriceGroup]                        AS [CustomerPriceGroupID]
  , doc.[PriceListType]                             AS [PriceListTypeID]
  , doc.[TaxDepartureCountry]
  , doc.[VATRegistration]
  , doc.[VATRegistrationCountry]
  , doc.[VATRegistrationOrigin]
  , doc.[CustomerTaxClassification1]
  , doc.[CustomerTaxClassification2]
  , doc.[CustomerTaxClassification3]
  , doc.[CustomerTaxClassification4]
  , doc.[CustomerTaxClassification5]
  , doc.[CustomerTaxClassification6]
  , doc.[CustomerTaxClassification7]
  , doc.[CustomerTaxClassification8]
  , doc.[CustomerTaxClassification9]
  , doc.[SDPricingProcedure]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[NetAmount]
  )                                                 AS [NetAmount]
  , doc.[TransactionCurrency]                       AS [TransactionCurrencyID]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[GrossAmount]
  )                                                 AS [GrossAmount]
  , doc.[PricingDate]
  , doc.[PriceDetnExchangeRate]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[PricingScaleQuantityInBaseUnit]
  )                                                 AS [PricingScaleQuantityInBaseUnit]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[TaxAmount]
  ) * (-1)                                          AS [TaxAmount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[CostAmount]
  ) * (-1)                                          AS [CostAmount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal1Amount]
  )                                                 AS [Subtotal1Amount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal2Amount]
  )                                                 AS [Subtotal2Amount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal3Amount]
  )                                                 AS [Subtotal3Amount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal4Amount]
  )                                                 AS [Subtotal4Amount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal5Amount]
  )                                                 AS [Subtotal5Amount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal6Amount]
  )                                                 AS [Subtotal6Amount]
  , doc.[StatisticalValueControl]
  , doc.[StatisticsExchangeRate]
  , doc.[StatisticsCurrency]
  , doc.[SalesOrganizationCurrency]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[EligibleAmountForCashDiscount]
  )                                                 AS [EligibleAmountForCashDiscount]
  , doc.[ContractAccount]
  , doc.[CustomerPaymentTerms]
  , doc.[PaymentMethod]
  , doc.[PaymentReference]
  , doc.[FixedValueDate]
  , doc.[AdditionalValueDays]
  , doc.[PayerParty]
  , doc.[CompanyCode]
  , doc.[FiscalYear]
  , doc.[FiscalPeriod]
  , doc.[CustomerAccountAssignmentGroup]            AS [CustomerAccountAssignmentGroupID]
  , doc.[BusinessArea]
  , doc.[ProfitCenter]
  , doc.[OrderID]
  , doc.[ControllingArea]
  , doc.[ProfitabilitySegment]
  , doc.[CostCenter]
  , doc.[OriginSDDocument]
  , doc.[OriginSDDocumentItem]
  , doc.[PriceDetnExchangeRateDate]
  , doc.[ExchangeRateType]                          AS [ExchangeRateTypeID]
  , doc.[FiscalYearVariant]
  , doc.[Currency]                                  AS [CurrencyID]
  , CASE
        WHEN doc.[AccountingExchangeRate] < 0
            THEN 1/doc.[AccountingExchangeRate]
        ELSE doc.[AccountingExchangeRate]
    END                                             AS [AccountingExchangeRate]
  , doc.[AccountingExchangeRateIsSet]
  , doc.[ReferenceSDDocument]
  , doc.[ReferenceSDDocumentItem]
  , doc.[ReferenceSDDocumentCategory]               AS [ReferenceSDDocumentCategoryID]
  , doc.[SalesDocument]                             AS [SalesDocumentID]
  , doc.[SalesDocumentItem]                         AS [SalesDocumentItemID]
  , doc.[SalesSDDocumentCategory]                   AS [SalesSDDocumentCategoryID]
  , doc.[HigherLevelItem]
  , doc.[BillingDocumentItemInPartSgmt]
  , doc.[SalesGroup]
  , doc.[AdditionalCustomerGroup1]
  , doc.[AdditionalCustomerGroup2]
  , doc.[AdditionalCustomerGroup3]
  , doc.[AdditionalCustomerGroup4]
  , doc.[AdditionalCustomerGroup5]
  , doc.[SDDocumentReason]                          AS [SDDocumentReasonID]
  , doc.[ItemIsRelevantForCredit]
  , doc.[CreditRelatedPrice]
  , doc.[SalesDistrict]                             AS [SalesDistrictID]
  , doc.[CustomerGroup]                             AS [CustomerGroupID]
  , doc.[SoldToParty]
  , doc.[Country]                                   AS [CountryID]
  , doc.[ShipToParty]
  , doc.[BillToParty]
  , doc.[ShippingPoint]
  , doc.[IncotermsVersion]
  , doc.[IncotermsClassification]
  , doc.[IncotermsTransferLocation]
  , doc.[IncotermsLocation1]
  , doc.[IncotermsLocation2]
  , doc.[ShippingCondition]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[BillingQuantity]
  )                                                 AS [QuantitySold]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[NetAmount] - doc.[CostAmount]
  )                                                 AS [GrossMargin]
  , ZB.Customer                                     AS ExternalSalesAgentID
  , ZB.FullName                                     AS ExternalSalesAgent
  , ZP.Customer                                     AS ProjectID
  , ZP.FullName                                     AS Project
  , dim_SalesEmployee.Personnel                     AS SalesEmployeeID
  , dim_SalesEmployee.FullName                      AS SalesEmployee
  , D1.[Customer]                                   AS GlobalParentID
  , D1.[FullName]                                   AS GlobalParent
  , case
      when D1.[Customer] is not Null then D1.[Customer]
      else AG.[Customer] end                        AS GlobalParentCalculatedID
  , case
      when D1.[Customer] is not Null then D1.[FullName]
      else AG.[FullName] end                        AS GlobalParentCalculated
  , C1.[Customer]                                   AS LocalParentID
  , C1.[FullName]                                   AS LocalParent
  , case
      when C1.[Customer] is not Null then C1.[Customer]
      else AG.[Customer] end                        AS LocalParentCalculatedID
  , case
      when C1.[Customer] is not Null then C1.[FullName]
      else AG.[FullName] end                        AS LocalParentCalculated

  , SDTT.SalesDocumentType                          AS SalesOrderTypeID
  , case
      when doc.[BillToParty] is not Null then doc.[BillToParty]
      else doc.[SoldToParty] end                    AS BillToID

  , case
      when doc.[BillToParty] is not Null then RE.[FullName]
      else AG.[FullName] end                        AS BillTo
  , doc.[BillingDocumentDate]                       AS [AccountingDate]
  , doc.[Material]                                  AS MaterialCalculated
  , doc.[SoldToParty]                               AS SoldToPartyCalculated
  , edw.svf_getInOutID_s4h (CustomerID)             AS InOutID
  , PA.ICSalesDocumentID 
  , PA.ICSalesDocumentItemID
  , doc.[t_applicationId]
  , doc.[t_extractionDtm]
  --, @t_jobId                                        AS t_jobId
  --, @t_jobDtm                                       AS t_jobDtm
  --, @t_lastActionCd                                 AS t_lastActionCd
  --, @t_jobBy                                        AS t_jobBy

from [base_s4h_cax].[C_BillingDocumentItemBasicDEX] doc
  left join [edw].[dim_BillingDocumentPartnerFs] ZB
      on ZB.SDDocument = doc.[BillingDocument] and ZB.[PartnerFunction] = 'ZB' 
      -- and ZB.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
  left join [edw].[dim_BillingDocumentPartnerFs] ZP
      on ZP.SDDocument = doc.[BillingDocument] and ZP.[PartnerFunction] = 'ZP'
      -- and ZP.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
  left join [edw].[vw_dim_SalesEmployee] dim_SalesEmployee
      on dim_SalesEmployee.SDDocument = doc.[BillingDocument]
      -- and VE.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
  left join [edw].[dim_BillingDocumentPartnerFs] D1
      on D1.SDDocument = doc.[BillingDocument] and D1.[PartnerFunction] = '1D'
      -- and D1.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
  left join [edw].[dim_BillingDocumentPartnerFs] C1
      on C1.SDDocument = doc.[BillingDocument] and C1.[PartnerFunction] = '1C'
      -- and C1.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
  left join [edw].[dim_BillingDocumentPartnerFs] AG
      on AG.SDDocument = doc.[BillingDocument] and AG.[PartnerFunction] = 'AG'
      -- and AG.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
  left join [edw].[dim_BillingDocumentPartnerFs] RE
      on RE.SDDocument = doc.[BillingDocument] and RE.[PartnerFunction] = 'RE'
      -- and RE.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
  left join [base_s4h_cax].[C_SalesDocumentItemDEX] SDID
      on SDID.[SalesDocument] = doc.[SalesDocument] and
              SDID.[SalesDocumentItem] = doc.[SalesDocumentItem] 
              -- and SDID.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
  left join [base_s4h_cax].[I_SalesDocumentTypeText] SDTT
      on SDTT.[SalesDocumentType] = SDID.[SalesDocumentType] and SDTT.[Language] = 'E' 
      -- and SDTT.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
  -- supporting full load
  -- where doc.[t_lastActionCd] in ('I', 'U')
  left join [edw].[dim_Brand] DimBrand
        on DimBrand.[BrandID] = doc.[AdditionalMaterialGroup1]
  left join [edw].[dim_PurgAccAssignment] PA
    ON doc.SalesDocument = PA.PurchaseOrder                   
        AND right(doc.SalesDocumentItem,5) = PA.PurchaseOrderItem 
  left join [edw].[dim_Customer] DimCust
      ON doc.SoldToParty = DimCust.CustomerID  
    )

SELECT
       [BillingDocument]
      ,[BillingDocumentItem]
      ,edw.svf_getNaturalKey (BillingDocument,BillingDocumentItem,CR.CurrencyTypeID) 
                                            AS [nk_fact_BillingDocumentItem]
      ,CR.[CurrencyTypeID]
      ,CR.[CurrencyType]
      ,CASE
            WHEN CCR.CurrencyTypeID = '00'
                THEN [TransactionCurrencyID]
            ELSE CCR.[TargetCurrency]
       END                                  AS [CurrencyID]
      ,CASE
            WHEN CCR.CurrencyTypeID = '00' THEN
                CCR.[ExchangeRate]
            ELSE [AccountingExchangeRate] * CCR.[ExchangeRate]
	   END                                  AS [ExchangeRate]
      ,[SalesDocumentItemCategoryID]
      ,[SalesDocumentItemTypeID]
      ,[ReturnItemProcessingType]
      ,[BillingDocumentTypeID]
      ,[BillingDocumentCategoryID]
      ,[SDDocumentCategoryID]
      ,[CreationDate]
      ,[CreationTime]
      ,[LastChangeDate]
      ,[BillingDocumentDate]
      ,[BillingDocumentIsTemporary]
      ,[OrganizationDivision]
      ,[Division]
      ,[SalesOfficeID]
      ,[SalesOrganizationID]
      ,[DistributionChannelID]
      ,[Material]
      ,[OriginallyRequestedMaterial]
      ,[InternationalArticleNumber]
      ,[PricingReferenceMaterial]
      ,[LengthInMPer1]
      ,[LengthInM]
      ,[Batch]
      ,[MaterialGroupID]
      ,[BrandID]
      ,[Brand]
      ,[AdditionalMaterialGroup2]
      ,[AdditionalMaterialGroup3]
      ,[AdditionalMaterialGroup4]
      ,[AdditionalMaterialGroup5]
      ,[MaterialCommissionGroup]
      ,[PlantID]
      ,[StorageLocationID]
      ,[BillingDocumentIsCancelled]
      ,[CancelledBillingDocument]
      ,[CancelledInvoiceEffect]
      ,[BillingDocumentItemText]
      ,[ServicesRenderedDate]
      ,[BillingQuantity]
      ,[BillingQuantityUnitID]
      ,[BillingQuantityInBaseUnit]
      ,[BaseUnit]
      ,[MRPRequiredQuantityInBaseUnit]
      ,[BillingToBaseQuantityDnmntr]
      ,[BillingToBaseQuantityNmrtr]
      ,[ItemGrossWeight]
      ,[ItemNetWeight]
      ,[ItemWeightUnit]
      ,[ItemVolume]
      ,[ItemVolumeUnit]
      ,[BillToPartyCountry]
      ,[BillToPartyRegion]
      ,[BillingPlanRule]
      ,[BillingPlan]
      ,[BillingPlanItem]
      ,[CustomerPriceGroupID]
      ,[PriceListTypeID]
      ,[TaxDepartureCountry]
      ,[VATRegistration]
      ,[VATRegistrationCountry]
      ,[VATRegistrationOrigin]
      ,[CustomerTaxClassification1]
      ,[CustomerTaxClassification2]
      ,[CustomerTaxClassification3]
      ,[CustomerTaxClassification4]
      ,[CustomerTaxClassification5]
      ,[CustomerTaxClassification6]
      ,[CustomerTaxClassification7]
      ,[CustomerTaxClassification8]
      ,[CustomerTaxClassification9]
      ,[SDPricingProcedure]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [NetAmount]
        ELSE CONVERT(decimal(19,6), ([NetAmount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [NetAmount]
      ,[TransactionCurrencyID] 
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [GrossAmount]
        ELSE CONVERT(decimal(19,6), ([GrossAmount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [GrossAmount]
      ,[PricingDate]
      ,[PriceDetnExchangeRate]
      ,[PricingScaleQuantityInBaseUnit]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [TaxAmount]
        ELSE CONVERT(decimal(19,6), ([TaxAmount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [TaxAmount]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [CostAmount]
        ELSE CONVERT(decimal(19,6), ([CostAmount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [CostAmount]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [Subtotal1Amount]
        ELSE CONVERT(decimal(19,6), ([Subtotal1Amount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [Subtotal1Amount]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [Subtotal2Amount]
        ELSE CONVERT(decimal(19,6), ([Subtotal2Amount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [Subtotal2Amount]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [Subtotal3Amount]
        ELSE CONVERT(decimal(19,6), ([Subtotal3Amount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [Subtotal3Amount]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [Subtotal4Amount]
        ELSE CONVERT(decimal(19,6), ([Subtotal4Amount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [Subtotal4Amount]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [Subtotal5Amount]
        ELSE CONVERT(decimal(19,6), ([Subtotal5Amount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [Subtotal5Amount]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [Subtotal6Amount]
        ELSE CONVERT(decimal(19,6), ([Subtotal6Amount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [Subtotal6Amount]
      ,[StatisticalValueControl]
      ,[StatisticsExchangeRate]
      ,[StatisticsCurrency]
      ,[SalesOrganizationCurrency]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [EligibleAmountForCashDiscount]
        ELSE CONVERT(decimal(19,6), ([EligibleAmountForCashDiscount] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [EligibleAmountForCashDiscount]
      ,[ContractAccount]
      ,[CustomerPaymentTerms]
      ,[PaymentMethod]
      ,[PaymentReference]
      ,[FixedValueDate]
      ,[AdditionalValueDays]
      ,[PayerParty]
      ,[CompanyCode]
      ,[FiscalYear]
      ,[FiscalPeriod]
      ,[CustomerAccountAssignmentGroupID]
      ,[BusinessArea]
      ,[ProfitCenter]
      ,[OrderID]
      ,[ControllingArea]
      ,[ProfitabilitySegment]
      ,[CostCenter]
      ,[OriginSDDocument]
      ,[OriginSDDocumentItem]
      ,[PriceDetnExchangeRateDate]
      ,[ExchangeRateTypeID]
      ,[FiscalYearVariant]
      ,[CurrencyID] AS [CompanyCodeCurrencyID]
      ,[AccountingExchangeRate]
      ,[AccountingExchangeRateIsSet]
      ,[ReferenceSDDocument]
      ,[ReferenceSDDocumentItem]
      ,[ReferenceSDDocumentCategoryID]
      ,[SalesDocumentID]
      ,[SalesDocumentItemID]
      ,[SalesSDDocumentCategoryID]
      ,[HigherLevelItem]
      ,[BillingDocumentItemInPartSgmt]
      ,[SalesGroup]
      ,[AdditionalCustomerGroup1]
      ,[AdditionalCustomerGroup2]
      ,[AdditionalCustomerGroup3]
      ,[AdditionalCustomerGroup4]
      ,[AdditionalCustomerGroup5]
      ,[SDDocumentReasonID]
      ,[ItemIsRelevantForCredit]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [CreditRelatedPrice]
        ELSE CONVERT(decimal(19,6), ([CreditRelatedPrice] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [CreditRelatedPrice]
      ,[SalesDistrictID]
      ,[CustomerGroupID]
      ,[SoldToParty]
      ,[CountryID]
      ,[ShipToParty]
      ,[BillToParty]
      ,[ShippingPoint]
      ,[IncotermsVersion]
      ,[IncotermsClassification]
      ,[IncotermsTransferLocation]
      ,[IncotermsLocation1]
      ,[IncotermsLocation2]
      ,[ShippingCondition]
      ,[QuantitySold]
      ,CASE
        WHEN CCR.CurrencyTypeID = '00'
            THEN [GrossMargin]
        ELSE CONVERT(decimal(19,6), ([GrossMargin] * AccountingExchangeRate) * CCR.[ExchangeRate])
        END                                 AS [GrossMargin]
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
      ,[BillToID]
      ,[BillTo]
      ,[AccountingDate]
      ,[MaterialCalculated]
      ,[SoldToPartyCalculated]
      ,[InOutID]
      ,BDI.[ICSalesDocumentID]
      ,BDI.[ICSalesDocumentItemID]
      ,BDI.[t_applicationId]
      ,BDI.[t_extractionDtm]
      --,BDI.[t_jobId]
      --,BDI.[t_jobDtm]
      --,BDI.[t_lastActionCd]
      --,BDI.[t_jobBy]
FROM 
    BillingDocumentItemBase BDI
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON BDI.CurrencyID = CCR.SourceCurrency
LEFT JOIN 
    [edw].[dim_CurrencyType] CR
    ON CCR.CurrencyTypeID = CR.CurrencyTypeID