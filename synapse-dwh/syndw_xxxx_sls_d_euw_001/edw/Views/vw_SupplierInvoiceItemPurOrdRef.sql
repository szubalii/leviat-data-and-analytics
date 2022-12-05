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
  CASE WHEN SuplrInvcDeliveryCostCndnType = ''
    THEN factPDI.[PurchasingDocumentItemText]
    ELSE COND.[ACMPRICINGCONDITIONTYPENAME]
        END AS PurchasingDocumentItemShortText,
  factPDI.[PurchasingDocumentItemText],
  SIIPOR.[PurchaseOrderItemMaterial],
  SIIPOR.[PurchaseOrderQuantityUnit],
  SIIPOR.[QuantityInPurchaseOrderUnit],
  SIIPOR.[PurchaseOrderPriceUnit],
  SIIPOR.[QtyInPurchaseOrderPriceUnit],
  SIIPOR.[SuplrInvcDeliveryCostCndnType],
  SIIPOR.[SuplrInvcDeliveryCostCndnStep],
  SIIPOR.[SuplrInvcDeliveryCostCndnCount],
  SIIPOR.[DocumentCurrency] AS [DocumentCurrencyID],
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
  [base_s4h_cax].[I_SupplierInvoiceItemPurOrdRef] AS SIIPOR
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


 LEFT OUTER JOIN [edw].[fact_PurchasingDocument] factPD
 ON
    SIIPOR.PurchaseOrder = factPD.PurchasingDocument


 LEFT OUTER JOIN [base_s4h_cax].[I_PricingElement] PRC 
 ON
    factPD.PurchasingDocumentCondition = PRC.PricingDocument
    AND 
    --FB 01-12-22: Added leading 0 to accomodate structure difference between Purchase Order Item and Pricing Document Item.
    CONCAT('0',SIIPOR.PurchaseOrderItem) = PRC.PricingDocumentItem 
    AND 
    SIIPOR.SuplrInvcDeliveryCostCndnType = PRC.ConditionType


 LEFT OUTER JOIN [base_s4h_cax].[P_ConditionTypeText] COND 
 ON 
    COND.KSCHL = SIIPOR.SuplrInvcDeliveryCostCndnType
    AND 
    COND.KAPPL = PRC.ConditionApplication
    AND
    COND.SPRAS = 'E'