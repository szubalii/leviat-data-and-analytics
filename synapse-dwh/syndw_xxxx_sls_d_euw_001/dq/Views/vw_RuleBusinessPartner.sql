CREATE VIEW [dq].[vw_RuleBusinessPartner]
AS
SELECT
    [RuleID]
    ,[BUSINESSPARTNER]  COLLATE DATABASE_DEFAULT    AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_0_1]

UNION ALL

SELECT
    [RuleID]
    ,[BusinessPartner] 
FROM
    [dq].[vw_BP_2_0_2]

UNION ALL

SELECT
    [RuleID]
    ,[BusinessPartner] 
FROM
    [dq].[vw_BP_2_0_4]

UNION ALL

SELECT
    [RuleID]
    ,[BusinessPartner] 
FROM
    [dq].[vw_BP_2_0_5]

UNION ALL

SELECT
    [RuleID]
    ,[BusinessPartner] 
FROM
    [dq].[vw_BP_2_0_6]

UNION ALL

SELECT
    [RuleID]
    ,BUSINESSPARTNER        AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_0_8]

UNION ALL

SELECT
    [RuleID]
    ,[Supplier]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_0_9_Intercompany]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_0_9_ThirdParty]

UNION ALL

SELECT
    [RuleID]
    ,[BusinessPartner] 
FROM
    [dq].[vw_BP_2_0_10]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_0_11]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_1_2]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_1_3_Intercompany]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_1_3_ThirdParty]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_1_4]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_1_6]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_1_7]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_1_8]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_1_9]

UNION ALL

SELECT
    [RuleID]
    ,[Customer]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_1_10]

UNION ALL

SELECT
    [RuleID]
    ,[Supplier]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_2_1_Intercompany]

UNION ALL

SELECT
    [RuleID]
    ,[Supplier]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_2_1_ThirdParty]

UNION ALL

SELECT
    [RuleID]
    ,[Supplier]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_2_2]

UNION ALL

SELECT
    [RuleID]
    ,[Supplier]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_2_3]

UNION ALL

SELECT
    [RuleID]
    ,[Supplier]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_2_4]

UNION ALL

SELECT
    [RuleID]
    ,[Supplier]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_2_5]

UNION ALL

SELECT
    [RuleID]
    ,[Supplier]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_2_7]

UNION ALL

SELECT
    [RuleID]
    ,[Supplier]             AS [BusinessPartner] 
FROM
    [dq].[vw_BP_2_2_8]

UNION ALL

SELECT
    [RuleID]
    ,[BusinessPartner]
FROM
    [dq].[vw_BP_2_2_9]