CREATE VIEW [dm_sales].[vw_dim_SalesEmployee]
AS 
SELECT
      Employee,
      FullName
FROM  [edw].[vw_SalesEmployee]




