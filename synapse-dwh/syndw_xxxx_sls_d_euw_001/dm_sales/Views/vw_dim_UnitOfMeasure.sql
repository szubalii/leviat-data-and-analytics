CREATE VIEW [dm_sales].[vw_dim_UnitOfMeasure] AS
SELECT
	[UnitOfMeasureID]
	,[UnitOfMeasure]
	,[UnitOfMeasureLongName]
	,[UnitOfMeasureTechnicalName]
	,[UnitOfMeasure_E]
    ,[UnitOfMeasureCommercialName]
    ,[UnitOfMeasureSAPCode]
    ,[UnitOfMeasureISOCode]
	,[t_applicationId]
    ,[t_extractionDtm]
FROM
	[edw].[dim_UnitOfMeasure]
