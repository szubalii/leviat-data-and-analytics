CREATE VIEW [dm_dq].[vw_dim_ProductPlant] AS 

SELECT 
	 [Product]
	,[CountryOfOrigin]
	,[Plant]
	,[SpecialProcurementType] 
	,[ProcurementType]
	,[Commodity]
	,[IsMarkedForDeletion]
	,[CountryOfOrigin]
FROM
	[base_s4h_cax].[I_ProductPlant]

