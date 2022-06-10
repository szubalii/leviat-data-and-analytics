CREATE VIEW [dm_dq].[vw_Product] AS
SELECT
    [RuleID],
    [Product],
    [ProductType],
    [GrossWeight],
    [NetWeight],
    [ProductManufacturerNumber],
    [IndustrySector],
    [WeightUnit],
    [Division],
    [TransportationGroup],
    [ItemCategoryGroup],
    [Count]
FROM
    [dq].[vw_Product_1_2]

UNION ALL

SELECT
    [RuleID],
    [Product],
    [ProductType],
    [GrossWeight],
    [NetWeight],
    [ProductManufacturerNumber],
    [IndustrySector],
    [WeightUnit],
    [Division],
    [TransportationGroup],
    [ItemCategoryGroup],
    [Count]
FROM
    [dq].[vw_Product_1_8]

UNION ALL

SELECT
    [RuleID],
    [Product],
    [ProductType],
    [GrossWeight],
    [NetWeight],
    [ProductManufacturerNumber],
    [IndustrySector],
    [WeightUnit],
    [Division],
    [TransportationGroup],
    [ItemCategoryGroup],
    [Count]
FROM
    [dq].[vw_Product_1_16]

UNION ALL

SELECT
    [RuleID],
    [Product],
    [ProductType],
    [GrossWeight],
    [NetWeight],
    [ProductManufacturerNumber],
    [IndustrySector],
    [WeightUnit],
    [Division],
    [TransportationGroup],
    [ItemCategoryGroup],
    [Count]
FROM
    [dq].[vw_Product_1_17]

UNION ALL

SELECT
    [RuleID],
    [Product],
    [ProductType],
    [GrossWeight],
    [NetWeight],
    [ProductManufacturerNumber],
    [IndustrySector],
    [WeightUnit],
    [Division],
    [TransportationGroup],
    [ItemCategoryGroup],
    [Count]
FROM
    [dq].[vw_Product_1_18]

UNION ALL

SELECT
    [RuleID],
    [Product],
    [ProductType],
    [GrossWeight],
    [NetWeight],
    [ProductManufacturerNumber],
    [IndustrySector],
    [WeightUnit],
    [Division],
    [TransportationGroup],
    [ItemCategoryGroup],
    [Count]
FROM
    [dq].[vw_Product_1_19]

UNION ALL

SELECT
    [RuleID],
    [Product],
    [ProductType],
    [GrossWeight],
    [NetWeight],
    [ProductManufacturerNumber],
    [IndustrySector],
    [WeightUnit],
    [Division],
    [TransportationGroup],
    [ItemCategoryGroup],
    [Count]
FROM
    [dq].[vw_Product_1_20]