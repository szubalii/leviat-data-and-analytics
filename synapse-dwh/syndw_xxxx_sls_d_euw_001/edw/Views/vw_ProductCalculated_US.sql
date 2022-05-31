CREATE VIEW [edw].[vw_ProductCalculated_US] AS

WITH ITMS AS (
    SELECT
        I.[ITEM] AS [ProductIDCalculated]
    ,   I.[ItemName] AS [ProductCalculated]
    ,   I.[PCAT]
    ,   I.[SUB_PCAT]
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
        ,I.[SUB_PCAT]
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
    ,   ITMS.[ProductCalculated] AS [ProductCalculated]
    ,   CONCAT(ITMS.[ProductIDCalculated],'_',ITMS.[ProductCalculated]) AS [ProductID_NameCalculated]
    ,   SP.[ProductPillarID] AS [ProductPillarIDCalculated]
    ,   CASE
            WHEN
                ITMS.[COMP] = '044'
            THEN
                'ANCHORING & FIXING'
            ELSE
                SP.[ProductPillar] 
        END AS [ProductPillarCalculated]
    ,   SP.[CAProductGroupID] AS [ProductGroupIDCalculated]
    ,   CASE
            WHEN
                ITMS.[COMP] = '044'
            THEN
                'THERMOMASS (US)'
            ELSE
                PG.[CAProductGroupName]
        END AS [ProductGroupCalculated] 
    ,   PG.[MainGroupID] AS [MainGroupIDCalculated] 
    ,   PG.[MainGroup] AS [MainGroupCalculated] 
    ,   NULL AS [isReviewed] 
    ,   'no_SAP' AS [mappingType] 
    ,   CONCAT(ITMS.[COMP],'-',ITMS.[ProductIDCalculated]) AS [axbiItemNo]
    ,   ITMS.[ProductCalculated] AS [axbiItemName]
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
    [base_ff_USA].[SubPCAT_Pillar] SP
        ON SP.PCAT=ITMS.PCAT
        AND SP.SubPCAT = ITMS.SUB_PCAT
LEFT JOIN
    [base_ff_USA].[CAProductGroup] PG
        ON SP.[CAProductGroupID] = PG.[CAProductGroupID]

UNION ALL

SELECT
        CONCAT(Material_US.[COMP],'-',Material_US.[MaterialID]) AS [ProductIDCalculated]
    ,   Material_US.[MaterialID] AS [ProductExternalIDCalculated]
    ,   Material_US.[MaterialID] AS [ProductCalculated]
    ,   CONCAT(Material_US.[COMP],'_',Material_US.[MaterialID]) AS [ProductID_NameCalculated]
    ,   Material_US.[ProductPillarID] AS [ProductPillarIDCalculated] 
    ,   Material_US.[ProductPillar] AS [ProductPillarCalculated] 
    ,   Material_US.[CAProductGroupID] AS [ProductGroupIDCalculated] 
    ,   PG.[CAProductGroupName] AS [ProductGroupCalculated] 
    ,   PG.[MainGroupID] AS [MainGroupIDCalculated] 
    ,   PG.[MainGroup] AS [MainGroupCalculated] 
    ,   NULL AS [isReviewed] 
    ,   'no_SAP' AS [mappingType] 
    ,   CONCAT(Material_US.[COMP],'-',Material_US.[MaterialID]) AS [axbiItemNo]
    ,   Material_US.[MaterialID] AS [axbiItemName]
    ,   NULL AS [axbiProductPillarIDCalculated]
    ,   NULL AS [axbiProductPillarCalculated] 
    ,   NULL AS [axbiProductGroupIDCalculated] 
    ,   NULL AS [axbiProductGroupCalculated] 
    ,   NULL AS [axbiMainGroupIDCalculated] 
    ,   NULL AS [axbiMainGroupCalculated] 
    ,   Material_US.[t_applicationId]
    ,   Material_US.[t_jobId]
    ,   Material_US.[t_jobDtm]
    ,   Material_US.[t_jobBy]
    ,   NULL AS [t_extractionDtm]
    ,   Material_US.[t_filePath]
FROM
    [base_ff_USA].[DummyMaterial] Material_US
LEFT JOIN    
    [base_ff_USA].[CAProductGroup] PG
        ON PG.[CAProductGroupID] = Material_US.[CAProductGroupID]