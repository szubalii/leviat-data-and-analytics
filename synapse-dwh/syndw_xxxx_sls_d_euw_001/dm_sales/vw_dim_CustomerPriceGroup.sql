CREATE VIEW [dm_sales].[vw_dim_CustomerPriceGroup] AS

SELECT
    [CustomerPriceGroupID]
,   [CustomerPriceGroup]
FROM [edw].[dim_CustomerPriceGroup]