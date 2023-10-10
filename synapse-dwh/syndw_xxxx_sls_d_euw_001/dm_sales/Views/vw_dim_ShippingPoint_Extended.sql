CREATE VIEW [dm_sales].[vw_dim_ShippingPoint_Extended]
AS
SELECT
  ShippingPointID,
  ShippingPointName,
  ShippingPointType,
  ShippingPointCategory,
  Region,
  CountryCode,
  CityName,
  PostalCode,
  StreetName,
  HouseNumber,
  FullAddress,
  LogisticsAreaInM2
  FTELogistics
FROM
  [edw].[dim_ShippingPoint] s
LEFT JOIN
  [edw].[dim_Address] a
  ON
    a.AddressID = s.AddressID
