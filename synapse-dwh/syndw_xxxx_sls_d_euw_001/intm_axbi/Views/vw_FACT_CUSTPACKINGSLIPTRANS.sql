CREATE VIEW intm_axbi.vw_FACT_CUSTPACKINGSLIPTRANS AS
SELECT * FROM [base_tx_halfen_2_dwh].[FACT_CUSTPACKINGSLIPTRANS]
UNION
SELECT * FROM [base_tx_halfen_2_dwh].[FACT_CUSTPACKINGSLIPTRANS_Archive]