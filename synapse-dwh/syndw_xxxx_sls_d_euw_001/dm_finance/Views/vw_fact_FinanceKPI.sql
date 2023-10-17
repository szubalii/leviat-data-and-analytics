CREATE VIEW [dm_finance].[vw_fact_FinanceKPI] AS

WITH CompanyCodePeriod AS (

)



SELECT
  ccp.CompanyCodeID,
  ccp.FiscalYear,
  ccp.FiscalPeriod,
  ccp.FiscalYearPeriod,
  fin_agg.ManualJournalEntriesCount,
  fin_agg.ManualInventoryAdjustmentsCount,
  fin_agg.IC_Balance_KPI,
  oi.OpenInvoicedValue,
  vim.InvoicesCount,
  vim.POInvoicesCount,
  vim.NPOInvoicesCount,
  vim.FirstTimePassCount,
  gr.AgedGRPurchaseOrderCount,
  gr.AgedGRPurchaseOrdersAmount,
  sls.SOShippedNotBilledAmount
FROM
  CompanyCodePeriod

LEFT JOIN
  [edw].[vw_fact_ACDOCA_FinanceKPI_agg] fin_agg
  ON
    fin_agg.CompanyCodeID = ccp.CompanyCodeID
    AND
    fin_agg.FiscalYearPeriod = ccp.FiscalYearPeriod

LEFT JOIN
  [dm_finance].[vw_fact_ManualJournalEntriesCount] mj
  ON
    mj.CompanyCodeID = ccp.CompanyCodeID
    AND
    mj.FiscalYearPeriod = ccp.FiscalYearPeriod

LEFT JOIN
  [edw].[vw_fact_OpenInvoiced] oi
  ON
    oi.CompanyCodeID = ccp.CompanyCodeID
    AND
    oi.FiscalYearPeriod = ccp.FiscalYearPeriod

LEFT JOIN
  [edw].[vw_fact_VendorInvoice_ApprovedAndPosted_agg] vim
  ON
    vim.CompanyCodeID = ccp.CompanyCodeID
    AND
    vim.FiscalYearPeriod = ccp.FiscalYearPeriod

LEFT JOIN
  [edw].[vw_fact_GRIRAccountReconciliation_agg] gr
  ON
    gr.CompanyCodeID = ccp.CompanyCodeID
    AND
    gr.FiscalYearPeriod = ccp.FiscalYearPeriod

LEFT JOIN
  [edw].[vw_fact_ScheduleLineShippedNotBilled_agg] sls
  ON
    sls.CompanyCodeID = ccp.CompanyCodeID
    AND
    sls.FiscalYearPeriod = ccp.FiscalYearPeriod
