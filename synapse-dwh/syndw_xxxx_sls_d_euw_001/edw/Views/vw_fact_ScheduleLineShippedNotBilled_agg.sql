CREATE VIEW [edw].[vw_fact_ScheduleLineShippedNotBilled_agg] AS

WITH By_SDI_ODB_LatestActualGoodsMovmtDate AS (
  SELECT
    NULL AS CompanyCodeID, --TODO, where to get CompanyCodeID value from?
    YEAR(ReportDate) AS FiscalYear,
    MONTH(ReportDate) AS FiscalPeriod,
    NULL AS FiscalYearPeriod,
    CASE
      WHEN
        DATEDIFF(MONTH, SDI_ODB_LatestActualGoodsMovmtDate, ReportDate) > 2
      THEN
        SUM(OpenInvoicedValue)
    END AS SOShippedNotBilledAmount
  FROM
    [edw].[fact_ScheduleLineShippedNotBilled]
  GROUP BY
    ReportDate,
    SDI_ODB_LatestActualGoodsMovmtDate
)

SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  SUM(SOShippedNotBilledAmount) AS SOShippedNotBilledAmount
FROM
  By_SDI_ODB_LatestActualGoodsMovmtDate
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
