CREATE VIEW [dm_finance].[vw_fact_FinanceKPI] AS
SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  KPIName
  KPIValue
FROM
  [edw].[vw_fact_ACDOCA_EPM_Sales_agg_unpvt]

UNION

SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  KPIName
  KPIValue
FROM
  [edw].[vw_fact_ManualJournalEntriesCount]

UNION

SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  KPIName
  KPIValue
FROM
  [edw].[vw_fact_OpenInvoiced]

