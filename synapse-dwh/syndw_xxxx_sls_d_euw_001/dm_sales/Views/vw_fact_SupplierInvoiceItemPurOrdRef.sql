CREATE VIEW [dm_sales].[vw_fact_SupplierInvoiceItemPurOrdRef]
AS
SELECT
    [SupplierInvoice],
    [FiscalYear],
    [SupplierInvoiceItem],
    [sk_fact_PurchasingDocumentItem],
    [PurchaseOrder],
    [PurchaseOrderItem],
    [PurchasingDocumentItemShortText],
    [QuantityInPurchaseOrderUnit],
    [PurchaseOrderQuantityUnit],
    [SupplierInvoiceItemAmount],
    [DocumentCurrencyID]
FROM
    [edw].[fact_SupplierInvoiceItemPurOrdRef]
