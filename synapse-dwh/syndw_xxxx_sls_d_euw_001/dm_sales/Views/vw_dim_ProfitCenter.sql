CREATE VIEW [dm_sales].[vw_dim_ProfitCenter] AS 

SELECT
  [ControllingArea]
, [ProfitCenterID]
, [ProfitCenter]
, [ProfitCenterTypeID]
, [ProfitCenterType]
, [ProfitCtrResponsiblePersonName]
, [Segment]
, [ProfitCenterIsBlocked]
, [CityName]
, [PostalCode]
--, [POBoxPostalCode]
, [District]
, [Country]
, [Region]
FROM [edw].[dim_ProfitCenter]
