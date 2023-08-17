CREATE VIEW [dm_dq].[vw_fact_BusinessPartnerTotalLatest]
AS
SELECT
    TOP 1
    [BusinessPartnerTotals]    
  , [ErrorTotals]
  , [t_jobDtm]
FROM [dq].[fact_BusinessPartnerTotal]
ORDER BY t_jobDtm DESC