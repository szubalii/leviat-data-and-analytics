﻿CREATE VIEW [dm_dq].[vw_dim_Rule] AS
SELECT
    [RuleID]
    ,[RuleBusinessDescription]
    ,[RuleTechnicalDefinition]
    ,[Formula]
    ,[RuleClass]
    ,[RuleGroup]
    ,[DataArea]
    ,[t_jobDtm]
FROM
    [dq].[dim_Rule]