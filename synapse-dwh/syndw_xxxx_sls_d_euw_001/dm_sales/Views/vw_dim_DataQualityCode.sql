CREATE VIEW [dm_sales].[vw_dim_DataQualityCode] AS

SELECT
  [DataQualityCodeID]
, [System]
, [Area]
, [SubArea]
, [DataQualityCodeShortMessage]
, [DataQualityCodeLongMessage]
FROM [edw].[dim_DataQualityCode]
