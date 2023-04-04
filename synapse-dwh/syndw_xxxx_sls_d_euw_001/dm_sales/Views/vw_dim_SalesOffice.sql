CREATE VIEW [dm_sales].[vw_dim_SalesOffice]
AS
SELECT
  [SalesOfficeID],
  [SalesOffice],
  CONCAT([SalesOfficeID], '_',[SalesOffice]) as SalesOfficeID_Name,
  [t_applicationId]
FROM
  [edw].[vw_SalesOffice]