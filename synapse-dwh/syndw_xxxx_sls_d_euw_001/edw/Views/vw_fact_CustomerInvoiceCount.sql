CREATE VIEW [edw].[vw_fact_CustomerInvoiceCount] AS
SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod
  FiscalYearPeriod,
  'NumOfCustomerInvoices' AS KPIName,
  COUNT(DISTINCT ReferenceDocument) AS KPIValue
FROM 
  [edw].[vw_fact_ACDOCA_EPMSalesView]
WHERE
  AccountingDocumentTypeID IN ('RV')
  AND
  SourceLedgerID IN ('0L', 'OC')
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
