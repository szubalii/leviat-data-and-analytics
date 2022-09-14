BULK INSERT [base_dw_halfen_2_dwh].[FACT_HGDAWA_active]
FROM 'C:\Users\Michiel_Pors\Downloads\FACT_HGDAWA_2022_01_27_09_43_53_650.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDQUOTE = '"'
)

BULK INSERT [base_dw_halfen_2_dwh].[FACT_HGDAWA_new]
FROM 'C:\Users\Michiel_Pors\Downloads\FACT_HGDAWA_2022_01_31_09_35_46_452.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	FIELDQUOTE = '"'
)

truncate table [base_dw_halfen_2_dwh].[FACT_HGDAWA_active]
truncate table [base_dw_halfen_2_dwh].[FACT_HGDAWA_new]