CREATE VIEW [edw].[vw_SalesOrderItem_combined]
AS
SELECT
       doc.[SalesDocument]                       as [SalesOrderID]
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
     , doc.[OrderType]
     , edw.[svf_getOrderStatus] (BDI.BillingDocument, doc.SalesDocumentTypeID, doc.OrderStatus) AS OrderStatus
     , edw.[svf_getOrderStatus] (BDI.BillingDocumentItem, doc.SalesDocumentTypeID,doc.ItemOrderStatus) AS ItemOrderStatus
     , doc.[ActualDeliveredQuantityInBaseUnit]
     , doc.[BillingQuantityInBaseUnit]
     , doc.[ActualDeliveredQuantityIBUOverall]
     , doc.[BillingQuantityIBUOverall]
     , doc.[ItemDeliveryStatus]    
     , doc.[OverallDeliveryStatus] 
     , doc.[ScheduleLineCategory]
     , doc.[SalesOfficeID]
     , dimSO.[SalesOffice]
     , doc.[CostAmount] 
     , doc.[ShippingConditionID]
     , BDI.[BillingDocument]                      
     , BDI.[BillingDocumentItem]                  
     , BDI.[CurrencyTypeID]   as [BillingDocumentCurrencyTypeID]
     , BDI.[BillingDocumentTypeID]                
     , BDI.[BillingDocumentCategoryID]            
     , BDI.[SDDocumentCategoryID]     AS [BillingDocumentSDDocumentCategoryID]       
     , BDI.[CreationDate]             AS [BillingDocumentCreationDate]                    
     , BDI.[CreationTime]             AS [BillingDocumentCreationTime]                                           
     , BDI.[BillingDocumentIsTemporary]           
     , BDI.[ProductSurrogateKey]      AS [BillingDocumentProductSurrogateKey]            
     , BDI.[BillingDocumentIsCancelled]           
     , BDI.[CancelledBillingDocument]             
     , BDI.[CancelledInvoiceEffect]                     
     , BDI.[BillingQuantity]                      
     , BDI.[BillingQuantityUnitID]                
     , BDI.[BillingQuantityInBaseUnit]    AS [BillingDocumentQuantityIBU]                           
     , BDI.[MRPRequiredQuantityInBaseUnit]                 
     , BDI.[ItemGrossWeight]                      
     , BDI.[ItemNetWeight]                      
     , BDI.[ItemVolume]                           
     , BDI.[NetAmount]    AS [BillingDocumentNetAmount]                   
     , BDI.[GrossAmount]                            
     , BDI.[TaxAmount]                            
     , BDI.[CostAmount]           AS [BillingDocumentCostAmount]   
     , BDI.[OriginSDDocument]                     
     , BDI.[OriginSDDocumentItem]         
     , BDI.[ReferenceSDDocument]      AS [BillingDocumentReferenceDocument]                
     , BDI.[ReferenceSDDocumentItem]  AS [BillingDocumentReferenceDocumentItem]            
     , BDI.[ReferenceSDDocumentCategoryID]    AS [BillingDocumentReferenceDocumentCategoryID]       
     , BDI.[SalesDocumentID]                      
     , BDI.[SalesDocumentItemID]                  
     , BDI.[SalesSDDocumentCategoryID]                            
     , BDI.[BillingDocumentType]    
     , BDI.[SDDocumentCategory]      AS [BillingDocumentSDDocumentCategory]
     , BDI.[BillingDocumentCategory]
     , dimSDSL.[ScheduleLine]
     , dimSDSL.[ScheduleLineCategory] AS [dimSDSLScheduleLineCategory]
     , dimSDSL.[OrderQuantityUnit]  AS  [dimSDSLOrderQuantityUnit]
     , dimSDSL.[IsRequestedDelivSchedLine]
     , dimSDSL.[ScheduleLineOrderQuantity]
     , dimSDSL.[CorrectedQtyInOrderQtyUnit]
     , dimSDSL.[IsConfirmedDelivSchedLine]
     , dimSDSL.[ConfirmedDeliveryDate]
     , dimSDSL.[ScheduleLineConfirmationStatus]
     , dimSDSL.[DeliveredQtyInOrderQtyUnit]
     , dimSDSL.[DeliveredQuantityInBaseUnit]
     , dimSDSL.[ConfdOrderQtyByMatlAvailCheck]
     , CASE
           WHEN dimSDSL.IsConfirmedDelivSchedLine= 'X'
           THEN dimSDSL.ConfirmedDeliveryDate
           ELSE doc.RequestedDeliveryDate
       END  as ExpectedDeliveryDate
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

         LEFT JOIN [edw].[dim_SalesOffice] dimSO
                    ON doc.[SalesOfficeID] = dimSO.[SalesOfficeID]
        
        LEFT JOIN [edw].[vw_BillingDocumentItem_for_SalesDocumentItem] BDI
                    ON doc.SalesDocument = BDI.SalesDocumentID
                       AND doc.SalesDocumentItem = BDI.SalesDocumentItemID
                       AND doc.CurrencyTypeID = BDI.CurrencyTypeID

         LEFT JOIN [edw].[dim_SalesDocumentScheduleLine] dimSDSL
                    ON doc.SalesDocument = dimSDSL.SalesDocumentID
                       AND doc.SalesDocumentItem = dimSDSL.SalesDocumentItem

WHERE doc.[SDDocumentCategoryID] <> 'B'
AND dimSDDRjS.[SDDocumentRejectionStatus] <> 'Fully Rejected'