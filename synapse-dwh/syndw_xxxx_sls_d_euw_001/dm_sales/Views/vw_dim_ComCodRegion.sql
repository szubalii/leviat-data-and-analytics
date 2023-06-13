CREATE VIEW [dm_sales].[vw_dim_ComCodRegion]
AS
SELECT
    CC.CompanyCodeID    AS CompanyCodeID,
    SO.RegionID         AS RegionID,
    SO.RegionID         AS Region,
    CC.Country          AS CountryID,
    Ctr.Country         AS Country
FROM [edw].[dim_CompanyCode] CC
LEFT JOIN [edw].[dim_Country] Ctr
    ON CC.Country = Ctr.CountryID
LEFT JOIN [edw].[dim_SalesOrganization] SO
    ON CC.Country = SO.CountryID
WHERE CC.t_applicationId LIKE 's4h%'