SELECT
  SO.BillingCompanyCodeID AS CompanyCodeID,
  'OpenInvoicedValue' AS KPIName,
  YEAR(SO.BillingDocumentDate) AS FiscalYear,
  MONTH(SO.BillingDocumentDate) AS FiscalPeriod,
  CONCAT(YEAR(SO.BillingDocumentDate), '0', MONTH(SO.BillingDocumentDate)) AS FiscalYearPeriod,
  SUM(SL.OpenInvoicedValue) AS KPIValue
FROM
  [dm_sales].[vw_fact_ScheduleLineStatus] SL
LEFT JOIN
  [dm_sales].[vw_fact_SalesOrderItem] SO
  ON
    SL.nk_fact_SalesDocumentItem = SO.nk_fact_SalesDocumentItem --TODO, correct key?
WHERE
  SLDeliveryStatus IN ('P', 'C')
  AND
  SLInvoicedStatus IN ('P', 'N')
  AND
  SL.CurrencyTypeID = '30'
GROUP BY
  SO.BillingCompanyCodeID,
  YEAR(SO.BillingDocumentDate),
  MONTH(SO.BillingDocumentDate),
  CONCAT(YEAR(SO.BillingDocumentDate), '0', MONTH(SO.BillingDocumentDate))
