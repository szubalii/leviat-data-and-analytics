CREATE VIEW [edw].[vw_fact_GRIRAccountReconciliation_agg] AS

WITH By_OldestOpenItemPostingDate AS (
  SELECT
    CompanyCodeID,
    YEAR(ReportDate)       AS FiscalYear,
    MONTH(ReportDate)      AS FiscalPeriod,
    edw.svf_getYearPeriod(ReportDate) AS FiscalYearPeriod,
    CASE
      WHEN
        DATEDIFF(MONTH, OldestOpenItemPostingDate, ReportDate) > 2
      THEN
        COUNT(DISTINCT PurchasingDocument)
    END AS AgedGRPurchaseOrderCount,
    CASE
      WHEN
        DATEDIFF(MONTH, OldestOpenItemPostingDate, ReportDate) > 2
      THEN
        SUM(BalAmtInCompanyCodeCrcy)
    END AS AgedGRPurchaseOrdersAmount
  FROM
    [edw].[fact_GRIRAccountReconciliation]
  GROUP BY
    CompanyCodeID,
    ReportDate,
    OldestOpenItemPostingDate
)

SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  SUM(AgedGRPurchaseOrderCount) AS AgedGRPurchaseOrderCount,
  SUM(AgedGRPurchaseOrdersAmount) AS AgedGRPurchaseOrdersAmount
FROM
  By_OldestOpenItemPostingDate
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
