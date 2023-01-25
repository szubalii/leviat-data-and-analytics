CREATE VIEW [dm_sales].[vw_fact_SalesOrderItem] 
AS

WITH statuses AS (
     SELECT 'Closed'     AS Status
     ,   0               AS OrderType
     ,   'C'             AS DeliveryStatus
     ,   'F'             AS InvoiceStatus
     UNION ALL SELECT 'Delivered not Invoiced',   0,        'C',       'N'
     UNION ALL SELECT 'Delivered not Invoiced',   0,        'C',       'P'
     UNION ALL SELECT 'ZZ_To_Be_Investigated',    0,        'A',       'F'
     UNION ALL SELECT 'Open',                     0,        'A',       'N'
     UNION ALL SELECT 'ZZ_To_Be_Investigated',    0,        'A',       'P'
     UNION ALL SELECT 'ZZ_To_Be_Investigated',    0,        'B',       'F'
     UNION ALL SELECT 'Delivered not Invoiced',   0,        'B',       'N'
     UNION ALL SELECT 'Open',                     0,        'B',       'P'
     UNION ALL SELECT 'Closed',                   1,        'C',       'F'
     UNION ALL SELECT 'Delivered not Invoiced',   1,        'C',       'N'
     UNION ALL SELECT 'Delivered not Invoiced',   1,        'C',       'P'
     UNION ALL SELECT 'ZZ_To_Be_Investigated',    1,        'A',       'F'
     UNION ALL SELECT 'Open',                     1,        'A',       'N'
     UNION ALL SELECT 'ZZ_To_Be_Investigated',    1,        'A',       'P'
     UNION ALL SELECT 'ZZ_To_Be_Investigated',    1,        'B',       'F'
     UNION ALL SELECT 'Delivered not Invoiced',   1,        'B',       'N'
     UNION ALL SELECT 'Open',                     1,        'B',       'P'
     UNION ALL SELECT 'Closed',                   2,        null,      'F'
     UNION ALL SELECT 'Open',                     2,        null,      'N'
     UNION ALL SELECT 'Open',                     2,        null,      'P'
),
outboundDeliveries AS (
     SELECT SUM(ActualDeliveredQtyInBaseUnit)          AS ActualDeliveredQuantityInBaseUnit
          ,[ReferenceSDDocument]
          ,[ReferenceSDDocumentItem]
     FROM [edw].[fact_OutboundDeliveryItem]
     GROUP BY [ReferenceSDDocument]
               ,[ReferenceSDDocumentItem]
),
documentItems AS (
     SELECT SUM(BillingQuantityInBaseUnit)             AS BillingQuantityInBaseUnit
          ,[ReferenceSDDocument]
          ,[ReferenceSDDocumentItem]
          ,[CurrencyTypeID]
         /* , AVG (
               CASE ShippingCondition 
                    WHEN 70 THEN 1
                    ELSE 0
               END
          )                                            AS ShippingCondition*/
     FROM [edw].[fact_BillingDocumentItem]
     GROUP BY [ReferenceSDDocument], [ReferenceSDDocumentItem], [CurrencyTypeID]
),
salesDocumentScheduleLine AS (
     SELECT MAX(ScheduleLineCategory)                  AS ScheduleLineCategory
          ,[SalesDocumentID]
          ,[SalesDocumentItem]
     FROM [edw].[dim_SalesDocumentScheduleLine]
     GROUP BY 
          [SalesDocumentID]
          ,[SalesDocumentItem]
)
select doc.[SalesDocument]                       as [SalesOrderID]
     , doc.[SalesDocumentItem]                   as [SalesOrderItemID]
     , doc.[CurrencyTypeID]
     , doc.[CurrencyType]
     , doc.[CurrencyID]
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
     , dimUOM.[UnitOfMeasureID]                  as [OrderQuantityUnitID]
     , dimUOM.[UnitOfMeasure]                    as [OrderQuantityUnit]
     , doc.[TargetQuantity]
     , doc.[TargetQuantityUnitID]
     --, doc.[ConfdDelivyInOrderyUnitID]
     --, doc.[TargetDelivyInOrderyUnitID]
     --, doc.[ConfdDeliveryInBaseUnitID]
     , doc.[ServicesRenderedDate]
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
     , quo.[sk_fact_SalesDocumentItem]           as [ReferenceSDDocumentItemSurrogateKey]
     , doc.[ReferenceSDDocumentID]
     , doc.[ReferenceSDDocumentItemID]
     , dimRSDDC.SDDocumentCategoryID             as [ReferenceSDDocumentCategoryID]
     , dimRSDDC.SDDocumentCategory               as [ReferenceSDDocumentCategory]
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
     , doc.[Margin]
     , doc.[Subtotal1Amount]
     , doc.[Subtotal2Amount]
     , doc.[Subtotal3Amount]
     , doc.[Subtotal4Amount]
     , doc.[Subtotal5Amount]
     , doc.[Subtotal6Amount]
     , doc.[InOutID]
     , CASE
          WHEN SDSL.ScheduleLineCategory = 'ZS'
               THEN 'Drop Shipment'
          WHEN doc.ShippingConditionID = 70      -- all related ShippingCondition is 70
               THEN 'Collection'
          WHEN doc.ShippingConditionID <> 70      -- all related ShippingCondition isn't 70
               THEN 'Delivery'
          ELSE      'Unknown'
     END                                               AS [OrderType]
     , ios_status.Status                               AS [ItemOrderStatus]
     , os_status.Status                                AS [OrderStatus]
     , OD.[ActualDeliveredQuantityInBaseUnit]
     , DI.[BillingQuantityInBaseUnit]
     , doc.[t_applicationId]
     , doc.[t_extractionDtm]
from [edw].[fact_SalesDocumentItem] doc
         left join [edw].[fact_SalesDocumentItem] quo
                   on doc.ReferenceSDDocumentID = quo.SalesDocument
                       AND
                      doc.ReferenceSDDocumentItemID = quo.SalesDocumentItem
                       and
                      doc.CurrencyTypeID = quo.CurrencyTypeID
                       and
                      doc.CurrencyID = quo.CurrencyID
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

          LEFT JOIN outboundDeliveries OD
                    ON doc.[SalesDocument] = OD.[ReferenceSDDocument]
                         AND doc.[SalesDocumentItem] = OD.[ReferenceSDDocumentItem]

          LEFT JOIN documentItems DI
                    ON doc.[SalesDocument] = DI.[ReferenceSDDocument]
                         AND doc.[SalesDocumentItem] = DI.[ReferenceSDDocumentItem]
                         AND doc.[CurrencyTypeID] = DI.[CurrencyTypeID]

          LEFT JOIN salesDocumentScheduleLine SDSL
                    ON doc.[SalesDocument] = SDSL.[SalesDocumentID]
                         AND doc.[SalesDocumentItem] = SDSL.[SalesDocumentItem]
                         
          LEFT JOIN statuses  ios_status
                   /* ON CASE 
                         WHEN SDSL.ScheduleLineCategory = 'ZS'
                              AND dimIDIS.[ItemDeliveryIncompletionStatus] = 'Complete'
                              AND OD.ActualDeliveredQuantityInBaseUnit = DI.BillingQuantityInBaseUnit
                              THEN ios_status.OrderType = 'Drop Shipment' AND ios_status.InvoiceStatus = 'F'
                         WHEN SDSL.ScheduleLineCategory = 'ZS'
                              AND dimIDIS.[ItemDeliveryIncompletionStatus] = 'Incomplete'
                              AND DI.BillingQuantityInBaseUnit <> 0
                              THEN ios_status.OrderType = 'Drop Shipment' AND ios_status.InvoiceStatus = 'P'
                         WHEN SDSL.ScheduleLineCategory = 'ZS'
                              AND dimIDIS.[ItemDeliveryIncompletionStatus] = 'Incomplete'
                              AND DI.BillingQuantityInBaseUnit = 0 
                              THEN ios_status.OrderType = 'Drop Shipment' AND ios_status.InvoiceStatus = 'N'
                         ELSE doc.ShippingCondition = ios_status.OrderType
                              AND dimIDIS.[ItemDeliveryIncompletionStatusID] = ios_status.DeliveryStatus
                              AND CASE 
                                   WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Complete'
                                        AND OD.ActualDeliveredQuantityInBaseUnit = DI.BillingQuantityInBaseUnit
                                        THEN 'F'
                                   WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Incomplete'
                                        AND DI.BillingQuantityInBaseUnit <> 0
                                        THEN 'P'
                                   WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Incomplete'
                                        AND DI.BillingQuantityInBaseUnit = 0 
                                        THEN 'N'
                                   END = ios.status.InvoiceStatus
                         END*/
                         ON 
                              CASE
                                   WHEN SDSL.ScheduleLineCategory = 'ZS'
                                        THEN 2
                                   WHEN doc.ShippingConditionID = 70
                                        THEN 1
                                   WHEN doc.ShippingConditionID <> 70
                                        THEN 0
                              END = ios_status.OrderType
                         AND dimIDIS.[ItemDeliveryIncompletionStatusID] = COALESCE (ios_status.DeliveryStatus, dimIDIS.[ItemDeliveryIncompletionStatusID])
                         AND CASE 
                                   WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Complete'
                                        AND OD.ActualDeliveredQuantityInBaseUnit = DI.BillingQuantityInBaseUnit
                                        THEN 'F'
                                   WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Incomplete'
                                        AND DI.BillingQuantityInBaseUnit <> 0
                                        THEN 'P'
                                   WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Incomplete'
                                        AND COALESCE(DI.BillingQuantityInBaseUnit,0) = 0 
                                        THEN 'N'
                              END = ios_status.InvoiceStatus
          LEFT JOIN statuses  os_status
                    /*ON CASE 
                         WHEN SDSL.ScheduleLineCategory = 'ZS'
                              AND dimOTDS.[OverallTotalDeliveryStatus] = 'Complete'
                              AND OD.ActualDeliveredQuantityInBaseUnit = DI.BillingQuantityInBaseUnit
                              THEN os_status.OrderType = 'Drop Shipment' AND os_status.InvoiceStatus = 'F'
                         WHEN SDSL.ScheduleLineCategory = 'ZS'
                              AND dimOTDS.[OverallTotalDeliveryStatus] <> 'Complete'
                              AND DI.BillingQuantityInBaseUnit <> 0
                              THEN os_status.OrderType = 'Drop Shipment' AND os_status.InvoiceStatus = 'P'
                         WHEN SDSL.ScheduleLineCategory = 'ZS'
                              AND dimOTDS.[OverallTotalDeliveryStatus] <> 'Complete'
                              AND DI.BillingQuantityInBaseUnit = 0 
                              THEN os_status.OrderType = 'Drop Shipment' AND os_status.InvoiceStatus = 'N'
                         ELSE doc.ShippingCondition = os_status.OrderType
                              AND dimOTDS.[OverallTotalDeliveryStatusID] = os_status.DeliveryStatus
                              AND CASE 
                                   WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Complete'
                                        AND OD.ActualDeliveredQuantityInBaseUnit = DI.BillingQuantityInBaseUnit
                                        THEN 'F'
                                   WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Incomplete'
                                        AND DI.BillingQuantityInBaseUnit <> 0
                                        THEN 'P'
                                   WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Incomplete'
                                        AND DI.BillingQuantityInBaseUnit = 0 
                                        THEN 'N'
                                   END = ios.status.InvoiceStatus
                         END*/
                    ON 
                         CASE
                              WHEN SDSL.ScheduleLineCategory = 'ZS'
                                   THEN 2
                              WHEN doc.ShippingConditionID = 70
                                   THEN 1
                              WHEN doc.ShippingConditionID <> 70
                                   THEN 0
                         END = os_status.OrderType
                    AND dimOTDS.[OverallTotalDeliveryStatusID] = COALESCE (os_status.DeliveryStatus, dimOTDS.[OverallTotalDeliveryStatusID])
                    AND CASE 
                              WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Complete'
                                   AND OD.ActualDeliveredQuantityInBaseUnit = DI.BillingQuantityInBaseUnit
                                   THEN 'F'
                              WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Incomplete'
                                   AND DI.BillingQuantityInBaseUnit <> 0
                                   THEN 'P'
                              WHEN dimIDIS.[ItemDeliveryIncompletionStatus] = 'Incomplete'
                                   AND COALESCE(DI.BillingQuantityInBaseUnit,0) = 0 
                                   THEN 'N'
                         END = os_status.InvoiceStatus
where doc.[SDDocumentCategoryID] <> 'B'
     AND dimSDDRjS.[SDDocumentRejectionStatus] <> 'Fully Rejected'