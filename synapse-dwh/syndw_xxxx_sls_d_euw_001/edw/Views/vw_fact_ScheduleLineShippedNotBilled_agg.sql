CREATE VIEW [edw].[vw_fact_ScheduleLineShippedNotBilled_agg] AS
SELECT
  CompanyCodeID,
  YEAR(ReportDate)                  AS FiscalYear,
  MONTH(ReportDate)                 AS FiscalPeriod,
  edw.svf_getYearPeriod(ReportDate) AS FiscalYearPeriod,
  SUM(OpenInvoicedValue)            AS SOShippedNotBilledAmount
FROM
  [edw].[fact_ScheduleLineShippedNotBilled]
WHERE
  DATEDIFF(MONTH, SDI_ODB_LatestActualGoodsMovmtDate, ReportDate) > 2
GROUP BY
  CompanyCodeID,
  YEAR(ReportDate),                 
  MONTH(ReportDate),                
  edw.svf_getYearPeriod(ReportDate)
