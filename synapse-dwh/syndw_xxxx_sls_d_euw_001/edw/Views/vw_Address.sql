CREATE VIEW [edw].[vw_Address]
AS
SELECT
  AddressID,
  Region,
  Country AS CountryCode,
  CityName,
  PostalCode,
  StreetName,
  HouseNumber,
  NULL AS FullAddress
FROM
  [base_s4h_cax].[I_Address]
