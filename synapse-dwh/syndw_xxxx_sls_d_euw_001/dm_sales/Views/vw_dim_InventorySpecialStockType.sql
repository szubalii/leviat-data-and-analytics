CREATE VIEW [dm_sales].[vw_dim_InventorySpecialStockType] AS
SELECT
	[InventorySpecialStockTypeID]
	,[InventorySpecialStockTypeName]
	,[t_applicationId]
	,[t_extractionDtm]
FROM
    [edw].[dim_InventorySpecialStockType]
