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
    [dq].[vw_Product_1_14]

UNION ALL

SELECT
    [RuleID]
    , [Product]    
FROM
    [dq].[vw_Product_1_15]

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

UNION ALL

SELECT
    [RuleID]
    , [Product]   
FROM
    [dq].[vw_Product_1_11]

UNION ALL

SELECT
    [RuleID]
    , [Product]   
FROM
    [dq].[vw_Product_1_13]

UNION ALL

SELECT
    [RuleID]
    , [Product]   
FROM
    [dq].[vw_Product_1_29]

UNION ALL

SELECT
    [RuleID]
    , [Product]   
FROM
    [dq].[vw_Product_1_22]

UNION ALL

-- 1.1
SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_1]

UNION ALL

--1.25_ZVER
SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_25]
    

UNION ALL

--1.29_ALL
SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_29_all]

UNION ALL

--1.30_ALL
SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_30]             

UNION ALL

-- 1.31_ZHAW, 1.31_ZVER
SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_31]

UNION ALL

-- 1.32_ZROH, 1.32_ZHAW
SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_32]

UNION ALL

--1.33_ZROH
SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_33]

UNION ALL

--1.41_ZVER
SELECT
    [RuleID]
    , [Product] 
FROM
    [dq].[vw_Product_1_41]