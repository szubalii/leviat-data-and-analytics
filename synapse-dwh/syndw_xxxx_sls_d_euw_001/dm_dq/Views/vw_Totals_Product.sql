CREATE VIEW [dm_dq].[vw_Totals_Product] AS 

SELECT 
	[ProductTotals]    
  , [ErrorTotals]
  , [t_jobDtm]
FROM 
	[dq].[TotalsProduct] pr