CREATE VIEW [dm_dq].[vw_Rule] AS
SELECT
    [RuleID]
    ,[RuleBusinessDescription]
    ,[RuleTechnicalDescription]
    ,[Formula]
    ,[RuleClass]
    ,[RuleGroup]
    ,[DataArea]
    ,[t_jobDtm]
FROM
    [dq].[Rule]