CREATE VIEW [dm_sales].[vw_fact_SalesQuotationItem] AS

WITH

CTE_CustomerSalesArea AS (
    SELECT
        csa.CustomerGroup
    ,   csa.SalesOrganization
    ,   csa.DistributionChannel
    ,   csa.Division
    ,   csa.Customer
    ,   csa.CustomerPriceGroup
    ,   ROW_NUMBER() OVER (
            PARTITION BY csa.CustomerGroup, csa.SalesOrganization, csa.DistributionChannel, csa.Division, csa.Customer
            ORDER BY csa.CustomerGroup, csa.SalesOrganization, csa.DistributionChannel, csa.Division, csa.Customer
        ) AS row_num
    FROM [base_s4h_cax].[I_CustomerSalesArea] csa
    GROUP BY
        csa.CustomerGroup
    ,   csa.SalesOrganization
    ,   csa.DistributionChannel
    ,   csa.Division
    ,   csa.Customer
    ,   csa.CustomerPriceGroup
)
,
CTE_SalesOrder AS (
  SELECT
    subDoc.[ReferenceSDDocumentID] AS [QuotationID],
    subDoc.[ReferenceSDDocumentItemID] AS [QuotationItemID],
    subDoc.[CurrencyTypeID],                   
    SUM(OrderQuantity) AS SO_OrderQuantity,
    SUM(NetAmount)     AS SO_NetAmount,
    SUM(CostAmount)    AS SO_CostAmount,
    SUM(Margin)        AS SO_Margin
  FROM
    [edw].[fact_SalesDocumentItem] subDoc
  WHERE
    subDoc.[SDDocumentCategoryID] <> 'B'
    AND
    subDoc.[ReferenceSDDocumentID] <> ''
    AND
    subDoc.[ReferenceSDDocumentCategoryID] = 'B'
    AND
    subDoc.[SalesDocumentTypeID] = 'ZOR'
  GROUP BY
    subDoc.[ReferenceSDDocumentID],
    subDoc.[ReferenceSDDocumentItemID],
    subDoc.[CurrencyTypeID]
)
,
CTE_ConditionTypes AS (
  SELECT
    [SalesQuotation]
    ,[SalesQuotationItem]
    ,[CurrencyTypeID]
    ,ConditionType AS ConditionTypeForConditionAmount
    ,ConditionType + '1' AS ConditionTypeForConditionRateValue
    ,SUM(ConditionAmount) AS ConditionAmount
    ,SUM(ConditionRateValue) AS ConditionRateValue
  FROM
    [edw].[fact_SalesQuotationItemPrcgElmnt]
  GROUP BY
    [SalesQuotation]
    ,[SalesQuotationItem]
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
    [SalesQuotation]
    ,[SalesQuotationItem]
    ,[CurrencyTypeID]
    ,MAX([ZC10])    AS [PrcgElmntZC10ConditionAmount]
    ,MAX([ZCF1])    AS [PrcgElmntZCF1ConditionAmount]
    ,MAX([VPRS])    AS [PrcgElmntVPRSConditionAmount]
    ,MAX([EK02])    AS [PrcgElmntEK02ConditionAmount]
    ,MAX([ZC101])   AS [PrcgElmntZC10ConditionRate]
    ,MAX([ZCF11])   AS [PrcgElmntZCF1ConditionRate]
    ,MAX([VPRS1])   AS [PrcgElmntVPRSConditionRate]
    ,MAX([EK021])   AS [PrcgElmntEK02ConditionRate]
  FROM
    CTE_PVT
  GROUP BY
    [SalesQuotation]
    ,[SalesQuotationItem]
    ,[CurrencyTypeID]
)

SELECT
  doc.[SalesDocument]           AS [QuotationID]
, doc.[SalesDocumentItem]       AS [QuotationItemID]
, doc.[CurrencyTypeID]
, doc.[CurrencyType]
, doc.[sk_fact_SalesDocumentItem] AS sk_fact_SalesQuotationItem
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
, doc.[nk_ProductPlant]
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
, dimUOM.[UnitOfMeasureID]      AS [OrderQuantityUnitID]
, dimUOM.[UnitOfMeasure]        AS [OrderQuantityUnit]
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
, dimRSDDC.SDDocumentCategoryID AS [ReferenceSDDocumentCategoryID]
, dimRSDDC.SDDocumentCategory   AS [ReferenceSDDocumentCategory]
, doc.[OriginSDDocumentID]
, doc.[OriginSDDocumentItemID]
, dimOSS.[OverallSDProcessStatusID]
, dimOSS.[OverallSDProcessStatus]
, dimOTDS.[OverallTotalDeliveryStatusID]
, dimOTDS.[OverallTotalDeliveryStatus] AS [OverallTotalDeliveryStatus]
, doc.[OverallOrdReltdBillgStatusID]
, dimTCCS.[TotalCreditCheckStatusID]
, dimTCCS.[TotalCreditCheckStatus]
, dimDBS.[DeliveryBlockStatusID]
, dimDBS.[DeliveryBlockStatus]
, dimBBS.[BillingBlockStatusID]
, dimBBS.[BillingBlockStatus]
, dimTSDDRS.[TotalSDDocReferenceStatusID]
, dimTSDDRS.[TotalSDDocReferenceStatus]     AS [TotalSDDocReferenceStatus]
, dimSDDRS.[SDDocReferenceStatusID]
, dimSDDRS.[SDDocReferenceStatus]
, dimOSDDRS.[OverallSDDocumentRjcnStatusID]
, dimOSDDRS.[OverallSDDocumentRjcnStatus] AS [OverallSDDocumentRejectionSts]
, dimSDDRjS.[SDDocumentRejectionStatusID]
, dimSDDRjS.[SDDocumentRejectionStatus]     AS [SDDocumentRejectionStatus]
, dimOTSDDRS.[OverallTotalSDDocRefStatusID]
, dimOTSDDRS.[OverallTotalSDDocRefStatus]   AS [OverallTotalSDDocRefStatus]
, dimOSDDRSt.[OverallSDDocReferenceStatusID]
, dimOSDDRSt.[OverallSDDocReferenceStatus]  AS [OverallSDDocReferenceStatus]
, dimIGIS.[ItemGeneralIncompletionStatusID]
, dimIGIS.[ItemGeneralIncompletionStatus]
, dimIBIS.[ItemBillingIncompletionStatusID]
, dimIBIS.[ItemBillingIncompletionStatus]
, dimPIS.[PricingIncompletionStatusID]
, dimPIS.[PricingIncompletionStatus]        AS [PricingIncompletionStatus]
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
, CTE_SalesOrder.[SO_OrderQuantity]
, CTE_SalesOrder.[SO_NetAmount]
, CTE_SalesOrder.[SO_CostAmount]
, CTE_SalesOrder.[SO_Margin]
, doc.[CorrespncExternalReference] 
, doc.SalesOfficeID
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
, doc.[SalesGroupID]
, doc.[SalesGroupName]
, csa.CustomerPriceGroup AS [CustomerPriceGroupID]
, doc.[t_applicationId]
, doc.[t_extractionDtm]
FROM
  [edw].[fact_SalesDocumentItem] doc
LEFT JOIN
  [edw].[dim_SDDocumentCategory] dimSDDC
  ON
    dimSDDC.[SDDocumentCategoryID] = doc.[SDDocumentCategoryID]
LEFT JOIN
  [edw].[dim_SalesDocumentItemCategory] dimSDIC 
  ON
    dimSDIC.[SalesDocumentItemCategoryID] = doc.[SalesDocumentItemCategoryID]
LEFT JOIN
  [edw].[dim_SDDocumentReason] dimSDR
  ON
    dimSDR.[SDDocumentReasonID] = doc.[SDDocumentReasonID]

LEFT JOIN
  [edw].[dim_CustomerGroup] dimCGr
  ON
    dimCGr.[CustomerGroupID] = doc.[CustomerGroupID]
LEFT JOIN
  [edw].[dim_SDDocumentCategory] dimRSDDC
  ON
    dimRSDDC.[SDDocumentCategoryID] = doc.[ReferenceSDDocumentCategoryID]

LEFT JOIN
  [edw].[dim_SalesDocumentType] dimSDT
  ON
    dimSDT.[SalesDocumentTypeID] = doc.[SalesDocumentTypeID]

LEFT JOIN
  [edw].[dim_BillingBlockStatus] dimBBS
  ON
    dimBBS.[BillingBlockStatusID] = doc.[BillingBlockStatusID]

LEFT JOIN
  [edw].[dim_DeliveryBlockStatus] dimDBS
  ON
    dimDBS.[DeliveryBlockStatusID] = doc.[DeliveryBlockStatusID]

LEFT JOIN
  [edw].[dim_ItemBillingIncompletionStatus] dimIBIS
  ON
    dimIBIS.[ItemBillingIncompletionStatusID] = doc.[ItemBillingIncompletionStatusID]

LEFT JOIN
  [edw].[dim_ItemDeliveryIncompletionStatus] dimIDIS
  ON
    dimIDIS.[ItemDeliveryIncompletionStatusID] = doc.[ItemDeliveryIncompletionStatusID]

LEFT JOIN
  [edw].[dim_ItemGeneralIncompletionStatus] dimIGIS
  ON
    dimIGIS.[ItemGeneralIncompletionStatusID] = doc.[ItemGeneralIncompletionStatusID]

LEFT JOIN
  [edw].[dim_OverallSDProcessStatus] dimOSS
  ON
    dimOSS.[OverallSDProcessStatusID] = doc.[OverallSDProcessStatusID]

LEFT JOIN
  [edw].[dim_SDDocReferenceStatus] dimSDDRS
  ON
    dimSDDRS.[SDDocReferenceStatusID] = doc.[SDDocReferenceStatusID]

LEFT JOIN
  [edw].[dim_TotalCreditCheckStatus] dimTCCS
  ON
    dimTCCS.[TotalCreditCheckStatusID] = doc.[TotalCreditCheckStatusID]

LEFT JOIN
  [edw].[dim_UnitOfMeasure] dimUOM
  ON
    dimUOM.[UnitOfMeasureID] = doc.[OrderQuantityUnitID]

LEFT JOIN
  [edw].[dim_SalesDocumentRjcnReason] dimSDRR
  ON
    dimSDRR.[SalesDocumentRjcnReasonID] = doc.[SalesDocumentRjcnReasonID]

LEFT JOIN
  [edw].[dim_DistributionChannel] dimDCh
  ON
    dimDCh.[DistributionChannelID] = doc.[DistributionChannelID]
LEFT JOIN
  CTE_SalesOrder
  ON
    CTE_SalesOrder.[QuotationID] = doc.[SalesDocument] 
    AND
    CTE_SalesOrder.[QuotationItemID] = doc.[SalesDocumentItem]
    AND
    CTE_SalesOrder.[CurrencyTypeID] = doc.[CurrencyTypeID]
LEFT JOIN
  [edw].[dim_TotalSDDocReferenceStatus] dimTSDDRS
  ON
    dimTSDDRS.[TotalSDDocReferenceStatusID] = doc.[TotalSDDocReferenceStatusID]

LEFT JOIN
  [edw].[dim_OverallSDDocumentRjcnStatus] dimOSDDRS
  ON
    dimOSDDRS.[OverallSDDocumentRjcnStatusID] = doc.[OverallSDDocumentRejectionStsID]

LEFT JOIN
  [edw].[dim_SDDocumentRejectionStatus] dimSDDRjS
  ON
    dimSDDRjS.[SDDocumentRejectionStatusID] = doc.[SDDocumentRejectionStatusID]

LEFT JOIN
  [edw].[dim_OverallTotalSDDocRefStatus] dimOTSDDRS
  ON
    dimOTSDDRS.[OverallTotalSDDocRefStatusID] = doc.[OverallTotalSDDocRefStatusID]

LEFT JOIN
  [edw].[dim_OverallSDDocReferenceStatus] dimOSDDRSt
  ON
    dimOSDDRSt.[OverallSDDocReferenceStatusID] = doc.[OverallSDDocReferenceStatusID]

LEFT JOIN
  [edw].[dim_PricingIncompletionStatus] dimPIS
  ON
    dimPIS.[PricingIncompletionStatusID] = doc.[PricingIncompletionStatusID]

LEFT JOIN
  [edw].[dim_OverallTotalDeliveryStatus] dimOTDS
  ON
    dimOTDS.[OverallTotalDeliveryStatusID] = doc.[OverallTotalDeliveryStatusID]

LEFT JOIN
  CTE_PrcgElmnt
  ON
    doc.SalesDocument = CTE_PrcgElmnt.SalesQuotation
    AND
    doc.SalesDocumentItem = CTE_PrcgElmnt.SalesQuotationItem
    AND
    doc.CurrencyTypeID = CTE_PrcgElmnt.CurrencyTypeID

LEFT JOIN
  CTE_CustomerSalesArea csa
  ON
    doc.SoldToPartyID = csa.Customer
    AND
    doc.CustomerGroupID = csa.CustomerGroup
    AND 
    doc.SalesOrganizationID = csa.SalesOrganization
    AND 
    doc.DistributionChannelID = csa.DistributionChannel
    AND
    doc.DivisionID = csa.Division
    AND 
    csa.row_num = 1


WHERE
  doc.[SDDocumentCategoryID] = 'B'
