CREATE VIEW [edw].[vw_fact_VendorInvoice_ApprovedAndPosted_CUR] AS
SELECT
  VIM.DocumentLedgerID
, VIM.DocumentItemID
, VIM.CompanyCodeID
, VIM.PurchasingDocument
, VIM.PurchasingDocumentItem
, PDI.sk_fact_PurchasingDocumentItem
, VIM.MaterialID
, VIM.Quantity
, VIM.OrderUnit
, VIM.OrderPriceUnit
, VIM.NetAmount * CCR_EUR.ExchangeRate AS NetAmount_EUR
, VIM.NetAmount * CCR_USD.ExchangeRate AS NetAmount_USD
, VIM.PlantID
, VIM.DebitCreditIndicator
, VIM.ConditionType
, VIM.NetOrderPrice
, VIM.CostCenterID
, VIM.FinalInvoice
, VIM.GLAccountID
, VIM.OrderNumber
, VIM.LineItemText
, VIM.ControllingAreaID
, VIM.ProfitCenterID
, VIM.SalesDocument
, VIM.SalesDocumentItem
, VIM.ScheduleLineNumber
, VIM.TaxCode
, VIM.MaterialDocument
, VIM.MaterialDocumentYear
, VIM.MaterialDocumentItem
, VIM.ValuationAreaID
, VIM.QuantityOrdered
, VIM.QuantityInvoiced
, VIM.QuantityOfGoodsReceived
, VIM.HDR1_ObjectType
, VIM.HDR1_DocumentStatus
, VIM.HDR1_NotFirstPass
, VIM.HDR1_AccountingDocumentTypeID
, VIM.HDR1_FiscalYear
, VIM.HDR1_DocumentDate
, VIM.HDR1_PostingDate
, VIM.HDR1_SupplierID
, VIM.HDR1_ReferenceID
, VIM.HDR1_CurrencyID
, VIM.HDR1_HeaderText
, VIM.HDR1_CountryID
, VIM.HDR2_SupplierInvoiceID
, VIM.HDR2_AccountDocumentID
, VIM.HDR2_PostingUser
FROM
  [edw].[fact_VendorInvoice_ApprovedAndPosted] VIM
LEFT JOIN
  [edw].[vw_CurrencyConversionRate] CCR_EUR
    ON
      CCR_EUR.SourceCurrency = VIM.HDR1_CurrencyID
      AND
      CCR_EUR.CurrencyTypeID = '30'
LEFT JOIN
  [edw].[vw_CurrencyConversionRate] CCR_USD
    ON
      CCR_USD.SourceCurrency = VIM.HDR1_CurrencyID
      AND
      CCR_USD.CurrencyTypeID = '40'
LEFT JOIN
  [edw].[fact_PurchasingDocumentItem] PDI
    ON
      PDI.PurchasingDocument COLLATE DATABASE_DEFAULT = VIM.PurchasingDocument
      AND
      PDI.PurchasingDocumentItem COLLATE DATABASE_DEFAULT = VIM.PurchasingDocumentItem
