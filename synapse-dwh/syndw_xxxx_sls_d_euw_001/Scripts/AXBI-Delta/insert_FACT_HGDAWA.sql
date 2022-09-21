--truncate table [base_dw_halfen_2_dwh].[FACT_HGDAWA_active]
truncate table [base_dw_halfen_2_dwh].[FACT_HGDAWA]

BULK INSERT [base_dw_halfen_2_dwh].[FACT_HGDAWA]
FROM 'C:\Users\Michiel_Pors\source\repos\syndw_xxxx_sls_d_euw_001\Test\Data\FACT_HGDAWA_2022_01_27_09_43_53_650.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	FIELDQUOTE = '"'
)

DECLARE	@return_value Int

EXEC	@return_value = [utilities].[sp_process_axbi_delta]
		@schema_name = N'base_dw_halfen_2_dwh',
		@table_name = N'FACT_HGDAWA',
		@pk_field_names = N'Company,Orderno,Invoiceno,Posno'

SELECT	@return_value as 'Return Value'


truncate table [base_dw_halfen_2_dwh].[FACT_HGDAWA]

BULK INSERT [base_dw_halfen_2_dwh].[FACT_HGDAWA]
FROM 'C:\Users\Michiel_Pors\Downloads\FACT_HGDAWA_2022_01_31_09_35_46_452.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	FIELDQUOTE = '"'
)

DECLARE	@return_value Int

EXEC	@return_value = [utilities].[sp_process_axbi_delta]
		@schema_name = N'base_dw_halfen_2_dwh',
		@table_name = N'FACT_HGDAWA',
		@pk_field_names = N'Company,Orderno,Invoiceno,Posno'

SELECT	@return_value as 'Return Value'
