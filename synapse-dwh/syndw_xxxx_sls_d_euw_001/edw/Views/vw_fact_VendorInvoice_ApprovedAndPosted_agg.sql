CREATE VIEW [edw].[vw_fact_VendorInvoice_ApprovedAndPosted_agg] AS
WITH GroupBy AS (
  SELECT
    CompanyCodeID,
    HDR1_FiscalYear,
    MONTH(HDR1_PostingDate)      AS FiscalPeriod,
    CONCAT(
      CAST(YEAR(HDR1_PostingDate)  AS VARCHAR)
      ,RIGHT(CONCAT('00',MONTH(HDR1_PostingDate)),3)
    ) AS FiscalYearPeriod,
    COUNT(DISTINCT HDR2_AccountingDocument) AS InvoicesCount,
    CASE
      WHEN HDR1_DocumentType IN ('PO_S4', 'ZPO_S4')
      THEN COUNT(DISTINCT HDR2_AccountingDocument)
    END AS POInvoicesCount,
    CASE
      WHEN HDR1_DocumentType IN ('NPO_S4', 'ZNPO_S4')
      THEN COUNT(DISTINCT HDR2_AccountingDocument)
    END AS NPOInvoicesCount,
    CASE
      WHEN HDR1_NotFirstPass IS NULL OR HDR1_NotFirstPass = ''
      THEN COUNT(DISTINCT HDR2_AccountingDocument)
    END AS FirstTimePassCount
  FROM
    [edw].[fact_VendorInvoice_ApprovedAndPosted]
  GROUP BY
    CompanyCodeID,
    HDR1_FiscalYear,
    HDR1_PostingDate,
    HDR1_DocumentType,
    HDR1_NotFirstPass
)

SELECT
  CompanyCodeID,
  HDR1_FiscalYear AS FiscalYear,
  FiscalPeriod,
  FiscalYearPeriod,
  SUM(InvoicesCount) AS InvoicesCount,
  SUM(POInvoicesCount) AS POInvoicesCount,
  SUM(NPOInvoicesCount) AS NPOInvoicesCount,
  SUM(FirstTimePassCount) AS FirstTimePassCount
FROM
  GroupBy
GROUP BY
  CompanyCodeID,
  HDR1_FiscalYear
