CREATE VIEW [dm_sales].[vw_fact_SupplierInvoiceItemPurOrdRef]
  AS 
  SELECT 
    [SupplierInvoice],              
    [FiscalYear],                     
    [SupplierInvoiceItem],          
    [PurchaseOrder],                
    [PurchaseOrderItem]           
  FROM
    [edw].[fact_SupplierInvoiceItemPurOrdRef]
