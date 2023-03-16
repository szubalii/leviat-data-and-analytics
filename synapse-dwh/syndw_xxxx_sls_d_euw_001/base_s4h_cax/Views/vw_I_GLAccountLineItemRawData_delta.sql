CREATE VIEW [base_s4h_cax].[vw_I_GLAccountLineItemRawData_delta]
AS

-- As multiple updates can exist on the same document,
-- apply group by and max on TS_SEQUENCE_NUMBER to only 
-- take the most recent change
SELECT *
FROM base_s4h_cax.I_GLAccountLineItemRawData_delta
WHERE TS_SEQUENCE_NUMBER IN (
  SELECT MAX(TS_SEQUENCE_NUMBER) AS TS_SEQUENCE_NUMBER
  FROM base_s4h_cax.I_GLAccountLineItemRawData_delta
  GROUP BY
    MANDT,
    [SourceLedger],
    [CompanyCode],
    [FiscalYear],
    [AccountingDocument],
    [LedgerGLLineItem]
)