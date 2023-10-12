CREATE VIEW [edw].[vw_fact_ScheduleLineShippedNotBilled_agg] AS

WITH By_HDR_ActualGoodsMovementDate AS (
  SELECT
    NULL AS CompanyCodeID, --TODO, where to get CompanyCodeID value from?
    YEAR(ReportDate) AS FiscalYear,
    MONTH(ReportDate) AS FiscalPeriod,
    NULL AS FiscalYearPeriod,
    CASE
      WHEN
        DATEDIFF(MONTH, HDR_ActualGoodsMovementDate, ReportDate) > 2
      THEN
        SUM(OpenInvoicedValue)
    END AS SOShippedNotBilledAmount
  FROM
    [edw].[fact_ScheduleLineShippedNotBilled]
  GROUP BY
    ReportDate,
    HDR_ActualGoodsMovementDate
)

SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  SUM(SOShippedNotBilledAmount) AS SOShippedNotBilledAmount
FROM
  By_HDR_ActualGoodsMovementDate
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
