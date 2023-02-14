CREATE VIEW intm_axbi.vw_FACT_HGPLUM AS
SELECT * FROM [base_dw_halfen_2_dwh].[FACT_HGPLUM]
UNION
SELECT * FROM [base_dw_halfen_2_dwh].[FACT_HGPLUM_Archive]