CREATE VIEW [dq].[vw_BP_2_0_2]
  AS  

SELECT
        BP.[OrganizationBPName1]
    ,   '2.0.2' AS [RuleID]
    ,   COUNT([OrganizationBPName1]) AS [Count]
FROM
    [base_s4h_cax].[I_BusinessPartner] BP
GROUP BY
     [OrganizationBPName1]
     ,'2.0.2'
HAVING
    COUNT(*)>1