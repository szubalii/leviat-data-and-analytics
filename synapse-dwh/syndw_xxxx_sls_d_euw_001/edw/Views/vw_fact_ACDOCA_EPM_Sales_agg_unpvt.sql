CREATE VIEW [edw].[vw_fact_ACDOCA_EPM_Sales_agg_unpvt] AS
SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  KPIName
  KPIValue
FROM (
  SELECT
    CompanyCodeID,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod,
    Sales,
    OtherCoSExclFreight,
    CustomerInvoicesCount,
    ICOutOfBalance
  FROM
    [edw].[vw_fact_ACDOCA_EPM_Sales_agg] agg
) a
UNPIVOT (
  KPIValue FOR KPIName IN (
    Sales,
    OtherCoSExclFreight,
    CustomerInvoicesCount,
    ICOutOfBalance
  )
) AS unpivot
