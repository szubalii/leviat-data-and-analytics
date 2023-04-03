CREATE VIEW [dm_sales].[vw_dim_VariantConfigurator] AS
SELECT
	 [SalesDocument]
	,[SalesDocumentItem]
	,[ProductID]
	,[ProductExternalID]
	,[CharacteristicName]
    ,[CharacteristicDescription]
	,[t_applicationId]
    ,[t_extractionDtm]
FROM
	[edw].[dim_VariantConfigurator]