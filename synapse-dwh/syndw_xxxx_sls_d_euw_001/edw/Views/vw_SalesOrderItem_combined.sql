CREATE VIEW [edw].[vw_SalesOrderItem_combined]
AS
SELECT
     SDI.[SalesDocument]
    ,SDI.[SalesDocumentItem]
    ,SDI.[SalesDocumentTypeID]
    ,edw.[svf_getOrderStatus] (BDI.BillingDocument,SDI.SalesDocumentTypeID,SDI.OrderStatus) AS OrderStatus
    ,edw.[svf_getOrderStatus] (BDI.BillingDocumentItem,SDI.SalesDocumentTypeID,SDI.ItemOrderStatus) AS ItemOrderStatus
    ,BDI.[BillingDocument]                      
    ,BDI.[BillingDocumentItem]                  
    ,BDI.[CurrencyTypeID]      
    ,BDI.[BillingDocumentTypeID]                
    ,BDI.[BillingDocumentCategoryID]            
    ,BDI.[SDDocumentCategoryID]                 
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
    ,BDI.[SDDocumentCategory]     
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
        ELSE SDI.RequestedDeliveryDate
     END  as ExpectedDeliveryDate
    ,SDI.[t_applicationId]
    ,SDI.[t_extractionDtm]
FROM [edw].[fact_SalesDocumentItem] SDI
LEFT JOIN [edw].[vw_BillingDocumentItem_for_SalesDocumentItem] BDI
    ON SDI.SalesDocument = BDI.SalesDocumentID
    AND SDI.SalesDocumentItem = BDI.SalesDocumentItemID
    AND SDI.CurrencyTypeID = BDI.CurrencyTypeID
LEFT JOIN [edw].[dim_SalesDocumentScheduleLine] SDSL
    ON SDI.SalesDocument = SDSL.SalesDocumentID
    AND SDI.SalesDocumentItem = SDSL.SalesDocumentItem
WHERE SDI.[SDDocumentRejectionStatusID] <> 'Fully Rejected'