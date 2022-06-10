CREATE VIEW [dm_dq].[vw_Totals] AS
SELECT
	[RuleID]
    ,[RecordTotals]
    ,[ErrorTotals]
    ,[t_jobDtm]
FROM
    [dq].[Totals]