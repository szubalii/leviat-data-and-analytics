CREATE VIEW [dm_sales].[vw_dim_ShippingPoint] AS

SELECT
 [ShippingPointID]
, [ActiveDepartureCountry]
, [AddressID]
, [PickingConfirmation]
, [ShippingPointType]
FROM [edw].[dim_ShippingPoint]
