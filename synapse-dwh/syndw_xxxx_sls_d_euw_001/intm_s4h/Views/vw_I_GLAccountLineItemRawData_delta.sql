CREATE VIEW [intm_s4h].[vw_I_GLAccountLineItemRawData_delta]
AS

-- Add row_number based on t_extractionDtm, TS_SEQUENCE_NUMBER
-- the lower row_number - the freshest date
-- ordering on t_extractionDtm get the latest load
-- ordering on TS_SEQUENCE_NUMBER get the latest record in a load
WITH add_rn AS (
  SELECT *
    , ROW_NUMBER () OVER (
        PARTITION BY
          MANDT,
          [SourceLedger],
          [CompanyCode],
          [FiscalYear],
          [AccountingDocument],
          [LedgerGLLineItem]
        ORDER BY
          [t_extractionDtm] DESC,
          [TS_SEQUENCE_NUMBER] DESC
        ) AS rn
  FROM [intm_s4h].[I_GLAccountLineItemRawData_delta]
)
-- leave only the latest records
SELECT *
FROM add_rn
WHERE rn=1