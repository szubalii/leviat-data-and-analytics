CREATE VIEW [dm_finance].[vw_fact_FinanceKPI] AS
SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  ICOutOfBalance--KPIName
  -- KPIValue
FROM
  [edw].[vw_fact_ACDOCA_EPM_Sales_agg]

UNION

SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  ManualJournalEntriesCount--KPIName
  -- KPIValue
FROM
  [edw].[vw_fact_ManualJournalEntriesCount]

UNION

SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  OpenInvoicedValue--KPIName
  -- KPIValue
FROM
  [edw].[vw_fact_OpenInvoiced]

UNION

SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  InvoicesCount,
  POInvoicesCount,
  NPOInvoicesCount,
  FirstTimePassCount
  -- KPIName
  -- KPIValue
FROM
  [edw].[vw_fact_VendorInvoice_ApprovedAndPosted_agg]

UNION

SELECT
  CASE
    WHEN
      DATEDIFF(MONTH, ReportDate, OldestOpenItemPostingDate) > 2
    THEN
      COUNT(DISTINCT PurchasingDocument)
  END AS AgedGRPurchaseOrderCount,
  CASE
    WHEN
      DATEDIFF(MONTH, ReportDate, OldestOpenItemPostingDate) > 2
    THEN
      SUM(BalAmtInCompanyCodeCry)
  END AS AmountAgedGRPurchaseOrders
FROM
  [edw].[fact_GRIRAccountReconciliation]

UNION

SELECT
  CASE
    WHEN
      DATEDIFF(MONTH, ReportDate, ActualGoodsMovementDate) > 2
    THEN
      SUM(OpenInvoicedValue)
  END AS SONotBilledAmount
FROM
  [edw].[vw_fact_ScheduleLineShippedNotBilled]
