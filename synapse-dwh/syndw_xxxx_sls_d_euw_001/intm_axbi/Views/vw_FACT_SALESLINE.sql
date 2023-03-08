CREATE VIEW intm_axbi.vw_FACT_SALESLINE AS
SELECT * FROM [base_tx_halfen_2_dwh].[FACT_SALESLINE]
UNION ALL
SELECT * FROM [base_tx_halfen_2_dwh].[FACT_SALESLINE_Archive];