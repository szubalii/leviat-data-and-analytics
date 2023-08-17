CREATE VIEW [dm_dq].[vw_fact_BusinessPartnerTotal] AS 

SELECT 
	[BusinessPartnerTotals]    
  , [ErrorTotals]
  , [t_jobDtm]
FROM 
	[dq].[fact_BusinessPartnerTotal] bp