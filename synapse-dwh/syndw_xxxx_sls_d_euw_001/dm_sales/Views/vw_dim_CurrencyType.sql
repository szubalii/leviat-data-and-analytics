CREATE VIEW [dm_sales].[vw_dim_CurrencyType] AS 

SELECT
  [CurrencyTypeID]
, [CurrencyType]
FROM [edw].[dim_CurrencyType]
WHERE [CurrencyTypeID] <> '00'