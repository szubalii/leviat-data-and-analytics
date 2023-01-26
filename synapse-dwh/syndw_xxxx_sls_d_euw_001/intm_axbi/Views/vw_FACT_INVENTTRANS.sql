CREATE VIEW intm_axbi.vw_FACT_INVENTTRANS AS
SELECT * FROM [base_tx_halfen_2_dwh].[FACT_INVENTTRANS]
UNION
SELECT * FROM [base_tx_halfen_2_dwh].[FACT_INVENTTRANS_Archive];