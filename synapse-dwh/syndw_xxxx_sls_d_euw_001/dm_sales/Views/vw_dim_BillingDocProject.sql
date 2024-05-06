CREATE VIEW [dm_sales].[vw_dim_BillingDocProject]
AS
-- get list of unique projects
SELECT
    ProjectID
  , MAX(Project) AS Project
  , MAX(ProjectID_Name) AS ProjectID_Name
  , NULL AS CityName      -- Power BI expects this field but is not actually used
  , NULL AS StreetName    -- Power BI expects this field but is not actually used
  , NULL AS PostalCode    -- Power BI expects this field but is not actually used
  , [t_applicationId]
  , [t_extractionDtm]
FROM
  edw.[dim_BillingDocProject]
GROUP BY
    ProjectID
  , [t_applicationId]
  , [t_extractionDtm]
