CREATE VIEW [dm_procurement].[vw_dim_EClassCodes]
AS
SELECT
    CASE 
        WHEN MG.MaterialGroupIDE IN ('01','02')
            THEN ECC.EClassCode
        ELSE ''
    END                                             AS CommodityId
    ,CASE 
        WHEN MG.MaterialGroupIDE IN ('01','02')
            THEN ECC.EClassCategory
        ELSE ''
    END                                             AS CommodityName
    ,''                                             AS CommodityType
    ,CASE 
        WHEN MG.MaterialGroupIDE IN ('01','02')
            THEN ECC.EClassCategoryDescription
        ELSE ''
    END                                             AS CommodityDescription
FROM [edw].[dim_MaterialGroup]  MG
LEFT JOIN base_ff.EClassCodes   ECC
    ON MG.MaterialGroupID = ECC.MaterialGroupID