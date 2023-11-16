CREATE VIEW [edw].[vw_fact_GRIRAccountReconciliation_agg]
AS
SELECT
  CompanyCodeID,
  YEAR(ReportDate)       AS FiscalYear,
  MONTH(ReportDate)      AS FiscalPeriod,
  edw.svf_getYearPeriod(ReportDate) AS FiscalYearPeriod,
  COUNT(DISTINCT PurchasingDocument)AS AgedGRPurchaseOrderCount,
  SUM(BalAmtInCompanyCodeCrcy)      AS AgedGRPurchaseOrdersAmount
FROM
  [edw].[fact_GRIRAccountReconciliation]
WHERE
  DATEDIFF(MONTH, OldestOpenItemPostingDate, ReportDate) > 2
GROUP BY
  CompanyCodeID,
  YEAR(ReportDate),
  MONTH(ReportDate),
  edw.svf_getYearPeriod(ReportDate)