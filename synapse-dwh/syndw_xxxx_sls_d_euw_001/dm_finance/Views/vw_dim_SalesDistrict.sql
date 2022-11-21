CREATE VIEW [dm_finance].[vw_dim_SalesDistrict]
AS 
SELECT 
        [SalesDistrictID] 
    ,   [SalesDistrict]
    ,   [t_applicationId]
FROM [edw].[dim_SalesDistrict]

UNION ALL

SELECT 
        'MA-Dummy'  AS [SalesDistrictID] 
    ,   'MA'        AS [SalesDistrict]
    ,   null        AS [t_applicationId]