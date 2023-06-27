CREATE VIEW [edw].[vw_SalesDocumentItem_s4h]
	AS

WITH Product AS (
    SELECT 
        [ProductID]
    FROM
        [edw].[dim_Product]
    GROUP BY
        [ProductID]
),


OpenOrderAmount AS(
SELECT    SL.SalesDocument
        , SL.SalesDocumentItem 
        , COALESCE(SUM(SL.OpenDeliveryNetAmount), 0) as OpenDeliveryNetAmount


FROM base_s4h_cax.I_SalesDocumentScheduleLine AS SL 

GROUP BY SL.SalesDocument, SL.SalesDocumentItem
),
outboundDeliveries AS (
     SELECT SUM(ActualDeliveredQtyInBaseUnit)          AS ActualDeliveredQuantityInBaseUnit
          ,[ReferenceSDDocument]
          ,[ReferenceSDDocumentItem]
     FROM [edw].[vw_OutboundDeliveryItem_for_SalesDocumentItem]
     GROUP BY [ReferenceSDDocument]
               ,[ReferenceSDDocumentItem]
),
outboundDeliveriesOverall AS (
     SELECT SUM(ActualDeliveredQuantityInBaseUnit)          AS ActualDeliveredQuantityInBaseUnit
          ,[ReferenceSDDocument]
     FROM outboundDeliveries
     GROUP BY [ReferenceSDDocument]
),
documentItems AS (
    SELECT MAX(BillingQuantityInBaseUnit)           AS [BillingQuantityInBaseUnit] 
        , ReferenceSDDocument
        , ReferenceSDDocumentItem
    FROM (
        SELECT SUM(BillingQuantityInBaseUnit) AS [BillingQuantityInBaseUnit] 
            ,[SalesDocumentID]                  AS [ReferenceSDDocument]          
            ,[SalesDocumentItemID]              AS [ReferenceSDDocumentItem]      
        FROM [edw].[vw_BillingDocumentItem_for_SalesDocumentItem]
        GROUP BY [SalesDocumentID], [SalesDocumentItemID], [CurrencyID], [CurrencyTypeID]
    ) a
    GROUP BY [ReferenceSDDocument], [ReferenceSDDocumentItem]
),
documentItemsOverall AS (
    SELECT SUM(BillingQuantityInBaseUnit) AS BillingQuantityInBaseUnit      
        ,[ReferenceSDDocument]                                      
    FROM documentItems
    GROUP BY [ReferenceSDDocument]
),
salesDocumentScheduleLine AS (
     SELECT MAX(ScheduleLineCategory)                  AS ScheduleLineCategory
          ,[SalesDocumentID]
          ,[SalesDocumentItem]
     FROM [edw].[dim_SalesDocumentScheduleLine]
     GROUP BY 
          [SalesDocumentID]
          ,[SalesDocumentItem]
),

C_SalesDocumentItemDEXBase as (
    SELECT
         -- doc.[TS_SEQUENCE_NUMBER]
         --,doc.[ODQ_CHANGEMODE]
         --,doc.[ODQ_ENTITYCNTR]
           doc.[SalesDocument]
         , doc.[SalesDocumentItem]
         , doc.[SDDocumentCategory]             as [SDDocumentCategoryID]
         , doc.[SalesDocumentType]              as [SalesDocumentTypeID]
         , doc.[SalesDocumentItemCategory]      as [SalesDocumentItemCategoryID]
         , doc.[IsReturnsItem]                  as [IsReturnsItemID]
         , doc.[CreationDate]
         , doc.[CreationTime]
         , doc.[LastChangeDate]
         , doc.[SalesOrganization]              as [SalesOrganizationID]
         , doc.[DistributionChannel]            as [DistributionChannelID]
         , doc.[Division]                       as [DivisionID]
         , doc.[SalesGroup]                     as [SalesGroupID]
         , doc.[SalesOffice]                    as [SalesOfficeID]
         , doc.[InternationalArticleNumber]     as [InternationalArticleNumberID]
         , doc.[Batch]                          as [BatchID]
         , doc.[Material]                       as [MaterialID]
         , COALESCE(VC.[ProductSurrogateKey],Product.[ProductID]) AS [ProductSurrogateKey]
         , doc.[OriginallyRequestedMaterial]    as [OriginallyRequestedMaterialID]
         , doc.[MaterialSubstitutionReason]     as [MaterialSubstitutionReasonID]
         , doc.[MaterialGroup]                  as [MaterialGroupID]
         , DimBrand.[BrandID]                   as [BrandID]
         , DimBrand.[Brand]                     as [Brand]
         , doc.[AdditionalMaterialGroup2]       as [AdditionalMaterialGroup2ID]
         , doc.[AdditionalMaterialGroup3]       as [AdditionalMaterialGroup3ID]
         , doc.[AdditionalMaterialGroup4]       as [AdditionalMaterialGroup4ID]
         , doc.[AdditionalMaterialGroup5]       as [AdditionalMaterialGroup5ID]
         , doc.[SoldToParty]                    as [SoldToPartyID]
         , doc.[AdditionalCustomerGroup1]       as [AdditionalCustomerGroup1ID]
         , doc.[AdditionalCustomerGroup2]       as [AdditionalCustomerGroup2ID]
         , doc.[AdditionalCustomerGroup3]       as [AdditionalCustomerGroup3ID]
         , doc.[AdditionalCustomerGroup4]       as [AdditionalCustomerGroup4ID]
         , doc.[AdditionalCustomerGroup5]       as [AdditionalCustomerGroup5ID]
         , doc.[ShipToParty]                    as [ShipToPartyID]
         , doc.[PayerParty]                     as [PayerPartyID]
         , doc.[BillToParty]                    as [BillToPartyID]
         , doc.[SDDocumentReason]               as [SDDocumentReasonID]
         , doc.[SalesDocumentDate]
         , doc.[OrderQuantity]
         , doc.[OrderQuantityUnit]              as [OrderQuantityUnitID]
         , doc.[TargetQuantity]
         , doc.[TargetQuantityUnit]             as [TargetQuantityUnitID]
         , doc.[TargetToBaseQuantityDnmntr]
         , doc.[TargetToBaseQuantityNmrtr]
         , doc.[OrderToBaseQuantityDnmntr]
         , doc.[OrderToBaseQuantityNmrtr]
         , doc.[ConfdDelivQtyInOrderQtyUnit]
         , doc.[TargetDelivQtyInOrderQtyUnit]
         , doc.[ConfdDeliveryQtyInBaseUnit]
         , doc.[BaseUnit]                       as [BaseUnitID]
         , doc.[ItemGrossWeight]
         , doc.[ItemNetWeight]
         , doc.[ItemWeightUnit]                 as [ItemWeightUnitID]
         , doc.[ItemVolume]
         , doc.[ItemVolumeUnit]                 as [ItemVolumeUnitID]
         , doc.[ServicesRenderedDate]
         , doc.[SalesDistrict]                  as [SalesDistrictID]
         , doc.[CustomerGroup]                  as [CustomerGroupID]
         , doc.[HdrOrderProbabilityInPercent]   as [HdrOrderProbabilityInPercentID]
         , doc.[ItemOrderProbabilityInPercent]  as [ItemOrderProbabilityInPercentID]
         , doc.[SalesDocumentRjcnReason]        as [SalesDocumentRjcnReasonID]
         , doc.[PricingDate]
         , doc.[ExchangeRateDate]
         , doc.[PriceDetnExchangeRate]
         , doc.[StatisticalValueControl]        as [StatisticalValueControlID]
         , edw.[svf_getInvertAmount] (doc.SalesDocumentType, doc.NetAmount) as NetAmount
         , doc.[TransactionCurrency]            as [TransactionCurrencyID]
         , doc.[SalesOrganizationCurrency]      as [SalesOrganizationCurrencyID]
         , doc.[NetPriceAmount]
         , doc.[NetPriceQuantity]
         , doc.[NetPriceQuantityUnit]           as [NetPriceQuantityUnitID]
         , doc.[TaxAmount]
         , edw.[svf_getInvertAmount] (doc.SalesDocumentType, doc.CostAmount) as CostAmount
         , doc.[NetAmount] - doc.[CostAmount]   as [Margin]
         , doc.[Subtotal1Amount]
         , doc.[Subtotal2Amount]
         , doc.[Subtotal3Amount]
         , doc.[Subtotal4Amount]
         , doc.[Subtotal5Amount]
         , doc.[Subtotal6Amount]
         , doc.[ShippingPoint]                  as [ShippingPointID]
         , doc.[ShippingType]                   as [ShippingTypeID]
         , doc.[DeliveryPriority]               as [DeliveryPriorityID]
         , doc.[InventorySpecialStockType]      as [InventorySpecialStockTypeID]
         , doc.[RequestedDeliveryDate]
         , doc.[ShippingCondition]              as [ShippingConditionID]
         , doc.[DeliveryBlockReason]            as [DeliveryBlockReasonID]
         , doc.[Plant]                          as [PlantID]
         , doc.[StorageLocation]                as [StorageLocationID]
         , doc.[Route]                          as [RouteID]
         , doc.[IncotermsClassification]        as [IncotermsClassificationID]
         , doc.[IncotermsVersion]               as [IncotermsVersionID]
         , doc.[IncotermsTransferLocation]      as [IncotermsTransferLocationID]
         , doc.[IncotermsLocation1]             as [IncotermsLocation1ID]
         , doc.[IncotermsLocation2]             as [IncotermsLocation2ID]
         , doc.[MinDeliveryQtyInBaseUnit]
         , doc.[UnlimitedOverdeliveryIsAllowed] as [UnlimitedOverdeliveryIsAllowedID]
         , doc.[OverdelivTolrtdLmtRatioInPct]
         , doc.[UnderdelivTolrtdLmtRatioInPct]
         , doc.[PartialDeliveryIsAllowed]       as [PartialDeliveryIsAllowedID]
         , doc.[BindingPeriodValidityStartDate]
         , doc.[BindingPeriodValidityEndDate]
         , doc.[OutlineAgreementTargetAmount]
         , doc.[BillingDocumentDate]
         , doc.[BillingCompanyCode]             as [BillingCompanyCodeID]
         , doc.[HeaderBillingBlockReason]       as [HeaderBillingBlockReasonID]
         , doc.[ItemBillingBlockReason]         as [ItemBillingBlockReasonID]
         , doc.[FiscalYear]                     as [FiscalYearID]
         , doc.[FiscalPeriod]                   as [FiscalPeriodID]
         , doc.[CustomerAccountAssignmentGroup] as [CustomerAccountAssignmentGroupID]
         , doc.[ExchangeRateType]               as [ExchangeRateTypeID]
         , doc.[Currency]                       as [CurrencyID]
         , doc.[FiscalYearVariant]              as [FiscalYearVariantID]
         , doc.[BusinessArea]                   as [BusinessAreaID]
         , doc.[ProfitCenter]                   as [ProfitCenterID]
         , doc.[OrderID]                        as [OrderID]
         , doc.[ProfitabilitySegment]           as [ProfitabilitySegmentID]
         , doc.[ControllingArea]                as [ControllingAreaID]
         , doc.[ReferenceSDDocument]            as [ReferenceSDDocumentID]
         , doc.[ReferenceSDDocumentItem]        as [ReferenceSDDocumentItemID]
         , doc.[ReferenceSDDocumentCategory]    as [ReferenceSDDocumentCategoryID]
         , doc.[OriginSDDocument]               as [OriginSDDocumentID]
         , doc.[OriginSDDocumentItem]           as [OriginSDDocumentItemID]
         , doc.[OverallSDProcessStatus]         as [OverallSDProcessStatusID]
         , doc.[OverallTotalDeliveryStatus]     as [OverallTotalDeliveryStatusID]
         , doc.[OverallOrdReltdBillgStatus]     as [OverallOrdReltdBillgStatusID]
         , doc.[TotalCreditCheckStatus]         as [TotalCreditCheckStatusID]
         , doc.[DeliveryBlockStatus]            as [DeliveryBlockStatusID]
         , doc.[BillingBlockStatus]             as [BillingBlockStatusID]
         , doc.[TotalSDDocReferenceStatus]      as [TotalSDDocReferenceStatusID]
         , doc.[SDDocReferenceStatus]           as [SDDocReferenceStatusID]
         , doc.[OverallSDDocumentRejectionSts]  as [OverallSDDocumentRejectionStsID]
         , doc.[SDDocumentRejectionStatus]      as [SDDocumentRejectionStatusID]
         , doc.[OverallTotalSDDocRefStatus]     as [OverallTotalSDDocRefStatusID]
         , doc.[OverallSDDocReferenceStatus]    as [OverallSDDocReferenceStatusID]
         , doc.[ItemGeneralIncompletionStatus]  as [ItemGeneralIncompletionStatusID]
         , doc.[ItemBillingIncompletionStatus]  as [ItemBillingIncompletionStatusID]
         , doc.[PricingIncompletionStatus]      as [PricingIncompletionStatusID]
         , doc.[ItemDeliveryIncompletionStatus] as [ItemDeliveryIncompletionStatusID]
         , ZA.[Customer]                        as SalesAgentID
         , ZA.[FullName]                        as SalesAgent
         , ZB.[Customer]                        as [ExternalSalesAgentID]
         , ZB.[FullName]                        as [ExternalSalesAgent]
         , D1.[Customer]                        as [GlobalParentID]
         , D1.[FullName]                        as [GlobalParent]
         , C1.[Customer]                        as [LocalParentID]
         , C1.[FullName]                        as [LocalParent]
         , ZP.[Customer]                        as [ProjectID]
         , ZP.[FullName]                        as [Project]
         , dim_SalesEmployee.[Personnel]        as [SalesEmployeeID]
         , dim_SalesEmployee.[FullName]         as [SalesEmployee]
         , case
               when D1.[Customer] is not null then D1.[Customer]
               else AG.[Customer]
           end                                  as [GlobalParentCalculatedID]
         , case
               when D1.[FullName] is not null then D1.[FullName]
               else AG.[FullName]
          end                                   as [GlobalParentCalculated]
         , case
               when C1.[Customer] is not null then C1.[Customer]
               else AG.[Customer]
          end                                   as [LocalParentCalculatedID]
         , case
               when C1.[FullName] is not null then C1.[FullName]
               else AG.[FullName]
          end                                   as [LocalParentCalculated]
         , doc.[SDoc_ControllingObject]         as [SDoc_ControllingObjectID]
         , doc.[SDItem_ControllingObject]       as [SDItem_ControllingObjectID]
         , doc.[CorrespncExternalReference]     as [CorrespncExternalReference] 
         , edw.svf_getInOutID_s4h (CustomerID)  as [InOutID]
         , ORDAM.OpenDeliveryNetAmount
         , CASE
            WHEN SDSL.ScheduleLineCategory = 'ZS'
                THEN 'Drop Shipment'
            WHEN doc.ShippingCondition = 70      -- all related ShippingCondition is 70
                THEN 'Collection'
            WHEN doc.ShippingCondition <> 70      -- all related ShippingCondition isn't 70
                THEN 'Delivery'
            ELSE      'Unknown'
        END                                               AS [OrderType]
        , ios_status.Status                               AS [ItemOrderStatus]
        , os_status.Status                                AS [OrderStatus]
        , OD.[ActualDeliveredQuantityInBaseUnit]
        , DI.[BillingQuantityInBaseUnit]
        , ODO.[ActualDeliveredQuantityInBaseUnit]         AS [ActualDeliveredQuantityIBUOverall]
        , DIO.[BillingQuantityInBaseUnit]                 AS [BillingQuantityIBUOverall]
        , doc.[ItemDeliveryStatus]    
        , doc.[OverallDeliveryStatus] 
        , SDSL.[ScheduleLineCategory]
         , doc.[t_applicationId]
         , doc.[t_jobId]
         , doc.[t_jobDtm]
         , doc.[t_jobBy]
         , doc.[t_extractionDtm]
         , doc.[t_filePath]
    FROM
        [base_s4h_cax].[C_SalesDocumentItemDEX] doc
    LEFT JOIN
        [edw].[dim_BillingDocumentPartnerFs] ZB
        ON
            ZB.[SDDocument] = doc.[SalesDocument]
            AND
            ZB.[PartnerFunction] = 'ZB'
            --  and ZB.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    LEFT JOIN
        [edw].[dim_BillingDocumentPartnerFs] D1
        ON
            D1.[SDDocument] = doc.[SalesDocument]
            AND
            D1.[PartnerFunction] = '1D'
            --  and D1.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    LEFT JOIN
        [edw].[dim_BillingDocumentPartnerFs] C1
        ON
            C1.[SDDocument] = doc.[SalesDocument]
            AND
            C1.[PartnerFunction] = '1C'
            --  and C1.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    LEFT JOIN
        [edw].[dim_BillingDocumentPartnerFs] ZP
        ON
            ZP.[SDDocument] = doc.[SalesDocument]
            AND
            ZP.[PartnerFunction] = 'ZP'
            --  and ZP.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    LEFT JOIN
        [edw].[vw_dim_SalesEmployee] dim_SalesEmployee
        ON
            dim_SalesEmployee.[SDDocument] = doc.[SalesDocument]
            --  and VE.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    LEFT JOIN
        [edw].[dim_BillingDocumentPartnerFs] AG
        ON
            AG.[SDDocument] = doc.[SalesDocument]
            AND
            AG.[PartnerFunction] = 'AG'
            --  and AG.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    -- WHERE doc.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
     LEFT JOIN 
        [edw].[dim_BillingDocumentPartnerFs] ZA
        ON 
            ZA.[SDDocument] = doc.[SalesDocument]
            AND 
            ZA.[PartnerFunction] = 'ZA' 
    LEFT JOIN
        [edw].[vw_Brand] DimBrand
        ON
            DimBrand.[BrandID] = doc.[AdditionalMaterialGroup1]
    LEFT JOIN
        Product
        ON
            doc.[Material] = Product.[ProductID]
    LEFT JOIN
        [edw].[vw_ProductHierarchyVariantConfigCharacteristic] AS VC
        ON
            doc.[SalesDocument] = VC.[SalesDocument]
            AND
            doc.[SalesDocumentItem] = VC.[SalesDocumentItem]
    LEFT JOIN 
        OpenOrderAmount AS ORDAM 
        ON 
            ORDAM.SalesDocument = doc.SalesDocument 
            AND 
            ORDAM.SalesDocumentItem = doc.SalesDocumentItem

    LEFT JOIN outboundDeliveries OD
            ON doc.[SalesDocument] = OD.[ReferenceSDDocument]
                    AND doc.[SalesDocumentItem] = OD.[ReferenceSDDocumentItem]

    LEFT JOIN documentItems DI
            ON doc.[SalesDocument] = DI.[ReferenceSDDocument]
                    AND doc.[SalesDocumentItem] = DI.[ReferenceSDDocumentItem]

    LEFT JOIN salesDocumentScheduleLine SDSL
            ON doc.[SalesDocument] = SDSL.[SalesDocumentID]
                    AND doc.[SalesDocumentItem] = SDSL.[SalesDocumentItem]
    
    LEFT JOIN documentItemsOverall DIO
            ON doc.[SalesDocument] = DIO.[ReferenceSDDocument]

    LEFT JOIN outboundDeliveriesOverall ODO
            ON doc.[SalesDocument] = ODO.[ReferenceSDDocument]
                      
    LEFT JOIN [base_ff].[SalesDocumentStatuses]  ios_status
            ON 
                CASE
                    WHEN SDSL.ScheduleLineCategory = 'ZS'
                        THEN 2
                    WHEN doc.ShippingCondition = 70
                        THEN 1
                    WHEN doc.ShippingCondition <> 70
                        THEN 0
                END = ios_status.OrderType
            AND doc.[ItemDeliveryStatus] = COALESCE (ios_status.DeliveryStatus, doc.[ItemDeliveryStatus])
            AND CASE 
                    WHEN (doc.[ItemDeliveryStatus] = 'C' OR doc.[ItemDeliveryStatus] = '' OR SDSL.ScheduleLineCategory = 'ZS')
                        AND OD.ActualDeliveredQuantityInBaseUnit = DI.BillingQuantityInBaseUnit
                        THEN 'F'
                    WHEN (doc.[ItemDeliveryStatus] <> 'C' OR doc.[ItemDeliveryStatus] = '' OR SDSL.ScheduleLineCategory = 'ZS')
                        AND DI.BillingQuantityInBaseUnit <> 0
                        THEN 'P'
                    WHEN COALESCE(DI.BillingQuantityInBaseUnit,0) = 0 
                        THEN 'N'
                END = ios_status.InvoiceStatus
            AND doc.[SDDocumentCategory] <> 'B'
            AND doc.[SDDocumentRejectionStatus] <> 'C'
    LEFT JOIN [base_ff].[SalesDocumentStatuses]  os_status
            ON 
                    CASE
                        WHEN SDSL.ScheduleLineCategory = 'ZS'
                            THEN 2
                        WHEN doc.ShippingCondition = 70
                            THEN 1
                        WHEN doc.ShippingCondition <> 70
                            THEN 0
                    END = os_status.OrderType
            AND doc.[OverallDeliveryStatus] = COALESCE (os_status.DeliveryStatus, doc.[OverallDeliveryStatus])
            AND CASE 
                    WHEN (doc.[OverallDeliveryStatus] = 'C' OR doc.[OverallDeliveryStatus] = '' OR SDSL.ScheduleLineCategory = 'ZS')
                        AND ODO.ActualDeliveredQuantityInBaseUnit = DIO.BillingQuantityInBaseUnit
                        THEN 'F'
                    WHEN DIO.BillingQuantityInBaseUnit <> 0
                        THEN 'P'
                    WHEN COALESCE(DIO.BillingQuantityInBaseUnit,0) = 0 
                        THEN 'N'
                    END = os_status.InvoiceStatus
            AND doc.[SDDocumentCategory] <> 'B'
            AND doc.[SDDocumentRejectionStatus] <> 'C'

    LEFT JOIN  [edw].[dim_Customer] DimCust
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
        ExchangeRateType = 'P'
        and
        TargetCurrency = 'EUR'
        and
        [ExchangeRateEffectiveDate] <= GETDATE()
            UNION ALL
    SELECT                  -- EUR2EUR rate
        'EUR'
        ,'1900-01-01'
        ,1.0
),
ExchangeRateEuro AS (
    SELECT
            [SalesDocument]
        ,   [SalesDocumentItem]
        ,   EuroBudgetExchangeRate.[ExchangeRate] AS [ExchangeRate]
    FROM (
        SELECT
                [SalesDocument]
            ,   [SalesDocumentItem]
            ,   [TransactionCurrencyID]
            ,   MAX([ExchangeRateEffectiveDate]) as [ExchangeRateEffectiveDate]
        FROM             
            C_SalesDocumentItemDEXBase SDI 
        LEFT JOIN 
            EuroBudgetExchangeRate
            ON 
                SDI.[TransactionCurrencyID] = EuroBudgetExchangeRate.SourceCurrency
        --WHERE 
         -- [ExchangeRateEffectiveDate] <= [CreationDate]
        GROUP BY
                [SalesDocument]
            ,   [SalesDocumentItem]
            ,   [TransactionCurrencyID] 
    ) bdi_er_date_eur
    LEFT JOIN 
        EuroBudgetExchangeRate
        ON
            bdi_er_date_eur.[TransactionCurrencyID] = EuroBudgetExchangeRate.[SourceCurrency]
            AND
            bdi_er_date_eur.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRate.[ExchangeRateEffectiveDate]
),
SalesDocument_30 AS (
    SELECT
       ExchangeRateEuro.[SalesDocument]
      ,ExchangeRateEuro.[SalesDocumentItem]
      ,'EUR' AS [CurrencyID]
      ,ExchangeRateEuro.[ExchangeRate] as [ExchangeRate]
      ,[SDDocumentCategoryID]
      ,[SalesDocumentTypeID]
      ,[SalesDocumentItemCategoryID]
      ,[IsReturnsItemID]
      ,[CreationDate]
      ,[CreationTime]
      ,[LastChangeDate]
      ,[SalesOrganizationID]
      ,[DistributionChannelID]
      ,[DivisionID]
      ,[SalesGroupID]
      ,[SalesOfficeID]
      ,[InternationalArticleNumberID]
      ,[BatchID]
      ,[MaterialID]
      ,[ProductSurrogateKey]
      ,[OriginallyRequestedMaterialID]
      ,[MaterialSubstitutionReasonID]
      ,[MaterialGroupID]
      ,[BrandID]
      ,[Brand]
      ,[AdditionalMaterialGroup2ID]
      ,[AdditionalMaterialGroup3ID]
      ,[AdditionalMaterialGroup4ID]
      ,[AdditionalMaterialGroup5ID]
      ,[SoldToPartyID]
      ,[AdditionalCustomerGroup1ID]
      ,[AdditionalCustomerGroup2ID]
      ,[AdditionalCustomerGroup3ID]
      ,[AdditionalCustomerGroup4ID]
      ,[AdditionalCustomerGroup5ID]
      ,[ShipToPartyID]
      ,[PayerPartyID]
      ,[BillToPartyID]
      ,[SDDocumentReasonID]
      ,[SalesDocumentDate]
      ,[OrderQuantity]
      ,[OrderQuantityUnitID]
      ,[TargetQuantity]
      ,[TargetQuantityUnitID]
      ,[TargetToBaseQuantityDnmntr]
      ,[TargetToBaseQuantityNmrtr]
      ,[OrderToBaseQuantityDnmntr]
      ,[OrderToBaseQuantityNmrtr]
      ,[ConfdDelivQtyInOrderQtyUnit]
      ,[TargetDelivQtyInOrderQtyUnit]
      ,[ConfdDeliveryQtyInBaseUnit]
      ,[BaseUnitID]
      ,[ItemGrossWeight]
      ,[ItemNetWeight]
      ,[ItemWeightUnitID]
      ,[ItemVolume]
      ,[ItemVolumeUnitID]
      ,[ServicesRenderedDate]
      ,[SalesDistrictID]
      ,[CustomerGroupID]
      ,[HdrOrderProbabilityInPercentID]
      ,[ItemOrderProbabilityInPercentID]
      ,[SalesDocumentRjcnReasonID]
      ,[PricingDate]
      ,[ExchangeRateDate]
      ,[PriceDetnExchangeRate]
      ,[StatisticalValueControlID]
      ,CONVERT(decimal(19,6), [NetAmount] * ExchangeRateEuro.[ExchangeRate]) as [NetAmount]
      ,[TransactionCurrencyID]
      ,[SalesOrganizationCurrencyID]
      ,CONVERT(decimal(19,6), [NetPriceAmount] * ExchangeRateEuro.[ExchangeRate]) as [NetPriceAmount]
      ,[NetPriceQuantity]
      ,[NetPriceQuantityUnitID]
	  ,CONVERT(decimal(19,6), [TaxAmount] * ExchangeRateEuro.[ExchangeRate]) as [TaxAmount]
	  ,CONVERT(decimal(19,6), [CostAmount] * ExchangeRateEuro.[ExchangeRate]) as [CostAmount]
      ,CONVERT(decimal(19, 6), [Margin] * ExchangeRateEuro.[ExchangeRate])          as [Margin]
	  ,CONVERT(decimal(19,6), [Subtotal1Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal1Amount]
	  ,CONVERT(decimal(19,6), [Subtotal2Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal2Amount]
	  ,CONVERT(decimal(19,6), [Subtotal3Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal3Amount]
	  ,CONVERT(decimal(19,6), [Subtotal4Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal4Amount]
	  ,CONVERT(decimal(19,6), [Subtotal5Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal5Amount]
      ,CONVERT(decimal(19,6), [Subtotal6Amount] * ExchangeRateEuro.[ExchangeRate]) as [Subtotal6Amount]
      ,[ShippingPointID]
      ,[ShippingTypeID]
      ,[DeliveryPriorityID]
      ,[InventorySpecialStockTypeID]
      ,[RequestedDeliveryDate]
      ,[ShippingConditionID]
      ,[DeliveryBlockReasonID]
      ,[PlantID]
      ,[StorageLocationID]
      ,[RouteID]
      ,[IncotermsClassificationID]
      ,[IncotermsVersionID]
      ,[IncotermsTransferLocationID]
      ,[IncotermsLocation1ID]
      ,[IncotermsLocation2ID]
      ,[MinDeliveryQtyInBaseUnit]
      ,[UnlimitedOverdeliveryIsAllowedID]
      ,[OverdelivTolrtdLmtRatioInPct]
      ,[UnderdelivTolrtdLmtRatioInPct]
      ,[PartialDeliveryIsAllowedID]
      ,[BindingPeriodValidityStartDate]
      ,[BindingPeriodValidityEndDate]
      ,[OutlineAgreementTargetAmount]
      ,[BillingDocumentDate]
      ,[BillingCompanyCodeID]
      ,[HeaderBillingBlockReasonID]
      ,[ItemBillingBlockReasonID]
      ,[FiscalYearID]
      ,[FiscalPeriodID]
      ,[CustomerAccountAssignmentGroupID]
      ,[ExchangeRateTypeID]
      ,[CurrencyID] as [CompanyCodeCurrencyID]
      ,[FiscalYearVariantID]
      ,[BusinessAreaID]
      ,[ProfitCenterID]
      ,[OrderID]
      ,[ProfitabilitySegmentID]
      ,[ControllingAreaID]
      ,[ReferenceSDDocumentID]
      ,[ReferenceSDDocumentItemID]
      ,[ReferenceSDDocumentCategoryID]
      ,[OriginSDDocumentID]
      ,[OriginSDDocumentItemID]
      ,[OverallSDProcessStatusID]
      ,[OverallTotalDeliveryStatusID]
      ,[OverallOrdReltdBillgStatusID]
      ,[TotalCreditCheckStatusID]
      ,[DeliveryBlockStatusID]
      ,[BillingBlockStatusID]
      ,[TotalSDDocReferenceStatusID]
      ,[SDDocReferenceStatusID]
      ,[OverallSDDocumentRejectionStsID]
      ,[SDDocumentRejectionStatusID]
      ,[OverallTotalSDDocRefStatusID]
      ,[OverallSDDocReferenceStatusID]
      ,[ItemGeneralIncompletionStatusID]
      ,[ItemBillingIncompletionStatusID]
      ,[PricingIncompletionStatusID]
      ,[ItemDeliveryIncompletionStatusID]
      ,SDI.[SalesAgentID]
      ,SDI.[SalesAgent]
      ,[ExternalSalesAgentID]
      ,[ExternalSalesAgent]
      ,[GlobalParentID]
      ,[GlobalParent]
      ,[LocalParentID]
      ,[LocalParent]
      ,[ProjectID]
      ,[Project]
      ,[SalesEmployeeID]
      ,[SalesEmployee]
      ,[GlobalParentCalculatedID]
      ,[GlobalParentCalculated]
      ,[LocalParentCalculatedID]
      ,[LocalParentCalculated]
      ,[SDoc_ControllingObjectID]
      ,[SDItem_ControllingObjectID]
      ,[CorrespncExternalReference] 
      ,[InOutID]
      ,CONVERT(decimal(19,6), [OpenDeliveryNetAmount] * ExchangeRateEuro.[ExchangeRate]) as [OpenDeliveryNetAmount]
      ,[OrderType]
      ,[ItemOrderStatus]
      ,[OrderStatus]
      ,[ActualDeliveredQuantityInBaseUnit]
      ,[BillingQuantityInBaseUnit]
      ,[ActualDeliveredQuantityIBUOverall]
      ,[BillingQuantityIBUOverall]
      ,[ItemDeliveryStatus]    
      ,[OverallDeliveryStatus] 
      ,[ScheduleLineCategory]
      ,SDI.[t_applicationId]
      ,SDI.[t_jobId]
      ,SDI.[t_jobDtm]
      ,SDI.[t_jobBy]
      ,SDI.[t_extractionDtm]
      ,SDI.[t_filePath]    
    FROM 
        ExchangeRateEuro
    LEFT JOIN
        C_SalesDocumentItemDEXBase SDI
        ON
            SDI.SalesDocument = ExchangeRateEuro.SalesDocument
            AND
            SDI.SalesDocumentItem = ExchangeRateEuro.SalesDocumentItem
),
EuroBudgetExchangeRateUSD as (
    select
         TargetCurrency
        ,ExchangeRateEffectiveDate
        ,ExchangeRate
    from
        edw.dim_ExchangeRates
    where
        ExchangeRateType = 'P'
        and
        SourceCurrency = 'USD'
        and
        [ExchangeRateEffectiveDate] <= GETDATE()
),
ExchangeRateUSD as (
    SELECT
            [SalesDocument]
        ,   [SalesDocumentItem]
        ,   EuroBudgetExchangeRateUSD.[ExchangeRate] AS [ExchangeRate]
    FROM (
        SELECT 
                [SalesDocument]
            ,   [SalesDocumentItem]
            ,   [CurrencyID]
            ,   MAX([ExchangeRateEffectiveDate]) as [ExchangeRateEffectiveDate]
        FROM             
            SalesDocument_30 SD_30
        LEFT JOIN 
            EuroBudgetExchangeRateUSD
            ON 
                SD_30.CurrencyID = EuroBudgetExchangeRateUSD.TargetCurrency
        --WHERE 
         -- [ExchangeRateEffectiveDate] <= [CreationDate]
        GROUP BY
                [SalesDocument]
            ,   [SalesDocumentItem]
            ,   [CurrencyID]
    ) bdi_er_date_usd            
    LEFT JOIN 
        EuroBudgetExchangeRateUSD
        ON
            bdi_er_date_usd.[CurrencyID] = EuroBudgetExchangeRateUSD.[TargetCurrency]
            AND
            bdi_er_date_usd.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRateUSD.[ExchangeRateEffectiveDate]
     )



SELECT 
      -- [TS_SEQUENCE_NUMBER]
      --,[ODQ_CHANGEMODE]
      --,[ODQ_ENTITYCNTR]
       CONCAT_WS('¦', [SalesDocument] collate SQL_Latin1_General_CP1_CS_AS, [SalesDocumentItem] collate SQL_Latin1_General_CP1_CS_AS, CR.[CurrencyTypeID]) as [nk_fact_SalesDocumentItem]
      ,[SalesDocument]
      ,[SalesDocumentItem]
      ,CR.[CurrencyTypeID]
      ,CR.[CurrencyType]
      ,[TransactionCurrencyID] as [CurrencyID]
      ,1.0 as [ExchangeRate]
      ,[SDDocumentCategoryID]
      ,[SalesDocumentTypeID]
      ,[SalesDocumentItemCategoryID]
      ,[IsReturnsItemID]
      ,[CreationDate]
      ,[CreationTime]
      ,[LastChangeDate]
      ,[SalesOrganizationID]
      ,[DistributionChannelID]
      ,[DivisionID]
      ,[SalesGroupID]
      ,[SalesOfficeID]
      ,[InternationalArticleNumberID]
      ,[BatchID]
      ,[MaterialID]
      ,[ProductSurrogateKey]
      ,[OriginallyRequestedMaterialID]
      ,[MaterialSubstitutionReasonID]
      ,[MaterialGroupID]
      ,[BrandID]
      ,[Brand]
      ,[AdditionalMaterialGroup2ID]
      ,[AdditionalMaterialGroup3ID]
      ,[AdditionalMaterialGroup4ID]
      ,[AdditionalMaterialGroup5ID]
      ,[SoldToPartyID]
      ,[AdditionalCustomerGroup1ID]
      ,[AdditionalCustomerGroup2ID]
      ,[AdditionalCustomerGroup3ID]
      ,[AdditionalCustomerGroup4ID]
      ,[AdditionalCustomerGroup5ID]
      ,[ShipToPartyID]
      ,[PayerPartyID]
      ,[BillToPartyID]
      ,[SDDocumentReasonID]
      ,[SalesDocumentDate]
      ,[OrderQuantity]
      ,[OrderQuantityUnitID]
      ,[TargetQuantity]
      ,[TargetQuantityUnitID]
      ,[TargetToBaseQuantityDnmntr]
      ,[TargetToBaseQuantityNmrtr]
      ,[OrderToBaseQuantityDnmntr]
      ,[OrderToBaseQuantityNmrtr]
      ,[ConfdDelivQtyInOrderQtyUnit]
      ,[TargetDelivQtyInOrderQtyUnit]
      ,[ConfdDeliveryQtyInBaseUnit]
      ,[BaseUnitID]
      ,[ItemGrossWeight]
      ,[ItemNetWeight]
      ,[ItemWeightUnitID]
      ,[ItemVolume]
      ,[ItemVolumeUnitID]
      ,[ServicesRenderedDate]
      ,[SalesDistrictID]
      ,[CustomerGroupID]
      ,[HdrOrderProbabilityInPercentID]
      ,[ItemOrderProbabilityInPercentID]
      ,[SalesDocumentRjcnReasonID]
      ,[PricingDate]
      ,[ExchangeRateDate]
      ,[PriceDetnExchangeRate]
      ,[StatisticalValueControlID]
      ,[NetAmount]
      ,[TransactionCurrencyID]
      ,[SalesOrganizationCurrencyID]
      ,[NetPriceAmount]
      ,[NetPriceQuantity]
      ,[NetPriceQuantityUnitID]
      ,[TaxAmount]
      ,[CostAmount]
      ,[Margin]
      ,[Subtotal1Amount]
      ,[Subtotal2Amount]
      ,[Subtotal3Amount]
      ,[Subtotal4Amount]
      ,[Subtotal5Amount]
      ,[Subtotal6Amount]
      ,[ShippingPointID]
      ,[ShippingTypeID]
      ,[DeliveryPriorityID]
      ,[InventorySpecialStockTypeID]
      ,[RequestedDeliveryDate]
      ,[ShippingConditionID]
      ,[DeliveryBlockReasonID]
      ,[PlantID]
      ,[StorageLocationID]
      ,[RouteID]
      ,[IncotermsClassificationID]
      ,[IncotermsVersionID]
      ,[IncotermsTransferLocationID]
      ,[IncotermsLocation1ID]
      ,[IncotermsLocation2ID]
      ,[MinDeliveryQtyInBaseUnit]
      ,[UnlimitedOverdeliveryIsAllowedID]
      ,[OverdelivTolrtdLmtRatioInPct]
      ,[UnderdelivTolrtdLmtRatioInPct]
      ,[PartialDeliveryIsAllowedID]
      ,[BindingPeriodValidityStartDate]
      ,[BindingPeriodValidityEndDate]
      ,[OutlineAgreementTargetAmount]
      ,[BillingDocumentDate]
      ,[BillingCompanyCodeID]
      ,[HeaderBillingBlockReasonID]
      ,[ItemBillingBlockReasonID]
      ,[FiscalYearID]
      ,[FiscalPeriodID]
      ,[CustomerAccountAssignmentGroupID]
      ,[ExchangeRateTypeID]
      ,[CurrencyID] as [CompanyCodeCurrencyID]
      ,[FiscalYearVariantID]
      ,[BusinessAreaID]
      ,[ProfitCenterID]
      ,[OrderID]
      ,[ProfitabilitySegmentID]
      ,[ControllingAreaID]
      ,[ReferenceSDDocumentID]
      ,[ReferenceSDDocumentItemID]
      ,[ReferenceSDDocumentCategoryID]
      ,[OriginSDDocumentID]
      ,[OriginSDDocumentItemID]
      ,[OverallSDProcessStatusID]
      ,[OverallTotalDeliveryStatusID]
      ,[OverallOrdReltdBillgStatusID]
      ,[TotalCreditCheckStatusID]
      ,[DeliveryBlockStatusID]
      ,[BillingBlockStatusID]
      ,[TotalSDDocReferenceStatusID]
      ,[SDDocReferenceStatusID]
      ,[OverallSDDocumentRejectionStsID]
      ,[SDDocumentRejectionStatusID]
      ,[OverallTotalSDDocRefStatusID]
      ,[OverallSDDocReferenceStatusID]
      ,[ItemGeneralIncompletionStatusID]
      ,[ItemBillingIncompletionStatusID]
      ,[PricingIncompletionStatusID]
      ,[ItemDeliveryIncompletionStatusID]
      ,[SalesAgentID]
      ,[SalesAgent]
      ,SDI.[ExternalSalesAgentID]
      ,[ExternalSalesAgent]
      ,[GlobalParentID]
      ,[GlobalParent]
      ,[LocalParentID]
      ,[LocalParent]
      ,[ProjectID]
      ,[Project]
      ,[SalesEmployeeID]
      ,[SalesEmployee]
      ,[GlobalParentCalculatedID]
      ,[GlobalParentCalculated]
      ,[LocalParentCalculatedID]
      ,[LocalParentCalculated]
      ,[SDoc_ControllingObjectID]
      ,[SDItem_ControllingObjectID]
      ,[CorrespncExternalReference] 
      ,[InOutID]
      ,OpenDeliveryNetAmount
      ,[OrderType]
      ,[ItemOrderStatus]
      ,[OrderStatus]
      ,[ActualDeliveredQuantityInBaseUnit]
      ,[BillingQuantityInBaseUnit]
      ,[ActualDeliveredQuantityIBUOverall]
      ,[BillingQuantityIBUOverall]
      ,[ItemDeliveryStatus]    
      ,[OverallDeliveryStatus]
      ,[ScheduleLineCategory] 
      ,SDI.[t_applicationId]
      ,SDI.[t_jobId]
      ,SDI.[t_jobDtm]
      ,SDI.[t_jobBy]
      ,SDI.[t_extractionDtm]
      ,SDI.[t_filePath]
  FROM [C_SalesDocumentItemDEXBase] SDI
 CROSS JOIN [edw].[dim_CurrencyType] CR
 WHERE CR.[CurrencyTypeID] = '00'
  UNION ALL
SELECT 
      -- [TS_SEQUENCE_NUMBER]
      --,[ODQ_CHANGEMODE]
      --,[ODQ_ENTITYCNTR]
       CONCAT_WS('¦', [SalesDocument] collate SQL_Latin1_General_CP1_CS_AS, [SalesDocumentItem] collate SQL_Latin1_General_CP1_CS_AS, CR.[CurrencyTypeID]) as [nk_fact_SalesDocumentItem]
      ,[SalesDocument]
      ,[SalesDocumentItem]
	  ,CR.[CurrencyTypeID]
      ,CR.[CurrencyType]
      ,[CurrencyID]
      ,(CASE
			 WHEN ER.[ExchangeRate] IS NOT NULL
			 THEN ER.[ExchangeRate]
			 ELSE 1
			 END) as [ExchangeRate]
      ,[SDDocumentCategoryID]
      ,[SalesDocumentTypeID]
      ,[SalesDocumentItemCategoryID]
      ,[IsReturnsItemID]
      ,[CreationDate]
      ,[CreationTime]
      ,[LastChangeDate]
      ,[SalesOrganizationID]
      ,[DistributionChannelID]
      ,[DivisionID]
      ,[SalesGroupID]
      ,[SalesOfficeID]
      ,[InternationalArticleNumberID]
      ,[BatchID]
      ,[MaterialID]
      ,[ProductSurrogateKey]
      ,[OriginallyRequestedMaterialID]
      ,[MaterialSubstitutionReasonID]
      ,[MaterialGroupID]
      ,[BrandID]
      ,[Brand]
      ,[AdditionalMaterialGroup2ID]
      ,[AdditionalMaterialGroup3ID]
      ,[AdditionalMaterialGroup4ID]
      ,[AdditionalMaterialGroup5ID]
      ,[SoldToPartyID]
      ,[AdditionalCustomerGroup1ID]
      ,[AdditionalCustomerGroup2ID]
      ,[AdditionalCustomerGroup3ID]
      ,[AdditionalCustomerGroup4ID]
      ,[AdditionalCustomerGroup5ID]
      ,[ShipToPartyID]
      ,[PayerPartyID]
      ,[BillToPartyID]
      ,[SDDocumentReasonID]
      ,[SalesDocumentDate]
      ,[OrderQuantity]
      ,[OrderQuantityUnitID]
      ,[TargetQuantity]
      ,[TargetQuantityUnitID]
      ,[TargetToBaseQuantityDnmntr]
      ,[TargetToBaseQuantityNmrtr]
      ,[OrderToBaseQuantityDnmntr]
      ,[OrderToBaseQuantityNmrtr]
      ,[ConfdDelivQtyInOrderQtyUnit]
      ,[TargetDelivQtyInOrderQtyUnit]
      ,[ConfdDeliveryQtyInBaseUnit]
      ,[BaseUnitID]
      ,[ItemGrossWeight]
      ,[ItemNetWeight]
      ,[ItemWeightUnitID]
      ,[ItemVolume]
      ,[ItemVolumeUnitID]
      ,[ServicesRenderedDate]
      ,[SalesDistrictID]
      ,[CustomerGroupID]
      ,[HdrOrderProbabilityInPercentID]
      ,[ItemOrderProbabilityInPercentID]
      ,[SalesDocumentRjcnReasonID]
      ,[PricingDate]
      ,[ExchangeRateDate]
      ,[PriceDetnExchangeRate]
      ,[StatisticalValueControlID]
      ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [NetAmount] * ER.[ExchangeRate] ELSE [NetAmount] END) as [NetAmount]
      ,[TransactionCurrencyID]
      ,[SalesOrganizationCurrencyID]
	  ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [NetPriceAmount] * ER.[ExchangeRate] ELSE [NetPriceAmount] END) as [NetPriceAmount]
      ,[NetPriceQuantity]
      ,[NetPriceQuantityUnitID]
	  ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [TaxAmount] * ER.[ExchangeRate] ELSE [TaxAmount] END) as [TaxAmount]
	  ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [CostAmount] * ER.[ExchangeRate] ELSE [CostAmount] END) as [CostAmount]
	  ,CONVERT(decimal(19, 6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [Margin] * ER.[ExchangeRate] ELSE [Margin] END)
	  ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [Subtotal1Amount] * ER.[ExchangeRate] ELSE [Subtotal1Amount] END) as [Subtotal1Amount]
	  ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [Subtotal2Amount] * ER.[ExchangeRate] ELSE [Subtotal2Amount] END) as [Subtotal2Amount]
	  ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [Subtotal3Amount] * ER.[ExchangeRate] ELSE [Subtotal3Amount] END) as [Subtotal3Amount]
	  ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [Subtotal4Amount] * ER.[ExchangeRate] ELSE [Subtotal4Amount] END) as [Subtotal4Amount]
	  ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [Subtotal5Amount] * ER.[ExchangeRate] ELSE [Subtotal5Amount] END) as [Subtotal5Amount]
	  ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [Subtotal6Amount] * ER.[ExchangeRate] ELSE [Subtotal6Amount] END) as [Subtotal6Amount]
      ,[ShippingPointID]
      ,[ShippingTypeID]
      ,[DeliveryPriorityID]
      ,[InventorySpecialStockTypeID]
      ,[RequestedDeliveryDate]
      ,[ShippingConditionID]
      ,[DeliveryBlockReasonID]
      ,[PlantID]
      ,[StorageLocationID]
      ,[RouteID]
      ,[IncotermsClassificationID]
      ,[IncotermsVersionID]
      ,[IncotermsTransferLocationID]
      ,[IncotermsLocation1ID]
      ,[IncotermsLocation2ID]
      ,[MinDeliveryQtyInBaseUnit]
      ,[UnlimitedOverdeliveryIsAllowedID]
      ,[OverdelivTolrtdLmtRatioInPct]
      ,[UnderdelivTolrtdLmtRatioInPct]
      ,[PartialDeliveryIsAllowedID]
      ,[BindingPeriodValidityStartDate]
      ,[BindingPeriodValidityEndDate]
      ,[OutlineAgreementTargetAmount]
      ,[BillingDocumentDate]
      ,[BillingCompanyCodeID]
      ,[HeaderBillingBlockReasonID]
      ,[ItemBillingBlockReasonID]
      ,[FiscalYearID]
      ,[FiscalPeriodID]
      ,[CustomerAccountAssignmentGroupID]
      ,[ExchangeRateTypeID]
      ,[CurrencyID] as [CompanyCodeCurrencyID]
      ,[FiscalYearVariantID]
      ,[BusinessAreaID]
      ,[ProfitCenterID]
      ,[OrderID]
      ,[ProfitabilitySegmentID]
      ,[ControllingAreaID]
      ,[ReferenceSDDocumentID]
      ,[ReferenceSDDocumentItemID]
      ,[ReferenceSDDocumentCategoryID]
      ,[OriginSDDocumentID]
      ,[OriginSDDocumentItemID]
      ,[OverallSDProcessStatusID]
      ,[OverallTotalDeliveryStatusID]
      ,[OverallOrdReltdBillgStatusID]
      ,[TotalCreditCheckStatusID]
      ,[DeliveryBlockStatusID]
      ,[BillingBlockStatusID]
      ,[TotalSDDocReferenceStatusID]
      ,[SDDocReferenceStatusID]
      ,[OverallSDDocumentRejectionStsID]
      ,[SDDocumentRejectionStatusID]
      ,[OverallTotalSDDocRefStatusID]
      ,[OverallSDDocReferenceStatusID]
      ,[ItemGeneralIncompletionStatusID]
      ,[ItemBillingIncompletionStatusID]
      ,[PricingIncompletionStatusID]
      ,[ItemDeliveryIncompletionStatusID]
      ,[SalesAgentID]
      ,[SalesAgent]
      ,[ExternalSalesAgentID]
      ,[ExternalSalesAgent]
      ,[GlobalParentID]
      ,[GlobalParent]
      ,[LocalParentID]
      ,[LocalParent]
      ,[ProjectID]
      ,[Project]
      ,[SalesEmployeeID]
      ,[SalesEmployee]
      ,[GlobalParentCalculatedID]
      ,[GlobalParentCalculated]
      ,[LocalParentCalculatedID]
      ,[LocalParentCalculated]
      ,[SDoc_ControllingObjectID]
      ,[SDItem_ControllingObjectID]
      ,[CorrespncExternalReference] 
      ,[InOutID]
      ,CONVERT(decimal(19,6), CASE WHEN ER.[ExchangeRate] IS NOT NULL THEN [OpenDeliveryNetAmount] * ER.[ExchangeRate] ELSE [OpenDeliveryNetAmount] END) as [OpenDeliveryNetAmount]
      ,[OrderType]
      ,[ItemOrderStatus]
      ,[OrderStatus]
      ,[ActualDeliveredQuantityInBaseUnit]
      ,[BillingQuantityInBaseUnit]
      ,[ActualDeliveredQuantityIBUOverall]
      ,[BillingQuantityIBUOverall]
      ,[ItemDeliveryStatus]    
      ,[OverallDeliveryStatus]
      ,[ScheduleLineCategory] 
      ,SDI.[t_applicationId]
      ,SDI.[t_jobId]
      ,SDI.[t_jobDtm]
      ,SDI.[t_jobBy]
      ,SDI.[t_extractionDtm]
      ,SDI.[t_filePath]
  FROM
    [C_SalesDocumentItemDEXBase] SDI
  LEFT JOIN
    [edw].[dim_ExchangeRates] ER
    ON 
        ER.[ExchangeRateEffectiveDate] =
	    (SELECT 
            TOP(1) [edw].[dim_ExchangeRates].[ExchangeRateEffectiveDate]
		FROM 
            [edw].[dim_ExchangeRates]
		WHERE
            [edw].[dim_ExchangeRates].[ExchangeRateEffectiveDate] <= SDI.[CreationDate]
		    AND
            [ExchangeRateType] = 'M'
            AND
            [SourceCurrency] = SDI.[TransactionCurrencyID]
		ORDER BY
            [ExchangeRateEffectiveDate] DESC)
        AND 
        SDI.[TransactionCurrencyID] = ER.[SourceCurrency]
        AND
        SDI.[CurrencyID] = ER.[TargetCurrency]
        AND
        ER.[ExchangeRateType] = 'M'
 CROSS JOIN
    [edw].[dim_CurrencyType] CR
 WHERE
    CR.[CurrencyTypeID] = '10'

UNION ALL

SELECT 
      -- [TS_SEQUENCE_NUMBER]
      --,[ODQ_CHANGEMODE]
      --,[ODQ_ENTITYCNTR]
       CONCAT_WS('¦', [SalesDocument] collate SQL_Latin1_General_CP1_CS_AS, [SalesDocumentItem] collate SQL_Latin1_General_CP1_CS_AS, CR.[CurrencyTypeID]) as [nk_fact_SalesDocumentItem]
      ,[SalesDocument]
      ,[SalesDocumentItem]
	  ,CR.[CurrencyTypeID]
      ,CR.[CurrencyType]
      ,[CurrencyID]
      ,[ExchangeRate]
      ,[SDDocumentCategoryID]
      ,[SalesDocumentTypeID]
      ,[SalesDocumentItemCategoryID]
      ,[IsReturnsItemID]
      ,[CreationDate]
      ,[CreationTime]
      ,[LastChangeDate]
      ,[SalesOrganizationID]
      ,[DistributionChannelID]
      ,[DivisionID]
      ,[SalesGroupID]
      ,[SalesOfficeID]
      ,[InternationalArticleNumberID]
      ,[BatchID]
      ,[MaterialID]
      ,[ProductSurrogateKey]
      ,[OriginallyRequestedMaterialID]
      ,[MaterialSubstitutionReasonID]
      ,[MaterialGroupID]
      ,[BrandID]
      ,[Brand]
      ,[AdditionalMaterialGroup2ID]
      ,[AdditionalMaterialGroup3ID]
      ,[AdditionalMaterialGroup4ID]
      ,[AdditionalMaterialGroup5ID]
      ,[SoldToPartyID]
      ,[AdditionalCustomerGroup1ID]
      ,[AdditionalCustomerGroup2ID]
      ,[AdditionalCustomerGroup3ID]
      ,[AdditionalCustomerGroup4ID]
      ,[AdditionalCustomerGroup5ID]
      ,[ShipToPartyID]
      ,[PayerPartyID]
      ,[BillToPartyID]
      ,[SDDocumentReasonID]
      ,[SalesDocumentDate]
      ,[OrderQuantity]
      ,[OrderQuantityUnitID]
      ,[TargetQuantity]
      ,[TargetQuantityUnitID]
      ,[TargetToBaseQuantityDnmntr]
      ,[TargetToBaseQuantityNmrtr]
      ,[OrderToBaseQuantityDnmntr]
      ,[OrderToBaseQuantityNmrtr]
      ,[ConfdDelivQtyInOrderQtyUnit]
      ,[TargetDelivQtyInOrderQtyUnit]
      ,[ConfdDeliveryQtyInBaseUnit]
      ,[BaseUnitID]
      ,[ItemGrossWeight]
      ,[ItemNetWeight]
      ,[ItemWeightUnitID]
      ,[ItemVolume]
      ,[ItemVolumeUnitID]
      ,[ServicesRenderedDate]
      ,[SalesDistrictID]
      ,[CustomerGroupID]
      ,[HdrOrderProbabilityInPercentID]
      ,[ItemOrderProbabilityInPercentID]
      ,[SalesDocumentRjcnReasonID]
      ,[PricingDate]
      ,[ExchangeRateDate]
      ,[PriceDetnExchangeRate]
      ,[StatisticalValueControlID]
      ,[NetAmount]
      ,[TransactionCurrencyID]
      ,[SalesOrganizationCurrencyID]
      ,[NetPriceAmount]
      ,[NetPriceQuantity]
      ,[NetPriceQuantityUnitID]
	  ,[TaxAmount]
	  ,[CostAmount]
      ,[Margin]
	  ,[Subtotal1Amount]
	  ,[Subtotal2Amount]
	  ,[Subtotal3Amount]
	  ,[Subtotal4Amount]
	  ,[Subtotal5Amount]
      ,[Subtotal6Amount]
      ,[ShippingPointID]
      ,[ShippingTypeID]
      ,[DeliveryPriorityID]
      ,[InventorySpecialStockTypeID]
      ,[RequestedDeliveryDate]
      ,[ShippingConditionID]
      ,[DeliveryBlockReasonID]
      ,[PlantID]
      ,[StorageLocationID]
      ,[RouteID]
      ,[IncotermsClassificationID]
      ,[IncotermsVersionID]
      ,[IncotermsTransferLocationID]
      ,[IncotermsLocation1ID]
      ,[IncotermsLocation2ID]
      ,[MinDeliveryQtyInBaseUnit]
      ,[UnlimitedOverdeliveryIsAllowedID]
      ,[OverdelivTolrtdLmtRatioInPct]
      ,[UnderdelivTolrtdLmtRatioInPct]
      ,[PartialDeliveryIsAllowedID]
      ,[BindingPeriodValidityStartDate]
      ,[BindingPeriodValidityEndDate]
      ,[OutlineAgreementTargetAmount]
      ,[BillingDocumentDate]
      ,[BillingCompanyCodeID]
      ,[HeaderBillingBlockReasonID]
      ,[ItemBillingBlockReasonID]
      ,[FiscalYearID]
      ,[FiscalPeriodID]
      ,[CustomerAccountAssignmentGroupID]
      ,[ExchangeRateTypeID]
      ,[CurrencyID] as [CompanyCodeCurrencyID]
      ,[FiscalYearVariantID]
      ,[BusinessAreaID]
      ,[ProfitCenterID]
      ,[OrderID]
      ,[ProfitabilitySegmentID]
      ,[ControllingAreaID]
      ,[ReferenceSDDocumentID]
      ,[ReferenceSDDocumentItemID]
      ,[ReferenceSDDocumentCategoryID]
      ,[OriginSDDocumentID]
      ,[OriginSDDocumentItemID]
      ,[OverallSDProcessStatusID]
      ,[OverallTotalDeliveryStatusID]
      ,[OverallOrdReltdBillgStatusID]
      ,[TotalCreditCheckStatusID]
      ,[DeliveryBlockStatusID]
      ,[BillingBlockStatusID]
      ,[TotalSDDocReferenceStatusID]
      ,[SDDocReferenceStatusID]
      ,[OverallSDDocumentRejectionStsID]
      ,[SDDocumentRejectionStatusID]
      ,[OverallTotalSDDocRefStatusID]
      ,[OverallSDDocReferenceStatusID]
      ,[ItemGeneralIncompletionStatusID]
      ,[ItemBillingIncompletionStatusID]
      ,[PricingIncompletionStatusID]
      ,[ItemDeliveryIncompletionStatusID]
      ,[SalesAgentID]
      ,[SalesAgent]
      ,[ExternalSalesAgentID]
      ,[ExternalSalesAgent]
      ,[GlobalParentID]
      ,[GlobalParent]
      ,[LocalParentID]
      ,[LocalParent]
      ,[ProjectID]
      ,[Project]
      ,[SalesEmployeeID]
      ,[SalesEmployee]
      ,[GlobalParentCalculatedID]
      ,[GlobalParentCalculated]
      ,[LocalParentCalculatedID]
      ,[LocalParentCalculated]
      ,[SDoc_ControllingObjectID]
      ,[SDItem_ControllingObjectID]
      ,[CorrespncExternalReference] 
      ,[InOutID]
      ,OpenDeliveryNetAmount
      ,[OrderType]
      ,[ItemOrderStatus]
      ,[OrderStatus]
      ,[ActualDeliveredQuantityInBaseUnit]
      ,[BillingQuantityInBaseUnit]
      ,[ActualDeliveredQuantityIBUOverall]
      ,[BillingQuantityIBUOverall]
      ,[ItemDeliveryStatus]    
      ,[OverallDeliveryStatus] 
      ,[ScheduleLineCategory]
      ,SD_30.[t_applicationId]
      ,SD_30.[t_jobId]
      ,SD_30.[t_jobDtm]
      ,SD_30.[t_jobBy]
      ,SD_30.[t_extractionDtm]
      ,SD_30.[t_filePath]
FROM 
    SalesDocument_30 SD_30
CROSS JOIN
    [edw].[dim_CurrencyType] CR
WHERE
    CR.[CurrencyTypeID] = '30'
UNION ALL

SELECT 
      -- [TS_SEQUENCE_NUMBER]
      --,[ODQ_CHANGEMODE]
      --,[ODQ_ENTITYCNTR]
       CONCAT_WS('¦', ExchangeRateUSD.[SalesDocument] collate SQL_Latin1_General_CP1_CS_AS, ExchangeRateUSD.[SalesDocumentItem] collate SQL_Latin1_General_CP1_CS_AS, CR.[CurrencyTypeID]) as [nk_fact_SalesDocumentItem]
      ,ExchangeRateUSD.[SalesDocument]
      ,ExchangeRateUSD.[SalesDocumentItem]
	  ,CR.[CurrencyTypeID]
      ,CR.[CurrencyType]
      ,'USD' AS [CurrencyID]
      ,1/ExchangeRateUSD.[ExchangeRate] AS [ExchangeRate]
      ,[SDDocumentCategoryID]
      ,[SalesDocumentTypeID]
      ,[SalesDocumentItemCategoryID]
      ,[IsReturnsItemID]
      ,[CreationDate]
      ,[CreationTime]
      ,[LastChangeDate]
      ,[SalesOrganizationID]
      ,[DistributionChannelID]
      ,[DivisionID]
      ,[SalesGroupID]
      ,[SalesOfficeID]
      ,[InternationalArticleNumberID]
      ,[BatchID]
      ,[MaterialID]
      ,[ProductSurrogateKey]
      ,[OriginallyRequestedMaterialID]
      ,[MaterialSubstitutionReasonID]
      ,[MaterialGroupID]
      ,[BrandID]
      ,[Brand]
      ,[AdditionalMaterialGroup2ID]
      ,[AdditionalMaterialGroup3ID]
      ,[AdditionalMaterialGroup4ID]
      ,[AdditionalMaterialGroup5ID]
      ,[SoldToPartyID]
      ,[AdditionalCustomerGroup1ID]
      ,[AdditionalCustomerGroup2ID]
      ,[AdditionalCustomerGroup3ID]
      ,[AdditionalCustomerGroup4ID]
      ,[AdditionalCustomerGroup5ID]
      ,[ShipToPartyID]
      ,[PayerPartyID]
      ,[BillToPartyID]
      ,[SDDocumentReasonID]
      ,[SalesDocumentDate]
      ,[OrderQuantity]
      ,[OrderQuantityUnitID]
      ,[TargetQuantity]
      ,[TargetQuantityUnitID]
      ,[TargetToBaseQuantityDnmntr]
      ,[TargetToBaseQuantityNmrtr]
      ,[OrderToBaseQuantityDnmntr]
      ,[OrderToBaseQuantityNmrtr]
      ,[ConfdDelivQtyInOrderQtyUnit]
      ,[TargetDelivQtyInOrderQtyUnit]
      ,[ConfdDeliveryQtyInBaseUnit]
      ,[BaseUnitID]
      ,[ItemGrossWeight]
      ,[ItemNetWeight]
      ,[ItemWeightUnitID]
      ,[ItemVolume]
      ,[ItemVolumeUnitID]
      ,[ServicesRenderedDate]
      ,[SalesDistrictID]
      ,[CustomerGroupID]
      ,[HdrOrderProbabilityInPercentID]
      ,[ItemOrderProbabilityInPercentID]
      ,[SalesDocumentRjcnReasonID]
      ,[PricingDate]
      ,[ExchangeRateDate]
      ,[PriceDetnExchangeRate]
      ,[StatisticalValueControlID]
      ,CONVERT(decimal(19,6), [NetAmount] * (1/ExchangeRateUSD.[ExchangeRate])) as [NetAmount]
      ,[TransactionCurrencyID]
      ,[SalesOrganizationCurrencyID]
      ,CONVERT(decimal(19,6), [NetPriceAmount] * (1/ExchangeRateUSD.[ExchangeRate])) as [NetPriceAmount]
      ,[NetPriceQuantity]
      ,[NetPriceQuantityUnitID]
	  ,CONVERT(decimal(19,6), [TaxAmount] * (1/ExchangeRateUSD.[ExchangeRate])) as [TaxAmount]
	  ,CONVERT(decimal(19,6), [CostAmount] * (1/ExchangeRateUSD.[ExchangeRate])) as [CostAmount]
      ,CONVERT(decimal(19, 6), [Margin] * (1/ExchangeRateUSD.[ExchangeRate]))          as [Margin]
	  ,CONVERT(decimal(19,6), [Subtotal1Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal1Amount]
	  ,CONVERT(decimal(19,6), [Subtotal2Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal2Amount]
	  ,CONVERT(decimal(19,6), [Subtotal3Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal3Amount]
	  ,CONVERT(decimal(19,6), [Subtotal4Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal4Amount]
	  ,CONVERT(decimal(19,6), [Subtotal5Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal5Amount]
      ,CONVERT(decimal(19,6), [Subtotal6Amount] * (1/ExchangeRateUSD.[ExchangeRate])) as [Subtotal6Amount]
      ,[ShippingPointID]
      ,[ShippingTypeID]
      ,[DeliveryPriorityID]
      ,[InventorySpecialStockTypeID]
      ,[RequestedDeliveryDate]
      ,[ShippingConditionID]
      ,[DeliveryBlockReasonID]
      ,[PlantID]
      ,[StorageLocationID]
      ,[RouteID]
      ,[IncotermsClassificationID]
      ,[IncotermsVersionID]
      ,[IncotermsTransferLocationID]
      ,[IncotermsLocation1ID]
      ,[IncotermsLocation2ID]
      ,[MinDeliveryQtyInBaseUnit]
      ,[UnlimitedOverdeliveryIsAllowedID]
      ,[OverdelivTolrtdLmtRatioInPct]
      ,[UnderdelivTolrtdLmtRatioInPct]
      ,[PartialDeliveryIsAllowedID]
      ,[BindingPeriodValidityStartDate]
      ,[BindingPeriodValidityEndDate]
      ,[OutlineAgreementTargetAmount]
      ,[BillingDocumentDate]
      ,[BillingCompanyCodeID]
      ,[HeaderBillingBlockReasonID]
      ,[ItemBillingBlockReasonID]
      ,[FiscalYearID]
      ,[FiscalPeriodID]
      ,[CustomerAccountAssignmentGroupID]
      ,[ExchangeRateTypeID]
      ,[CurrencyID] as [CompanyCodeCurrencyID]
      ,[FiscalYearVariantID]
      ,[BusinessAreaID]
      ,[ProfitCenterID]
      ,[OrderID]
      ,[ProfitabilitySegmentID]
      ,[ControllingAreaID]
      ,[ReferenceSDDocumentID]
      ,[ReferenceSDDocumentItemID]
      ,[ReferenceSDDocumentCategoryID]
      ,[OriginSDDocumentID]
      ,[OriginSDDocumentItemID]
      ,[OverallSDProcessStatusID]
      ,[OverallTotalDeliveryStatusID]
      ,[OverallOrdReltdBillgStatusID]
      ,[TotalCreditCheckStatusID]
      ,[DeliveryBlockStatusID]
      ,[BillingBlockStatusID]
      ,[TotalSDDocReferenceStatusID]
      ,[SDDocReferenceStatusID]
      ,[OverallSDDocumentRejectionStsID]
      ,[SDDocumentRejectionStatusID]
      ,[OverallTotalSDDocRefStatusID]
      ,[OverallSDDocReferenceStatusID]
      ,[ItemGeneralIncompletionStatusID]
      ,[ItemBillingIncompletionStatusID]
      ,[PricingIncompletionStatusID]
      ,[ItemDeliveryIncompletionStatusID]
      ,[SalesAgentID]
      ,[SalesAgent]
      ,[ExternalSalesAgentID]
      ,[ExternalSalesAgent]
      ,[GlobalParentID]
      ,[GlobalParent]
      ,[LocalParentID]
      ,[LocalParent]
      ,[ProjectID]
      ,[Project]
      ,[SalesEmployeeID]
      ,[SalesEmployee]
      ,[GlobalParentCalculatedID]
      ,[GlobalParentCalculated]
      ,[LocalParentCalculatedID]
      ,[LocalParentCalculated]
      ,[SDoc_ControllingObjectID]
      ,[SDItem_ControllingObjectID]
      ,[CorrespncExternalReference] 
      ,[InOutID]
      ,CONVERT(decimal(19,6), [OpenDeliveryNetAmount] * (1/ExchangeRateUSD.[ExchangeRate])) as [OpenDeliveryNetAmount]
      ,[OrderType]
      ,[ItemOrderStatus]
      ,[OrderStatus]
      ,[ActualDeliveredQuantityInBaseUnit]
      ,[BillingQuantityInBaseUnit]
      ,[ActualDeliveredQuantityIBUOverall]
      ,[BillingQuantityIBUOverall]
      ,[ItemDeliveryStatus]    
      ,[OverallDeliveryStatus]
      ,[ScheduleLineCategory]
      ,SD_30.[t_applicationId]
      ,SD_30.[t_jobId]
      ,SD_30.[t_jobDtm]
      ,SD_30.[t_jobBy]
      ,SD_30.[t_extractionDtm]
      ,SD_30.[t_filePath]
FROM 
    ExchangeRateUSD
left join
    SalesDocument_30 SD_30
    ON
        SD_30.[SalesDocument] = ExchangeRateUSD.[SalesDocument]
        AND
        SD_30.[SalesDocumentItem] = ExchangeRateUSD.[SalesDocumentItem]
CROSS JOIN
    [edw].[dim_CurrencyType] CR
WHERE
    CR.[CurrencyTypeID] = '40'