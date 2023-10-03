SELECT
  CompanyCodeID,
  'ICOutOfBalance' AS KPIName,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  SUM(Amount) AS KPIValue 
FROM
  [edw].[vw_fact_ACDOCA_EPM_Base]
WHERE
  GLAccountID IN (
    '0015112100',
    '0015112105',
    '0015112110',
    '0015112199',
    '0018300100',
    '0021102100',
    '0021102101',
    '0021102110',
    '0021102111',
    '0021102198',
    '0021102199',
    '0021390121',
    '0026200100',
    '0035200100',
    '0035500100',
    '0035500101',
    '0035600100',
    '0035700100',
    '0035800100'
  )
  AND
  PartnerCompanyID NOT LIKE ''
  AND
  SourceLedgerID IN ('0L', 'OC')
  AND
  CurrencyTypeID = '30'
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
