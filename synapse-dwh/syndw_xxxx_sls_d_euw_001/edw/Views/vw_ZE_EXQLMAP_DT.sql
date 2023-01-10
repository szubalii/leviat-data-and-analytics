CREATE VIEW [edw].[vw_ZE_EXQLMAP_DT]
AS
SELECT 
    RIGHT(CONCAT('0000000000',GLACCOUNT),10) AS GLACCOUNT
    ,FUNCTIONALAREA
    ,MAX(CONTIGENCY5) AS CONTIGENCY5
FROM [base_s4h_cax].[ZE_EXQLMAP_DT]
WHERE [CONTIGENCY5] <> ''
GROUP BY GLACCOUNT
    ,FUNCTIONALAREA