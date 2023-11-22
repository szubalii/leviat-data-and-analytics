CREATE VIEW [edw].[vw_fact_ACDOCA_FinanceKPI_agg] AS

WITH ManualInventoryAdjustmentsCount AS (
  SELECT
    [CompanyCodeID],
    [FiscalYear],
    [FiscalPeriod],
    [FiscalYearPeriod],
    CASE
      WHEN [Manual_JE_KPI] IS NOT NULL
        THEN [AccountingDocument]
    END                                   AS [Manual_JE_KPIAccountingDocument],
    CASE 
      WHEN Inventory_Adj_KPI IS NOT NULL
        THEN CONCAT([AccountingDocument], [LedgerGLLineItem])
    END                                   AS [ManualInventoryAdjustmentsCount],
    IC_Balance_KPI
  FROM
    [edw].[vw_fact_ACDOCA_EPM_Base]
)

SELECT
  [CompanyCodeID],
  [FiscalYear],
  [FiscalPeriod],
  [FiscalYearPeriod],
  COUNT(DISTINCT [Manual_JE_KPIAccountingDocument]) AS [ManualJournalEntriesCount],
  SUM([ManualInventoryAdjustmentsCount])            AS [ManualInventoryAdjustmentsCount],
  SUM([IC_Balance_KPI])                             AS [IC_Balance_KPI]
FROM
  ManualInventoryAdjustmentsCount
GROUP BY
  [CompanyCodeID],
  [FiscalYear],
  [FiscalPeriod],
  [FiscalYearPeriod]
