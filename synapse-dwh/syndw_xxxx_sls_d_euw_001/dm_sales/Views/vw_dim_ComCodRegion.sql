CREATE VIEW [dm_sales].[vw_dim_ComCodRegion]
AS
WITH Regions AS (
    SELECT 
        RegionID,    
        RegionName,
        CountryID
    FROM [edw].[dim_SalesOrganization]
    GROUP BY
        RegionID,    
        RegionName,
        CountryID
)
SELECT
    CC.CompanyCodeID    AS CompanyCodeID,
    SO.RegionID         AS RegionID,
    SO.RegionName       AS Region,
    CC.Country          AS CountryID,
    Ctr.Country         AS Country
FROM [edw].[dim_CompanyCode] CC
LEFT JOIN [edw].[dim_Country] Ctr
    ON CC.Country = Ctr.CountryID
LEFT JOIN Regions SO
    ON CC.Country = SO.CountryID
WHERE CC.t_applicationId LIKE 's4h%'