CREATE VIEW [dq].[vw_RuleTotal] AS

-- Calculate count rows per ProductType from I_Product table
WITH CountRowsPerProductType AS (
    SELECT
        [ProductType]
    , COUNT(*) as [RecordTotals]
    FROM
        [base_s4h_cax].[I_Product]
    GROUP BY
        [ProductType]
)
,
-- Calculate count rows per RuleID from Rule table
CountRowsPerRuleID AS (
SELECT
     r.[RuleID]
    ,r.[RuleGroup]
    ,cnt.[RecordTotals]
    ,(SELECT COUNT(*) FROM [base_s4h_cax].[I_Product]) as [AllRecordTotals]
FROM
    [dq].[dim_Rule] AS r
LEFT JOIN
    CountRowsPerProductType AS cnt
    ON
        r.[RuleGroup] = cnt.[ProductType]
WHERE
    [DataArea] = 'Material'
)

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_2] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.2_ZFER', '1.2_ZHAW')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_3] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.3_ZERS', '1.3_ZFER', '1.3_ZROH')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN cnt.[AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    (SELECT COUNT(DISTINCT Product) FROM [dq].[vw_Product_1_6] ) AS [ErrorTotals] --FB 05.12.2022: Added DISTINCT Product Count to suit reporting requirements from R Hofste.
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_6] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.6_ALL')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN [AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_14] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE
    cnt.RuleID IN ('1.14_ALL')
    AND
    p.ProductType <> 'ZTXT'

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN cnt.[AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_15] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.15_ALL')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_16] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.16_ZFER', '1.16_ZHAL', '1.16_ZHAW', '1.16_ZROH', '1.16_ZVER')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_17] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.17_ZHAW', '1.17_ZVER')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN cnt.[AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_18] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.18_ALL')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN [AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_19] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.19_ALL')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_20] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.20_ZFER')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_7] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.7_ZFER', '1.7_ZHAW', '1.7_ZVER')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_12] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.12_ZFER', '1.12_ZHAW')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_23] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.23_ZHAW')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_30] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.30_ZFER', '1.30_ZHAW')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN [AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_13] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.13_ALL')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN [AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_11] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.11_ALL')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_29] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.29_ZHAW')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_22] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.22_ZHAW')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

-- 1.1
SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN [AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_1] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.1_ALL')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]

UNION ALL

--1.25_ZVER
SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_25] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.25_ZVER')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]

UNION ALL

--1.26_ALL
SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN [AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_26] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.26_ALL')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]   

UNION ALL

--1.34_ALL
SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN [AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_34] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.34_ALL')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]   

UNION ALL

--1.35_ALL
SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[RuleGroup] LIKE '%ALL%'
        THEN [AllRecordTotals]
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_35] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.35_ALL')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals],
    cnt.[AllRecordTotals]                

UNION ALL

-- 1.31_ZHAW, 1.31_ZVER
SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_31] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.31_ZHAW', '1.31_ZVER')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]   

UNION ALL

-- 1.32_ZROH, 1.32_ZHAW
SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_32] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.32_ZHAW', '1.32_ZROH')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]   

UNION ALL

--1.33_ZROH
SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_33] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.33_ZROH')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]  

UNION ALL

--1.41_ZVER
SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
LEFT OUTER JOIN
    [dq].[vw_Product_1_41] AS p
    ON
        cnt.[RuleID] = p.[RuleID]

WHERE cnt.RuleID IN ('1.41_ZVER')

GROUP BY
    cnt.[RuleID],
    cnt.[RuleGroup],
    cnt.[RecordTotals]  