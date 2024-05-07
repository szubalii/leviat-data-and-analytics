CREATE VIEW [dm_dq].[vw_dim_ProductPlant] AS 

SELECT 
	 PP.[Product]
	,PP.[CountryOfOrigin]
	,PP.[Plant]
	,PP.[SpecialProcurementType] 
	,PP.[ProcurementType]
	,PP.[Commodity]
	,PP.[IsMarkedForDeletion]
    ,PP.[MRPType]
    ,NVM.[MINBE] as [ReorderPoint]
	,NVM.[NCOST] as [DoNotCost]
	,NVM.[FXHOR] as [PlanningTimeFence]

FROM
	[base_s4h_cax].[I_ProductPlant] PP

LEFT JOIN 
    [base_s4h_cax].[NSDM_V_MARC] NVM
    ON 
      PP.[Product] = NVM.[MATNR]
      AND
      PP.[Plant] = NVM.[WERKS]


