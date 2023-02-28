CREATE VIEW [base_s4h_cax].[vw_C_SalesDocumentItemDEX_delta]
AS

-- As multiple updates can exist on the same document,
-- apply group by and max on TS_SEQUENCE_NUMBER to only 
-- take the most recent change
SELECT *
FROM base_s4h_cax.C_SalesDocumentItemDEX_delta
WHERE TS_SEQUENCE_NUMBER IN (
  SELECT MAX(TS_SEQUENCE_NUMBER) AS TS_SEQUENCE_NUMBER
  FROM base_s4h_cax.C_SalesDocumentItemDEX_delta
  GROUP BY
    MANDT,
    SalesDocument,
    SalesDocumentItem
)