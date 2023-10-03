CREATE VIEW [edw].[vw_fact_ACDOCA_EPM_Sales_agg] AS
SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  SUM(SalesAmount) AS Sales
FROM
  dm_finance.vw_fact_ACDOCA_EPMSalesView
WHERE
  SourceLedgerID IN ('0L', 'OC')
  AND
  CurrencyTypeID = '30'
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
