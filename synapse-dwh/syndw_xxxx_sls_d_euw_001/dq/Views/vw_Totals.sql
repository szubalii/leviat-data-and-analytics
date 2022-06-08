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
-- Calculate count rows per RuleCodeID from Rule table
CountRowsPerRuleCodeID AS (
SELECT
    [RuleCodeID]
    ,SUBSTRING(r.[RuleCodeID],CHARINDEX('_',r.[RuleCodeID])+1,LEN(r.[RuleCodeID]))  AS [ProductType]
    ,[RecordTotals]
FROM
    [dq].[Rule] AS r
LEFT JOIN
    CountRowsPerProductType AS cnt
    ON
        SUBSTRING(r.[RuleCodeID],CHARINDEX('_',r.[RuleCodeID])+1,LEN(r.[RuleCodeID])) = cnt.[ProductType]
WHERE
    [DataArea] = 'Material'
)

SELECT
    cnt.[RuleCodeID],
    CASE
        WHEN cnt.[ProductType] LIKE '%All%'
        THEN (SELECT COUNT(*) FROM [base_s4h_cax].[I_Product])
        ELSE cnt.[RecordTotals]
    END AS [RecordTotals],
    COUNT(p.Count) AS [ErrorTotals]
FROM
    CountRowsPerRuleCodeID AS cnt
INNER JOIN
    [dq].[vw_Product] AS p
    ON
        cnt.[RuleCodeID] = p.[RuleCodeID]
GROUP BY
    cnt.[RuleCodeID],
    cnt.[ProductType],
    cnt.[RecordTotals]