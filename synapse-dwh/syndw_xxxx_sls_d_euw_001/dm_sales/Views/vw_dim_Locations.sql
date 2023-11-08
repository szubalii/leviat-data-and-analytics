CREATE VIEW [dm_sales].[vw_dim_Locations] AS 

SELECT
  [Region]
, [CountryCode]
, [SAPShippingPoint]
, [WarehouseName]
, [Type]
, [SAPCode]
, [WarehouseType]
, [Address]
, [Zipcode]
, [City]
, [LogisticsAreaInM2]
, [FTELogistics]
, [FullAddress]
, [t_applicationId]
, [t_jobDtm]

FROM [edw].[vw_Locations]
