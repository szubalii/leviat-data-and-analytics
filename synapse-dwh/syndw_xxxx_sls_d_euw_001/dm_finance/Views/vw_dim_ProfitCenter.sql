CREATE VIEW [dm_finance].[vw_dim_ProfitCenter] AS 

SELECT
  [ControllingArea]
, CASE
    WHEN [ProfitCenterID] = 'DUMMY'
    THEN 'MA'
    ELSE [ProfitCenterID]
END AS [ProfitCenterID]
, CASE
    WHEN [ProfitCenterID] = 'DUMMY'
    THEN 'MA'
    ELSE [ProfitCenter]
END AS [ProfitCenter]
, CASE
    WHEN [ProfitCenterID] = 'DUMMY'
    THEN 'MA'
    ELSE [ProfitCenterTypeID]
END AS [ProfitCenterTypeID]
, CASE
    WHEN [ProfitCenterID] = 'DUMMY'
    THEN 'MA'
    ELSE [ProfitCenterType]
END AS [ProfitCenterType]
, CASE
    WHEN [ProfitCenterID] = 'DUMMY'
    THEN 'MA'
    ELSE  [ProfitCtrResponsiblePersonName]
END AS [ProfitCtrResponsiblePersonName]
, [Segment]
, [ProfitCenterIsBlocked]
, [CityName]
, [PostalCode]
--, [POBoxPostalCode]
, [District]
, [Country]
, [Region]
FROM [edw].[dim_ProfitCenter]
