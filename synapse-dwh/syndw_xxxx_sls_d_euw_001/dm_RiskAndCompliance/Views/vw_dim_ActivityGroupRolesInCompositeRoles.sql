CREATE VIEW [dm_RiskAndCompliance].[vw_dim_ActivityGroupRolesInCompositeRoles]
AS
WITH AGR_TEXTS_SINGLE_LINE AS (
  SELECT
    [Agr_Name],
    STRING_AGG([Text], ' ') WITHIN GROUP ( ORDER BY [Line] ASC ) AS [Text]
  FROM
    [base_s4h_cax].[AGR_TEXTS]
  GROUP BY
    [Agr_Name]
)
SELECT
  AA.[Agr_Name] AS [CompositeActivityGroupRoleName]
, AA.[Child_Agr] AS [ActivityGroupRoleName]
, AA.[Attributes]
, AGR_TEXTS_SINGLE_LINE.[Text] AS [CompositeActivityGroupRoleDescription]
, AA.[t_applicationId]
, AA.[t_extractionDtm]
FROM
  [base_s4h_cax].[AGR_AGRS] AA
LEFT JOIN
  AGR_TEXTS_SINGLE_LINE
  ON
    AA.[Agr_Name] = AGR_TEXTS_SINGLE_LINE.[Agr_Name]
