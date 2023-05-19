CREATE VIEW [dm_procurement].[vw_dim_EClassCodes]
AS
SELECT
    CASE 
        WHEN ECC.MaterialGroupID IN ('01','02')
            THEN ECC.EClassCode
        ELSE ''
    END                                             AS CommodityId
    ,CASE 
        WHEN ECC.MaterialGroupID IN ('01','02')
            THEN ECC.EClassCategory
        ELSE ''
    END                                             AS CommodityName
    ,''                                             AS CommodityType
    ,CASE 
        WHEN ECC.MaterialGroupID IN ('01','02')
            THEN ECC.EClassCategoryDescription
        ELSE ''
    END                                             AS CommodityDescription
FROM [base_ff].[EClassCodes]   ECC