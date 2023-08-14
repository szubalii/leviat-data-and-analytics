CREATE VIEW [dm_dq].[vw_dim_RuleBusinessPartner] AS
SELECT
    [RuleID],
    [BusinessPartner],
    [t_jobDtm]
FROM
    [dq].[dim_RuleBusinessPartner]