CREATE VIEW [dm_scm].[vw_dim_CustomerAddress]
AS
SELECT
  c.CustomerID,
  a.CountryID,
  a.FullAddress
FROM
  [edw].[dim_Customer] c
LEFT JOIN
  [edw].[dim_Address] a
  ON
    a.AddressID = c.AddressID
