CREATE VIEW [edw].[vw_ProductCalculated_US] AS
WITH ITMS AS (
    SELECT
        I.[ITEM] AS [ProductIDCalculated]
    ,   I.[ItemName] AS [ProductCalculated]
    ,   I.[PCAT]
    ,   I.[COMP]
    ,   I.[t_applicationId]
    ,   I.[t_jobId]
    ,   I.[t_jobDtm]
    ,   I.[t_jobBy]
    ,   I.[t_extractionDtm]
    ,   I.[t_filePath]
    FROM
        [base_us_leviat_db].[ITEMS] I
    GROUP BY
         I.[ITEM]
        ,I.[ItemName]
        ,I.[PCAT]
        ,I.[COMP]
        ,I.[t_applicationId]
        ,I.[t_jobId]
        ,I.[t_jobDtm]
        ,I.[t_jobBy]
        ,I.[t_extractionDtm]
        ,I.[t_filePath]
)
SELECT 
    CONCAT(ITMS.[COMP],'-',ITMS.[ProductIDCalculated]) AS [ProductIDCalculated]
,   ITMS.[ProductIDCalculated] AS [ProductExternalIDCalculated]
,   MAX(ITMS.[ProductCalculated]) AS [ProductCalculated]
,   CONCAT(ITMS.[ProductIDCalculated],'_',MAX(ITMS.[ProductCalculated])) AS [ProductID_NameCalculated]
,   MAX(SP.[ProductPillarID]) AS [ProductPillarIDCalculated] 
,   MAX(SP.[ProductPillar]) AS [ProductPillarCalculated] 
,   NULL AS [ProductGroupIDCalculated] 
,   NULL AS [ProductGroupCalculated] 
,   NULL AS [MainGroupIDCalculated] 
,   NULL AS [MainGroupCalculated] 
,   NULL AS [isReviewed] 
,   'no_SAP' AS [mappingType] 
,   CONCAT(ITMS.[COMP],'-',ITMS.[ProductIDCalculated]) AS [axbiItemNo]
,   MAX(ITMS.[ProductCalculated]) AS [axbiItemName]
,   NULL AS [axbiProductPillarIDCalculated]
,   NULL AS [axbiProductPillarCalculated] 
,   NULL AS [axbiProductGroupIDCalculated] 
,   NULL AS [axbiProductGroupCalculated] 
,   NULL AS [axbiMainGroupIDCalculated] 
,   NULL AS [axbiMainGroupCalculated] 
,   ITMS.[t_applicationId]
,   ITMS.[t_jobId]
,   ITMS.[t_jobDtm]
,   ITMS.[t_jobBy]
,   ITMS.[t_extractionDtm]
,   ITMS.[t_filePath]
FROM 
    ITMS
LEFT JOIN
    [base_us_leviat_db].[SubPCAT_Pillar] SP
        ON SP.PCAT=ITMS.PCAT
GROUP BY
    ProductIDCalculated
,   ITMS.COMP
,   ITMS.[t_applicationId]
,   ITMS.[t_jobId]
,   ITMS.[t_jobDtm]
,   ITMS.[t_jobBy]
,   ITMS.[t_extractionDtm]
,   ITMS.[t_filePath]
-- order by ProductIDCalculated