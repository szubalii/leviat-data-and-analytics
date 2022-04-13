CREATE VIEW [edw].[vw_AXProductSAPHierarchy]
AS
WITH
AXProductSAPHierarchy_Calculated_Sub AS (
    select
           TRIM(AXPSH.[ITEMID])                             AS [ITEMID]
         , TRIM(AXPSH.[FINAL_TEXT])                         AS [FINAL_TEXT]
         --, AXPSH.[MATERIAL_TYPE]
         , NULL                                             AS [MATERIAL_TYPE]
         , TRIM(AXPSH.[SALES_PROD_HIER_L1])                 AS [SALES_PROD_HIER_L1]
         , TRIM(AXPSH.[SALES_PROD_HIER_L2])                 AS [SALES_PROD_HIER_L2]
         , TRIM(AXPSH.[SALES_PROD_HIER_L3])                 AS [SALES_PROD_HIER_L3]
         , TRIM(AXPSH.[SALES_PROD_HIER_L4])                 AS [SALES_PROD_HIER_L4]
         , TRIM(AXPSH.[SALES_PROD_HIER_L5])                 AS [SALES_PROD_HIER_L5]
         , UPPER(TRIM(AXPSH.[DATAAREAID]))                  AS [DATAAREAID]
         , CASE
               WHEN TRIM(AXPSH.[DATAAREAID]) = '0000'
                   THEN 'HALF'
               WHEN UPPER(TRIM(AXPSH.[DATAAREAID])) = 'ASS'
                   THEN 'ASCH'
               ELSE UPPER(TRIM(AXPSH.[DATAAREAID]))
        END                                                  AS [DATAAREAID_Calculated]
         --, AXPSH.[SAP_MATERIAL]
         , NULL                                              AS [SAP_MATERIAL]
         , TRIM(AXPSH.[MIGRATE])                             AS [MIGRATE]
         , TRIM(AXPSH.[ORIGINAL_MATERIAL])                   AS [ORIGINAL_MATERIAL]
    from [map_AXBI].[AXProductSAPHierarchy] AXPSH
    GROUP BY
      TRIM(AXPSH.[ITEMID])
    , TRIM(AXPSH.[FINAL_TEXT])
    , TRIM(AXPSH.[SALES_PROD_HIER_L1])
    , TRIM(AXPSH.[SALES_PROD_HIER_L2])
    , TRIM(AXPSH.[SALES_PROD_HIER_L3])
    , TRIM(AXPSH.[SALES_PROD_HIER_L4])
    , TRIM(AXPSH.[SALES_PROD_HIER_L5])
    , TRIM(AXPSH.[DATAAREAID])
    , TRIM(AXPSH.[MIGRATE])
    , TRIM(AXPSH.[ORIGINAL_MATERIAL])
),
AXProductSAPHierarchy_ProductID_Sub  AS (
      select
           AXPSHsub.[DATAAREAID_Calculated] + '-' + AXPSHsub.[ITEMID]    AS [ProductID]
       ,   AXPSHsub.[FINAL_TEXT]
       ,   AXPSHsub.[MATERIAL_TYPE]
       ,   AXPSHsub.[SALES_PROD_HIER_L1]
       ,   AXPSHsub.[SALES_PROD_HIER_L2]
       ,   AXPSHsub.[SALES_PROD_HIER_L3]
       ,   AXPSHsub.[SALES_PROD_HIER_L4]
       ,   AXPSHsub.[SALES_PROD_HIER_L5]
       ,   AXPSHsub.[DATAAREAID]
       ,   AXPSHsub.[DATAAREAID_Calculated]
       ,   AXPSHsub.[SAP_MATERIAL]
       ,   AXPSHsub.[MIGRATE]
       ,   AXPSHsub.[ORIGINAL_MATERIAL]
       from
        AXProductSAPHierarchy_Calculated_Sub AXPSHsub
     )

select
    AXPSHProdSub.[ProductID]                                           AS [ProductID]
,   AXPSHProdSub.[ProductID]                                           AS [ProductExternalID]
,   AXPSHProdSub.[FINAL_TEXT]                                          AS [Product]
,   AXPSHProdSub.[ProductID] + '-' + AXPSHProdSub.[FINAL_TEXT]         AS [ProductID_Name]
,   AXPSHProdSub.[MATERIAL_TYPE]                                       AS [MaterialTypeID]
--,   IPTTT.[MaterialTypeName]                                           AS [MaterialType]
,   NULL                                                               AS [MaterialType]
,   NULL                                                               AS [ProductHierarchy]
,   NULL                                                               AS [Product_L1_PillarID]
,   NULL                                                               AS [Product_L2_GroupID]
,   NULL                                                               AS [Product_L3_TypeID]
,   NULL                                                               AS [Product_L4_FamilyID]
,   NULL                                                               AS [Product_L5_SubFamilyID]
,   AXPSHProdSub.[SALES_PROD_HIER_L1]                                  AS [Product_L1_Pillar]
,   AXPSHProdSub.[SALES_PROD_HIER_L2]                                  AS [Product_L2_Group]
,   AXPSHProdSub.[SALES_PROD_HIER_L3]                                  AS [Product_L3_Type]
,   AXPSHProdSub.[SALES_PROD_HIER_L4]                                  AS [Product_L4_Family]
,   AXPSHProdSub.[SALES_PROD_HIER_L5]                                  AS [Product_L5_SubFamily]
,   AXPSHProdSub.[DATAAREAID]                                          AS [DATAAREAID]
,   AXPSHProdSub.[DATAAREAID_Calculated]                               AS [DATAAREAID_Calculated]
,   AXPSHProdSub.[SAP_MATERIAL]
,   AXPSHProdSub.[MIGRATE]
,   AXPSHProdSub.[ORIGINAL_MATERIAL]                                   AS [ORIGINAL_MATERIAL]
from 
    AXProductSAPHierarchy_ProductID_Sub AXPSHProdSub
     --LEFT JOIN [base_s4h_cax].[I_ProductTypeText] IPTTT
     --          ON AXPSHProdSub.[MATERIAL_TYPE] = IPTTT.[ProductType] AND IPTTT.[Language] = 'E'

    LEFT JOIN
    [edw].[dim_SAPItemNumberBasicMappingTable] AS SINMT
    ON
        AXPSHProdSub.[ProductID] = SINMT.[axbi_ItemNoCalc]
        AND
        SINMT.[SAPProductID] IS NOT NULL
WHERE 
    -- AXPSHProdSub.[MIGRATE] IN ('Y', 'D') 
    -- AND  
    SINMT.[axbi_ItemNoCalc] IS NULL