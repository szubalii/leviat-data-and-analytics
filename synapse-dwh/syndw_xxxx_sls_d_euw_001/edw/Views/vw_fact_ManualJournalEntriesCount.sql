SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  'ManualJournalEntriesCount' AS KPIName,
  COUNT (DISTINCT AccountingDocument) AS KPIValue
FROM
  [edw].[vw_fact_ACDOCA_EPM_Base]
WHERE
  AccountingDocumentTypeID IN ('SA', 'JR', 'AB')
  AND
  BusinessTransactionTypeID IN ('RFBU', 'RFPT', 'RFCL', 'AZUM', 'RFCV')
  AND
  ReferenceDocumentTypeID IN ('BKPFF', 'BKPF')
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
