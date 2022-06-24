CREATE VIEW [dm_dq].[vw_dim_RuleProduct] AS
SELECT
    [RuleID],
    [Product],
    [t_jobDtm]
FROM
    [dq].[dim_RuleProduct]