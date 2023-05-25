CREATE VIEW [dm_procurement].[vw_dim_EClassCodes]
AS
SELECT
    ECC.EClassCode                                  AS CommodityId
    ,ECC.EClassCategory                             AS CommodityName
    ,''                                             AS CommodityType
    ,ECC.EClassCategoryDescription                  AS CommodityDescription
FROM [base_ff].[EClassCodes]   ECC