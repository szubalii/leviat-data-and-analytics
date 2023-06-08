CREATE VIEW [dm_procurement].[vw_dim_EClassCodes]
AS
SELECT
     ECC.EClassCode                                 AS CommodityId
    ,ECC.EClassCategoryDescription                  AS CommodityName
    ,ECC.EClassCategory                             AS CommodityType

FROM [base_ff].[EClassCodes] ECC