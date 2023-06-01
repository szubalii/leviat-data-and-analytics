CREATE VIEW [dm_procurement].[vw_dim_EClassCodes]
AS
SELECT
     ECC.EClassCode                                 AS CommodityId
    ,ECC.EClassCategory                             AS CommodityName
    ,ECC.EClassCategoryDescription                  AS CommodityType

FROM [base_ff].[EClassCodes] ECC