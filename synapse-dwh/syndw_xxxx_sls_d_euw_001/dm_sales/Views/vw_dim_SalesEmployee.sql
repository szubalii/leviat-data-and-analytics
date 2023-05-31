CREATE VIEW [dm_sales].[vw_dim_SalesEmployee]
AS 
SELECT
        [Personnel]
      , [FullName]
FROM (
      SELECT Personnel, 
             FullName, 
             ROW_NUMBER() OVER (PARTITION BY  Personnel ORDER BY cnt DESC) AS row_num
      FROM (
           SELECT Personnel, FullName, COUNT(*) as cnt
           FROM [edw].[vw_dim_SalesEmployee]
           GROUP BY Personnel, FullName
           ) total_count
      ) frequent_value 
WHERE row_num=1 




