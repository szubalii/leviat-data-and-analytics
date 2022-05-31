CREATE VIEW [dm_sales].[vw_dim_Plant] AS
SELECT
	dp.[PlantID]
	,dp.[Plant]
	,dp.[ValuationArea]
	,dp.[PlantCustomer]
	,dp.[PlantSupplier]
	,dp.[FactoryCalendar]
    ,dp.[DefaultPurchasingOrganization]
    ,dp.[SalesOrganization]             AS [SalesOrganizationID]
    ,dso.[SalesOrganization]
    ,dp.[AddressID]
    ,dso.[CountryID]                    AS [SalesOrg_CountryID]
    ,dso.[CountryName]                  AS [SalesOrg_Country]
    ,dso.[RegionID]                     AS [SalesOrg_RegionID]
    ,dso.[RegionName]                   AS [SalesOrg_Region]
    ,dp.[PlantCategory]
    ,dp.[DistributionChannel]
    ,dp.[Division]
    ,dp.[t_applicationId]
    ,dp.[t_extractionDtm]
FROM
    [edw].[dim_Plant] AS dp
LEFT JOIN
    [edw].[dim_SalesOrganization] AS dso
    ON
        dp.[SalesOrganization] = dso.[SalesOrganizationID]