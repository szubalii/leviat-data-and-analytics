﻿CREATE VIEW [edw].[vw_BillingDocumentItem_s4h_delta]
AS

WITH BillingDocumentItemBase as (
    select 
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
        , doc.[AdditionalMaterialGroup1]                  as [BrandID]
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
        , CASE
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN doc.[NetAmount] * (-1) 
              ELSE 
                  doc.[NetAmount]
         END AS [NetAmount]
        , doc.[TransactionCurrency]                       AS [TransactionCurrencyID]
        , CASE
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN doc.[GrossAmount] * (-1) 
              ELSE 
                  doc.[GrossAmount]
          END AS [GrossAmount]
        , doc.[PricingDate]
        , doc.[PriceDetnExchangeRate]
        , doc.[PricingScaleQuantityInBaseUnit]
        , CASE
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN doc.[TaxAmount]  
              ELSE  
                  doc.[TaxAmount] * (-1)
          END AS [TaxAmount] 
        , CASE 
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN doc.[CostAmount]  
              ELSE 
                  doc.[CostAmount] * (-1)
          END AS [CostAmount]
        , CASE             
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN doc.[Subtotal1Amount] * (-1) 
              ELSE 
                  doc.[Subtotal1Amount]
          END AS [Subtotal1Amount] 
        , CASE 
            WHEN 
                doc.[ReturnItemProcessingType] = 'X'
                OR                
                (doc.[BillingDocumentType] = 'ZG2'
                AND
                doc.[SalesDocumentItemCategory] = 'ZL2N')
            THEN doc.[Subtotal2Amount] * (-1) 
            ELSE 
                doc.[Subtotal2Amount]
          END AS [Subtotal2Amount] 
        , CASE 
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN doc.[Subtotal3Amount] * (-1) 
              ELSE 
                  doc.[Subtotal3Amount]
          END AS [Subtotal3Amount] 
        , CASE 
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN doc.[Subtotal4Amount] * (-1) 
              ELSE 
                  doc.[Subtotal4Amount]
          END AS [Subtotal4Amount] 
        , CASE 
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN doc.[Subtotal5Amount] * (-1) 
              ELSE 
                  doc.[Subtotal5Amount]
          END AS [Subtotal5Amount] 
        , CASE 
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN doc.[Subtotal6Amount] * (-1) 
              ELSE 
                  doc.[Subtotal6Amount]
          END AS [Subtotal6Amount]
        , doc.[StatisticalValueControl]
        , doc.[StatisticsExchangeRate]
        , doc.[StatisticsCurrency]
        , doc.[SalesOrganizationCurrency]
        , CASE
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN doc.[EligibleAmountForCashDiscount] * (-1) 
              ELSE 
                  doc.[EligibleAmountForCashDiscount]
          END AS [EligibleAmountForCashDiscount]
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
        , CASE
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN [BillingQuantity] * (-1)
              ELSE
                  [BillingQuantity]
          END AS QuantitySold 
        , CASE 
              WHEN 
                  doc.[ReturnItemProcessingType] = 'X'
                  OR                
                  (doc.[BillingDocumentType] = 'ZG2'
                  AND
                  doc.[SalesDocumentItemCategory] = 'ZL2N')
              THEN (doc.[NetAmount] - doc.[CostAmount]) * (-1) 
              ELSE doc.[NetAmount] - doc.[CostAmount]
          END AS GrossMargin
        , ZB.Customer                                     as ExternalSalesAgentID
        , ZB.FullName                                     as ExternalSalesAgent
        , ZP.Customer                                     as ProjectID
        , ZP.FullName                                     as Project
        , VE.Personnel                                    as SalesEmployeeID
        , VE.FullName                                     as SalesEmployee
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

        -- move to DM
        , SDID.[SalesDocumentType]                      as SalesOrderTypeID
        , case
            when doc.[BillToParty] is not Null then doc.[BillToParty]
            else doc.[SoldToParty] end                  as BillToID

        , case
            when doc.[BillToParty] is not Null then RE.[FullName]
            else AG.[FullName] end                      as BillTo
        , doc.[BillingDocumentDate]                     as [AccountingDate]
        , doc.[Material] as MaterialCalculated
        , doc.[SoldToParty] as SoldToPartyCalculated
        , case
            when left(doc.[SoldToParty], 2) = 'IC' or left(doc.[SoldToParty], 2) = 'IP'
            then 'I'
            else 'O'
          end as InOutID
        , PA.ICSalesDocumentID 
        , PA.ICSalesDocumentItemID
        , doc.[t_applicationId]
        , doc.[t_extractionDtm]
        , doc.[t_lastActionBy]
        , doc.[t_lastActionCd]
        , doc.[t_lastActionDtm]
        , doc.[t_filePath]   

    from [base_s4h_cax].[C_BillingDocumentItemBasicDEX_active] doc
        left join [edw].[dim_BillingDocumentPartnerFs] ZB
            on ZB.SDDocument = doc.[BillingDocument] and ZB.[PartnerFunction] = 'ZB' 
            -- and ZB.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
        left join [edw].[dim_BillingDocumentPartnerFs] ZP
            on ZP.SDDocument = doc.[BillingDocument] and ZP.[PartnerFunction] = 'ZP'
            -- and ZP.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
        left join [edw].[dim_BillingDocumentPartnerFs] VE
            on VE.SDDocument = doc.[BillingDocument] and VE.[PartnerFunction] = 'VE'
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
        left join [edw].[dim_PurgAccAssignment] PA
            ON doc.SalesDocument = PA.PurchaseOrder                   COLLATE DATABASE_DEFAULT
                AND right(doc.SalesDocumentItem,5) = PA.PurchaseOrderItem
        -- move to DM            
        --left join [base_s4h_cax].[I_SalesDocumentTypeText] SDTT
        --    on SDTT.[SalesDocumentType] = SDID.[SalesDocumentType] and SDTT.[Language] = 'E' 
        WHERE  
            -- casting the left and right sides of equality to the same data type DATE              
            CAST(doc.[t_lastActionDtm] as DATE) >  -- the view displays new data that is not yet in the fact table
            (
                SELECT 
                    CAST(isNull(max([t_lastActionDtm]), '1900-01-01') as DATE) AS [max_lastActionDay]
                FROM 
                    [edw].[fact_BillingDocumentItem_s4h_active]
            )
    ),
    BillingDocumentItemBase_Margin AS (    
    select 
          BDI_Base.[BillingDocument]
        , BDI_Base.[BillingDocumentItem]
        , BDI_Base.[SalesDocumentItemCategoryID]
        , BDI_Base.[SalesDocumentItemTypeID]
        , BDI_Base.[ReturnItemProcessingType]
        , BDI_Base.[BillingDocumentTypeID]
        , BDI_Base.[BillingDocumentCategoryID]
        , BDI_Base.[SDDocumentCategoryID]
        , BDI_Base.[CreationDate]
        , BDI_Base.[CreationTime]
        , BDI_Base.[LastChangeDate]
        , BDI_Base.[BillingDocumentDate]
        , BDI_Base.[BillingDocumentIsTemporary]
        , BDI_Base.[OrganizationDivision]
        , BDI_Base.[Division]
        , BDI_Base.[SalesOfficeID]
        , BDI_Base.[SalesOrganizationID]
        , BDI_Base.[DistributionChannelID]
        , BDI_Base.[Material]
        , BDI_Base.[OriginallyRequestedMaterial]
        , BDI_Base.[InternationalArticleNumber]
        , BDI_Base.[PricingReferenceMaterial]
        , BDI_Base.[LengthInMPer1]
        , BDI_Base.[LengthInM]
        , BDI_Base.[Batch]
        , BDI_Base.[MaterialGroupID]
        , BDI_Base.[BrandID]
        , BDI_Base.[AdditionalMaterialGroup2]
        , BDI_Base.[AdditionalMaterialGroup3]
        , BDI_Base.[AdditionalMaterialGroup4]
        , BDI_Base.[AdditionalMaterialGroup5]
        , BDI_Base.[MaterialCommissionGroup]
        , BDI_Base.[PlantID]
        , BDI_Base.[StorageLocationID]
        , BDI_Base.[BillingDocumentIsCancelled]
        , BDI_Base.[CancelledBillingDocument]
        , BDI_Base.[CancelledInvoiceEffect]
        , BDI_Base.[BillingDocumentItemText]
        , BDI_Base.[ServicesRenderedDate]
        , BDI_Base.[BillingQuantity]
        , BDI_Base.[BillingQuantityUnitID]
        , BDI_Base.[BillingQuantityInBaseUnit]
        , BDI_Base.[BaseUnit]
        , BDI_Base.[MRPRequiredQuantityInBaseUnit]
        , BDI_Base.[BillingToBaseQuantityDnmntr]
        , BDI_Base.[BillingToBaseQuantityNmrtr]
        , BDI_Base.[ItemGrossWeight]
        , BDI_Base.[ItemNetWeight]
        , BDI_Base.[ItemWeightUnit]
        , BDI_Base.[ItemVolume]
        , BDI_Base.[ItemVolumeUnit]
        , BDI_Base.[BillToPartyCountry]
        , BDI_Base.[BillToPartyRegion]
        , BDI_Base.[BillingPlanRule]
        , BDI_Base.[BillingPlan]
        , BDI_Base.[BillingPlanItem]
        , BDI_Base.[CustomerPriceGroupID]
        , BDI_Base.[PriceListTypeID]
        , BDI_Base.[TaxDepartureCountry]
        , BDI_Base.[VATRegistration]
        , BDI_Base.[VATRegistrationCountry]
        , BDI_Base.[VATRegistrationOrigin]
        , BDI_Base.[CustomerTaxClassification1]
        , BDI_Base.[CustomerTaxClassification2]
        , BDI_Base.[CustomerTaxClassification3]
        , BDI_Base.[CustomerTaxClassification4]
        , BDI_Base.[CustomerTaxClassification5]
        , BDI_Base.[CustomerTaxClassification6]
        , BDI_Base.[CustomerTaxClassification7]
        , BDI_Base.[CustomerTaxClassification8]
        , BDI_Base.[CustomerTaxClassification9]
        , BDI_Base.[SDPricingProcedure]
        , BDI_Base.[NetAmount]
        , BDI_Base.[TransactionCurrencyID]
        , BDI_Base.[GrossAmount]
        , BDI_Base.[PricingDate]
        , BDI_Base.[PriceDetnExchangeRate]
        , BDI_Base.[PricingScaleQuantityInBaseUnit]
        , BDI_Base.[TaxAmount] 
        , BDI_Base.[CostAmount]
        , BDI_Base.[Subtotal1Amount] 
        , BDI_Base.[Subtotal2Amount] 
        , BDI_Base.[Subtotal3Amount] 
        , BDI_Base.[Subtotal4Amount] 
        , BDI_Base.[Subtotal5Amount] 
        , BDI_Base.[Subtotal6Amount]
        , BDI_Base.[StatisticalValueControl]
        , BDI_Base.[StatisticsExchangeRate]
        , BDI_Base.[StatisticsCurrency]
        , BDI_Base.[SalesOrganizationCurrency]
        , BDI_Base.[EligibleAmountForCashDiscount]
        , BDI_Base.[ContractAccount]
        , BDI_Base.[CustomerPaymentTerms]
        , BDI_Base.[PaymentMethod]
        , BDI_Base.[PaymentReference]
        , BDI_Base.[FixedValueDate]
        , BDI_Base.[AdditionalValueDays]
        , BDI_Base.[PayerParty]
        , BDI_Base.[CompanyCode]
        , BDI_Base.[FiscalYear]
        , BDI_Base.[FiscalPeriod]
        , BDI_Base.[CustomerAccountAssignmentGroupID]
        , BDI_Base.[BusinessArea]
        , BDI_Base.[ProfitCenter]
        , BDI_Base.[OrderID]
        , BDI_Base.[ControllingArea]
        , BDI_Base.[ProfitabilitySegment]
        , BDI_Base.[CostCenter]
        , BDI_Base.[OriginSDDocument]
        , BDI_Base.[OriginSDDocumentItem]
        , BDI_Base.[PriceDetnExchangeRateDate]
        , BDI_Base.[ExchangeRateTypeID]
        , BDI_Base.[FiscalYearVariant]
        , BDI_Base.[CurrencyID]
        , BDI_Base.[AccountingExchangeRate]
        , BDI_Base.[AccountingExchangeRateIsSet]
        , BDI_Base.[ReferenceSDDocument]
        , BDI_Base.[ReferenceSDDocumentItem]
        , BDI_Base.[ReferenceSDDocumentCategoryID]
        , BDI_Base.[SalesDocumentID]
        , BDI_Base.[SalesDocumentItemID]
        , BDI_Base.[SalesSDDocumentCategoryID]
        , BDI_Base.[HigherLevelItem]
        , BDI_Base.[BillingDocumentItemInPartSgmt]
        , BDI_Base.[SalesGroup]
        , BDI_Base.[AdditionalCustomerGroup1]
        , BDI_Base.[AdditionalCustomerGroup2]
        , BDI_Base.[AdditionalCustomerGroup3]
        , BDI_Base.[AdditionalCustomerGroup4]
        , BDI_Base.[AdditionalCustomerGroup5]
        , BDI_Base.[SDDocumentReasonID]
        , BDI_Base.[ItemIsRelevantForCredit]
        , BDI_Base.[CreditRelatedPrice]
        , BDI_Base.[SalesDistrictID]
        , BDI_Base.[CustomerGroupID]
        , BDI_Base.[SoldToParty]
        , BDI_Base.[CountryID]
        , BDI_Base.[ShipToParty]
        , BDI_Base.[BillToParty]
        , BDI_Base.[ShippingPoint]
        , BDI_Base.[IncotermsVersion]
        , BDI_Base.[IncotermsClassification]
        , BDI_Base.[IncotermsTransferLocation]
        , BDI_Base.[IncotermsLocation1]
        , BDI_Base.[IncotermsLocation2]
        , BDI_Base.[ShippingCondition]
        , BDI_Base.[QuantitySold]
        , BDI_Base.[GrossMargin]
        , BDI_Base.[ExternalSalesAgentID]
        , BDI_Base.[ExternalSalesAgent]
        , BDI_Base.[ProjectID]
        , BDI_Base.[Project]
        , BDI_Base.[SalesEmployeeID]
        , BDI_Base.[SalesEmployee]
        , BDI_Base.[GlobalParentID]
        , BDI_Base.[GlobalParent]
        , BDI_Base.[GlobalParentCalculatedID]
        , BDI_Base.[GlobalParentCalculated]
        , BDI_Base.[LocalParentID]
        , BDI_Base.[LocalParent]
        , BDI_Base.[LocalParentCalculatedID]
        , BDI_Base.[LocalParentCalculated]
        , BDI_Base.[SalesOrderTypeID]
        , BDI_Base.[BillToID]
        , BDI_Base.[BillTo]
        , BDI_Base.[AccountingDate]
        , BDI_Base.[MaterialCalculated]
        , BDI_Base.[SoldToPartyCalculated]
        , BDI_Base.[InOutID]
        , BDI_Base.[ICSalesDocumentID]
        , BDI_Base.[ICSalesDocumentItemID]
        , BDI_Base.[t_applicationId]
        , BDI_Base.[t_extractionDtm]
        , BDI_Base.[t_lastActionBy]
        , BDI_Base.[t_lastActionCd]
        , BDI_Base.[t_lastActionDtm]
        , BDI_Base.[t_filePath]
    from BillingDocumentItemBase BDI_Base
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
        ),
    BillingDocument_30 AS(
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
            ,   BDI.[t_lastActionBy]
            ,   BDI.[t_lastActionCd]
            ,   BDI.[t_lastActionDtm]
            ,   BDI.[t_filePath]   
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

SELECT [BillingDocument]
      ,[BillingDocumentItem]
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
      ,BDI.[t_lastActionBy]
      ,BDI.[t_lastActionCd]
      ,BDI.[t_lastActionDtm]
      ,BDI.[t_filePath]   
FROM 
    BillingDocumentItemBase_Margin BDI
CROSS JOIN 
    [edw].[dim_CurrencyType] CR
WHERE 
    CR.[CurrencyTypeID] = '00'

UNION ALL

/*
    Local Company Code currency data from S4H
*/

SELECT 
     [BillingDocument]
    ,[BillingDocumentItem]
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
    ,BDI.[t_lastActionBy]
    ,BDI.[t_lastActionCd]
    ,BDI.[t_lastActionDtm]
    ,BDI.[t_filePath]  
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
    ,[ICSalesDocumentID]
    ,[ICSalesDocumentItemID]
    ,BD_30.[t_applicationId]
    ,BD_30.[t_extractionDtm]
    ,BD_30.[t_lastActionBy]
    ,BD_30.[t_lastActionCd]
    ,BD_30.[t_lastActionDtm]
    ,BD_30.[t_filePath]   
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
    ,[ICSalesDocumentID]
    ,[ICSalesDocumentItemID]
    ,BDI_30.[t_applicationId]
    ,BDI_30.[t_extractionDtm]
    ,BDI_30.[t_lastActionBy]
    ,BDI_30.[t_lastActionCd]
    ,BDI_30.[t_lastActionDtm]
    ,BDI_30.[t_filePath]   
FROM 
    ExchangeRateUSD
LEFT JOIN
    BillingDocument_30 BDI_30
    ON
        BDI_30.BillingDocument = ExchangeRateUSD.BillingDocument
        AND
        BDI_30.BillingDocumentItem = ExchangeRateUSD.BillingDocumentItem
CROSS JOIN 
    [edw].[dim_CurrencyType] CR
WHERE 
    CR.[CurrencyTypeID] = '40'