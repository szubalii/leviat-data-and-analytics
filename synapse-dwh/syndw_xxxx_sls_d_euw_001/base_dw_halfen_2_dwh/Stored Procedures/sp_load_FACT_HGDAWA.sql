CREATE PROCEDURE [base_dw_halfen_2_dwh].[sp_load_FACT_HGDAWA]

AS
	
	-- Copy data from FACT_HGDAWA to FACT_HGDAWA_new
	TRUNCATE TABLE base_dw_halfen_2_dwh.FACT_HGDAWA_new;

	SELECT
		*
	INTO
		base_dw_halfen_2_dwh.FACT_HGDAWA_new
	FROM
		base_dw_halfen_2_dwh.FACT_HGDAWA;

	-- TODO, what to do about 9999 values and other duplicates?

	-- Run generic utilities.process_axbi_delta with parameter values for FACT_HGDAWA
	EXEC utilities.sp_process_axbi_delta
		'base_dw_halfen_2_dwh',
		'FACT_HGDAWA',
		'Company,Orderno,Invoiceno,Posno'

	-- Check if data in FACT_HGDAWA is same as FACT_HGDAWA_active
	(
		SELECT
			*
		FROM
			base_dw_halfen_2_dwh.FACT_HGDAWA

		EXCEPT

		SELECT
			*
		FROM
			base_dw_halfen_2_dwh.FACT_HGDAWA_active
	)

	UNION ALL

	(
		SELECT
			*
		FROM
			base_dw_halfen_2_dwh.FACT_HGDAWA_active

		EXCEPT

		SELECT
			*
		FROM
			base_dw_halfen_2_dwh.FACT_HGDAWA
	)

RETURN 0
