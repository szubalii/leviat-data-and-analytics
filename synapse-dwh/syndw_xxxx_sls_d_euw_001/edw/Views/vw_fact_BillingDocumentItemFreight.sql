CREATE VIEW [edw].[vw_fact_BillingDocumentItemFreight]
AS
SELECT
    BDI_TC.[ReferenceSDDocument]
    ,BDI_TC.[ReferenceSDDocumentItem]
    ,PE.[CurrencyID]                  AS TransactionCurrencyID
    ,SUM(PE.[ConditionAmount])        AS InvoicedFreightValueTransactionCurrency
FROM
    [edw].[fact_BillingDocumentItem] BDI_TC
LEFT JOIN
    [edw].[fact_BillingDocumentItemPrcgElmnt] PE
    ON BDI_TC.BillingDocument = PE.BillingDocument
      AND BDI_TC.BillingDocumentItem = PE.BillingDocumentItem
      AND PE.ConditionType in ( 'ZF10', 'ZF20', 'ZF40','ZF60', 'ZTMF')          -- ZF10 - Freight surchage %
WHERE                                                                           -- ZF20 - Min. Freight charges
    BDI_TC.[CurrencyTypeID] = '00'                                              -- ZF40 - Freight Charge- Pack
    AND PE.[CurrencyTypeID] = '00'                                              -- ZF60 - Man. Freight Charges
    --AND BDI_TC.Material='000000000070000011'      -- Freight                     ZTMF - Freight from SAP TM
    AND COALESCE( BDI_TC.BillingDocumentIsCancelled, '') = ''
    AND COALESCE( BDI_TC.CancelledBillingDocument, '') = ''
GROUP BY
    BDI_TC.[ReferenceSDDocument]
    ,BDI_TC.[ReferenceSDDocumentItem]
    ,PE.[CurrencyID]