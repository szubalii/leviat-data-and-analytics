CREATE VIEW [dm_dq].[vw_Rule] AS
SELECT
    [RuleID]
    ,[RuleBusinessDescription]
    ,[RuleClass]
    ,[DataArea]
    ,[t_jobDtm]
FROM
    [dq].[Rule]