CREATE VIEW [dm_sales].[vw_dim_BillingDocProject]
AS
WITH maxProject AS (
  SELECT
        ProjectID
      , MAX([Project]) OVER (PARTITION BY [ProjectID]) AS Project
      , MAX([ProjectID_Name]) OVER (PARTITION BY [ProjectID]) AS ProjectID_Name
      , [t_applicationId]
      , [t_extractionDtm]
  FROM 
    edw.[dim_BillingDocProject]

)
-- get list of unique projects
SELECT
    ProjectID
  , Project
  , ProjectID_Name
  , NULL AS CityName      -- Power BI expects this field but is not actually used
  , NULL AS StreetName    -- Power BI expects this field but is not actually used
  , NULL AS PostalCode    -- Power BI expects this field but is not actually used
  , [t_applicationId]
  , [t_extractionDtm]
FROM
  maxProject
GROUP BY
    ProjectID
  , Project
  , ProjectID_Name
  , [t_applicationId]
  , [t_extractionDtm]
