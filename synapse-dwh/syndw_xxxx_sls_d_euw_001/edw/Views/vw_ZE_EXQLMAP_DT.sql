CREATE VIEW [edw].[vw_ZE_EXQLMAP_DT]
AS
SELECT 
    RIGHT(CONCAT('0000000000',GLACCOUNT),10)    AS GLAccountID
    ,COALESCE(FUNCTIONALAREA,'')                AS FunctionalAreaID   --Data in [base_s4h_cax].[ZE_EXQLMAP_DT] is 
--currently ingested from csv-file using COPY INTO in which empty strings are converted to NULL values by default.
-- [edw].[fact_ACDOCA] is extracted using Theobald that doesn't generate NULL values in parquet files for empty strings.
    ,RIGHT(CONCAT('0000000000',GLACCOUNT),10) + COALESCE(FUNCTIONALAREA,'')  AS [nk_ExQLmap]
    ,[REKNR] AS ExQLNode
    ,[REKOMS] AS ExQLAccount
    ,MAX(CONTIGENCY4) AS CONTIGENCY4 
    ,MAX(CONTIGENCY5) AS CONTIGENCY5 
    ,MAX(CONTIGENCY6) AS CONTIGENCY6
    ,MAX(CONTIGENCY7) AS CONTIGENCY7
FROM [base_s4h_cax].[ZE_EXQLMAP_DT]
WHERE [CONTIGENCY5] <> ''
    AND XLSBLD = 'IS'
GROUP BY GLACCOUNT
    ,FUNCTIONALAREA
    ,REKNR
    ,REKOMS