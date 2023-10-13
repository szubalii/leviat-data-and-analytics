CREATE VIEW [edw].[vw_fact_VendorInvoice_ApprovedAndPosted_agg] AS
SELECT
  CompanyCodeID,
  HDR1_FiscalYear,
  COUNT(DISTINCT HDR2_AccountingDocument) AS InvoicesCount,
  CASE
    WHEN HDR1_AccountingDocumentTypeID IN ('PO_S4, ZPO_S4')
    THEN COUNT(DISTINCT HDR2_AccountingDocument)
  END AS POInvoicesCount,
  CASE
    WHEN HDR1_AccountingDocumentTypeID IN ('NPO_S4, ZNPO_S4')
    THEN COUNT(DISTINCT HDR2_AccountingDocument)
  END AS NPOInvoicesCount,
  CASE
    WHEN HDR1_NotFirstPass IS NULL
    THEN COUNT(DISTINCT HDR2_AccountingDocument)
  END AS FirstTimePassCount
FROM
  [edw].[fact_VendorInvoice_ApprovedAndPosted]
GROUP BY
  CompanyCodeID,
  HDR1_FiscalYear,
  HDR1_AccountingDocumentTypeID,
  HDR1_NotFirstPass
