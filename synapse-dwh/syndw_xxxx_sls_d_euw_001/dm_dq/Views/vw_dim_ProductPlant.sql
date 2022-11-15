CREATE VIEW [dm_dq].[vw_dim_ProductPlant] AS 

SELECT 
	 [Product]
	,[CountryOfOrigin]
	,[Plant]
	,[SpecialProcurementType] 
	,[ProcurementType]
	,[Commodity]
	,[IsMarkedForDeletion]
    ,[MRPType]
    ,NVM.[MINBE] as [Reorder Point]
	,NVM.[NCOST] as [Do Not Cost Indicator]
	,NVM.[FXHOR] as [Planning Time Fence]

FROM
	[base_s4h_cax].[I_ProductPlant] PP

LEFT JOIN 
    [base_s4h_cax].[NSDM_V_MARC] NVM
    ON 
      PP.[Product] = NVM.[MATNR]  COLLATE Latin1_General_100_BIN2
      AND
      PP.[Plant] = NVM.[WERKS]  COLLATE Latin1_General_100_BIN2


