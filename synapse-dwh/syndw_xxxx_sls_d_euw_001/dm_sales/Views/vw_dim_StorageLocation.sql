CREATE VIEW [dm_sales].[vw_dim_StorageLocation] AS
SELECT 
    sl.[StorageLocationID]
    ,sl.[StorageLocation]
    ,sl.[Plant]
    ,CONVERT(NVARCHAR(32),
            HashBytes('SHA2_256',
            isNull(CAST([StorageLocationID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') +
			isNull(CAST([Plant] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') 
            )
        , 2)                            AS StoragePlantID
    ,sl.[SalesOrganization]             AS [SalesOrganizationID]
    ,dso.[SalesOrganization]
    ,dso.[CountryID]                    AS [SalesOrg_CountryID]
    ,dso.[CountryName]                  AS [SalesOrg_Country]
    ,dso.[RegionID]                     AS [SalesOrg_RegionID]
    ,dso.[RegionName]                   AS [SalesOrg_Region]
    ,sl.[DistributionChannel]
    ,sl.[Division]
    ,sl.[IsStorLocAuthznCheckActive]
    ,sl.[t_applicationId]
    ,sl.[t_extractionDtm]
FROM
    [edw].[dim_StorageLocation] AS sl
LEFT JOIN
    [edw].[dim_SalesOrganization] AS dso
    ON
        sl.[SalesOrganization] = dso.[SalesOrganizationID]
