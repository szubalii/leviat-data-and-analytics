CREATE VIEW [dm_sales].[vw_fact_SalesQuotationItem] AS

WITH
PrcgElmnt AS (
    SELECT
        [SalesQuotation]
        ,[SalesQuotationItem]
        ,[CurrencyTypeID]
        ,MAX([ZC10])    AS [ZC10]
        ,MAX([ZCF1])    AS [ZCF1]
        ,MAX([VPRS])    AS [VPRS]
        ,MAX([EK02])    AS [EK02]
    FROM [edw].[fact_SalesQuotationItemPrcgElmnt]
    PIVOT  
    (  
        SUM(ConditionAmount)  
        FOR [ConditionType] IN ([ZC10], [ZCF1], [VPRS], [EK02])  
    ) AS PivotTable
    GROUP BY
        [SalesQuotation]
        ,[SalesQuotationItem]
        ,[CurrencyTypeID]
)
select doc.[SalesDocument]           as [QuotationID]
     , doc.[SalesDocumentItem]       as [QuotationItemID]
     , doc.[CurrencyTypeID]
     , doc.[CurrencyType]
     , doc.[sk_fact_SalesDocumentItem] as sk_fact_SalesQuotationItem
     , dimSDDC.[SDDocumentCategoryID]
     , dimSDDC.[SDDocumentCategory]
     , dimSDT.[SalesDocumentTypeID]
     , dimSDT.[SalesDocumentType]
     , dimSDIC.[SalesDocumentItemCategoryID]
     , dimSDIC.[SalesDocumentItemCategory]
     , doc.[IsReturnsItemID]
     , doc.[CreationDate]
     , doc.[CreationTime]
     , doc.[LastChangeDate]
     , doc.[SalesOrganizationID]  
     , dimDCh.[DistributionChannelID]
     , dimDCh.[DistributionChannel]
     , doc.[MaterialID]
     , doc.[ProductSurrogateKey]
     , doc.[OriginallyRequestedMaterialID]
     , doc.[MaterialSubstitutionReasonID]
     , doc.[MaterialGroupID]
     , doc.[BrandID]
     , doc.[Brand]
     , doc.[SoldToPartyID]
     , doc.[ShipToPartyID]
     , doc.[PayerPartyID]
     , doc.[BillToPartyID]
     , dimSDR.[SDDocumentReasonID]
     , dimSDR.[SDDocumentReason]
     , doc.[SalesDocumentDate]
     , doc.[OrderQuantity]
     , dimUOM.[UnitOfMeasureID]      as [OrderQuantityUnitID]
     , dimUOM.[UnitOfMeasure]        as [OrderQuantityUnit]
     , doc.[TargetQuantity]
     , doc.[TargetQuantityUnitID]
     --, doc.[ConfdDelivyInOrderyUnitID]
     --, doc.[TargetDelivyInOrderyUnitID]
     --, doc.[ConfdDeliveryInBaseUnitID]
     , doc.[SalesDistrictID]
     , dimCGr.[CustomerGroupID]
     , dimCGr.[CustomerGroup]
     , dimSDRR.[SalesDocumentRjcnReasonID]
     , dimSDRR.[SalesDocumentRjcnReason]
     , doc.[PricingDate]
     , doc.[ExchangeRateDate]
     , doc.[NetAmount]
     , doc.[TransactionCurrencyID]
     , doc.[RequestedDeliveryDate]
     , doc.[PlantID]
     , doc.[StorageLocationID]
     --, doc.[MinDeliveryInBaseUnitID]
     --, doc.[BindingPeriodValityStartDate]
     --, doc.[BindingPeriodValityEndDate]
     , doc.[BillingDocumentDate]
     , doc.[BillingCompanyCodeID]
     , doc.[ProfitCenterID]
     , doc.[ReferenceSDDocumentID]
     , doc.[ReferenceSDDocumentItemID]
     , dimRSDDC.SDDocumentCategoryID as [ReferenceSDDocumentCategoryID]
     , dimRSDDC.SDDocumentCategory   as [ReferenceSDDocumentCategory]
     , doc.[OriginSDDocumentID]
     , doc.[OriginSDDocumentItemID]
     , dimOSS.[OverallSDProcessStatusID]
     , dimOSS.[OverallSDProcessStatus]
     , dimOTDS.[OverallTotalDeliveryStatusID]
     , dimOTDS.[OverallTotalDeliveryStatus] as [OverallTotalDeliveryStatus]
     , doc.[OverallOrdReltdBillgStatusID]
     , dimTCCS.[TotalCreditCheckStatusID]
     , dimTCCS.[TotalCreditCheckStatus]
     , dimDBS.[DeliveryBlockStatusID]
     , dimDBS.[DeliveryBlockStatus]
     , dimBBS.[BillingBlockStatusID]
     , dimBBS.[BillingBlockStatus]
     , dimTSDDRS.[TotalSDDocReferenceStatusID]
     , dimTSDDRS.[TotalSDDocReferenceStatus]     as [TotalSDDocReferenceStatus]
     , dimSDDRS.[SDDocReferenceStatusID]
     , dimSDDRS.[SDDocReferenceStatus]
     , dimOSDDRS.[OverallSDDocumentRjcnStatusID]
     , dimOSDDRS.[OverallSDDocumentRjcnStatus] as [OverallSDDocumentRejectionSts]
     , dimSDDRjS.[SDDocumentRejectionStatusID]
     , dimSDDRjS.[SDDocumentRejectionStatus]     as [SDDocumentRejectionStatus]
     , dimOTSDDRS.[OverallTotalSDDocRefStatusID]
     , dimOTSDDRS.[OverallTotalSDDocRefStatus]   as [OverallTotalSDDocRefStatus]
     , dimOSDDRSt.[OverallSDDocReferenceStatusID]
     , dimOSDDRSt.[OverallSDDocReferenceStatus]  as [OverallSDDocReferenceStatus]
     , dimIGIS.[ItemGeneralIncompletionStatusID]
     , dimIGIS.[ItemGeneralIncompletionStatus]
     , dimIBIS.[ItemBillingIncompletionStatusID]
     , dimIBIS.[ItemBillingIncompletionStatus]
     , dimPIS.[PricingIncompletionStatusID]
     , dimPIS.[PricingIncompletionStatus]        as [PricingIncompletionStatus]
     , dimIDIS.[ItemDeliveryIncompletionStatusID]
     , dimIDIS.[ItemDeliveryIncompletionStatus]
     , doc.[ExternalSalesAgentID]
     , doc.[ExternalSalesAgent]
     , doc.[ProjectID]
     , doc.[Project]
     , doc.[SalesEmployeeID]
     , doc.[SalesEmployee]
     , doc.[GlobalParentCalculatedID]
     , doc.[GlobalParentCalculated]
     , doc.[LocalParentCalculatedID]
     , doc.[LocalParentCalculated]
     , doc.[SDoc_ControllingObjectID]
     , doc.[SDItem_ControllingObjectID]     
     , doc.[Margin]
     , doc.[Subtotal1Amount]
     , doc.[Subtotal2Amount]
     , doc.[Subtotal3Amount]
     , doc.[Subtotal4Amount]
     , doc.[Subtotal5Amount]
     , doc.[Subtotal6Amount]
     , doc.[InOutID]       
     --, doc.[OrderNetAmount]
     , ord.[SO_OrderQuantity]
     , ord.[SO_NetAmount]
     , ord.[SO_CostAmount]
     , ord.[SO_Margin]
     , doc.[CorrespncExternalReference] 
     , doc.SalesOfficeID
    , PrcgElmnt.[ZC10]                         AS [PrcgElmntZC10ConditionAmount]
    , PrcgElmnt.[ZCF1]                         AS [PrcgElmntZCF1ConditionAmount]
    , [edw].[svf_replaceZero](
            PrcgElmnt.[VPRS]
            ,PrcgElmnt.[EK02])                 AS [PrcgElmntVPRS/EK02ConditionAmount]
     , doc.[t_applicationId]
     , doc.[t_extractionDtm]
from [edw].[fact_SalesDocumentItem] doc
         left join [edw].[dim_SDDocumentCategory] dimSDDC
                   on dimSDDC.[SDDocumentCategoryID] = doc.[SDDocumentCategoryID]
         left join [edw].[dim_SalesDocumentItemCategory] dimSDIC 
                   on dimSDIC.[SalesDocumentItemCategoryID] = doc.[SalesDocumentItemCategoryID]
         left join [edw].[dim_SDDocumentReason] dimSDR
                   on dimSDR.[SDDocumentReasonID] = doc.[SDDocumentReasonID]

         left join [edw].[dim_CustomerGroup] dimCGr
                   on dimCGr.[CustomerGroupID] = doc.[CustomerGroupID]
         left join [edw].[dim_SDDocumentCategory] dimRSDDC
                   on dimRSDDC.[SDDocumentCategoryID] = doc.[ReferenceSDDocumentCategoryID]

         left join [edw].[dim_SalesDocumentType] dimSDT
                   on dimSDT.[SalesDocumentTypeID] = doc.[SalesDocumentTypeID]

         left join [edw].[dim_BillingBlockStatus] dimBBS
                   on dimBBS.[BillingBlockStatusID] = doc.[BillingBlockStatusID]

         left join [edw].[dim_DeliveryBlockStatus] dimDBS
                   on dimDBS.[DeliveryBlockStatusID] = doc.[DeliveryBlockStatusID]

         left join [edw].[dim_ItemBillingIncompletionStatus] dimIBIS
                   on dimIBIS.[ItemBillingIncompletionStatusID] = doc.[ItemBillingIncompletionStatusID]

         left join [edw].[dim_ItemDeliveryIncompletionStatus] dimIDIS
                   on dimIDIS.[ItemDeliveryIncompletionStatusID] = doc.[ItemDeliveryIncompletionStatusID]

         left join [edw].[dim_ItemGeneralIncompletionStatus] dimIGIS
                   on dimIGIS.[ItemGeneralIncompletionStatusID] = doc.[ItemGeneralIncompletionStatusID]

         left join [edw].[dim_OverallSDProcessStatus] dimOSS
                   on dimOSS.[OverallSDProcessStatusID] = doc.[OverallSDProcessStatusID]

         left join [edw].[dim_SDDocReferenceStatus] dimSDDRS
                   on dimSDDRS.[SDDocReferenceStatusID] = doc.[SDDocReferenceStatusID]

         left join [edw].[dim_TotalCreditCheckStatus] dimTCCS
                   on dimTCCS.[TotalCreditCheckStatusID] = doc.[TotalCreditCheckStatusID]

         left join [edw].[dim_UnitOfMeasure] dimUOM
                   on dimUOM.[UnitOfMeasureID] = doc.[OrderQuantityUnitID]

         left join [edw].[dim_SalesDocumentRjcnReason] dimSDRR
                   on dimSDRR.[SalesDocumentRjcnReasonID] = doc.[SalesDocumentRjcnReasonID]

         left join [edw].[dim_DistributionChannel] dimDCh
                   on dimDCh.[DistributionChannelID] = doc.[DistributionChannelID]
         left join (
                select subDoc.[ReferenceSDDocumentID]    as [QuotationID],
                    subDoc.[ReferenceSDDocumentItemID]   as [QuotationItemID],
                    subDoc.[CurrencyTypeID],                   
                    sum(OrderQuantity) as       SO_OrderQuantity,
                    sum(NetAmount)     as       SO_NetAmount,
                    sum(CostAmount)             SO_CostAmount,
                    sum(Margin)                 SO_Margin
                from [edw].[fact_SalesDocumentItem] subDoc
                where subDoc.[SDDocumentCategoryID] <> 'B'
                and subDoc.[ReferenceSDDocumentID] <> ''
                and subDoc.[ReferenceSDDocumentCategoryID] = 'B'
                and subDoc.[SalesDocumentTypeID] = 'ZOR'
                group by subDoc.[ReferenceSDDocumentID], subDoc.[ReferenceSDDocumentItemID],  subDoc.[CurrencyTypeID] 
                
             ) as ord on ord.[QuotationID] = doc.[SalesDocument] 
                    and ord.[QuotationItemID] = doc.[SalesDocumentItem]
                    and ord.[CurrencyTypeID] = doc.[CurrencyTypeID]
        left join [edw].[dim_TotalSDDocReferenceStatus] dimTSDDRS
                   on dimTSDDRS.[TotalSDDocReferenceStatusID] = doc.[TotalSDDocReferenceStatusID]

         left join [edw].[dim_OverallSDDocumentRjcnStatus] dimOSDDRS
                   on dimOSDDRS.[OverallSDDocumentRjcnStatusID] = doc.[OverallSDDocumentRejectionStsID]

         left join [edw].[dim_SDDocumentRejectionStatus] dimSDDRjS
                   on dimSDDRjS.[SDDocumentRejectionStatusID] = doc.[SDDocumentRejectionStatusID]

         left join [edw].[dim_OverallTotalSDDocRefStatus] dimOTSDDRS
                   on dimOTSDDRS.[OverallTotalSDDocRefStatusID] = doc.[OverallTotalSDDocRefStatusID]

         left join [edw].[dim_OverallSDDocReferenceStatus] dimOSDDRSt
                   on dimOSDDRSt.[OverallSDDocReferenceStatusID] = doc.[OverallSDDocReferenceStatusID]

         left join [edw].[dim_PricingIncompletionStatus] dimPIS
                   on dimPIS.[PricingIncompletionStatusID] = doc.[PricingIncompletionStatusID]

         left join [edw].[dim_OverallTotalDeliveryStatus] dimOTDS
                   on dimOTDS.[OverallTotalDeliveryStatusID] = doc.[OverallTotalDeliveryStatusID]
        
         LEFT JOIN PrcgElmnt
                 ON doc.SalesDocument = PrcgElmnt.SalesQuotation
                     AND doc.SalesDocumentItem = PrcgElmnt.SalesQuotationItem  
                     AND doc.CurrencyTypeID = PrcgElmnt.CurrencyTypeID

where doc.[SDDocumentCategoryID] = 'B'