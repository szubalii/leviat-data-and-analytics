CREATE VIEW [dm_sales].[vw_fact_SalesOrderItem_combined]
AS
SELECT
     SOI.[SalesOrderID]
    ,SOI.[SalesOrderItemID]
    ,SOI.[CreationDate]
    ,SOI.[CreationTime]
    ,SOI.[BillingDocumentDate]
    ,SOI.[CurrencyType]
    ,SOI.[SalesDocumentType]
    ,SOI.[MaterialID]
    ,SOI.[OrderQuantity]
    ,SOI.[OrderQuantityUnitID]
    ,SOI.[CurrencyID]
    ,SOI.[InOutID]
    ,SOI.[SalesOrganizationID]
    ,SOI.[RequestedDeliveryDate]
    ,SOI.[ActualDeliveredQuantityInBaseUnit]
    ,SOI.[BillingQuantityInBaseUnit]
    ,SOI.[ActualDeliveredQuantityIBUOverall]
    ,SOI.[BillingQuantityIBUOverall]
    ,edw.[svf_getOrderStatus] (BDI.BillingDocument, SOI.SalesDocumentTypeID, SOI.OrderStatus) AS OrderStatus
    ,edw.[svf_getOrderStatus] (BDI.BillingDocumentItem, SOI.SalesDocumentTypeID, SOI.ItemOrderStatus) AS ItemOrderStatus
    ,SOI.[OrderType]
    ,SOI.[ItemDeliveryStatus]    
    ,SOI.[OverallDeliveryStatus]
    ,SOI.[ShippingConditionID]
    ,SOI.[NetAmount] as SOI_NetAmount
    ,SOI.[CostAmount] as SOI_CostAmount
    ,SOI.[DistributionChannelID]
    ,SOI.[DistributionChannel]
    ,SOI.[SalesDocumentTypeID]
    ,SOI.[SalesDocumentItemCategoryID]
    ,SOI.[SalesDocumentItemCategory]
    ,SOI.[IsReturnsItemID]
    ,SOI.[LastChangeDate]
    ,SOI.[MaterialSubstitutionReasonID]
    ,SOI.[MaterialGroupID]
    ,SOI.[OriginallyRequestedMaterialID]
    ,SOI.[BrandID]
    ,SOI.[Brand]
    ,SOI.[SoldToPartyID]
    ,SOI.[ShipToPartyID]
    ,SOI.[PayerPartyID]
    ,SOI.[BillToPartyID]
    ,SOI.[SDDocumentReasonID]
    ,SOI.[SDDocumentReason]
    ,SOI.[SalesDocumentDate]
    ,SOI.[TargetQuantity]
    ,SOI.[TargetQuantityUnitID]
    ,SOI.[ServicesRenderedDate]
    ,SOI.[SalesDistrictID]
    ,SOI.[CustomerGroupID]
    ,SOI.[CustomerGroup]
    ,SOI.[SalesDocumentRjcnReasonID]
    ,SOI.[SalesDocumentRjcnReason]
    ,SOI.[PricingDate]
    ,SOI.[ExchangeRateDate]
    ,SOI.[TransactionCurrencyID]
    ,SOI.[PlantID]
    ,SOI.[StorageLocationID]
    ,SOI.[BillingCompanyCodeID]
    ,SOI.[ProfitCenterID]
    ,SOI.[SDDocumentCategoryID]
    ,SOI.[SDDocumentCategory]
    ,SOI.[ReferenceSDDocumentItemSurrogateKey]
    ,SOI.[ReferenceSDDocumentID]
    ,SOI.[ReferenceSDDocumentItemID]
    ,SOI.[ReferenceSDDocumentCategoryID]
    ,SOI.[ReferenceSDDocumentCategory]
    ,SOI.[OriginSDDocumentID]
    ,SOI.[OriginSDDocumentItemID]
    ,SOI.[OverallSDProcessStatusID]
    ,SOI.[OverallSDProcessStatus]
    ,SOI.[OverallTotalDeliveryStatusID]
    ,SOI.[OverallTotalDeliveryStatus]
    ,SOI.[OverallOrdReltdBillgStatusID]
    ,SOI.[TotalCreditCheckStatusID]
    ,SOI.[TotalCreditCheckStatus]
    ,SOI.[DeliveryBlockStatusID]
    ,SOI.[DeliveryBlockStatus]
    ,SOI.[BillingBlockStatusID]
    ,SOI.[BillingBlockStatus]
    ,SOI.[TotalSDDocReferenceStatusID]
    ,SOI.[TotalSDDocReferenceStatus]
    ,SOI.[SDDocReferenceStatusID]
    ,SOI.[SDDocReferenceStatus]
    ,SOI.[OverallSDDocumentRjcnStatusID]
    ,SOI.[OverallSDDocumentRejectionSts]
    ,SOI.[SDDocumentRejectionStatusID]
    ,SOI.[SDDocumentRejectionStatus]
    ,SOI.[OverallTotalSDDocRefStatusID]
    ,SOI.[OverallTotalSDDocRefStatus]
    ,SOI.[OverallSDDocReferenceStatusID]
    ,SOI.[OverallSDDocReferenceStatus]
    ,SOI.[ItemGeneralIncompletionStatusID]
    ,SOI.[ItemGeneralIncompletionStatus]
    ,SOI.[ItemBillingIncompletionStatusID]
    ,SOI.[ItemBillingIncompletionStatus]
    ,SOI.[PricingIncompletionStatusID]
    ,SOI.[PricingIncompletionStatus]
    ,SOI.[ItemDeliveryIncompletionStatusID]
    ,SOI.[ItemDeliveryIncompletionStatus]
    ,SOI.[SalesAgent]
    ,SOI.[ExternalSalesAgentID]
    ,SOI.[ExternalSalesAgent]
    ,SOI.[ProjectID]
    ,SOI.[Project]
    ,SOI.[SalesEmployeeID]
    ,SOI.[SalesEmployee]
    ,SOI.[GlobalParentCalculatedID]
    ,SOI.[GlobalParentCalculated]
    ,SOI.[LocalParentCalculatedID]
    ,SOI.[LocalParentCalculated]
    ,SOI.[Margin]
    ,SOI.[Subtotal1Amount]
    ,SOI.[Subtotal2Amount]
    ,SOI.[Subtotal3Amount]
    ,SOI.[Subtotal4Amount]
    ,SOI.[Subtotal5Amount]
    ,SOI.[Subtotal6Amount]
    ,SOI.[SalesOfficeID]
    ,SOI.[SalesOffice]
    ,BDI.[BillingDocument]                      
    ,BDI.[BillingDocumentItem]                  
    ,BDI.[CurrencyTypeID]      
    ,BDI.[BillingDocumentTypeID]                
    ,BDI.[BillingDocumentCategoryID]            
    ,BDI.[SDDocumentCategory]  AS  [BillingDocumentSDDocumentCategory] 
    ,BDI.[SDDocumentCategoryID] AS [BillingDocumentSDDocumentCategoryID]            
    ,BDI.[CreationDate]             AS [BillingDocumentCreationDate]                    
    ,BDI.[CreationTime]             AS [BillingDocumentCreationTime]                                           
    ,BDI.[BillingDocumentIsTemporary]           
    ,BDI.[ProductSurrogateKey]                      
    ,BDI.[BillingDocumentIsCancelled]           
    ,BDI.[CancelledBillingDocument]             
    ,BDI.[CancelledInvoiceEffect]                     
    ,BDI.[BillingQuantity]                      
    ,BDI.[BillingQuantityUnitID]                
    ,BDI.[BillingQuantityInBaseUnit]    AS [BillingDocumentQuantityIBU]                           
    ,BDI.[MRPRequiredQuantityInBaseUnit]                 
    ,BDI.[ItemGrossWeight]                      
    ,BDI.[ItemNetWeight]                      
    ,BDI.[ItemVolume]                           
    ,BDI.[NetAmount]                       
    ,BDI.[GrossAmount]                            
    ,BDI.[TaxAmount]                            
    ,BDI.[CostAmount]              
    ,BDI.[OriginSDDocument]                     
    ,BDI.[OriginSDDocumentItem]         
    ,BDI.[ReferenceSDDocument]      AS [BillingDocumentReferenceDocument]                
    ,BDI.[ReferenceSDDocumentItem]  AS [BillingDocumentReferenceDocumentItem]            
    ,BDI.[ReferenceSDDocumentCategoryID]    AS [BillingDocumentReferenceDocumentCategoryID]       
    ,BDI.[SalesDocumentID]                      
    ,BDI.[SalesDocumentItemID]                  
    ,BDI.[SalesSDDocumentCategoryID]                            
    ,BDI.[BillingDocumentType]      
    ,BDI.[BillingDocumentCategory]
    ,SDSL.[ScheduleLine]
    ,SDSL.[ScheduleLineCategory]
    ,SDSL.[OrderQuantityUnit]
    ,SDSL.[IsRequestedDelivSchedLine]
    ,SDSL.[ScheduleLineOrderQuantity]
    ,SDSL.[CorrectedQtyInOrderQtyUnit]
    ,SDSL.[IsConfirmedDelivSchedLine]
    ,SDSL.[ConfirmedDeliveryDate]
    ,SDSL.[ScheduleLineConfirmationStatus]
    ,SDSL.[DeliveredQtyInOrderQtyUnit]
    ,SDSL.[DeliveredQuantityInBaseUnit]
    ,SDSL.[ConfdOrderQtyByMatlAvailCheck]
    ,CASE
        WHEN SDSL.IsConfirmedDelivSchedLine= 'X'
        THEN SDSL.ConfirmedDeliveryDate
        ELSE SOI.RequestedDeliveryDate
     END  as ExpectedDeliveryDate
    ,SOI.[t_applicationId]
    ,SOI.[t_extractionDtm]
FROM [dm_sales].[vw_fact_SalesOrderItem] SOI
LEFT JOIN [edw].[vw_BillingDocumentItem_for_SalesDocumentItem] BDI
    ON SOI.SalesOrderID = BDI.SalesDocumentID
    AND SOI.SalesOrderItemID = BDI.SalesDocumentItemID
    AND SOI.CurrencyTypeID = BDI.CurrencyTypeID
LEFT JOIN [edw].[dim_SalesDocumentScheduleLine] SDSL
    ON SOI.SalesOrderID = SDSL.SalesDocumentID
    AND SOI.SalesOrderItemID = SDSL.SalesDocumentItem
WHERE SOI.[SDDocumentRejectionStatus] <> 'Fully Rejected'
