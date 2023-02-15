CREATE VIEW intm_axbi.vw_DIM_VENDTABLE AS
SELECT * FROM [base_tx_halfen_2_dwh].[DIM_VENDTABLE]
UNION
SELECT * FROM [base_tx_halfen_2_dwh].[DIM_VENDTABLE_Archive]