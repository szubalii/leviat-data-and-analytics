CREATE VIEW [dm_RiskAndCompliance].[vw_dim_ActivityGroupRole]
AS
WITH [UniqueRoles] AS (
  SELECT
    [Child_Agr] AS [ActivityGroupRoleName]
  FROM
    [base_s4h_cax].[AGR_AGRS]
  GROUP BY
    [Child_Agr]
)

SELECT
  UniqueRoles.[ActivityGroupRoleName],
  AGR_T.[ActivityGroupRoleDescription]
FROM
  [UniqueRoles]
LEFT JOIN
  [intm_s4h].[vw_ActivityGroupRoleText] AGR_T
  ON
    AGR_T.[ActivityGroupRoleName] = UniqueRoles.[ActivityGroupRoleName]
