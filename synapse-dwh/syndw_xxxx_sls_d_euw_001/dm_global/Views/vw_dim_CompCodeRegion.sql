CREATE VIEW [dm_global].[vw_dim_CompCodeRegion]
AS
SELECT
  [CompanyCode]
, [RegionName]
FROM
  [dm_sales].[vw_dim_SalesOrganization]
WHERE
  [CompanyCode] IS NOT NULL
GROUP BY
  [CompanyCode]
, [RegionName]
