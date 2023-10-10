CREATE VIEW [edw].[vw_fact_ACDOCA_EPM_OtherCOS] AS
SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  SUM(OpexAmount) + SUM(OtherCoSAmount) AS OtherCoSExclFreight
FROM
  [edw].[vw_fact_ACDOCA_EPMSalesView]
WHERE
  GrossMarginAmount <> 0
  AND
  GLAccountID NOT IN ('0055000100', '0055000110', '0055000120', '0055000130', '0055000160')
  AND
  FunctionalAreaID NOT IN ('DT141', 'DT142')
  AND
  SourceLedgerID IN ('0L', 'OC')
  AND
  CurrencyTypeID = '30'
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
