CREATE VIEW [dm_sales].[vw_dim_SalesOffice]
AS
SELECT
  [SalesOfficeID],
  [SalesOffice],
  [t_applicationId]
FROM
  [edw].[vw_SalesOffice]