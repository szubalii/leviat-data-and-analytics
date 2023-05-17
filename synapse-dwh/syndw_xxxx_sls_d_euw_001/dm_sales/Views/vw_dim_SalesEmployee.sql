CREATE VIEW [dm_sales].[vw_dim_SalesEmployee]
AS 
SELECT
          [Personnel]
        , [FullName]
    FROM [edw].[vw_dim_SalesEmployee]
    GROUP BY
          [Personnel]
        , [FullName]

