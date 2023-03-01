CREATE VIEW intm_axbi.vw_FACT_PURCHLINE AS
SELECT * FROM [base_tx_halfen_2_dwh].[FACT_PURCHLINE]
UNION ALL
SELECT * FROM  [base_tx_halfen_2_dwh].[FACT_PURCHLINE_Archive];