CREATE VIEW [dm_RiskAndCompliance].[vw_dim_ActivityGroupRole]
AS

SELECT
  AGR.[Agr_Name] AS [ActivityGroupRoleName],
  AGR.[Parent_Agr] AS [CompositeActivityGroupRoleName],
  AGR_T.[ActivityGroupRoleDescription]
FROM
  [base_s4h_cax].[AGR_DEFINE] AGR
LEFT JOIN
  [intm_s4h].[vw_ActivityGroupRoleText] AGR_T
  ON
    AGR_T.[ActivityGroupRoleName] = AGR.[Agr_Name]
