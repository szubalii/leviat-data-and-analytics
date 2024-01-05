CREATE VIEW [dm_RiskAndCompliance].[vw_dim_ActivityGroupRoleInCompositeRole]
AS

SELECT
  AA.[Agr_Name] AS [CompositeActivityGroupRoleName]
, AGR_T.[ActivityGroupRoleDescription] AS [CompositeActivityGroupRoleDescription]
, AA.[Child_Agr] AS [ActivityGroupRoleName]
, AA.[Attributes]
, AA.[t_applicationId]
, AA.[t_extractionDtm]
FROM
  [base_s4h_cax].[AGR_AGRS] AA
LEFT JOIN
  [intm_s4h].[vw_ActivityGroupRoleText] AGR_T
  ON
    AA.[Agr_Name] = AGR_T.[ActivityGroupRoleName]
