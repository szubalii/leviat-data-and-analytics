CREATE VIEW [edw].[vw_fact_ACDOCA_EPM_Sales_agg] AS
SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  -- svf_getFinanceKPI_SalesAmount(SalesAmount, SourceLedgerID, CurrencyTypeID)
  SUM(SalesAmount) AS SalesAmount,
  CASE
    WHEN
      GrossMarginAmount <> 0
      AND
      GLAccountID NOT IN ('0055000100', '0055000110', '0055000120', '0055000130', '0055000160')
      AND
      FunctionalAreaID NOT IN ('DT141', 'DT142')
    THEN SUM(OpexAmount) + SUM(OtherCoSAmount)
  END AS OtherCoSExclFreight,
  CASE
    WHEN AccountingDocumentTypeID IN ('RV')
    THEN COUNT(DISTINCT ReferenceDocument)
  END AS NumOfCustomerInvoices,
  CASE
    WHEN
      PartnerCompanyID NOT LIKE ''
      AND
      GLAccountID IN (SELECT GLAccountID FROM base_ff.IC_ReconciliationGLAccounts)
    THEN SUM(Amount)
  END AS ICOutOfBalance
  --TODO should ICOutOfBalance be based on edw.vw_fact_ACDOCA_EPMSalesView or edw.vw_fact_ACDOCA_EPM_Base
FROM
  [edw].[vw_fact_ACDOCA_EPMSalesView]
WHERE
  SourceLedgerID IN ('0L', 'OC')
  AND
  CurrencyTypeID = '30'
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
