-- CREATE VIEW [edw].[vw_BillingDocumentItem_s4h]
-- AS
WITH 
BillingDocumentItemBase AS (
  SELECT 
    doc.[BillingDocument]                           as [BillingDocument]
  , doc.[BillingDocumentItem]
  , doc.[SalesDocumentItemCategory]                 as [SalesDocumentItemCategoryID]
  , doc.[SalesDocumentItemType]                     as [SalesDocumentItemTypeID]
  , doc.[ReturnItemProcessingType]
  , doc.[BillingDocumentType]                       as [BillingDocumentTypeID]
  , doc.[BillingDocumentCategory]                   as [BillingDocumentCategoryID]
  , doc.[SDDocumentCategory]                        as [SDDocumentCategoryID]
  , doc.[CreationDate]
  , doc.[CreationTime]
  , doc.[LastChangeDate]
  , doc.[BillingDocumentDate]
  , doc.[BillingDocumentIsTemporary]
  , doc.[OrganizationDivision]
  , doc.[Division]
  , doc.[SalesOffice]                               as [SalesOfficeID]
  , doc.[SalesOrganization]                         as [SalesOrganizationID]
  , doc.[DistributionChannel]                       as [DistributionChannelID]
  , doc.[Material]
  , doc.[OriginallyRequestedMaterial]
  , doc.[InternationalArticleNumber]
  , doc.[PricingReferenceMaterial]
  , NULL as [LengthInMPer1]
  , NULL as [LengthInM]
  , doc.[Batch]
  , doc.[MaterialGroup]                             as [MaterialGroupID]
  , DimBrand.[BrandID]                              as [BrandID]
  , DimBrand.[Brand]                                as [Brand]
  , doc.[AdditionalMaterialGroup2]
  , doc.[AdditionalMaterialGroup3]
  , doc.[AdditionalMaterialGroup4]
  , doc.[AdditionalMaterialGroup5]
  , doc.[MaterialCommissionGroup]
  , doc.[Plant]                                     as [PlantID]
  , doc.[StorageLocation]                           as [StorageLocationID]
  , doc.[BillingDocumentIsCancelled]
  , doc.[CancelledBillingDocument]
  , CASE
        WHEN
            doc.[BillingDocumentIsCancelled] = 'X' 
            OR
            doc.[CancelledBillingDocument]<>''
        THEN 'Y'
        ELSE 'N' 
    END AS [CancelledInvoiceEffect]
  , doc.[BillingDocumentItemText]
  , doc.[ServicesRenderedDate]
  , doc.[BillingQuantity]
  , doc.[BillingQuantityUnit]                       as [BillingQuantityUnitID]
  , doc.[BillingQuantityInBaseUnit]
  , doc.[BaseUnit]
  , doc.[MRPRequiredQuantityInBaseUnit]
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
  , doc.[CustomerPriceGroup]                        as [CustomerPriceGroupID]
  , doc.[PriceListType]                             as [PriceListTypeID]
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
  ) AS [NetAmount]
  , doc.[TransactionCurrency]                       AS [TransactionCurrencyID]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[GrossAmount]
  ) AS [GrossAmount]
  , doc.[PricingDate]
  , doc.[PriceDetnExchangeRate]
  , doc.[PricingScaleQuantityInBaseUnit]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[TaxAmount]
  ) AS [TaxAmount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[CostAmount]
  ) AS [CostAmount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal1Amount]
  ) AS [Subtotal1Amount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal2Amount]
  ) AS [Subtotal2Amount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal3Amount]
  ) AS [Subtotal3Amount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal4Amount]
  ) AS [Subtotal4Amount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal5Amount]
  ) AS [Subtotal5Amount]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[Subtotal6Amount]
  ) AS [Subtotal6Amount]
  , doc.[StatisticalValueControl]
  , doc.[StatisticsExchangeRate]
  , doc.[StatisticsCurrency]
  , doc.[SalesOrganizationCurrency]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[EligibleAmountForCashDiscount]
  ) AS [EligibleAmountForCashDiscount]
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
  , doc.[CustomerAccountAssignmentGroup]            as [CustomerAccountAssignmentGroupID]
  , doc.[BusinessArea]
  , doc.[ProfitCenter]
  , doc.[OrderID]
  , doc.[ControllingArea]
  , doc.[ProfitabilitySegment]
  , doc.[CostCenter]
  , doc.[OriginSDDocument]
  , doc.[OriginSDDocumentItem]
  , doc.[PriceDetnExchangeRateDate]
  , doc.[ExchangeRateType]                          as [ExchangeRateTypeID]
  , doc.[FiscalYearVariant]
  , doc.[Currency]                                  as [CurrencyID]
  , doc.[AccountingExchangeRate]
  , doc.[AccountingExchangeRateIsSet]
  , doc.[ReferenceSDDocument]
  , doc.[ReferenceSDDocumentItem]
  , doc.[ReferenceSDDocumentCategory]               as [ReferenceSDDocumentCategoryID]
  , doc.[SalesDocument]                             as [SalesDocumentID]
  , doc.[SalesDocumentItem]                         as [SalesDocumentItemID]
  , doc.[SalesSDDocumentCategory]                   as [SalesSDDocumentCategoryID]
  , doc.[HigherLevelItem]
  , doc.[BillingDocumentItemInPartSgmt]
  , doc.[SalesGroup]
  , doc.[AdditionalCustomerGroup1]
  , doc.[AdditionalCustomerGroup2]
  , doc.[AdditionalCustomerGroup3]
  , doc.[AdditionalCustomerGroup4]
  , doc.[AdditionalCustomerGroup5]
  , doc.[SDDocumentReason]                          as [SDDocumentReasonID]
  , doc.[ItemIsRelevantForCredit]
  , doc.[CreditRelatedPrice]
  , doc.[SalesDistrict]                             as [SalesDistrictID]
  , doc.[CustomerGroup]                             as [CustomerGroupID]
  , doc.[SoldToParty]
  , doc.[Country]                                   as [CountryID]
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
  ) AS [QuantitySold]
  , edw.svf_getInvertAmountForReturns(
      doc.[ReturnItemProcessingType],
      doc.[BillingDocumentType],
      doc.[SalesDocumentItemCategory],
      doc.[NetAmount] - doc.[CostAmount]
  ) AS [GrossMargin]
  , ZB.Customer                                     as ExternalSalesAgentID
  , ZB.FullName                                     as ExternalSalesAgent
  , ZP.Customer                                     as ProjectID
  , ZP.FullName                                     as Project
  , dim_SalesEmployee.Personnel                     as SalesEmployeeID
  , dim_SalesEmployee.FullName                      as SalesEmployee
  , D1.[Customer]                                   as GlobalParentID
  , D1.[FullName]                                   as GlobalParent
  , case
      when D1.[Customer] is not Null then D1.[Customer]
      else AG.[Customer] end                      as GlobalParentCalculatedID
  , case
      when D1.[Customer] is not Null then D1.[FullName]
      else AG.[FullName] end                      as GlobalParentCalculated
  , C1.[Customer]                                   as LocalParentID
  , C1.[FullName]                                   as LocalParent
  , case
      when C1.[Customer] is not Null then C1.[Customer]
      else AG.[Customer] end                      as LocalParentCalculatedID
  , case
      when C1.[Customer] is not Null then C1.[FullName]
      else AG.[FullName] end                      as LocalParentCalculated

  , SDTT.SalesDocumentType                          as SalesOrderTypeID
  , case
      when doc.[BillToParty] is not Null then doc.[BillToParty]
      else doc.[SoldToParty] end                  as BillToID

  , case
      when doc.[BillToParty] is not Null then RE.[FullName]
      else AG.[FullName] end                      as BillTo
  , doc.[BillingDocumentDate]                     as [AccountingDate]
  , doc.[Material] as MaterialCalculated
  , doc.[SoldToParty] as SoldToPartyCalculated
  , edw.svf_getInOutID_s4h (CustomerID) as InOutID
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
    ON doc.SalesDocument = PA.PurchaseOrder                   COLLATE DATABASE_DEFAULT
        AND right(doc.SalesDocumentItem,5) = PA.PurchaseOrderItem 
  left join [edw].[dim_Customer] DimCust
      ON doc.SoldToParty = DimCust.CustomerID  
),
EuroBudgetExchangeRate as (
  select 
    SourceCurrency
    ,ExchangeRateEffectiveDate
    ,ExchangeRate
  from 
    edw.dim_ExchangeRates
  where
    ExchangeRateType = 'ZAXBIBUD'
    and
    TargetCurrency = 'EUR'
),    
EuroBudgetExchangeRateUSD as (
    select
        TargetCurrency
        ,ExchangeRateEffectiveDate
        ,ExchangeRate
    from
        edw.dim_ExchangeRates
    where
        ExchangeRateType = 'ZAXBIBUD'
        AND
        SourceCurrency = 'USD'),
ExchangeRateEuro as (
  SELECT
    [BillingDocument]
,   [BillingDocumentItem]
,   EuroBudgetExchangeRate.[ExchangeRate] AS [ExchangeRate]
  FROM (
    SELECT
      [BillingDocument]
  ,   [BillingDocumentItem]
  ,   [TransactionCurrencyID]
  ,   MAX([ExchangeRateEffectiveDate]) as [ExchangeRateEffectiveDate]
    FROM 
      BillingDocumentItemBase BDI
    LEFT JOIN 
      EuroBudgetExchangeRate
      ON 
        BDI.[TransactionCurrencyID] = EuroBudgetExchangeRate.SourceCurrency
    WHERE 
      [ExchangeRateEffectiveDate] <= [BillingDocumentDate]
    GROUP BY
      [BillingDocument]
  ,   [BillingDocumentItem]
  ,   [TransactionCurrencyID] 
  ) bdi_er_date_eur
  LEFT JOIN 
    EuroBudgetExchangeRate
    ON
      bdi_er_date_eur.[TransactionCurrencyID] = EuroBudgetExchangeRate.[SourceCurrency]
      AND
      bdi_er_date_eur.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRate.[ExchangeRateEffectiveDate]
)

SELECT
  bdi.BillingDocument,
  bdi.BillingDocumentItem,
  bdi.TransactionCurrencyID,
  bdi.CurrencyID,
  curr.CurrencyTypeID,
  rates.SourceCurrency,
  rates.TargetCurrency,
  rates.ExchangeRate,
  CASE
    WHEN curr.CurrencyTypeID = '00'
    THEN NetAmount
    ELSE ExchangeRate * NetAmount
  END AS NetAmount
FROM
  BillingDocumentItemBase bdi
CROSS JOIN 
  [edw].[dim_CurrencyType] curr
LEFT JOIN
  edw.vw_CurrencyConversionRate rates
  ON
    rates.CurrencyTypeID = curr.CurrencyTypeID
    AND
    GETDATE() BETWEEN rates.ExchangeRateEffectiveDate AND rates.LastDay
    AND
    rates.SourceCurrency = bdi.CurrencyID
WHERE
  BillingDocument IN ('4850000107')
ORDER BY
  BillingDocumentItem,
  CurrencyTypeID

-- with [today_] as (select GETDATE() as today)

-- SELECT
--         SourceCurrency,
--         TargetCurrency,
--         ExchangeRate,
--         '00'                AS CurrencyTypeID
--     FROM [edw].[vw_CurrencyConversionRate]
--     WHERE CurrencyTypeID = '10'

--         UNION ALL

--     SELECT
--         SourceCurrency,
--         TargetCurrency,
--         ExchangeRate,
--         CurrencyTypeID
--     FROM [edw].[vw_CurrencyConversionRate]  rates
--     CROSS JOIN [today_]
--     WHERE today BETWEEN rates.ExchangeRateEffectiveDate AND rates.LastDay






    ,BillingDocument_30 AS(
        SELECT 
                ExchangeRateEuro.[BillingDocument]
            ,   ExchangeRateEuro.[BillingDocumentItem]
            ,   'EUR' AS [CurrencyID]
            ,   ExchangeRateEuro.[ExchangeRate] AS [ExchangeRate]
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
            ,   CONVERT(decimal(19,6), [NetAmount] * ExchangeRateEuro.[ExchangeRate]) as [NetAmount]
            ,   [TransactionCurrencyID]
            ,   CONVERT(decimal(19,6), [GrossAmount] * ExchangeRateEuro.[ExchangeRate]) as [GrossAmount]
            ,   [PricingDate]
            ,   [PriceDetnExchangeRate]
            ,   [PricingScaleQuantityInBaseUnit]
            ,   CONVERT(decimal(19,6), [TaxAmount] * ExchangeRateEuro.[ExchangeRate]) as [TaxAmount]
            ,   CONVERT(decimal(19,6), [CostAmount] * ExchangeRateEuro.[ExchangeRate]) as [CostAmount]
            ,   CONVERT(decimal(19,6), [Subtotal1Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal1Amount]
            ,   CONVERT(decimal(19,6), [Subtotal2Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal2Amount]
            ,   CONVERT(decimal(19,6), [Subtotal3Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal3Amount]
            ,   CONVERT(decimal(19,6), [Subtotal4Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal4Amount]
            ,   CONVERT(decimal(19,6), [Subtotal5Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal5Amount]
            ,   CONVERT(decimal(19,6), [Subtotal6Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal6Amount]
            ,   [StatisticalValueControl]
            ,   [StatisticsExchangeRate]
            ,   [StatisticsCurrency]
            ,   [SalesOrganizationCurrency]
            ,   CONVERT(decimal(19,6), [EligibleAmountForCashDiscount] * ExchangeRateEuro.[ExchangeRate]) as [EligibleAmountForCashDiscount]
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
            ,   [CurrencyID] AS [CompanyCodeCurrencyID]
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
            ,   CONVERT(decimal(19,6), [CreditRelatedPrice] * ExchangeRateEuro.[ExchangeRate]) as [CreditRelatedPrice]
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
            ,   CONVERT(decimal(19,6), [GrossMargin] * ExchangeRateEuro.[ExchangeRate]) as [GrossMargin]            
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
            ,   [AccountingDate]
            ,   [MaterialCalculated]
            ,   [SoldToPartyCalculated]
            ,   [InOutID]
            ,   BDI.[ICSalesDocumentID]
            ,   BDI.[ICSalesDocumentItemID]
            ,   BDI.[t_applicationId]
            ,   BDI.[t_extractionDtm]
        FROM 
            ExchangeRateEuro
        LEFT JOIN
            BillingDocumentItemBase_Margin BDI
            ON
                BDI.BillingDocument = ExchangeRateEuro.BillingDocument
                AND
                BDI.BillingDocumentItem = ExchangeRateEuro.BillingDocumentItem
    ),
    ExchangeRateUSD as (
        SELECT
                [BillingDocument]
            ,   [BillingDocumentItem]
            ,   EuroBudgetExchangeRateUSD.[ExchangeRate] AS [ExchangeRate]
        FROM (
            SELECT 
                    [BillingDocument]
                ,   [BillingDocumentItem]
                ,   [CurrencyID]
                ,   MAX([ExchangeRateEffectiveDate]) as [ExchangeRateEffectiveDate]
            FROM 
                BillingDocument_30 BDI_30
            LEFT JOIN 
                EuroBudgetExchangeRateUSD
                ON 
                    BDI_30.CurrencyID = EuroBudgetExchangeRateUSD.TargetCurrency
            WHERE 
                [ExchangeRateEffectiveDate] <= [BillingDocumentDate]
            GROUP BY
                    [BillingDocument]
                ,   [BillingDocumentItem]
                ,   [CurrencyID]
        ) bdi_er_date_usd            
        LEFT JOIN 
            EuroBudgetExchangeRateUSD
            ON
                bdi_er_date_usd.[CurrencyID] = EuroBudgetExchangeRateUSD.[TargetCurrency]
                AND
                bdi_er_date_usd.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRateUSD.[ExchangeRateEffectiveDate]
         )
/*
    Transaction currency data from S4H
*/
SELECT
       [BillingDocument]
      ,[BillingDocumentItem]
      ,edw.svf_getNaturalKey (BillingDocument,BillingDocumentItem,CR.CurrencyTypeID) as [nk_fact_BillingDocumentItem]
      ,CR.[CurrencyTypeID]
      ,CR.[CurrencyType]
      ,[TransactionCurrencyID] as [CurrencyID]
      ,1.0 as [ExchangeRate]
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
      ,[NetAmount]
      ,[TransactionCurrencyID] 
      ,[GrossAmount]
      ,[PricingDate]
      ,[PriceDetnExchangeRate]
      ,[PricingScaleQuantityInBaseUnit]
      ,[TaxAmount]
      ,[CostAmount]
      ,[Subtotal1Amount]
      ,[Subtotal2Amount]
      ,[Subtotal3Amount]
      ,[Subtotal4Amount]
      ,[Subtotal5Amount]
      ,[Subtotal6Amount]
      ,[StatisticalValueControl]
      ,[StatisticsExchangeRate]
      ,[StatisticsCurrency]
      ,[SalesOrganizationCurrency]
      ,[EligibleAmountForCashDiscount]
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
      ,[CurrencyID] as [CompanyCodeCurrencyID]
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
      ,[CreditRelatedPrice]
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
    BillingDocumentItemBase_Margin BDI
CROSS JOIN 
    [edw].[dim_CurrencyType] CR
-- WHERE 
--     CR.[CurrencyTypeID] = '00'

UNION ALL

/*
    Local Company Code currency data from S4H
*/

SELECT 
     [BillingDocument]
    ,[BillingDocumentItem]
    ,edw.svf_getNaturalKey (BillingDocument,BillingDocumentItem,CR.CurrencyTypeID) as [nk_fact_BillingDocumentItem]
    ,CR.[CurrencyTypeID]
    ,CR.[CurrencyType]
    ,[CurrencyID]
    ,[AccountingExchangeRate] as [ExchangeRate]
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
    ,CONVERT(decimal(19,6), [NetAmount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                            THEN 1 / [AccountingExchangeRate] 
                                            ELSE [AccountingExchangeRate] 
                                            END)) as [NetAmount]
    ,[TransactionCurrencyID]
    ,CONVERT(decimal(19,6), [GrossAmount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                        THEN 1 / [AccountingExchangeRate] 
                                        ELSE [AccountingExchangeRate] 
                                        END)) as [GrossAmount]
    ,[PricingDate]
    ,[PriceDetnExchangeRate]
    ,[PricingScaleQuantityInBaseUnit]
    ,CONVERT(decimal(19,6), [TaxAmount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                    THEN 1 / [AccountingExchangeRate] 
                                    ELSE [AccountingExchangeRate] 
                                    END)) as [TaxAmount]
    ,CONVERT(decimal(19,6), [CostAmount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                        THEN 1 / [AccountingExchangeRate] 
                                        ELSE [AccountingExchangeRate] 
                                        END)) as [CostAmount]
    ,CONVERT(decimal(19,6), [Subtotal1Amount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                        THEN 1 / [AccountingExchangeRate] 
                                        ELSE [AccountingExchangeRate] 
                                        END)) as [Subtotal1Amount]
    ,CONVERT(decimal(19,6), [Subtotal2Amount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                    THEN 1 / [AccountingExchangeRate] 
                                    ELSE [AccountingExchangeRate] 
                                    END)) as [Subtotal2Amount]
    ,CONVERT(decimal(19,6), [Subtotal3Amount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                    THEN 1 / [AccountingExchangeRate] 
                                    ELSE [AccountingExchangeRate] 
                                    END)) as [Subtotal3Amount]
    ,CONVERT(decimal(19,6), [Subtotal4Amount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                    THEN 1 / [AccountingExchangeRate] 
                                    ELSE [AccountingExchangeRate] 
                                    END)) as [Subtotal4Amount]
    ,CONVERT(decimal(19,6), [Subtotal5Amount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                    THEN 1 / [AccountingExchangeRate] 
                                    ELSE [AccountingExchangeRate] 
                                    END)) as [Subtotal5Amount]
    ,CONVERT(decimal(19,6), [Subtotal6Amount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                    THEN 1 / [AccountingExchangeRate] 
                                    ELSE [AccountingExchangeRate] 
                                    END)) as [Subtotal6Amount]
    ,[StatisticalValueControl]
    ,[StatisticsExchangeRate]
    ,[StatisticsCurrency]
    ,[SalesOrganizationCurrency]
    ,CONVERT(decimal(19,6), [EligibleAmountForCashDiscount] * (CASE WHEN [AccountingExchangeRate] < 0 
                                    THEN 1 / [AccountingExchangeRate] 
                                    ELSE [AccountingExchangeRate] 
                                    END)) as [EligibleAmountForCashDiscount]
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
    ,[CurrencyID] as [CompanyCodeCurrencyID]
    ,[AccountingExchangeRate] as [ExchangeRate]
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
    ,CONVERT(decimal(19,6), [CreditRelatedPrice] * (CASE WHEN [AccountingExchangeRate] < 0 
                                    THEN 1 / [AccountingExchangeRate] 
                                    ELSE [AccountingExchangeRate] 
                                    END)) as [CreditRelatedPrice]
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
    ,CONVERT(decimal(19,6), [GrossMargin] * (CASE WHEN [AccountingExchangeRate] < 0 
                                    THEN 1 / [AccountingExchangeRate] 
                                    ELSE [AccountingExchangeRate] 
                                    END)) as [GrossMargin]
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
    BillingDocumentItemBase_Margin BDI
CROSS JOIN 
    [edw].[dim_CurrencyType] CR
WHERE 
    CR.[CurrencyTypeID] = '10'

UNION ALL

/*
    Euro budgeted converted data from S4H
    
    Convert the monetairy measure fields using the Euro budgeted conversion rates. 
    First get the correct exchange rate for each billing document by looking up the 
    most recent exchange rate that applies for the billing document date. 
    Then use this exchange rate to apply the conversion calculations. 
*/
SELECT 
     [BillingDocument]
    ,[BillingDocumentItem]
    ,edw.svf_getNaturalKey (BillingDocument,BillingDocumentItem,CR.CurrencyTypeID) as [nk_fact_BillingDocumentItem]
    ,CR.[CurrencyTypeID]
    ,CR.[CurrencyType]
    ,[CurrencyID]
    ,[ExchangeRate]
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
    ,[NetAmount]
    ,[TransactionCurrencyID]
    ,[GrossAmount]
    ,[PricingDate]
    ,[PriceDetnExchangeRate]
    ,[PricingScaleQuantityInBaseUnit]
    ,[TaxAmount]
    ,[CostAmount]
    ,[Subtotal1Amount]
    ,[Subtotal2Amount]
    ,[Subtotal3Amount]
    ,[Subtotal4Amount]
    ,[Subtotal5Amount]
    ,[Subtotal6Amount]
    ,[StatisticalValueControl]
    ,[StatisticsExchangeRate]
    ,[StatisticsCurrency]
    ,[SalesOrganizationCurrency]
    ,[EligibleAmountForCashDiscount]
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
    ,[CreditRelatedPrice]
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
    ,[BillToID]
    ,[BillTo]
    ,[AccountingDate]
    ,[MaterialCalculated]
    ,[SoldToPartyCalculated]
    ,[InOutID]
    ,BD_30.[ICSalesDocumentID]
    ,BD_30.[ICSalesDocumentItemID]
    ,BD_30.[t_applicationId]
    ,BD_30.[t_extractionDtm]
    --,bdi_er_date.[t_jobId]
    --,bdi_er_date.[t_jobDtm]
    --,bdi_er_date.[t_lastActionCd]
    --,bdi_er_date.[t_jobBy]
FROM 
    BillingDocument_30 BD_30
CROSS JOIN 
    [edw].[dim_CurrencyType] CR
WHERE 
    CR.[CurrencyTypeID] = '30'

UNION ALL


SELECT 
     
     ExchangeRateUSD.[BillingDocument]
    ,ExchangeRateUSD.[BillingDocumentItem]
    ,edw.svf_getNaturalKey (ExchangeRateUSD.BillingDocument,ExchangeRateUSD.BillingDocumentItem,CR.CurrencyTypeID) as [nk_fact_BillingDocumentItem]
    ,CR.[CurrencyTypeID]
    ,CR.[CurrencyType]
    ,'USD' AS [CurrencyID]
    ,1/ExchangeRateUSD.[ExchangeRate] AS [ExchangeRate]
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
    ,CONVERT(decimal(19,6), [NetAmount] * (1/ExchangeRateUSD.[ExchangeRate])) as [NetAmount]
    ,[TransactionCurrencyID]
    ,CONVERT(decimal(19,6), [GrossAmount] * (1/ExchangeRateUSD.[ExchangeRate])) as [GrossAmount]
    ,[PricingDate]
    ,[PriceDetnExchangeRate]
    ,[PricingScaleQuantityInBaseUnit]
    ,CONVERT(decimal(19,6), [TaxAmount] * (1/ExchangeRateUSD.[ExchangeRate])) as [TaxAmount]
    ,CONVERT(decimal(19,6), [CostAmount] * (1/ExchangeRateUSD.[ExchangeRate])) as [CostAmount]
    ,CONVERT(decimal(19,6), [Subtotal1Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal1Amount]
    ,CONVERT(decimal(19,6), [Subtotal2Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal2Amount]
    ,CONVERT(decimal(19,6), [Subtotal3Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal3Amount]
    ,CONVERT(decimal(19,6), [Subtotal4Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal4Amount]
    ,CONVERT(decimal(19,6), [Subtotal5Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal5Amount]
    ,CONVERT(decimal(19,6), [Subtotal6Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal6Amount]
    ,[StatisticalValueControl]
    ,[StatisticsExchangeRate]
    ,[StatisticsCurrency]
    ,[SalesOrganizationCurrency]
    ,CONVERT(decimal(19,6), [EligibleAmountForCashDiscount] * (1/ExchangeRateUSD.[ExchangeRate])) as [EligibleAmountForCashDiscount]
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
    ,CONVERT(decimal(19,6), [CreditRelatedPrice] * (1/ExchangeRateUSD.[ExchangeRate])) as [CreditRelatedPrice]
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
    ,CONVERT(decimal(19,6), [GrossMargin] * (1/ExchangeRateUSD.[ExchangeRate])) as [GrossMargin]
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
FROM 
    ExchangeRateUSD
LEFT JOIN
    BillingDocument_30 BDI
    ON
        BDI.BillingDocument = ExchangeRateUSD.BillingDocument
        AND
        BDI.BillingDocumentItem = ExchangeRateUSD.BillingDocumentItem
CROSS JOIN 
    [edw].[dim_CurrencyType] CR
WHERE 
    CR.[CurrencyTypeID] = '40'