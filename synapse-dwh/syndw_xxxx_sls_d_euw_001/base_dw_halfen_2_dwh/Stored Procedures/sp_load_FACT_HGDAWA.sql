CREATE PROCEDURE [base_dw_halfen_2_dwh].[sp_load_FACT_HGDAWA]

AS

BEGIN
	-- Run generic utilities.process_axbi_delta with parameter values for FACT_HGDAWA
	EXEC utilities.sp_process_axbi_delta
		'base_dw_halfen_2_dwh',
		'FACT_HGDAWA',
		'Company,Orderno,Invoiceno,Posno'

END;

GO
