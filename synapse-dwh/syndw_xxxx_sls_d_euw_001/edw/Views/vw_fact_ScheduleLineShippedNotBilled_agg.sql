CREATE VIEW [edw].[vw_fact_ScheduleLineShippedNotBilled_agg] AS

WITH By_SDI_ODB_LatestActualGoodsMovmtDate AS (
  SELECT
    CompanyCode,
    YEAR(ReportDate) AS FiscalYear,
    MONTH(ReportDate) AS FiscalPeriod,
    CONCAT(
      CAST(YEAR(ReportDate) AS VARCHAR),
      RIGHT(CONCAT('00',CAST(MONTH(ReportDate) AS VARCHAR)),3)          -- pad month to 3 digits
    ) AS FiscalYearPeriod,
    CASE
      WHEN
        DATEDIFF(MONTH, SDI_ODB_LatestActualGoodsMovmtDate, ReportDate) > 2
      THEN
        SUM(OpenInvoicedValue)
    END AS SOShippedNotBilledAmount
  FROM
    [edw].[fact_ScheduleLineShippedNotBilled]
  GROUP BY
    CompanyCodeID,
    ReportDate,
    SDI_ODB_LatestActualGoodsMovmtDate
)

SELECT
  CompanyCode                   AS CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  SUM(SOShippedNotBilledAmount) AS SOShippedNotBilledAmount
FROM
  By_SDI_ODB_LatestActualGoodsMovmtDate
GROUP BY
  CompanyCode,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
