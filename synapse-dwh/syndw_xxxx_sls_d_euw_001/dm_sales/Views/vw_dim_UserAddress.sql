CREATE VIEW [dm_sales].[vw_dim_UserAddress] AS 

SELECT
  [UserName]
, [UserID]
, [UserClass]
, [t_applicationId]  


FROM [edw].[dim_UserAddress]
