CREATE VIEW [dm_dq].[vw_fact_ProductTotal] AS 

SELECT 
	[ProductTotals]    
  , [ErrorTotals]
  , [t_jobDtm]
FROM 
	[dq].[fact_ProductTotal] pr