CREATE VIEW intm_axbi.vw_FACT_SALESTABLE AS
SELECT * FROM [base_tx_halfen_2_dwh].[FACT_SALESTABLE]
UNION 
SELECT * FROM  [base_tx_halfen_2_dwh].[FACT_SALESTABLE_Archive];