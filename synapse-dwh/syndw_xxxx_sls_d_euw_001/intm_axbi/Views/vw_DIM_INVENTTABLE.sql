CREATE VIEW intm_axbi.vw_DIM_INVENTTABLE AS
SELECT * FROM [base_tx_halfen_2_dwh].[DIM_INVENTTABLE]
UNION ALL
SELECT * FROM [base_tx_halfen_2_dwh].[DIM_INVENTTABLE_Archive]
 
 