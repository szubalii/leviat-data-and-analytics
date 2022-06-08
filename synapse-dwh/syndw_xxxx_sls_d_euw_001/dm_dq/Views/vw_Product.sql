CREATE VIEW [dm_dq].[vw_Product] AS
SELECT
    [RuleCodeID],
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
    [dq].[vw_Product]