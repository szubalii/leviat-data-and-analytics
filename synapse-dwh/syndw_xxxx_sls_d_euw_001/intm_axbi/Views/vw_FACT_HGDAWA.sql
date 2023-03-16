CREATE VIEW intm_axbi.vw_FACT_HGDAWA AS
SELECT * FROM [base_dw_halfen_2_dwh].[FACT_HGDAWA]
UNION ALL
SELECT * FROM [base_dw_halfen_2_dwh].[FACT_HGDAWA_Archive]