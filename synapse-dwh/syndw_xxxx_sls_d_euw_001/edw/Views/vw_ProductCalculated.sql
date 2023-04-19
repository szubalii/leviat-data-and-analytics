CREATE VIEW [edw].[vw_ProductCalculated] AS 
WITH 
ITEMTABLE_without_quotes AS (
    SELECT
        CASE
            WHEN 
			    LEFT(IT.[ITEMID], 1) = '"'
			    AND
                RIGHT(IT.[ITEMID], 1) <> '"'
            THEN
			    SUBSTRING(IT.[ITEMID], 2, LEN(IT.[ITEMID]))
            WHEN
			    LEFT(IT.[ITEMID], 1) = '"'
                AND
                RIGHT(IT.[ITEMID], 1) = '"'
            THEN
			    SUBSTRING(IT.[ITEMID], 2, LEN(IT.[ITEMID]) - 2)
            WHEN
			    LEFT(IT.[ITEMID], 1) <> '"'
                AND
                RIGHT(IT.[ITEMID], 1) = '"'
            THEN
			    SUBSTRING(IT.[ITEMID], 1, LEN(IT.[ITEMID]) - 1)
            ELSE
                IT.[ITEMID]
        END  AS [ITEMID]
    ,   IT.[PRODUCTGROUPID]
    ,   IT.[ITEMNAME]
    ,   IT.[DATAAREAID] 
    ,   IT.[t_applicationId]
    ,   IT.[t_jobId]
    ,   IT.[t_jobDtm]
    ,   IT.[t_jobBy]
    ,   IT.[t_extractionDtm]
    FROM    
        [intm_axbi].[dim_ITEMTABLE] IT
)
,CALCULATED AS (
    SELECT 
        SBMT.[SAPItemnumberLeadingZeros] AS [ProductIDCalculated]
    ,   SBMT.[SAPItemnumber]    AS [ProductExternalIDCalculated]
    ,   PT.[ProductName]        AS [ProductCalculated]
    ,   COALESCE(PG.[PRODUCTPILLAR], PCF.[ProductPillarIDCalculated]) AS [ProductPillarIDCalculated]
    ,   COALESCE(PG.[PRODUCTPILLARNAME], PCF.[ProductPillarCalculated]) AS [ProductPillarCalculated]
    ,   COALESCE(PG.[PRODUCTGROUPID], PCF.[ProductGroupIDCalculated]) AS [ProductGroupIDCalculated]
    ,   COALESCE(PG.[PRODUCTGROUPNAME], PCF.[ProductGroupCalculated]) AS [ProductGroupCalculated]
    ,   COALESCE(PG.[MAINGROUPID], PCF.[MainGroupIDCalculated]) AS [MainGroupIDCalculated]
    ,   COALESCE(PG.[MAINGROUPNAME], PCF.[MainGroupCalculated]) AS [MainGroupCalculated]
    ,   NULL AS [isReviewed] 
    ,   CASE 
            WHEN 
                SBMT.CNT = 1 
            THEN 
                'one_TOM'
            WHEN 
                SBMT.CNT > 1 
            THEN 
                'many_TOM'
        END AS [mappingType] 
    ,   SBMT.[AXDataAreaId]     AS [axbiDataAreaID]
    ,   SBMT.[axbi_ItemNoCalc]  AS [axbiItemNo]
    ,   ITQ.[ITEMNAME]           AS [axbiItemName]    
    ,   PG.[PRODUCTPILLAR]      AS [axbiProductPillarIDCalculated]
    ,   PG.[PRODUCTPILLARNAME]  AS [axbiProductPillarCalculated] 
    ,   PG.[PRODUCTGROUPID]     AS [axbiProductGroupIDCalculated] 
    ,   PG.[PRODUCTGROUPNAME]   AS [axbiProductGroupCalculated] 
    ,   PG.[MAINGROUPID]        AS [axbiMainGroupIDCalculated] 
    ,   PG.[MAINGROUPNAME]      AS [axbiMainGroupCalculated]  
    ,   SBMT.[t_applicationId]
    ,   SBMT.[t_jobId]
    ,   SBMT.[t_jobDtm]
    ,   SBMT.[t_jobBy]
    ,   SBMT.[t_extractionDtm]
    ,   SBMT.[t_filePath]
    ,   SBMT.[t_source]
    FROM (
        -- SAPItemNumberBasicMappingTable data
        SELECT 
            SAP.[SAPProductID] AS [SAPItemnumberLeadingZeros]
        ,   SAP.[SAPItemnumber]
        ,   SAP.[axbi_ItemNoCalc] 
        ,   SAP.[AXDataAreaId]
        ,   row_number() over (PARTITION by SAP.[SAPItemnumber] order by SAP.[AXItemnumber]) AS RN
        ,   count(SAP.[AXItemnumber]) over (PARTITION by SAP.[SAPItemnumber]) AS CNT
        ,   SAP.[t_applicationId]
        ,   SAP.[t_jobId]
        ,   SAP.[t_jobDtm]
        ,   SAP.[t_jobBy]
        ,   SAP.[t_extractionDtm]
        ,   SAP.[t_filePath]
        ,   'SAPItemNumberBasicMappingTable' AS [t_source]
        FROM 
            [edw].[dim_SAPItemNumberBasicMappingTable] SAP
        WHERE 
            SAP.[SAPProductID] is not null
            AND
            SAP.[Migrate] in ('Y', 'D')
    ) SBMT
    LEFT JOIN 
        [base_s4h_cax].[I_ProductText] PT
        ON 
            SBMT.[SAPItemnumberLeadingZeros] = PT.[Product] 
            AND 
            PT.[Language] = 'E'
    LEFT JOIN 
        ITEMTABLE_without_quotes ITQ
        ON 
            ITQ.ITEMID = UPPER([axbi_ItemNoCalc])
    LEFT JOIN 
        [base_tx_ca_0_hlp].[PRODUCTGROUP] PG
        ON 
            ITQ.[PRODUCTGROUPID] = PG.[PRODUCTGROUPID]
    LEFT JOIN    
        [base_ff].[ProductCalculated] PCF
        ON
            SBMT.[SAPItemnumber]=PCF.[ProductExternalIDCalculated]
    WHERE 
        SBMT.RN = 1

    UNION ALL

    /*
        Take all S/4 HANA items from I_Product that don't exist in SAPItemNumberBasicMappingTable
    */

    SELECT 
        P.[Product] AS [ProductIDCalculated]
    ,   P.[ProductExternalID] AS [ProductExternalIDCalculated]
    ,   PT.[ProductName] AS [ProductCalculated]
    ,   PCF.[ProductPillarIDCalculated] AS [ProductPillarIDCalculated]
    ,   PCF.[ProductPillarCalculated] AS [ProductPillarCalculated]
    ,   PCF.[ProductGroupIDCalculated] AS [ProductGroupIDCalculated]
    ,   PCF.[ProductGroupCalculated] AS [ProductGroupCalculated]
    ,   PCF.[MainGroupIDCalculated] AS [MainGroupIDCalculated]
    ,   PCF.[MainGroupCalculated] AS [MainGroupCalculated]
    ,   NULL AS [isReviewed] 
    ,   'no_TOM' AS [mappingType] 
    ,   NULL AS [axbiDataAreaID]
    ,   NULL AS [axbiItemNo]
    ,   NULL AS [axbiItemName]
    ,   NULL AS [axbiProductPillarIDCalculated]
    ,   NULL AS [axbiProductPillarCalculated] 
    ,   NULL AS [axbiProductGroupIDCalculated] 
    ,   NULL AS [axbiProductGroupCalculated] 
    ,   NULL AS [axbiMainGroupIDCalculated] 
    ,   NULL AS [axbiMainGroupCalculated]   
    ,   P.[t_applicationId]
    ,   P.[t_jobId]
    ,   P.[t_jobDtm]
    ,   P.[t_jobBy]
    ,   P.[t_extractionDtm]
    ,   P.[t_filePath]
    ,   'I_Product' AS [t_source]
    FROM 
        [base_s4h_cax].[I_Product] P
    LEFT JOIN 
        [base_s4h_cax].[I_ProductText] PT
        ON 
            P.[Product]=PT.[Product]
        AND 
            PT.[Language]='E'
    LEFT JOIN    
        [base_ff].[ProductCalculated] PCF
        ON
            P.[ProductExternalID]=PCF.[ProductExternalIDCalculated]
    WHERE 
        NOT EXISTS(
            SELECT 
                [SAPItemnumber] 
            FROM
                [edw].[dim_SAPItemNumberBasicMappingTable] SIBMT
            WHERE 
                SIBMT.[SAPProductID] = P.[Product]
        )

    UNION ALL

    /*
        Take all AXBI items from ITEMTABLE that don't exist in SAPItemNumberBasicMappingTable
    */

    SELECT 
        ITQ.ITEMID AS [ProductIDCalculated]
    ,   ITQ.ITEMID AS [ProductExternalIDCalculated]
    ,   ITQ.[ITEMNAME] AS [ProductCalculated]
    ,   PG.[PRODUCTPILLAR] AS [ProductPillarIDCalculated] 
    ,   PG.[PRODUCTPILLARNAME] AS [ProductPillarCalculated] 
    ,   PG.[PRODUCTGROUPID] AS [ProductGroupIDCalculated] 
    ,   PG.[PRODUCTGROUPNAME] AS [ProductGroupCalculated] 
    ,   PG.[MAINGROUPID] AS [MainGroupIDCalculated] 
    ,   PG.[MAINGROUPNAME] AS [MainGroupCalculated] 
    ,   NULL AS [isReviewed] 
    ,   'no_SAP' AS [mappingType]
    ,   ITQ.[DATAAREAID] AS [axbiDataAreaID]
    ,   ITQ.ITEMID AS [axbiItemNo]
    ,   ITQ.[ITEMNAME] AS [axbiItemName]
    ,   PG.[PRODUCTPILLAR] AS [axbiProductPillarIDCalculated]
    ,   PG.[PRODUCTPILLARNAME] AS [axbiProductPillarCalculated] 
    ,   PG.[PRODUCTGROUPID] AS [axbiProductGroupIDCalculated] 
    ,   PG.[PRODUCTGROUPNAME] AS [axbiProductGroupCalculated] 
    ,   PG.[MAINGROUPID] AS [axbiMainGroupIDCalculated] 
    ,   PG.[MAINGROUPNAME] AS [axbiMainGroupCalculated] 
    ,   ITQ.[t_applicationId]
    ,   ITQ.[t_jobId]
    ,   ITQ.[t_jobDtm]
    ,   ITQ.[t_jobBy]
    ,   ITQ.[t_extractionDtm]
    ,   null as [t_filePath]
    ,   'ITEMTABLE' AS [t_source]
    FROM 
        ITEMTABLE_without_quotes ITQ
    LEFT JOIN 
        [base_tx_ca_0_hlp].[PRODUCTGROUP] PG
        ON 
            ITQ.[PRODUCTGROUPID] = PG.[PRODUCTGROUPID]
    WHERE 
        ITQ.ITEMID NOT IN(
            SELECT 
                [axbi_ItemNoCalc] 
            FROM
                [edw].[dim_SAPItemNumberBasicMappingTable] SIBMT
            WHERE 
                SIBMT.[SAPProductID] IS NOT NULL
                AND [axbi_ItemNoCalc] IS NOT NULL --Not in returns no records if the result set has NULL in it.
        )
)

SELECT 
        C.[ProductIDCalculated] 
    ,   C.[ProductExternalIDCalculated]
    ,   C.[ProductCalculated]
    ,   CONCAT(C.[ProductExternalIDCalculated],'_',C.[ProductCalculated]) AS [ProductID_NameCalculated]
    ,   C.[ProductPillarIDCalculated] 
    ,   C.[ProductPillarCalculated] 
    ,   C.[ProductGroupIDCalculated] 
    ,   C.[ProductGroupCalculated] 
    ,   C.[MainGroupIDCalculated] 
    ,   C.[MainGroupCalculated] 
    ,   C.[isReviewed] 
    ,   C.[mappingType] 
    ,   C.[axbiDataAreaID]
    ,   C.[axbiItemNo]
    ,   C.[axbiItemName]
    ,   C.[axbiProductPillarIDCalculated]
    ,   C.[axbiProductPillarCalculated] 
    ,   C.[axbiProductGroupIDCalculated] 
    ,   C.[axbiProductGroupCalculated] 
    ,   C.[axbiMainGroupIDCalculated] 
    ,   C.[axbiMainGroupCalculated] 
    ,   C.[t_applicationId]
    ,   C.[t_jobId]
    ,   C.[t_jobDtm]
    ,   C.[t_jobBy]
    ,   C.[t_extractionDtm]
    ,   C.[t_filePath]
    ,   C.[t_source]
FROM 
    CALCULATED C
WHERE 
    NOT EXISTS(
        SELECT 
            PC.[ProductIDCalculated] 
        FROM 
            [base_ff].[ProductCalculated] PC
        WHERE 
            PC.[ProductIDCalculated] = C.[ProductIDCalculated]
            AND 
            PC.[isReviewed] = 1
    )

UNION ALL

SELECT 
        PC.[ProductIDCalculated] 
    ,   PC.[ProductExternalIDCalculated]
    ,   PC.[ProductCalculated]
    ,   CONCAT(PC.[ProductExternalIDCalculated],'_',PC.[ProductCalculated]) AS [ProductID_NameCalculated]
    ,   PC.[ProductPillarIDCalculated] 
    ,   PC.[ProductPillarCalculated] 
    ,   PC.[ProductGroupIDCalculated] 
    ,   PC.[ProductGroupCalculated] 
    ,   PC.[MainGroupIDCalculated] 
    ,   PC.[MainGroupCalculated] 
    ,   PC.[isReviewed] 
    ,   PC.[mappingType] 
    ,   PC.[axbiDataAreaID]
    ,   PC.[axbiItemNo]
    ,   PC.[axbiItemName]
    ,   PC.[axbiProductPillarIDCalculated]
    ,   PC.[axbiProductPillarCalculated] 
    ,   PC.[axbiProductGroupIDCalculated] 
    ,   PC.[axbiProductGroupCalculated] 
    ,   PC.[axbiMainGroupIDCalculated] 
    ,   PC.[axbiMainGroupCalculated] 
    ,   PC.[t_applicationId]
    ,   PC.[t_jobId]
    ,   PC.[t_jobDtm]
    ,   PC.[t_jobBy]
    ,   PC.[t_extractionDtm]
    ,   PC.[t_filePath]
    ,   PC.[t_source]
FROM 
    [base_ff].[ProductCalculated] PC
WHERE 
    PC.[isReviewed] = 1

UNION ALL

SELECT
      PR.[ProductID]                AS [ProductIDCalculated]
    , PR.[ProductID]                AS [ProductExternalIDCalculated]
    , PR.[Product]                  AS [ProductCalculated]
    , PR.[ProductID_Name]           AS [ProductID_NameCalculated]
    , PR.[Product_L1_PillarID]      AS [ProductPillarIDCalculated]
    , PG.[PRODUCTPILLARNAME]        AS [ProductPillarCalculated]
    , PG.[PRODUCTGROUPID]           AS [ProductGroupIDCalculated]
    , PG.[PRODUCTGROUPNAME]         AS [ProductGroupCalculated]
    , PG.[MAINGROUPID]              AS [MainGroupIDCalculated]
    , PG.[MAINGROUPNAME]            AS [MainGroupCalculated]
    , NULL   AS [isReviewed]
    , NULL   AS [mappingType]
    , NULL   AS [axbiDataAreaID]
    , NULL   AS [axbiItemNo]
    , NULL   AS [axbiItemName]
    , NULL   AS [axbiProductPillarIDCalculated]
    , NULL   AS [axbiProductPillarCalculated]
    , NULL   AS [axbiProductGroupIDCalculated]
    , NULL   AS [axbiProductGroupCalculated]
    , NULL   AS [axbiMainGroupIDCalculated]
    , NULL   AS [axbiMainGroupCalculated]
    , PR.[t_applicationId]
    , NULL   AS [t_jobId]
    , NULL   AS [t_jobDtm]
    , NULL   AS [t_jobBy]
    , NULL   AS [t_extractionDtm]
    , NULL   AS [t_filePath]
    , NULL   AS [t_source]
FROM
    [edw].[vw_Product] PR
CROSS JOIN
    [base_tx_ca_0_hlp].[PRODUCTGROUP] as PG
WHERE PR.[ProductID] in ('ZZZDUMMY01', 'ZZZDUMMY02') AND PG.[PRODUCTGROUPID] = 'K.3.'