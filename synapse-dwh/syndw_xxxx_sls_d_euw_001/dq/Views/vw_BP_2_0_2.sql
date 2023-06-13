CREATE VIEW [dq].[vw_BP_2_0_2]
  AS  

WITH OrganizationBPName AS(
SELECT
        BP.[OrganizationBPName1]
    ,   COUNT([OrganizationBPName1]) AS [Count]
FROM
    [base_s4h_cax].[I_BusinessPartner] BP
GROUP BY
     [OrganizationBPName1]
HAVING
    COUNT(*)>1)
SELECT
    [OrganizationBPName1]
    ,   '2.0.2' AS [RuleID]
    ,   1 AS [Count]
FROM
    OrganizationBPName