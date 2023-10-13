CREATE VIEW [edw].[vw_fact_VendorInvoice_ApprovedAndPosted_agg] AS
SELECT
  CompanyCodeID,
  HDR1_FiscalYear,
  COUNT(DISTINCT HDR2_AccountingDocument) AS InvoicesCount,
  CASE
    WHEN DocumentType IN ('PO_S4, ZPO_S4')
    THEN COUNT(DISTINCT HDR2_AccountingDocument)
  END AS POInvoicesCount,
  CASE
    WHEN DocumentType IN ('NPO_S4, ZNPO_S4')
    THEN COUNT(DISTINCT HDR2_AccountingDocument)
  END AS NPOInvoicesCount,
  CASE
    WHEN HDR1_NotFirstPass IS NULL
    THEN COUNT(DISTINCT HDR2_AccountingDocument)
  END AS FirstTimePassCount
FROM
  [edw].[fact_VendorInvoice_ApprovedAndPosted]
