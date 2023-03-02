CREATE VIEW intm_axbi.vw_DIM_ARTICLE AS
SELECT * FROM [base_dw_halfen_2_dwh].[DIM_ARTICLE]
UNION
SELECT * FROM [base_dw_halfen_2_dwh].[DIM_ARTICLE_Archive]