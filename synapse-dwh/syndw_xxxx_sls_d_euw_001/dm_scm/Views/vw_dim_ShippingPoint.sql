CREATE VIEW [dm_scm].[vw_dim_ShippingPoint]
AS
SELECT
  s.ShippingPointID,
  NULL AS ShippingPointName,
  s.ShippingPointType,
  NULL AS ShippingPointCategory,
  a.CountryCode,
  a.FullAddress,
  w.LogisticsAreaInM2,
  w.FTELogistics
FROM
  [edw].[dim_ShippingPoint] s
LEFT JOIN
  [edw].[dim_Address] a
  ON
    a.AddressID = s.AddressID
LEFT JOIN
  [base_ff].[ShippingPointLogistics] w
  ON
    w.ShippingPointID = s.ShippingPointID
