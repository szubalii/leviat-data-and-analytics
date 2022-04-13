CREATE VIEW [dm_sales].[vw_dim_SalesOrganization]
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



