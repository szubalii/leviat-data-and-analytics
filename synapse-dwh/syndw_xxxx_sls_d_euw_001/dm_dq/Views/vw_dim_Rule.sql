CREATE VIEW [dm_dq].[vw_dim_Rule] AS
SELECT
    [RuleID]
    ,[RuleBusinessDescription]
    ,[RuleTechnicalDefinition]
    ,[FieldNameChecked]
    ,[RuleClass]
    ,[RuleGroup]
    ,[DataArea]
    ,[RAGStatus]
    ,[t_jobDtm]
FROM
    [dq].[dim_Rule]