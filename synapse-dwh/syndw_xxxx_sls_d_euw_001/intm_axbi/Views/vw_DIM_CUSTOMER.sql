CREATE VIEW intm_axbi.vw_DIM_CUSTOMER AS
SELECT * FROM [base_dw_halfen_2_dwh].[DIM_CUSTOMER]
UNION ALL
SELECT * FROM [base_dw_halfen_2_dwh].[DIM_CUSTOMER_Archive]