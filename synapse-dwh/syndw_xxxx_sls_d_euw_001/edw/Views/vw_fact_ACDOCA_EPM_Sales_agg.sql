CREATE VIEW [edw].[vw_fact_ACDOCA_EPM_Sales_agg] AS
WITH pre_filter AS (
  SELECT
    CompanyCodeID,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod,
    SalesAmount,
    CASE
      WHEN
        GrossMarginAmount <> 0
        AND
        GLAccountID NOT IN ('0055000100', '0055000110', '0055000120', '0055000130', '0055000160')
        AND
        FunctionalAreaID NOT IN ('DT141', 'DT142')
      THEN COALESCE(OpexAmount,0) + COALESCE(OtherCoSAmount,0)
    END AS OtherCoSExclFreight,
    CASE
      WHEN AccountingDocumentTypeID IN ('RV')
      THEN ReferenceDocument
    END AS CustomerInvoices,
    CASE
      WHEN
        PartnerCompanyID NOT LIKE ''
        AND
        GLAccountID IN (SELECT GLAccountID FROM base_ff.IC_ReconciliationGLAccounts)
      THEN Amount
    END AS ICOutOfBalance
  FROM
    [edw].[vw_fact_ACDOCA_EPMSalesView]
  WHERE
    SourceLedgerID IN ('0L', 'OC')
    AND
    CurrencyTypeID = '30'
)
SELECT
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  -- svf_getFinanceKPI_SalesAmount(SalesAmount, SourceLedgerID, CurrencyTypeID)
  SUM(SalesAmount)                  AS SalesAmount,
  SUM(OtherCoSExclFreight)          AS OtherCoSExclFreight,
  COUNT(DISTINCT CustomerInvoices)  AS CustomerInvoicesCount,
  SUM(ICOutOfBalance)               AS ICOutOfBalance
FROM
  pre_filter
GROUP BY
  CompanyCodeID,
  FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod
