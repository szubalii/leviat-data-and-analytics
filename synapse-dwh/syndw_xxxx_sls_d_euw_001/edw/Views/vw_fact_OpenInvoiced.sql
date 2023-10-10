CREATE VIEW [edw].[vw_fact_OpenInvoiced] AS
SELECT
  SO.BillingCompanyCodeID AS CompanyCodeID,
  YEAR(SO.BillingDocumentDate) AS FiscalYear,
  MONTH(SO.BillingDocumentDate) AS FiscalPeriod,
  CONCAT(YEAR(SO.BillingDocumentDate), '0', MONTH(SO.BillingDocumentDate)) AS FiscalYearPeriod,
  'OpenInvoicedValue' AS KPIName,
  SUM(SL.OpenInvoicedValue) AS KPIValue
FROM
  [edw].[vw_fact_ScheduleLineStatus] SL
LEFT JOIN
  [edw].[vw_fact_SalesOrderItem] SO
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
