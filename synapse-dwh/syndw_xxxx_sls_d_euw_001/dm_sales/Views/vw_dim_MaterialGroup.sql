CREATE VIEW [dm_sales].[vw_dim_MaterialGroup] AS 

SELECT
  [MaterialGroupID]
, [MaterialGroup]
, [MaterialAuthorizationGroup]
, [MaterialGroupText]
, [t_applicationId]

FROM [edw].[dim_MaterialGroup]
