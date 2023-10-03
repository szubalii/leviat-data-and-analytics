SELECT
  CompanyCodeID,
  'NumOfCustomerInvoices' AS KPIName,
  FiscalYear,
  FiscalPeriod
  FiscalYearPeriod,
  COUNT(DISTINCT ReferenceDocument) AS KPIValue
FROM 
  [dm_finance].[vw_fact_ACDOCA_EPMSalesView]
WHERE
  AccountingDocumentTypeID IN ('RV')
  AND
  SourceLedgerID IN ('0L', 'OC')
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
