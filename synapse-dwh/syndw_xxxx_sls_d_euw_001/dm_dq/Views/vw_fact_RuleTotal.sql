CREATE VIEW [dm_dq].[vw_fact_RuleTotal] AS
SELECT
	[RuleID]
    ,[RecordTotals]
    ,[ErrorTotals]
    ,[t_jobDtm]
FROM
    [dq].[Totals]