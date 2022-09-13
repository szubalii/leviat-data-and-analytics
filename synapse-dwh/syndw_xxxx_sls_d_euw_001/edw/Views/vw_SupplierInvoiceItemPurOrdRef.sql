CREATE VIEW [edw].[vw_SupplierInvoiceItemPurOrdRef]
  AS 
  SELECT         
    SIIPOR.[SupplierInvoice],                
    SIIPOR.[FiscalYear],           
    SIIPOR.[SupplierInvoiceItem],    
    factPDI.[sk_fact_PurchasingDocumentItem],        
    SIIPOR.[PurchaseOrder],                  
    SIIPOR.[PurchaseOrderItem],              
    SIIPOR.[Plant],                
    SIIPOR.[SupplierInvoiceItemText],        
    SIIPOR.[PurchaseOrderItemMaterial],      
    SIIPOR.[PurchaseOrderQuantityUnit],      
    SIIPOR.[QuantityInPurchaseOrderUnit],    
    SIIPOR.[PurchaseOrderPriceUnit],         
    SIIPOR.[QtyInPurchaseOrderPriceUnit],    
    SIIPOR.[SuplrInvcDeliveryCostCndnType],  
    SIIPOR.[SuplrInvcDeliveryCostCndnStep],  
    SIIPOR.[SuplrInvcDeliveryCostCndnCount], 
    SIIPOR.[DocumentCurrency],               
    SIIPOR.[SupplierInvoiceItemAmount],      
    SIIPOR.[IsSubsequentDebitCredit],        
    SIIPOR.[TaxCode],                        
    SIIPOR.[TaxJurisdiction],                
    SIIPOR.[ReferenceDocument],              
    SIIPOR.[ReferenceDocumentFiscalYear],    
    SIIPOR.[ReferenceDocumentItem],          
    SIIPOR.[DebitCreditCode],                
    SIIPOR.[FreightSupplier],                
    SIIPOR.[IsNotCashDiscountLiable],        
    SIIPOR.[SuplrInvcItemHasPriceVariance],  
    SIIPOR.[SuplrInvcItemHasQtyVariance],    
    SIIPOR.[SuplrInvcItemHasDateVariance],   
    SIIPOR.[SuplrInvcItemHasOrdPrcQtyVarc],  
    SIIPOR.[SuplrInvcItemHasOtherVariance],  
    SIIPOR.[SuplrInvcItemHasAmountOutsdTol], 
    SIIPOR.[SuplrInvcItmHasQualityVariance], 
    SIIPOR.[IsOnlineSupplierInvoiceItem],   
    SIIPOR.[t_applicationId],
    SIIPOR.[t_extractionDtm]
  FROM 
    [base_s4h_cax].[I_SupplierInvoiceItemPurOrdRef]  SIIPOR
  LEFT JOIN 
    [edw].[fact_PurchasingDocumentItem] factPDI
    ON 
      SIIPOR.[PurchaseOrder] = factPDI.[PurchasingDocument]
      AND     
      SIIPOR.[PurchaseOrderItem] = factPDI.[PurchasingDocumentItem]
  JOIN 
    [edw].[fact_SupplierInvoice] fact_SpI 
    ON 
      fact_SpI.[SupplierInvoiceID] = SIIPOR.[SupplierInvoice]
      AND
      fact_SpI.[FiscalYear] = SIIPOR.[FiscalYear]