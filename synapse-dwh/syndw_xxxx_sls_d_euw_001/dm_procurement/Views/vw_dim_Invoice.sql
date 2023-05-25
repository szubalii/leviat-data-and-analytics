CREATE VIEW [dm_procurement].[vw_dim_Invoice]
AS
SELECT
    SIIPOR.SupplierInvoice              AS InvoiceId
    ,''                                 AS ExtraInvoiceKey
    ,SIIPOR.SupplierInvoiceItem         AS InvoiceLineNumber
    ,''                                 AS ExtraInvoiceLineKey
    ,''                                 AS SplitAccountingNumber
    ,Invoice.PostingDate                AS AccountingDate
    ,SIIPOR.QuantityInPurchaseOrderUnit AS Quantity
    ,SIIPOR.SupplierInvoiceItemAmount   AS Amount
    ,Invoice.DocumentCurrencyID         AS AmountCurrency
    ,SIIPOR.PurchasingDocumentItemShortText AS Description
    ,PDI.MaterialGroupID                AS CommodityId
    ,REPLACE(LTRIM(REPLACE(PDI.MaterialID,'0',' ')),' ','0')
                                        AS PartNumber
    ,''                                 AS PartRevisionNumber
    ,PDI.OrderPriceUnit                 AS UnitOfMeasure
    ,REPLACE(LTRIM(REPLACE(PD.SupplierID,'0',' ')),' ','0')
                                        AS SupplierId
    ,''                                 AS SupplierLocationId
    ,PD.CreatedByUser                   AS RequesterId
    ,REPLACE(LTRIM(REPLACE(PDI.GLAccountID,'0',' ')),' ','0')
                                        AS AccountId
    ,''                                 AS AccountCompanyCode
    ,PD.PurchasingOrganizationID        AS CompanySiteId
    ,PDI.CostCenterID                   AS CostCenterId
    ,PDI.CompanyCodeID                  AS CostCenterCompanyCode
    ,PDI.PurchaseContract               AS ContractId
    ,SIIPOR.PurchaseOrder               AS POId
    ,''                                 AS ExtraPOKey
    ,SIIPOR.PurchaseOrderItem           AS POLineNumber
    ,''                                 AS ExtraPOLineKey
    ,Invoice.CreationDate               AS InvoiceDate
    ,''                                 AS PaidDate
    ,SIIPOR.SupplierInvoice             AS InvoiceNumber
    ,''                                 AS APPaymentTerms
    ,''                                 AS LineType
    ,''                                 AS FlexFieldId1
    ,''                                 AS FlexFieldId2
    ,''                                 AS FlexFieldId3
    ,''                                 AS FlexFieldId4
    ,''                                 AS FlexFieldId5
    ,''                                 AS FlexFieldId6
    ,''                                 AS FlexFieldId7
    ,''                                 AS FlexFieldId8
    ,''                                 AS FlexFieldId9
    ,''                                 AS FlexFieldId10
    ,''                                 AS FlexFieldId11
    ,''                                 AS FlexFieldId12
    ,''                                 AS FlexFieldId13
    ,''                                 AS FlexFieldId14
    ,''                                 AS FlexMeasure1
    ,''                                 AS FlexMeasure2
    ,''                                 AS FlexMeasure3
    ,''                                 AS FlexMeasure4
    ,''                                 AS FlexMeasure5
    ,''                                 AS FlexDate1
    ,''                                 AS FlexDate2
    ,''                                 AS FlexDate3
    ,''                                 AS FlexDate4
    ,''                                 AS FlexDate5
    ,''                                 AS FlexString1
    ,''                                 AS FlexString2
    ,''                                 AS FlexString3
    ,''                                 AS FlexString4
    ,''                                 AS FlexString5
    ,''                                 AS FlexString6
    ,''                                 AS FlexString7
    ,''                                 AS FlexString8
    ,''                                 AS FlexString9
    ,''                                 AS FlexString10
FROM [edw].[fact_PurchasingDocumentItem]                        PDI 
JOIN [edw].[fact_PurchasingDocument]                            PD
    ON PDI.PurchasingDocument = PD.PurchasingDocument
LEFT JOIN [edw].[fact_SupplierInvoiceItemPurOrdRef]             SIIPOR
    ON PDI.sk_fact_PurchasingDocumentItem = SIIPOR.sk_fact_PurchasingDocumentItem
LEFT JOIN [edw].[fact_SupplierInvoice]                          Invoice
    ON SIIPOR.SupplierInvoice = Invoice.SupplierInvoiceID
