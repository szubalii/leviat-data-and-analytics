CREATE VIEW [dm_sales].[vw_dim_InventoryStockType] AS
SELECT
	[InventoryStockTypeID]
	,[InventoryStockTypeName]
	,[t_applicationId]
    ,[t_extractionDtm]
FROM
	[edw].[dim_InventoryStockType]