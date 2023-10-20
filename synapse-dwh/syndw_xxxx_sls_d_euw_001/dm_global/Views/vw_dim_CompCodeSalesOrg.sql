CREATE VIEW [dm_global].[vw_dim_CompCodeSalesOrg]
AS
SELECT
  [SalesOrganizationID]
, [CompanyCode]
FROM
  [dm_sales].[vw_dim_SalesOrganization]
