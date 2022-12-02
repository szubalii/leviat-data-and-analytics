CREATE VIEW [dm_finance].[vw_dim_SalesOrganization]
AS 
SELECT 
        [SalesOrganizationID]  
    ,   [SalesOrganization]       
    ,   [SalesOrganizationCurrency] 
    ,   [CompanyCode]
    ,   [CountryID]
    ,   [CountryName]
    ,   [RegionID]
    ,   [RegionName]
    ,   [Access_Control_Unit]
    ,   [t_applicationId]
    ,   [t_extractionDtm]                
FROM [edw].[dim_SalesOrganization]

UNION ALL
    
SELECT 
        [SalesOrganizationID]  
    ,   [SalesOrganization]       
    ,   [SalesOrganizationCurrency] 
    ,   [CompanyCode]
    ,   [CountryID]
    ,   [CountryName]
    ,   [RegionID]
    ,   [RegionName]
    ,   [Access_Control_Unit]
    ,   [t_applicationId]
    ,   [t_extractionDtm]                
FROM [edw].[dim_SalesOrganization_US]

UNION ALL

SELECT
        'MA-Dummy'  AS [SalesOrganizationID]
    ,   'MA'        AS [SalesOrganization]  
    ,   null        AS [SalesOrganizationCurrency] 
    ,   null        AS [CompanyCode]
    ,   null        AS [CountryID]
    ,   null        AS [CountryName]
    ,   null        AS [RegionID]
    ,   'MA'        AS [RegionName]
    ,   null        AS [Access_Control_Unit]
    ,   null        AS [t_applicationId]
    ,   null        AS [t_extractionDtm]
