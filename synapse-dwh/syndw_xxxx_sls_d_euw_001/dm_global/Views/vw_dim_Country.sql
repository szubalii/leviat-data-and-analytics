CREATE VIEW [dm_global].[vw_dim_Country]
AS
SELECT
  CountryID,
  Country
FROM
  [edw].[dim_Country]
