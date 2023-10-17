CREATE VIEW [edw].[vw_Address]
AS
SELECT
  a.AddressID,
  a.Region,
  a.Country AS CountryCode,
  a.CityName,
  a.PostalCode,
  a.StreetName,
  a.HouseNumber,
  [edw].[svf_getFullAddress](
    a.StreetName,
    a.HouseNumber,
    a.PostalCode,
    a.CityName,
    co.Country
  ) AS FullAddress
FROM
  [base_s4h_cax].[I_Address] a
LEFT JOIN
  [edw].[dim_Country] co
  ON
    co.CountryID = a.CountryCode
