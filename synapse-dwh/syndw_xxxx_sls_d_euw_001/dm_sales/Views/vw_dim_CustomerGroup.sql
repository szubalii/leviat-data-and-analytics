CREATE VIEW [dm_sales].[vw_dim_CustomerGroup]
AS 
SELECT 
       [CustomerGroupID],
       [CustomerGroup]
  FROM [edw].[dim_CustomerGroup]