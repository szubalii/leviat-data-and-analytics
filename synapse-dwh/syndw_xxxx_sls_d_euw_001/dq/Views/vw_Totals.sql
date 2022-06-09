CREATE VIEW [dq].[vw_Totals] AS

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
    [RuleID]
    ,r.[ProductType]
    ,[RecordTotals]
FROM
    [dq].[Rule] AS r
LEFT JOIN
    CountRowsPerProductType AS cnt
    ON
        r.[ProductType] = cnt.[ProductType]
WHERE
    [DataArea] = 'Material'
)

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
INNER JOIN
    [dq].[vw_Product_1_2] AS p
    ON
        cnt.[RuleID] = p.[RuleID]
GROUP BY
    cnt.[RuleID],
    cnt.[ProductType],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
INNER JOIN
    [dq].[vw_Product_1_8] AS p
    ON
        cnt.[RuleID] = p.[RuleID]
GROUP BY
    cnt.[RuleID],
    cnt.[ProductType],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
INNER JOIN
    [dq].[vw_Product_1_16] AS p
    ON
        cnt.[RuleID] = p.[RuleID]
GROUP BY
    cnt.[RuleID],
    cnt.[ProductType],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
INNER JOIN
    [dq].[vw_Product_1_17] AS p
    ON
        cnt.[RuleID] = p.[RuleID]
GROUP BY
    cnt.[RuleID],
    cnt.[ProductType],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[ProductType] LIKE '%All%'
        THEN (SELECT COUNT(*) FROM [base_s4h_cax].[I_Product])
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
INNER JOIN
    [dq].[vw_Product_1_18] AS p
    ON
        cnt.[RuleID] = p.[RuleID]
GROUP BY
    cnt.[RuleID],
    cnt.[ProductType],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    CASE
        WHEN cnt.[ProductType] LIKE '%All%'
        THEN (SELECT COUNT(*) FROM [base_s4h_cax].[I_Product])
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
INNER JOIN
    [dq].[vw_Product_1_19] AS p
    ON
        cnt.[RuleID] = p.[RuleID]
GROUP BY
    cnt.[RuleID],
    cnt.[ProductType],
    cnt.[RecordTotals]

UNION ALL

SELECT
    cnt.[RuleID],
    cnt.[RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleID AS cnt
INNER JOIN
    [dq].[vw_Product_1_20] AS p
    ON
        cnt.[RuleID] = p.[RuleID]
GROUP BY
    cnt.[RuleID],
    cnt.[ProductType],
    cnt.[RecordTotals]