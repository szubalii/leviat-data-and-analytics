CREATE VIEW [intm_s4h].[vw_ActivityGroupRoleText]
AS
SELECT
  [Agr_Name] AS [ActivityGroupRoleName],
  STRING_AGG([Text], ' ') WITHIN GROUP ( ORDER BY [Line] ASC ) AS [ActivityGroupRoleDescription]
FROM
  [base_s4h_cax].[AGR_TEXTS]
GROUP BY
  [Agr_Name]
