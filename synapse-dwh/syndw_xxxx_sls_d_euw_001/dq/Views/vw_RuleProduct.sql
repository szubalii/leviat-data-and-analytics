CREATE VIEW [dq].[vw_RuleProduct] AS
SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_2]

UNION ALL

SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_3]

UNION ALL

SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_6]

UNION ALL

SELECT
    [RuleID]
    , [Product]  
FROM
    [dq].[vw_Product_1_8]

UNION ALL

SELECT
    [RuleID]
    , [Product]    
FROM
    [dq].[vw_Product_1_16]

UNION ALL

SELECT
    [RuleID]
    , [Product]   
FROM
    [dq].[vw_Product_1_17]

UNION ALL

SELECT
    [RuleID]
    , [Product]    
FROM
    [dq].[vw_Product_1_18]

UNION ALL

SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_19]

UNION ALL

SELECT
    [RuleID]
    , [Product]   
FROM
    [dq].[vw_Product_1_20]

UNION ALL

SELECT
    [RuleID]
    , [Product]   
FROM
    [dq].[vw_Product_1_7]

UNION ALL

SELECT
    [RuleID]
    , [Product]   
FROM
    [dq].[vw_Product_1_12]

UNION ALL

SELECT
    [RuleID]
    , [Product]   
FROM
    [dq].[vw_Product_1_23]

UNION ALL

SELECT
    [RuleID]
    , [Product]   
FROM
    [dq].[vw_Product_1_30]
