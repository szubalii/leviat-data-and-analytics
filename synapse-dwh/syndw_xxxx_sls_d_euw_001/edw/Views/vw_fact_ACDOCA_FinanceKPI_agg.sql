CREATE VIEW [edw].[vw_fact_ACDOCA_FinanceKPI_agg] AS

WITH ManualInventoryAdjustmentsCount AS (
  SELECT
    [CompanyCodeID],
    [FiscalYear],
    [FiscalPeriod],
    [FiscalYearPeriod],
    [AccountingDocument],
    COUNT(DISTINCT LedgerGLLineItem) AS ManualInventoryAdjustmentsCount,
    SUM(IC_Balance_KPI) AS IC_Balance_KPI
  FROM
    [edw].[vw_fact_ACDOCA_EPM_Base]
  GROUP BY
    [CompanyCodeID],
    [FiscalYear],
    [FiscalPeriod],
    [FiscalYearPeriod],
    [AccountingDocument]
)

SELECT
  [CompanyCodeID],
  [FiscalYear],
  [FiscalPeriod],
  [FiscalYearPeriod],
  COUNT(DISTINCT AccountingDocument) AS ManualJournalEntriesCount,
  SUM(ManualInventoryAdjustmentsCount) AS ManualInventoryAdjustmentsCount,
  SUM(IC_Balance_KPI) AS IC_Balance_KPI
FROM
  ManualInventoryAdjustmentsCount
GROUP BY
  [CompanyCodeID],
  [FiscalYear],
  [FiscalPeriod],
  [FiscalYearPeriod]
