CREATE VIEW intm_axbi.vw_FACT_INVENTSUM AS
SELECT * FROM [base_tx_halfen_2_dwh].[FACT_INVENTSUM]
UNION ALL
SELECT * FROM [base_tx_halfen_2_dwh].[FACT_INVENTSUM_Archive]