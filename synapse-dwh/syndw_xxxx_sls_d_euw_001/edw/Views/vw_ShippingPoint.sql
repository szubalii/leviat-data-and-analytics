CREATE VIEW [edw].[vw_ShippingPoint]
AS
SELECT
  sp.[ShippingPoint] AS [ShippingPointID],
  spt.[ShippingPointName] AS [ShippingPoint],
  sp.[ActiveDepartureCountry],
  sp.[AddressID],
  sp.[PickingConfirmation],
  CASE
    WHEN SUBSTRING(sp.[ShippingPoint], 3, 1) = 'S'
    THEN 'Subcontractor'
    WHEN SUBSTRING(sp.[ShippingPoint], 3, 1) = 'X'
    THEN '3rd Party'
    ELSE 'Leviat'
  END AS [ShippingPointType],
  sp.[t_applicationId]
FROM
  [base_s4h_cax].[I_ShippingPoint] sp
LEFT JOIN
  [base_s4h_cax].[I_ShippingPointText] spt
  ON
    spt.[ShippingPoint] = sp.[ShippingPoint]
