CREATE VIEW [edw].[vw_ZE_EXQLMAP_DT]
AS
SELECT 
    RIGHT(CONCAT('0000000000',GLACCOUNT),10)    AS GLACCOUNT
    ,COALESCE(FUNCTIONALAREA,'')                AS FUNCTIONALAREA   --Data in [base_s4h_cax].[ZE_EXQLMAP_DT] is 
--currently ingested from csv-file using COPY INTO in which empty strings are converted to NULL values by default.
-- [edw].[fact_ACDOCA] is extracted using Theobald that doesn't generate NULL values in parquet files for empty strings.
    ,MAX(CONTIGENCY5) AS CONTIGENCY5
FROM [base_s4h_cax].[ZE_EXQLMAP_DT]
WHERE [CONTIGENCY5] <> ''
    AND XLSBLD = 'IS'
GROUP BY GLACCOUNT
    ,FUNCTIONALAREA