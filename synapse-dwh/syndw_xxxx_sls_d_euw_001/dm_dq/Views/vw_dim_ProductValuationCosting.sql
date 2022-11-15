CREATE VIEW [dm_dq].[vw_dim_ProductValuationCosting] AS 

SELECT 
	 [Product]
	,[ValuationArea]
	,[IsMaterialRelatedOrigin]	

FROM 
	[base_s4h_cax].[I_ProductValuationCosting]