CREATE VIEW [dm_procurement].[vw_fact_VendorInvoice_ApprovedAndPosted]
AS
SELECT
  DocumentLedgerID
, DocumentItemID
, CompanyCodeID
, PurchasingDocument
, PurchasingDocumentItem
, sk_fact_PurchasingDocumentItem
, MaterialID
, Quantity
, OrderUnit
, OrderPriceUnit
, NetAmount_EUR
, NetAmount_USD
, PlantID
, DebitCreditIndicator
, ConditionType
, NetOrderPrice
, CostCenterID
, FinalInvoice
, GLAccountID
, OrderNumber
, LineItemText
, ControllingAreaID
, ProfitCenterID
, SalesDocument
, SalesDocumentItem
, ScheduleLineNumber
, TaxCode
, MaterialDocument
, MaterialDocumentYear
, MaterialDocumentItem
, ValuationAreaID
, QuantityOrdered
, QuantityInvoiced
, QuantityOfGoodsReceived
, HDR1_ObjectType
, HDR1_DocumentStatus
, HDR1_NotFirstPass
, HDR1_AccountingDocumentTypeID
, HDR1_FiscalYear
, HDR1_DocumentDate
, HDR1_PostingDate
, HDR1_SupplierID
, HDR1_ReferenceID
, HDR1_CurrencyID
, HDR1_HeaderText
, HDR1_CountryID
, HDR2_SupplierInvoiceID
, HDR2_AccountingDocument
, HDR2_PostingUser
FROM
  [edw].[vw_fact_VendorInvoice_ApprovedAndPosted_CUR]
